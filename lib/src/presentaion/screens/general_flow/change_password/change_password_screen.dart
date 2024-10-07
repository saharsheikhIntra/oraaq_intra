import 'package:oraaq/src/imports.dart';

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

  @override
  void initState() {
    super.initState();
    _oldPasswordVisible = false;
    _newPasswordVisible = false;
    _confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ),
                const Spacer(
                  flex: 1,
                ),
                CustomButton(
                  width: double.infinity,
                  type: CustomButtonType.primary,
                  text: StringConstants.setPassword,
                  onPressed: () {},
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
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
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
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
