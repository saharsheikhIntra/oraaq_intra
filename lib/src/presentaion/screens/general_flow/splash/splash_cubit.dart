import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oraaq/src/core/constants/route_constants.dart';
import 'package:oraaq/src/core/enum/user_type.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';
import 'package:oraaq/src/injection_container.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/otp/otp_arguement.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/splash/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashStateInitial());

  animate() async {
    await Future.delayed(600.milliseconds);
    emit(SplashStateAnimate());
    await Future.delayed(2000.milliseconds);
    redirect();
  }

  redirect() {
    if (getIt.isRegistered<UserEntity>()) {
      var user = getIt<UserEntity>();

      var type = user.role;
      log("${user.isOtpVerified}");

      if (type == UserType.customer) {
        log('customer runn $type ${user.role}');
        if (user.isOtpVerified == 'N') {
          emit(SplashStateRedirect(RouteConstants.otpRoute,
              arguments: OtpArguement(type, user.email, "register")));
          return;
        }
        if (user.latitude.toString().isEmpty ||
            user.longitude.toString().isEmpty || 
            user.latitude == "null" ||
                  user.longitude == "null"||
                  user.latitude == "" ||
                  user.longitude == "" ||
                  user.name == " " ||
                  user.name == "" ) {
          emit(SplashStateRedirect(RouteConstants.customerEditProfileRoute));
          return;
        } else {
          emit(SplashStateRedirect(RouteConstants.customerHomeScreenRoute));
        }
      } else if (type == UserType.merchant) {
        log('merchant runn $type ${user.role}');
        if (user.isOtpVerified == 'N') {
          emit(SplashStateRedirect(RouteConstants.otpRoute,
              arguments: OtpArguement(type, user.email, "register")));
          return;
        }
        if (user.latitude == 0 ||
            user.longitude == 0 ||
            user.cnicNtn.isEmpty ||
            user.serviceType == -1 ||
            user.openingTime.isEmpty ||
            user.closingTime.isEmpty) {
          emit(SplashStateRedirect(RouteConstants.merchantEditProfileRoute));
        } else {
          emit(SplashStateRedirect(RouteConstants.merchantHomeScreenRoute));
        }
      }
    } else {
      emit(SplashStateRedirect(RouteConstants.welcomeRoute));
    }
  }

  //
  // {
  //   var nextRoute = RouteConstants.welcomeRoute;
  //   if (getIt.isRegistered<UserEntity>()) {
  //     var user = getIt.get<UserEntity>();
  //     var type = user.role;
  //     if (type == UserType.customer) {
  //       if (user.latitude.isEmpty || user.longitude.isEmpty) {
  //         nextRoute = RouteConstants.customerEditProfileRoute;
  //       }
  //     }
  //     if (type == UserType.merchant) {
  //       if (user.latitude.isEmpty ||
  //           user.longitude.isEmpty ||
  //           user.cnicNtn.isEmpty ||
  //           user.serviceType == -1 ||
  //           user.openingTime.isEmpty ||
  //           user.closingTime.isEmpty) {
  //         nextRoute = RouteConstants.merchantEditProfileRoute;
  //       }
  //     }
  //   }
  //   emit(SplashStateRedirect(nextRoute));
  // }
}
