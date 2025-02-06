import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:oraaq/src/data/local/local_auth_repository.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/change_password.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/update_customer_request_dto.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/forget_password_dto.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/set_new_password.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/social_login_dto.dart';

import 'package:oraaq/src/data/remote/api/api_request_dtos/merchant_flow/update_merchant_profile_request_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/forget_password_dto.dart';

import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/generate_otp.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/verify_otp.dart';
import 'package:oraaq/src/data/remote/social/social_auth_repository.dart';
import 'package:oraaq/src/imports.dart';

import '../../data/remote/api/api_repositories/auth_repository.dart';
import '../../data/remote/api/api_request_dtos/general_flow/login_request_dto.dart';
import '../../data/remote/api/api_request_dtos/general_flow/register_request_dto.dart';

import '../entities/failure.dart';

class AuthenticationServices {
  final ApiAuthRepository _apiAuthRepository;
  final LocalAuthRepository _localAuthRepository;
  final SocialAuthRepository _socialAuthRepository;
  AuthenticationServices(
    this._apiAuthRepository,
    this._localAuthRepository,
    this._socialAuthRepository,
  );

  //
  //
  // MARK: GET_TOKEN
  //
  //

  Future<Either<Failure, String>> getToken() async {
    var result = await _apiAuthRepository.getToken();
    return result.fold(
      (l) => Left(l),
      (r) async {
        await _localAuthRepository.setToken(r);
        return Right(r);
      },
    );
  }

  //
  //
  // MARK: LOGIN
  //
  //

  Future<Either<Failure, UserEntity>> login(LoginRequestDto dto) async {
    var result = await _apiAuthRepository.login(dto);
    return result.fold(
      (l) => Left(l),
      (r) async {
        UserEntity user = r.user.toUserEntity.copyWith(token: r.token);
        log('otp verified: ${user.isOtpVerified.toString()}');
        await _localAuthRepository.setUser(user);
        await _localAuthRepository.setToken(r.token);
        if (getIt.isRegistered<UserEntity>()) getIt.unregister<UserEntity>();
        getIt.registerSingleton<UserEntity>(user);
        log('${user.role}');
        return Right(user);
      },
    );
  }

  //
  //
  // MARK: REGISTER
  //
  //

  Future<Either<Failure, UserEntity>> register(RegisterRequestDto dto) async {
    var result = await _apiAuthRepository.register(dto);
    return result.fold(
      (l) => Left(l),
      (r) async {
        UserEntity user = r.user.toUserEntity;
        await _localAuthRepository.setUser(user);
        if (getIt.isRegistered<UserEntity>()) getIt.unregister<UserEntity>();
        getIt.registerSingleton<UserEntity>(user);
        return Right(user);
      },
    );
  }

  //
  //
  // MARK: GENERATE_OTP
  //
  //
  Future<Either<Failure, GenerateOtpResponseDto>> generateOtp(
      int userId) async {
    return await _apiAuthRepository.generateOtp(userId);
  }

  //
  //
  // MARK: VERIFY_OTP
  //
  //
  Future<Either<Failure, VerifyOtpResponseDto>> verifyOtp(
      int userId, int otp) async {
    return await _apiAuthRepository.verifyOtp(userId, otp);
  }

  //
  //
  // MARK: CHANGE_PASWORD
  //
  //
  Future<Either<Failure, String>> changePassword(
      ChangePasswordRequestDto dto) async {
    return await _apiAuthRepository.changePassword(dto);
  }

  //
  //
  // MARK: CHANGE_PASWORD
  //
  //
  Future<Either<Failure, String>> setNewPassword(
      SetNewPasswordRequestDto dto) async {
    return await _apiAuthRepository.setNewPassword(dto);
  }

