import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/forgot_password/forget_password_arguement.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/forgot_password/forget_password_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/otp/otp_arguement.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final ForgetPasswordArguement arg;
  const ForgotPasswordScreen({super.key, required this.arg});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgetPasswordCubit _cubit = getIt.get<ForgetPasswordCubit>();
  final forgetPasswordFormKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  @override
  void dispose() {
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('FormKey created for ${forgetPasswordFormKey.hashCode}');
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          // if (state is ForgetPasswordSuccessState) {
          //   DialogComponent.hideLoading(context);
          //   context.pushNamed(RouteConstants.otpRoute,
          //       arguments: OtpArguement(widget.arg.selectedUserType,
          //           state.response.email, ));
          // }
          // if (state is ForgetPasswordErrorState) {
          //   DialogComponent.hideLoading(context);
          //   Toast.show(
          //     context: context,
          //     variant: SnackbarVariantEnum.warning,
          //     title: state.error.message,
          //   );
          // }
          // if (state is ForgetPasswordLoadingState) {
          //   DialogComponent.showLoading(context);
          // }
        },
        child: Scaffold(
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
                          key: forgetPasswordFormKey,
                          child: Column(children: [
                            const Spacer(),
                            Image.asset(
                              AssetConstants.logoIcon,
                              height: 80,
                            ),
                            const Spacer(),
                            Text(
                              StringConstants.forgotPassword,
                              textAlign: TextAlign.center,
                              style: TextStyleTheme.headlineSmall
                                  .copyWith(color: ColorTheme.primaryText),
                            ),
                            16.verticalSpace,
                            Text(
                              StringConstants.forgetPasswordMsg,
                              textAlign: TextAlign.center,
                              style: TextStyleTheme.bodyMedium
                                  .copyWith(color: ColorTheme.secondaryText),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            TextFormField(
                                controller: emailTextController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    ValidationUtils.checkEmail(value),
                                decoration: InputDecoration(
                                  labelText: StringConstants.emailAddress,
                                  labelStyle: TextStyleTheme.bodyLarge
                                      .copyWith(color: ColorTheme.onPrimary),
                                )),
                            16.verticalSpace,
                            CustomButton(
                              width: ScreenUtil().screenWidth,
                              text: StringConstants.sendCode,
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (forgetPasswordFormKey.currentState!
                                    .validate()) {
                                  context.pushNamed(RouteConstants.otpRoute,
                                      arguments: OtpArguement(
                                        widget.arg.selectedUserType,
                                        emailTextController.text,
                                        'forgetPassword',
                                      ));
                                  // _cubit
                                  //     .forgetPassword(emailTextController.text);
                                }
                              },
                              size: CustomButtonSize.large,
                              type: CustomButtonType.primary,
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            TextButton.icon(
                              onPressed: () => context
                                  .pushNamed(RouteConstants.welcomeRoute),
                              icon: Icon(
                                Symbols.arrow_back,
                                size: 24.sp,
                                color: ColorTheme.black,
                              ),
                              label: Text(
                                StringConstants.backToLogin,
                                style: TextStyleTheme.bodyMedium
                                    .copyWith(color: ColorTheme.black),
                              ),
                            ),
                          ]),
                        ))))),
      ),
    );
  }
}
