import 'package:flutter/material.dart';

import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';

class SelectionButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final double? width;
  final double? height;
  final bool isSelected;
  final Color backgroundColor;
  final VoidCallback onPressed;
  const SelectionButton({
    super.key,
    this.icon,
    this.width,
    this.height,
    required this.title,
    required this.isSelected,
    required this.onPressed,
    this.backgroundColor = ColorTheme.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: icon != null
            ? OutlinedButton.icon(
                onPressed: onPressed,
                icon: Icon(icon, weight: 600, fill: isSelected ? 1 : 0),
                style: _buttonStyle,
                label: _text,
              )
            : OutlinedButton(
                onPressed: onPressed,
                style: _buttonStyle,
                child: _text,
              ));
  }

  get _text => Text(title,
      style: TextStyleTheme.titleSmall.copyWith(
        color:
            isSelected ? ColorTheme.primary.shade700 : ColorTheme.primaryText,
      ));

  get _buttonStyle => OutlinedButton.styleFrom(
        side: BorderSide(
            width: 2,
            color:
                isSelected ? ColorTheme.primary.shade400 : Colors.transparent),
        backgroundColor: backgroundColor,
        foregroundColor:
            isSelected ? ColorTheme.primary.shade700 : ColorTheme.primaryText,
      );
}
