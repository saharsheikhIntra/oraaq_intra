import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/change_password/cubit/change_password_cubit.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/change_password/cubit/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  final ChangePasswordCubit _cubit = getIt.get<ChangePasswordCubit>();

  final FocusNode oldPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _oldPasswordVisible = false;
    _newPasswordVisible = false;
    _confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordStateError) {
            // Show error message using Toast
            DialogComponent.hideLoading(context);
            Toast.show(
              variant: SnackbarVariantEnum.warning,
              title: "Error",
              message:
                  state.error.message, // Assuming state.error has a message
              context: context, // Use the correct context
            );
          } else if (state is ChangePasswordStateLoaded) {
            DialogComponent.hideLoading(context);
            context.pop();
            // Show success message using Toast
            Toast.show(
              variant: SnackbarVariantEnum.success,
              title: "Success",
              message: state.res.message,
              context: context, // Use the correct context
            );
            // Optionally, navigate away or reset the fields
          } else if (state is ChangePasswordStateLoading) {
            // Show custom loading dialog when the state is loading
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
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    const Image(
                      image: AssetImage(AssetConstants.logoIcon),
                      height: 80,
                      width: 78,
                    ),
                    const Spacer(flex: 1),
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
                      focusnode: oldPasswordFocusNode,
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
                      focusnode: newPasswordFocusNode,
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
                      focusnode: confirmPasswordFocusNode,
                    ),
                    const Spacer(flex: 1),
                    CustomButton(
                      width: double.infinity,
                      type: CustomButtonType.primary,
                      text: StringConstants.setPassword,
                      onPressed: () {
                        // Hide the keyboard when the button is pressed
                        if (confirmPasswordController.text.isNotEmpty &&
                            oldPasswordController.text.isNotEmpty &&
                            newPasswordController.text.isNotEmpty) {
                          FocusScope.of(context).unfocus();

                          // Validate input fields
                          if (newPasswordController.text !=
                              confirmPasswordController.text) {
                            Toast.show(
                              variant: SnackbarVariantEnum.warning,
                              title: "Error",
                              message: "Passwords do not match.",
                              context: context, // Use the correct context
                            );
                            return;
                          }

                          // Trigger the change password action
                          _cubit.changePassword(
                            oldPasswordController.text,
                            newPasswordController.text,
                          );
                        } else {
                          Toast.show(
                            variant: SnackbarVariantEnum.warning,
                            title: "Error",
                            message: "fill all feilds.",
                            context: context, // Use the correct context
                          );
                        }
                      },
                    ),
                    const Spacer(flex: 2),
                  ],
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
    required FocusNode focusnode,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      focusNode: focusnode,
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
