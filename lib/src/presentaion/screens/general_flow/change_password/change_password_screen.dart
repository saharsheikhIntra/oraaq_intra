import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/change_password/change_password_cubit.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

final changePasswordFormKey = GlobalKey<FormState>();

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final changePasswordFormKey = GlobalKey<FormState>();
  final ChangePasswordCubit _cubit = getIt.get<ChangePasswordCubit>();
  final TextEditingController oldPasswordController = TextEditingController(),
      newPasswordController = TextEditingController(),
      confirmPasswordController = TextEditingController();
  FocusNode oldPasswordFocusNode = FocusNode(),
      newPasswordFocusNode = FocusNode(),
      confirmPasswordFocusNode = FocusNode();

  final ValueNotifier<bool> _oldPasswordVisible = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _newPasswordVisible = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _confirmPasswordVisible = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isValid = ValueNotifier<bool>(false);

  @override
  dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    _oldPasswordVisible.dispose();
    _newPasswordVisible.dispose();
    _confirmPasswordVisible.dispose();
    _isValid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordStateLoaded) {
            debugPrint(state.message);
            DialogComponent.hideLoading(context);
            Toast.show(
              context: context,
              variant: SnackbarVariantEnum.success,
              title: state.message,
            );
            context.pop();
          }
          if (state is ChangePasswordStateError) {
            DialogComponent.hideLoading(context);
            Toast.show(
              context: context,
              variant: SnackbarVariantEnum.warning,
              title: state.error.message,
            );
          }
          if (state is ChangePasswordStateLoading) {
            DialogComponent.showLoading(context);
          }
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(backgroundColor: ColorTheme.transparent),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: ScreenUtil().screenHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AssetConstants.splashBackground),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: changePasswordFormKey,
                  child: Column(
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      const Image(
                        image: AssetImage(AssetConstants.logoIcon),
                        height: 80,
                        width: 78,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        StringConstants.changePassword,
                        style: TextStyleTheme.headlineSmall,
                      ),
                      120.verticalSpace,
                      ValueListenableBuilder<bool>(
                          valueListenable: _oldPasswordVisible,
                          builder: (context, value, child) {
                            return TextFormField(
                                controller: oldPasswordController,
                                focusNode: oldPasswordFocusNode,
                                onChanged: (value) => _validate(),
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) =>
                                    ValidationUtils.checkEmptyField(value),
                                obscureText: value,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(newPasswordFocusNode),
                                decoration: InputDecoration(
                                  labelText: StringConstants.oldPassword,
                                  labelStyle: TextStyleTheme.bodyLarge
                                      .copyWith(color: ColorTheme.onPrimary),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      value
                                          ? Symbols.visibility_rounded
                                          : Symbols.visibility_off_rounded,
                                    ),
                                    onPressed: () {
                                      _oldPasswordVisible.value = !value;
                                    },
                                  ),
                                ));
                          }),
                      16.verticalSpace,
                      ValueListenableBuilder<bool>(
                          valueListenable: _newPasswordVisible,
                          builder: (context, value, child) {
                            return TextFormField(
                                controller: newPasswordController,
                                focusNode: newPasswordFocusNode,
                                onChanged: (value) => _validate(),
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) =>
                                    ValidationUtils.checkStrongPassword(value),
                                obscureText: value,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(confirmPasswordFocusNode),
                                decoration: InputDecoration(
                                  labelText: StringConstants.newPassword,
                                  labelStyle: TextStyleTheme.bodyLarge
                                      .copyWith(color: ColorTheme.onPrimary),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      value
                                          ? Symbols.visibility_rounded
                                          : Symbols.visibility_off_rounded,
                                    ),
                                    onPressed: () {
                                      _newPasswordVisible.value = !value;
                                    },
                                  ),
                                ));
                          }),
                      16.verticalSpace,
                      ValueListenableBuilder<bool>(
                          valueListenable: _confirmPasswordVisible,
                          builder: (context, value, child) {
                            return TextFormField(
                                controller: confirmPasswordController,
                                focusNode: confirmPasswordFocusNode,
                                onChanged: (value) => _validate(),
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) =>
                                    ValidationUtils.confirmPassword(
                                        value, newPasswordController.text),
                                obscureText: value,
                                onEditingComplete: () =>
                                    FocusScope.of(context).unfocus(),
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
                                      _confirmPasswordVisible.value = !value;
                                    },
                                  ),
                                ));
                          }),
                      16.verticalSpace,
                      const Spacer(
                        flex: 1,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _isValid,
                        builder: (context, value, child) {
                          return CustomButton(
                              width: double.infinity,
                              type: CustomButtonType.primary,
                              text: StringConstants.setPassword,
                              onPressed: value
                                  ? () {
                                      _cubit.ChangePassword(
                                          oldPasswordController.text,
                                          newPasswordController.text);
                                    }
                                  : null);
                        },
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _validate() =>
      _isValid.value = changePasswordFormKey.currentState!.validate();
}
