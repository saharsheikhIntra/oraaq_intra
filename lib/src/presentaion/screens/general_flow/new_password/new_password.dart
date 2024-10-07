import 'package:oraaq/src/imports.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

final newPasswordFormKey = GlobalKey<FormState>();

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  TextEditingController passwordTextController = TextEditingController(),
      confirmPasswordTextController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode(),
      confirmPasswordFocusNode = FocusNode();
  final isObscure = ValueNotifier<bool>(true);
  final isObscureConfirm = ValueNotifier<bool>(true);
  // bool isObscure = true;
  // bool isObscureConfirm = true;
  @override
  void dispose() {
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
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
                      key: newPasswordFormKey,
                      child: Column(children: [
                        const Spacer(),
                        Image.asset(
                          AssetConstants.logoIcon,
                          height: 80,
                        ),
                        const Spacer(),
                        Text(
                          StringConstants.setNewPassword,
                          textAlign: TextAlign.center,
                          style: TextStyleTheme.headlineSmall
                              .copyWith(color: ColorTheme.primaryText),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: isObscure,
                          builder: (context, value, child) {
                            return TextFormField(
                                controller: passwordTextController,
                                focusNode: passwordFocusNode,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) =>
                                    // ValidationUtils.checkEmptyField(value) ??
                                    ValidationUtils.checkStrongPassword(value),
                                obscureText: value,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(confirmPasswordFocusNode),
                                decoration: InputDecoration(
                                  labelText: StringConstants.password,
                                  labelStyle: TextStyleTheme.bodyLarge
                                      .copyWith(color: ColorTheme.onPrimary),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      value
                                          ? Symbols.visibility_rounded
                                          : Symbols.visibility_off_rounded,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isObscure.value = !value;
                                      });
                                    },
                                  ),
                                ));
                          },
                        ),
                        16.verticalSpace,
                        ValueListenableBuilder(
                          valueListenable: isObscureConfirm,
                          builder: (context, value, child) {
                            return TextFormField(
                                controller: confirmPasswordTextController,
                                focusNode: confirmPasswordFocusNode,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) =>
                                    ValidationUtils.confirmPassword(
                                        value, passwordTextController.text),
                                obscureText: value,
                                decoration: InputDecoration(
                                  labelText: StringConstants.confirmPassword,
                                  labelStyle: TextStyleTheme.bodyLarge
                                      .copyWith(color: ColorTheme.onPrimary),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      value
                                          ? Symbols.visibility_rounded
                                          : Symbols.visibility_off_rounded,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isObscureConfirm.value = !value;
                                      });
                                    },
                                  ),
                                ));
                          },
                        ),
                        20.verticalSpace,
                        CustomButton(
                          width: ScreenUtil().screenWidth,
                          text: StringConstants.setPassword,
                          onPressed: () {
                            if (newPasswordFormKey.currentState!.validate()) {
                              context.pushNamed(RouteConstants.welcomeRoute);
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
