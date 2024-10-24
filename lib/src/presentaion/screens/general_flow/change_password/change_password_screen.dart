import 'dart:developer';

import 'package:oraaq/src/core/extensions/context_extensions.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/change_password/change_password_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/change_password/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}
final changePasswordFormKey = GlobalKey<FormState>();

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;
  final FocusNode _oldPasswordFocusNode = FocusNode();
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  final ChangePasswordCubit _cubit = getIt.get<ChangePasswordCubit>();

  @override
  void initState() {
    super.initState();
    _oldPasswordVisible = false;
    _newPasswordVisible = false;
    _confirmPasswordVisible = false;
  }
  
  @override
  void dispose() {
    super.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(backgroundColor: ColorTheme.transparent),
          body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
            listener: (context, state) {
              if(state is ChangePasswordStateSuccess){
                DialogComponent.hideLoading(context);
                oldPasswordController.text = '';
                newPasswordController.text = '';
                confirmPasswordController.text = '';
                FocusScope.of(context).unfocus();
                context.pop();
                Toast.show(context: context, variant: SnackbarVariantEnum.success, title: state.response.status!,message: state.response.message);
                
              }else if(state is ChangePasswordStateError){
                DialogComponent.hideLoading(context);
                // FocusScope.of(context).unfocus();
                FocusScope.of(context).unfocus();
                Toast.show(context: context, variant: SnackbarVariantEnum.warning, title: state.error.code!, message: state.error.message);
                _confirmPasswordFocusNode.unfocus();
                _newPasswordFocusNode.unfocus();
                _oldPasswordFocusNode.unfocus();
                // showSnackBar(context, StringConstants.passwordChangedSuccessfully);  
              }else if(state is ChangePasswordStateLoading){
                DialogComponent.showLoading(context);
                FocusScope.of(context).unfocus();
                // Toast.show(context: context, variant: SnackbarVariantEnum.normal, title: 'Loading');
              }
    
            },
            child: SingleChildScrollView(
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
                        buildPasswordTextField(
                          controller: oldPasswordController,
                          hintText: StringConstants.oldPassword,
                          isVisible: _oldPasswordVisible,
                          onPressed: () {
                            setState(() {
                              _oldPasswordVisible = !_oldPasswordVisible;
                            });
                          },
                          node: _oldPasswordFocusNode,
                        ),
                        12.verticalSpace,
                        buildPasswordTextField(
                          controller: newPasswordController,
                          hintText: StringConstants.newPassword,
                          isVisible: _newPasswordVisible,
                          onPressed: () {
                            setState(() {
                              _newPasswordVisible = !_newPasswordVisible;
                            });
                          },
                          node: _newPasswordFocusNode,
                          validator: ValidationUtils.checkStrongPassword,
                        ),
                        12.verticalSpace,
                        buildPasswordTextField(
                          controller: confirmPasswordController,
                          hintText: StringConstants.confirmPassword,
                          isVisible: _confirmPasswordVisible,
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible = !_confirmPasswordVisible;
                            });
                          },
                          node: _confirmPasswordFocusNode,
                          validator: ValidationUtils.checkStrongPassword,
                          ),
                        const Spacer(
                          flex: 1,
                        ),
                        CustomButton(
                          width: double.infinity,
                          type: CustomButtonType.primary,
                          text: StringConstants.setPassword,
                          onPressed: () {
                            if(changePasswordFormKey.currentState!.validate()){
                              String oldPassword = oldPasswordController.text;
                            String newPassword = newPasswordController.text;
                            String confirmPassword = confirmPasswordController.text;
                            if (oldPassword.isNotEmpty &&
                                newPassword.isNotEmpty &&
                                confirmPassword.isNotEmpty) {
                              String? validate = ValidationUtils.confirmPassword(
                                  newPassword, confirmPassword);
                              if (validate == null) {
                                _cubit.changePassword(oldPassword, newPassword);
                                FocusScope.of(context).unfocus();
                              } else {
                                // showSnackBar(context, StringConstants.passwordsDoNotMatch);
                                log('message: $validate');
                                Toast.show(context: context, variant: SnackbarVariantEnum.warning, title: StringConstants.errorMessage,message: validate);
                                FocusScope.of(context).unfocus();
                              }
                            } else {
                              Toast.show(context: context, variant: SnackbarVariantEnum.warning, title: StringConstants.errorMessage,message: StringConstants.fillAllFields);
                              // showSnackBar(context, StringConstants.fillAllFields);
                              FocusScope.of(context).unfocus();
                            }
                            }
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

  Widget buildPasswordTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isVisible,
    required VoidCallback onPressed,
    required node,
    Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      focusNode: node,
      validator: (value) => validator != null ? validator(value) : null,
      decoration: InputDecoration(

        hintText: hintText,
        hintStyle: TextStyleTheme.bodyLarge,
        suffixIcon: IconButton(
          icon: Icon(
            isVisible
                ? Symbols.visibility_rounded
                : Symbols.visibility_off_rounded,
            color: ColorTheme.primaryText,
            size: 24,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