  //
  //
  // MARK: FORGET_PASSWORD
  //
  //
  Future<Either<Failure, ForgetPasswordResponseDto>> forgetPassword(
      ForgetPasswordRequestDto dto) async {
    final result = await _apiAuthRepository.forgetPassword(dto);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  //
  //
  // MARK: UPDATE_MERCHANT_PROFILE
  //
  //
  Future<Either<Failure, UserEntity>> updateMerchantProfile(
    UpdateMerchantProfileRequestDto dto,
  ) async {
    var result = await _apiAuthRepository.updateMerchantProfile(dto);

    return result.fold(
      (l) => Left(l),
      (r) async {
        UserEntity currentUser = getIt.get<UserEntity>();
        var tempUser = r.copyUserEntity(currentUser);
        // var tempUser = currentUser.copyWith(
        //   name: dto.merchantName,
        //   cnicNtn: dto.cnic,
        //   latitude: dto.latitude.toString(),
        //   longitude: dto.longitude.toString(),
        //   holidays: dto.holidays.join(","),
        //   openingTime: dto.openingTime,
        //   closingTime: dto.closingTime,
        //   serviceType: dto.serviceType,
        // );
        await _localAuthRepository.setUser(tempUser);
        getIt.unregister<UserEntity>();
        getIt.registerSingleton<UserEntity>(tempUser);

        return Right(tempUser);
      },
    );
  }

  //
  //
  // MARK: LOGOUT
  //
  //

  Future<void> logout() async {
    await _apiAuthRepository.logout();
    await _socialAuthRepository.logout();
    await _localAuthRepository.logout();
    getIt.unregister<UserEntity>();
  }

  //
  //
  //
  //
  //

  resendOtp() {}

  //
  //
  // MARK: SOCIAL-SIGN-IN
  //
  //

  Future<Either<Failure, User>> socialSignIn(
    // Future<Either<Failure, UserEntity>> socialSignIn(
    SocialSignInEnum signinProvidor,
    UserType userType,
  ) async {
    var result = switch (signinProvidor) {
      SocialSignInEnum.google => await _socialAuthRepository.signInWithGoogle(),
      // SocialSignInEnum.apple => await _socialAuthRepository.signInWithApple(),
      SocialSignInEnum.facebook =>
        await _socialAuthRepository.signInWithFacebook(),
    };
    log(result.toString());

    return result.fold(
      (l) => Left(l),
      (r) async {
        if (r.user == null) {
          await _socialAuthRepository.logout();
          return Left(Failure(StringConstants.somethingWentWrong));
        }
        return Right(
            // r.user!.displayName ?? r.additionalUserInfo?.username ?? "-",
            r.user!);

        // var apiResult = await _apiAuthRepository.socialSignIn(
        //   SocialLoginRequestDto(
        //     userType: userType.value,
        //     name: r.user!.displayName ?? r.additionalUserInfo?.username ?? "",
        //     email: r.user!.email ?? "",
        //     deviceType: Platform.operatingSystem,
        //     deviceToken: _deviceToken,
        //     platformType: signinProvidor.name,
        //     platformId: r.user!.uid,
        //   ),
        // );
        // return apiResult.fold(
        //   (l) async {
        //     await _socialAuthRepository.logout();
        //     return Left(l);
        //   },
        //   (r) async {
        //     if (r == null) {
        //       Left(Failure(AppString.somethingWentWrong));
        //     }
        //     var tempUser = r!.toUserEntity();
        //     user.value = tempUser;
        //     await _localAuthRepository.setUser(tempUser);
        //     await _localAuthRepository.setApiToken(tempUser.apiToken);
        //     return Right(tempUser);
        //   },
        // );
      },
    );
  }

  //
  //
  // MARK: SOCIAL-SIGN-IN SERVER API
  //
  //
  Future<Either<Failure, UserEntity>> loginViaSocial(
      SocialLoginRequestDto dto) async {
    var result = await _apiAuthRepository.loginViaSocial(dto);
    return result.fold(
      (l) => Left(l),
      (r) async {
        UserEntity user = r.user.toUserEntity.copyWith(token: r.token);
        await _localAuthRepository.setUser(user);
        await _localAuthRepository.setToken(r.token);
        if (getIt.isRegistered<UserEntity>()) getIt.unregister<UserEntity>();
        getIt.registerSingleton<UserEntity>(user);
        log('${user.role}');
        return Right(user);
      },
    );
  }

  //
  //
  // MARK: UPDATE_CUSTOMER_PROFILE
  //
  //
  Future<Either<Failure, UserEntity>> updateCustomerProfile(
    UpdateCustomerRequestDto dto,
  ) async {
    var result = await _apiAuthRepository.updateCustomerProfile(dto);

    return result.fold(
      (l) => Left(l),
      (r) async {
        UserEntity currentUser = getIt.get<UserEntity>();
        var tempUser = r.copyUserEntity(currentUser);
        // var tempUser = currentUser.copyWith(
        //   name: dto.merchantName,
        //   cnicNtn: dto.cnic,
        //   latitude: dto.latitude.toString(),
        //   longitude: dto.longitude.toString(),
        //   holidays: dto.holidays.join(","),
        //   openingTime: dto.openingTime,
        //   closingTime: dto.closingTime,
        //   serviceType: dto.serviceType,
        // );
        await _localAuthRepository.setUser(tempUser);
        getIt.unregister<UserEntity>();
        getIt.registerSingleton<UserEntity>(tempUser);
        return Right(tempUser);
      },
    );
  }
}
