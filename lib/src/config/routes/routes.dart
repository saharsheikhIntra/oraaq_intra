import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:oraaq/src/core/constants/route_constants.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/customer_edit_profile/customer_edit_profile_screen.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/customer_home/customer_home_screen.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/customer_profile/customer_profile_screen.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/offer_recieved/offer_received_screen.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/pick_location/pick_location_arguement.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/pick_location/pick_location_screen.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_argument.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_screen.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/reuqest_history/request_history_screen.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/change_password/change_password_screen.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/forgot_password/forgot_password.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/login/login_arguments.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/login/login_screen.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/new_password/new_password.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/otp/otp.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/register/register_screen.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/splash/splash_screen.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/welcome/welcome_screen.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_edit_profile/merchant_edit_profile_screen.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_history/history_screen.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_home/merchant_home_screen.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_home/merchant_inprogress_orders.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_profile/merchant_profile_screen.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/pick_merchant_location/pick_merchant_location_screen.dart';
import 'package:oraaq/src/presentaion/screens/test/test_screen.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      RouteConstants.testRoute => _generateRoute(const TestScreen(), settings),
      RouteConstants.splashRoute =>
        _generateRoute(const SplashScreen(), settings),
      RouteConstants.welcomeRoute =>
        _generateRoute(const WelcomeScreen(), settings),
      RouteConstants.pickLocationRoute => _generateRoute(
          PickLocationScreen(
            args: settings.arguments as int,
          ),
          settings),
      RouteConstants.loginRoute => _generateRoute(
          LoginScreen(arguments: settings.arguments as LoginArguments),
          settings),
      RouteConstants.signupRoute =>
        _generateRoute(const ResgisterScreen(), settings),
      RouteConstants.otpRoute => _generateRoute(const OtpScreen(), settings),
      RouteConstants.forgetPasswordRoute =>
        _generateRoute(const ForgotPasswordScreen(), settings),
      RouteConstants.newPasswordRoute =>
        _generateRoute(const SetNewPasswordScreen(), settings),
      RouteConstants.merchantEditProfileRoute =>
        _generateRoute(const EditProfileScreen(), settings),
      RouteConstants.merchantProfileRoute =>
        _generateRoute(const ProfileScreen(), settings),
      RouteConstants.merchantViewAllOrdersRoute =>
        _generateRoute(const WorkInProgressScreen(), settings),
      RouteConstants.customerProfileRoute =>
        _generateRoute(const CustomerProfileScreen(), settings),
      RouteConstants.customerEditProfileRoute =>
        _generateRoute(const CustomerEditProfileScreen(), settings),
      RouteConstants.changePasswordRoute =>
        _generateRoute(const ChangePasswordScreen(), settings),
      RouteConstants.questionnaireRoute => _generateRoute(
          QuestionnaireScreen(
              args: settings.arguments as QuestionnaireArgument),
          settings),
      RouteConstants.customerHomeScreenRoute =>
        _generateRoute(const CustomerHomeScreen(), settings),
      RouteConstants.merchantHomeScreenRoute =>
        _generateRoute(const MerchantHomeScreen(), settings),
      RouteConstants.offeredReceivedScreenRoute =>
        _generateRoute(const OfferReceivedScreen(), settings),
      RouteConstants.requestHistoryScreenRoute =>
        _generateRoute(const RequestHistoryScreen(), settings),
      RouteConstants.historyScreenRoute =>
        _generateRoute(const HistoryScreen(), settings),
      RouteConstants.pickMerchantLocation =>
        _generateRoute(const PickMerchantLocationScreen(), settings),
      _ => _generateRoute(const SplashScreen(), settings),
    };
  }

  static _generateRoute(Widget widget, RouteSettings settings) {
    Logger().d(
        "Navigating to ${settings.name}, with arguments ${settings.arguments}");
    return CupertinoPageRoute(
      builder: (context) => widget,
      settings: settings,
    );
  }
}
