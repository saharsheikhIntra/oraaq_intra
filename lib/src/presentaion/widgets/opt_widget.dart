import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';

class OtpWidget extends StatefulWidget {
  final ValueNotifier<bool> onOtpVerified;
  final ValueNotifier<int> onEnteredOtp;
  final String generatedOtp;
  const OtpWidget({
    super.key,
    required this.onOtpVerified,
    required this.onEnteredOtp,
    required this.generatedOtp,
  });

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 4,
      controller: _controller,
      focusNode: _focusNode,
      errorTextStyle:
          TextStyleTheme.labelMedium.copyWith(color: ColorTheme.error),
      defaultPinTheme: pinTheme(),
      focusedPinTheme: pinTheme(isFocused: true),
      submittedPinTheme: pinTheme(),
      followingPinTheme: pinTheme(),
      errorPinTheme: pinTheme(),

      // The validator will be set according to the API response
      validator: (value) {
        return _hasError ? 'Wrong code. Try again.' : null;
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      onCompleted: (pin) async {
        //temporary
        bool isOtpValid = pin == widget.generatedOtp;

        if (isOtpValid) {
          // navigate to next screen
          widget.onOtpVerified.value = true;
          widget.onEnteredOtp.value = int.parse(pin);
        } else {
          // If not valid, show error and clear the input
          setState(() {
            _hasError = true;
          });
          // _controller.clear();
        }
      },
    );
  }

  // Future<bool> verifyOtp(String pin) async {
  //   bool isValid = pin == "12345";
  //   setState(() {
  //     _hasError = !isValid;
  //   });
  //   return isValid;
  // }

  PinTheme pinTheme({bool isFocused = false}) {
    return PinTheme(
      width: isFocused ? 72 : 60,
      height: isFocused ? 72 : 60,
      textStyle: TextStyleTheme.titleLarge.copyWith(
        color: _hasError ? ColorTheme.error : ColorTheme.primary.shade700,
      ),
      decoration: BoxDecoration(
        color: _hasError
            ? ColorTheme.error.withOpacity(0.1)
            : ColorTheme.primary.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: isFocused ? 2 : 0.5,
          color: _hasError ? ColorTheme.error : ColorTheme.primary,
        ),
      ),
    );
  }
}
