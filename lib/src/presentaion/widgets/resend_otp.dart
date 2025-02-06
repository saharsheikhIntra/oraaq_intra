import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/presentaion/widgets/custom_button.dart';

class ResendOtpWidget extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onResend;

  const ResendOtpWidget({
    super.key,
    required this.duration,
    this.onResend,
  });

  @override
  State<ResendOtpWidget> createState() => _ResendOtpWidgetState();
}

class _ResendOtpWidgetState extends State<ResendOtpWidget> {
  Timer? _timer;
  Duration _timeElapsed = Duration.zero;

  void _startTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel(); // Cancel existing timer
    }
    _timeElapsed = Duration.zero; // Reset
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_timeElapsed < widget.duration) {
          _timeElapsed = _timeElapsed + const Duration(seconds: 1);
        } else {
          _timer!.cancel(); //cancel the timer when done
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onResendPress() {
    if (widget.onResend != null) {
      widget.onResend!();
    }
    _startTimer(); // Restart timer
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = widget.duration - _timeElapsed;
    final isTimerCompleted = remainingTime <= Duration.zero;

    return isTimerCompleted
        ? CustomButton(
            text: 'Resend',
            type: CustomButtonType.primary,
            size: CustomButtonSize.small,
            onPressed: _onResendPress,
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                strokeWidth: 2,
                color: ColorTheme.secondary,
                backgroundColor: ColorTheme.secondary.shade100,
                value: _timeElapsed.inSeconds / widget.duration.inSeconds,
              ),
              Padding(
                padding: 2.bottomPadding,
                child: Text(
                  '${remainingTime.inSeconds}s',
                  style: TextStyleTheme.labelMedium
                      .copyWith(color: ColorTheme.primaryText),
                ),
              ),
            ],
          );
  }
}
