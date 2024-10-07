import 'package:flutter/material.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import '../../config/themes/text_style_theme.dart';

enum RequestStatusChipSize { small, medium, large }

enum RequestStatusChipColor { red, green }

class RequestStatusChip extends StatelessWidget {
  final String buttonText;
  final RequestStatusChipSize size;
  final RequestStatusChipColor color;
  const RequestStatusChip({
    super.key,
    required this.buttonText,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = color == RequestStatusChipColor.green ? ColorTheme.secondary.shade700 : ColorTheme.error;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: color == RequestStatusChipColor.green ? ColorTheme.secondary.shade50 : ColorTheme.error.withOpacity(0.1),
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: size == RequestStatusChipSize.large ? 8 : 6,
                ),
                child: Text(
                  buttonText,
                  style: switch (size) {
                    RequestStatusChipSize.large => TextStyleTheme.labelLarge.copyWith(color: textColor),
                    RequestStatusChipSize.medium => TextStyleTheme.labelMedium.copyWith(color: textColor),
                    RequestStatusChipSize.small => TextStyleTheme.labelSmall.copyWith(color: textColor),
                  },
                ))),
      ],
    );
  }
}
