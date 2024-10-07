import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';

import '../../config/themes/color_theme.dart';

class ToastMessageCard extends StatelessWidget {
  final String heading;
  final String message;
  const ToastMessageCard(
      {super.key, required this.heading, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        height: 240,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        decoration: const BoxDecoration(
          color: ColorTheme.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Symbols.brightness_alert_rounded,
              color: ColorTheme.primary,
              size: 40,
            ),
            8.verticalSpace,
            Text(
              heading,
              style: TextStyleTheme.titleSmall
                  .copyWith(color: ColorTheme.secondaryText),
            ),
            8.verticalSpace,
            Expanded(
                child: Text(
              message,
              style: TextStyleTheme.bodyMedium.copyWith(
                  color: ColorTheme.secondaryText, fontWeight: FontWeight.w400),
            )),
          ],
        ),
      ),
    );
  }
}
