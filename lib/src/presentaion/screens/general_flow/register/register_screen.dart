import 'package:flutter/gestures.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/otp/otp_arguement.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/register/register_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/register/register_state.dart';

import 'package:oraaq/src/imports.dart';

class ResgisterScreen extends StatefulWidget {
  // final RegisterArguement args;
  const ResgisterScreen({
    super.key,
  });

  @override
  State<ResgisterScreen> createState() => _ResgisterScreenState();
}

class _ResgisterScreenState extends State<ResgisterScreen> {
  final RegisterCubit _cubit = getIt.get<RegisterCubit>();
  final UserType user = getIt.get<UserType>();

  final registerFormKey = GlobalKey<FormState>();
  TextEditingController nameTextController = TextEditingController(),
      emailTextController = TextEditingController(),
      phoneTextController = TextEditingController(),
      passwordTextController = TextEditingController(),
      confirmPasswordTextController = TextEditingController();

  FocusNode nameFocusNode = FocusNode(),
      emailFocusNode = FocusNode(),
      phoneFocusNode = FocusNode(),
      passwordFocusNode = FocusNode(),
      confirmPasswordFocusNode = FocusNode();

  final ValueNotifier<bool> isObscure = ValueNotifier<bool>(true);
  final ValueNotifier<bool> isObscureConfirm = ValueNotifier<bool>(true);
  final ValueNotifier<bool> acceptedTerms = ValueNotifier<bool>(false);

