import 'package:oraaq/src/imports.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

final forgetPasswordFormKey = GlobalKey<FormState>();

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailTextController = TextEditingController();
  @override
  void dispose() {
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            if (forgetPasswordFormKey.currentState!
                                .validate()) {
                              context.pushNamed(RouteConstants.otpRoute);
                            }
                          },
                          size: CustomButtonSize.large,
                          type: CustomButtonType.primary,
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        TextButton.icon(
                          onPressed: () =>
                              context.pushNamed(RouteConstants.welcomeRoute),
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
                    )))));
  }
}
