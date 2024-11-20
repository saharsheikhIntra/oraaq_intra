import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../../../domain/entities/failure.dart';

class SocialAuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _facebookAuth = FacebookAuth.instance;
  final _googleSignIn = GoogleSignIn();

  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  //
  //
  //<<<<<<<<<<<<<<<<<<<<<--------------LOGOUT-------------->>>>>>>>>>>>>>>>>>>>>
  //
  //

  Future<void> logout() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      user.providerData;
      for (var userInfo in user.providerData) {
        switch (userInfo.providerId) {
          case "google.com":
            await _googleSignIn.signOut();
            break;
          case "facebook.com":
            await _facebookAuth.logOut();
            break;
          case "apple.com":
            break;
          default:
            break;
        }
      }
      await _firebaseAuth.signOut();
    }
  }

  //
  //
  //<<<<<<<<<<<<<<<<<<<<<--------------GOOGLE-------------->>>>>>>>>>>>>>>>>>>>>
  //
  //

  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      log('googleUser: $googleUser');
      if (googleUser != null) {
        var googleAuth = await googleUser.authentication;
        var userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ));
        return Right(userCredential);
      }
      return Left(Failure("Sign-In Unsuccessful"));
    } on PlatformException catch (e) {
      log('run catch 1');
      log('e: $e');
      return Left(Failure(e.message ?? e.code, code: e.code));
    } on FirebaseAuthException catch (e) {
      log('run catch 2');
      return Left(Failure(e.message ?? e.code, code: e.code));
    } catch (e) {
      log('run catch 3');
      return Left(Failure("Something Went Wrong", code: e.toString()));
    }
  }

  //
  //
  //<<<<<<<<<<<<<<<<<<<<--------------FACEBOOK-------------->>>>>>>>>>>>>>>>>>>>
  //
  //

  Future<Either<Failure, UserCredential>> signInWithFacebook() async {
    var loginResult = await _facebookAuth.login();
    try {
      if (loginResult.status == LoginStatus.success &&
          loginResult.accessToken != null) {
        var userCredential = await FirebaseAuth.instance.signInWithCredential(
          FacebookAuthProvider.credential(
            loginResult.accessToken!.tokenString,
          ),
        );
        return Right(userCredential);
      } else if (loginResult.status == LoginStatus.cancelled) {
        return Left(Failure("Sign-In Cancelled"));
      } else {
        return Left(Failure("Sign-In Unsuccessful"));
      }
    } on PlatformException catch (e) {
      return Left(Failure(e.message ?? e.code, code: e.code));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.message ?? e.code, code: e.code));
    } catch (e) {
      return Left(Failure("Something Went Wrong", code: e.toString()));
    }
  }

  //
  //
  //<<<<<<<<<<<<<<<<<<<<<<--------------APPLE-------------->>>>>>>>>>>>>>>>>>>>>>
  //
  //

  Future<Either<Failure, UserCredential>> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider()
        ..addScope('email')
        ..addScope('name');
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);
      return Right(userCredential);
    } on Exception catch (e) {
      Logger().e(e);
      return Left(Failure("Something Went Wrong"));
    } on Error catch (e) {
      Logger().e(e);
      return Left(Failure("Something Went Wrong"));
    }
  }
}
