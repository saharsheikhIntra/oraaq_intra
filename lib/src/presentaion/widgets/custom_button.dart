import 'package:flutter/material.dart';

import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';

enum CustomButtonType { primary, secondary, tertiary, tertiaryBordered, danger }

enum CustomButtonSize { large, small }

enum CustomButtonIconPosition { leading, trailing }

class CustomButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final double? iconSize;
  // final bool isEnabled;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final CustomButtonType type;
  final CustomButtonSize size;
  final CustomButtonIconPosition iconPosition;
  CustomButton({
    super.key,
    this.text,
    this.icon,
    this.width,
    this.height,
    this.iconSize,
    this.onPressed,
    this.type = CustomButtonType.primary,
    this.size = CustomButtonSize.large,
    this.iconPosition = CustomButtonIconPosition.leading,
  }) {
    assert(
      text != null || icon != null,
      "Both text and icon cannot be null at the same time",
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor, foregroundColor;
    bool isEnabled = onPressed != null;
    BorderRadius borderRadius = 8.borderRadius;

    switch (type) {
      case CustomButtonType.primary when isEnabled:
        backgroundColor = ColorTheme.primary.shade400;
        foregroundColor = ColorTheme.white;
        break;

      case CustomButtonType.secondary when isEnabled:
        backgroundColor = ColorTheme.secondary.shade400;
        foregroundColor = ColorTheme.onSecondary;
        break;

      case CustomButtonType.tertiary when isEnabled:
        backgroundColor = ColorTheme.neutral1;
        foregroundColor = ColorTheme.primaryText;
        break;

      case CustomButtonType.tertiaryBordered when isEnabled:
        backgroundColor = ColorTheme.white;
        foregroundColor = ColorTheme.primaryText;
        break;

      case CustomButtonType.danger when isEnabled:
        backgroundColor = ColorTheme.error;
        foregroundColor = ColorTheme.white;
        break;

      case CustomButtonType.primary:
        backgroundColor = ColorTheme.primary.shade100;
        foregroundColor = ColorTheme.neutral3;
        break;

      case CustomButtonType.secondary:
        backgroundColor = ColorTheme.secondary.shade100;
        foregroundColor = ColorTheme.neutral3;
        break;

      case CustomButtonType.tertiary:
        backgroundColor = ColorTheme.scaffold;
        foregroundColor = ColorTheme.neutral3;
        break;

      case CustomButtonType.tertiaryBordered:
        backgroundColor = ColorTheme.scaffold;
        foregroundColor = ColorTheme.neutral3;
        break;

      case CustomButtonType.danger:
        backgroundColor = const Color(0xFFFFC0BC);
        foregroundColor = ColorTheme.white;
        break;
    }

    return Material(
        borderRadius: borderRadius,
        child: InkWell(
            onTap: onPressed,
            borderRadius: borderRadius,
            child: Ink(
                padding: _getPadding,
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: borderRadius,
                  border: type == CustomButtonType.tertiaryBordered
                      ? Border.all(color: ColorTheme.neutral2)
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null &&
                        iconPosition == CustomButtonIconPosition.leading)
                      _buildIcon(foregroundColor),
                    if (text != null) _buildText(foregroundColor),
                    if (icon != null &&
                        iconPosition == CustomButtonIconPosition.trailing)
                      _buildIcon(foregroundColor),
                  ],
                ))));
  }

  EdgeInsets get _getPadding {
    if (text == null && icon != null && size == CustomButtonSize.small) {
      return 8.allPadding;
    }
    if (text != null && icon != null) {
      return const EdgeInsets.fromLTRB(24, 12, 16, 12);
    }
    if (text == null && icon != null) return 12.allPadding;
    if (icon != null && size == CustomButtonSize.small) {
      return const EdgeInsets.fromLTRB(12, 8, 16, 8);
    }
    if (icon != null) return const EdgeInsets.fromLTRB(24, 12, 32, 12);
    if (size == CustomButtonSize.large) {
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    }
    if (size == CustomButtonSize.small) {
      return const EdgeInsets.fromLTRB(12, 4, 12, 6);
    }
    return 12.allPadding;
  }

  Widget _buildIcon(Color color) {
    return Padding(
        padding: text == null
            ? 0.allPadding
            : iconPosition == CustomButtonIconPosition.leading
                ? 12.endPadding
                : 12.startPadding,
        child: Icon(
          icon,
          color: color,
          weight: 400,
          size: iconSize ?? (size == CustomButtonSize.large ? 32 : 24),
        ));
  }

  Widget _buildText(Color color) {
    TextStyle style = size == CustomButtonSize.large
        ? TextStyleTheme.titleMedium
        : TextStyleTheme.labelLarge;
    return Text(
      text!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style.copyWith(color: color, fontWeight: FontWeight.bold),
    );
  }
}