  @override
  void dispose() {
    nameTextController.dispose();
    emailTextController.dispose();
    phoneTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    isObscure.dispose();
    isObscureConfirm.dispose();
    acceptedTerms.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            DialogComponent.hideLoading(context);
            context.pop();
            Toast.show(
              context: context,
              variant: SnackbarVariantEnum.success,
              title: StringConstants.accountCreated,
            );
            context.pushReplacementNamed(RouteConstants.otpRoute,
                arguments: OtpArguement(user, state.user.email, 'register'));

            // if (state.user.name.isEmpty ||
            //     state.user.cnicNtn.isEmpty ||
            //     state.user.serviceType == -1 ||
            //     state.user.latitude.isEmpty ||
            //     state.user.longitude.isEmpty ||
            //     state.user.openingTime.isEmpty ||
            //     state.user.closingTime.isEmpty) {
            //   // context.pushNamed(RouteConstants.merchantEditProfileRoute);
            //   context.pushReplacementNamed(
            //       RouteConstants.merchantEditProfileRoute);
            // } else {
            //   context
            //       .pushReplacementNamed(RouteConstants.merchantHomeScreenRoute);
            // }
          }
          if (state is RegisterError) {
            DialogComponent.hideLoading(context);
            Toast.show(
              context: context,
              variant: SnackbarVariantEnum.warning,
              title: state.error.message,
            );
          }
          if (state is RegisterLoading) {
            DialogComponent.showLoading(context);
          }
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(backgroundColor: ColorTheme.transparent),
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
                          key: registerFormKey,
                          child: Column(
                            children: [
                              const Spacer(),
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
                                  controller: nameTextController,
                                  focusNode: nameFocusNode,
                                  keyboardType: TextInputType.name,
                                  validator: (value) =>
                                      ValidationUtils.checkEmptyField(value),
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(emailFocusNode),
                                  decoration: const InputDecoration(
                                    labelText: StringConstants.userName,
                                  )),
                              16.verticalSpace,
                              TextFormField(
                                  controller: emailTextController,
                                  focusNode: emailFocusNode,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) =>
                                      ValidationUtils.checkEmail(value),
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(phoneFocusNode),
                                  decoration: const InputDecoration(
                                    labelText: StringConstants.emailAddress,
                                  )),
                              16.verticalSpace,
                              TextFormField(
                                  controller: phoneTextController,
                                  focusNode: phoneFocusNode,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    final phoneError =
                                        ValidationUtils.checkPhoneNumber(value);
                                    if (phoneError != null) {
                                      return phoneError;
                                    }
                                    return null;

                                    // if (value!.isEmpty) {
                                    //   return StringConstants.phoneErrorMessage;
                                    // }
                                    // return null;
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(passwordFocusNode),
                                  decoration: InputDecoration(
                                    labelText: StringConstants.phoneNumber,
                                    labelStyle: TextStyleTheme.bodyLarge
                                        .copyWith(color: ColorTheme.onPrimary),
                                  )),
                              16.verticalSpace,
                              ValueListenableBuilder<bool>(
                                  valueListenable: isObscure,
                                  builder: (context, value, child) {
                                    return TextFormField(
                                        controller: passwordTextController,
                                        focusNode: passwordFocusNode,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (value) =>
                                            ValidationUtils.checkStrongPassword(
                                                value),
                                        obscureText: value,
                                        onEditingComplete: () =>
                                            FocusScope.of(context).requestFocus(
                                                confirmPasswordFocusNode),
                                        decoration: InputDecoration(
                                          labelText: StringConstants.password,
                                          labelStyle: TextStyleTheme.bodyLarge
                                              .copyWith(
                                                  color: ColorTheme.onPrimary),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              value
                                                  ? Symbols.visibility_rounded
                                                  : Symbols
                                                      .visibility_off_rounded,
                                            ),
                                            onPressed: () {
                                              isObscure.value = !value;
                                            },
                                          ),
                                        ));
                                  }),
                              16.verticalSpace,
                              ValueListenableBuilder<bool>(
                                valueListenable: isObscureConfirm,
                                builder: (context, value, child) {
                                  return TextFormField(
                                      controller: confirmPasswordTextController,
                                      focusNode: confirmPasswordFocusNode,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: (value) =>
                                          ValidationUtils.confirmPassword(value,
                                              passwordTextController.text),
                                      obscureText: value,
                                      decoration: InputDecoration(
                                        labelText:
                                            StringConstants.confirmPassword,
                                        labelStyle: TextStyleTheme.bodyLarge
                                            .copyWith(
                                                color: ColorTheme.onPrimary),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            value
                                                ? Symbols.visibility_rounded
                                                : Symbols
                                                    .visibility_off_rounded,
                                          ),
                                          onPressed: () {
                                            isObscureConfirm.value = !value;
                                          },
                                        ),
                                      ));
                                },
                              ),
                              16.verticalSpace,
                              Row(
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: acceptedTerms,
                                    builder: (context, value, child) {
                                      return Checkbox(
                                        value: value,
                                        onChanged: (newValue) {
                                          acceptedTerms.value = newValue!;
                                        },
                                      );
                                    },
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: StringConstants.acceptall,
                                        style: TextStyleTheme.bodyMedium
                                            .copyWith(
                                                color:
                                                    ColorTheme.secondaryText)),
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => context.pushNamed(
                                              RouteConstants
                                                  .TermsAndConditionsScreen),
                                        text:
                                            StringConstants.termsAndConditions,
                                        style: TextStyleTheme.bodySmall
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: ColorTheme.primary)),
                                    TextSpan(
                                        text: ' & ',
                                        style: TextStyleTheme.bodyMedium
                                            .copyWith(
                                                color:
                                                    ColorTheme.secondaryText)),
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => context.pushNamed(
                                              RouteConstants
                                                  .PrivacyPolicyScreen),
                                        text: StringConstants.privacyPolicy,
                                        style: TextStyleTheme.bodySmall
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: ColorTheme.primary))
                                  ])),
                                  // Row(children: [
                                  //   Text(StringConstants.acceptall,
                                  //       style: TextStyleTheme.bodyMedium
                                  //           .copyWith(
                                  //               color:
                                  //                   ColorTheme.secondaryText)),
                                  //   6.horizontalSpace,
                                  //   Text(StringConstants.termsAndConditions,
                                  //       style: TextStyleTheme.labelLarge
                                  //           .copyWith(
                                  //               color:
                                  //                   ColorTheme.secondaryText)),
                                  // ]),
                                ],
                              ),
                              const Spacer(),
                              ValueListenableBuilder<bool>(
                                valueListenable: acceptedTerms,
                                builder: (context, value, child) =>
                                    CustomButton(
                                  text: StringConstants.registerButton,
                                  onPressed: value
                                      ? () {
                                          if (registerFormKey.currentState!
                                              .validate()) {
                                            // context.pushNamed(RouteConstants.otpRoute);

                                            _cubit.register(
                                              userName: nameTextController.text,
                                              password:
                                                  passwordTextController.text,
                                              phone: phoneTextController.text,
                                              email: emailTextController.text,
                                            );
                                          }
                                        }
                                      : null,
                                  type: CustomButtonType.primary,
                                  size: CustomButtonSize.large,
                                  width: ScreenUtil().screenWidth,
                                ),
                              ),
                              20.verticalSpace,
                              const Divider(
                                color: ColorTheme.neutral1,
                                thickness: 3,
                              ),
                              const Spacer(),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(StringConstants.alreadyHaveAccount,
                                        style: TextStyleTheme.bodyLarge),
                                    8.horizontalSpace,
                                    CustomButton(
                                        size: CustomButtonSize.small,
                                        text: StringConstants.signIn,
                                        type: CustomButtonType.primary,
                                        onPressed: () => {
                                              context.pushNamed(
                                                RouteConstants.welcomeRoute,
                                              )
                                            })
                                  ]),
                              const Spacer(),
                            ],
                          )),
                    )))),
      ),
    );
  }
}
