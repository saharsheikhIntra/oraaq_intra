import 'dart:developer';

import 'package:oraaq/src/core/extensions/context_extensions.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/forgot_password/forget_password_arguement.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/login/login_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/login/login_state.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/otp/otp_arguement.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/splash/splash_screen.dart';

class LoginScreen extends StatefulWidget {
  final LoginArguments arguments;
  const LoginScreen({
    super.key,
    required this.arguments,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginCubit _cubit = getIt.get<LoginCubit>();

  final loginFormKey = GlobalKey<FormState>();
  TextEditingController emailTextController =
          TextEditingController(),
      passwordTextController = TextEditingController();
  FocusNode emailFocusNode = FocusNode(), passwordFocusNode = FocusNode();

  final ValueNotifier<bool> _isObscure = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isValid = ValueNotifier<bool>(false);

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _isObscure.dispose();
    _isValid.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('FormKey created for ${loginFormKey.hashCode}');
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginStateLoaded) {
            var type = getIt.get<UserType>();
            if (type == UserType.merchant) {
              if (state.user.isOtpVerified == 'N') {
                context.pushNamed(RouteConstants.otpRoute,
                    arguments: OtpArguement(widget.arguments.selectedUserType,
                        state.user.email, 'login'));
                return;
              }
              if (state.user.name.isEmpty ||
                  state.user.cnicNtn.isEmpty ||
                  state.user.serviceType == -1 ||
                  state.user.bussinessName.isEmpty ||
                  state.user.latitude.isEmpty ||
                  state.user.longitude.isEmpty ||
                  state.user.openingTime.isEmpty ||
                  state.user.closingTime.isEmpty) {
                // context.pushNamed(RouteConstants.merchantEditProfileRoute);
                context.popAllNamed(RouteConstants.merchantEditProfileRoute);
              } else {
                context.popAllNamed(RouteConstants.merchantHomeScreenRoute);
              }
            } else if (type == UserType.customer) {
              log('customer runn $type ${state.user.isOtpVerified}');
              if (state.user.isOtpVerified == 'N') {
                context.pushReplacementNamed(RouteConstants.otpRoute,
                    arguments: OtpArguement(widget.arguments.selectedUserType,
                        state.user.email, 'login'));
                return;
              }
              if (state.user.latitude.isEmpty ||
                  state.user.longitude.isEmpty ||
                  state.user.latitude == "null" ||
                  state.user.longitude == "null" ||
                  state.user.latitude == "" ||
                  state.user.longitude == "" ||
                  state.user.name == " " ||
                  state.user.name == "") {
                context.popAllNamed(RouteConstants.customerEditProfileRoute);
              } else {
                context.popAllNamed(RouteConstants.customerHomeScreenRoute);
              }
            }
          }
          if (state is LoginStateError) {
            DialogComponent.hideLoading(context);
            FocusScope.of(context).unfocus();

            if (getIt.isRegistered<UserEntity>()) {
              getIt.unregister<UserEntity>();
            }

            Toast.show(
              context: context,
              variant: SnackbarVariantEnum.warning,
              title: state.error.message,
            );
          }
          if (state is LoginStateLoading) {
            DialogComponent.showLoading(context);
          }
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: ColorTheme.transparent,
            ),
            body: SingleChildScrollView(
                child: Container(
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenHeight,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              AssetConstants.splashBackground,
                            ))),
                    child: Container(
                      padding: 24.horizontalPadding,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0, 0.32, 0.75],
                        colors: [
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0.81),
                          Colors.white,
                        ],
                      )),
                      child: Form(
                        key: loginFormKey,
                        child: Column(
                          children: [
                            const Spacer(
                              flex: 2,
                            ),
                            Image.asset(
                              AssetConstants.logoIconWhite,
                              height: 70,
                            ),
                            const Spacer(),
                            Text(
                              StringConstants.login,
                              textAlign: TextAlign.center,
                              style: TextStyleTheme.headlineSmall
                                  .copyWith(color: ColorTheme.primaryText),
                            ),
                            16.verticalSpace,
                            Text(
                              StringConstants.loginMessage,
                              textAlign: TextAlign.center,
                              style: TextStyleTheme.bodyMedium
                                  .copyWith(color: ColorTheme.secondaryText),
                            ),
                            const Spacer(),
                            TextFormField(
                                controller: emailTextController,
                                // focusNode: emailFocusNode,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    ValidationUtils.checkEmail(value),
                                onChanged: (value) => _validate(),
                                // onEditingComplete: () => FocusScope.of(context)
                                //     .requestFocus(passwordFocusNode),
                                decoration: InputDecoration(
                                  labelText: StringConstants.emailAddress,
                                  labelStyle: TextStyleTheme.bodyLarge
                                      .copyWith(color: ColorTheme.onPrimary),
                                )),
                            16.verticalSpace,
                            ValueListenableBuilder<bool>(
                                valueListenable: _isObscure,
                                builder: (context, value, child) {
                                  return TextFormField(
                                      controller: passwordTextController,
                                      // focusNode: passwordFocusNode,
                                      // onEditingComplete: FocusScope.of(context)
                                      //     .unfocus,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: (value) => null,
                                      onChanged: (value) => _validate(),
                                      obscureText: value,
                                      decoration: InputDecoration(
                                        labelText: StringConstants.password,
                                        labelStyle: TextStyleTheme.bodyLarge
                                            .copyWith(
                                                color: ColorTheme.onPrimary),
                                        suffixIcon: IconButton(
                                          icon: Icon(value
                                              ? Symbols.visibility_rounded
                                              : Symbols.visibility_off_rounded),
                                          onPressed: () {
                                            _isObscure.value = !value;
                                          },
                                        ),
                                      ));
                                }),
                            Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => context.pushNamed(
                                      RouteConstants.forgetPasswordRoute,
                                      arguments: ForgetPasswordArguement(
                                          widget.arguments.selectedUserType)),
                                  style: TextButton.styleFrom(
                                      foregroundColor: ColorTheme.primaryText),
                                  child: const Text(
                                      StringConstants.forgotPassword),
                                )),
                            const Spacer(),
                            ValueListenableBuilder(
                                valueListenable: _isValid,
                                builder: (context, value, child) {
                                  return CustomButton(
                                    text: StringConstants.signIn,
                                    onPressed: value
                                        ? () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            if (getIt
                                                .isRegistered<UserType>()) {
                                              getIt.unregister<UserType>();
                                            }
                                            debugPrint(widget
                                                .arguments.selectedUserType
                                                .toString());
                                            getIt.registerSingleton<UserType>(
                                                widget.arguments
                                                    .selectedUserType);
                                            _cubit.login(
                                              emailTextController.text,
                                              passwordTextController.text,
                                            );
                                          }
                                        : null,
                                    type: CustomButtonType.primary,
                                    size: CustomButtonSize.large,
                                    width: ScreenUtil().screenWidth,
                                  );
                                }),
                            20.verticalSpace,
                            Text(StringConstants.orSignInWith,
                                textAlign: TextAlign.center,
                                style: TextStyleTheme.bodyLarge
                                    .copyWith(color: ColorTheme.primaryText)),
                            20.verticalSpace,
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: SocialSignInEnum.values
                                    .map((e) => Padding(
                                        padding: 8.horizontalPadding,
                                        child: CustomButton(
                                          icon: e.icon,
                                          type: CustomButtonType.tertiary,
                                          onPressed: () {
                                            if (getIt
                                                .isRegistered<UserType>()) {
                                              getIt.unregister<UserType>();
                                            }
                                            debugPrint(widget
                                                .arguments.selectedUserType
                                                .toString());
                                            getIt.registerSingleton<UserType>(
                                                widget.arguments
                                                    .selectedUserType);
                                            _cubit.socialSignIn(
                                              e,
                                              widget.arguments.selectedUserType,
                                            );
                                          },
                                        )))
                                    .toList()),
                            20.verticalSpace,
                            const Divider(
                              color: ColorTheme.neutral1,
                              thickness: 3,
                            ),
                            const Spacer(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(StringConstants.dontHaveAccount,
                                      style: TextStyleTheme.bodyLarge),
                                  8.horizontalSpace,
                                  CustomButton(
                                      size: CustomButtonSize.small,
                                      text: StringConstants.registerNow,
                                      type: CustomButtonType.primary,
                                      onPressed: () {
                                        if (getIt.isRegistered<UserType>()) {
                                          getIt.unregister<UserType>();
                                        }
                                        debugPrint(widget
                                            .arguments.selectedUserType
                                            .toString());
                                        getIt.registerSingleton<UserType>(
                                            widget.arguments.selectedUserType);
                                        debugPrint(widget
                                            .arguments.selectedUserType
                                            .toString());
                                        context.pushNamed(
                                          RouteConstants.signupRoute,
                                        );
                                      })
                                ]),
                            const Spacer(),
                          ],
                        ),
                      ),
                    )))),
      ),
    );
  }

  _validate() => _isValid.value = loginFormKey.currentState!.validate();
}
