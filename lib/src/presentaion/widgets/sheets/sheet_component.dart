import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/core/extensions/widget_extension.dart';
import 'package:oraaq/src/presentaion/widgets/custom_button.dart';
import 'package:oraaq/src/presentaion/widgets/selection_button.dart';

part 'package:oraaq/src/presentaion/widgets/sheets/warning_sheet.dart';
part 'package:oraaq/src/presentaion/widgets/sheets/selection_sheet.dart';
part 'package:oraaq/src/presentaion/widgets/sheets/multi_selection_sheet.dart';

enum SheetBackground { white, blue, red }

class SheetComponenet {
  static show(
    BuildContext context, {
    Widget? child,
    bool isScrollControlled = false,
    SheetBackground background = SheetBackground.blue,
  }) =>
      showModalBottomSheet(
          context: context,
          isDismissible: true,
          isScrollControlled: isScrollControlled,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.white.withOpacity(0.5),
          elevation: background == SheetBackground.white ? 16 : 0,
          builder: (context) => _SheetBackground(
                background: background,
                isScrollControlled: isScrollControlled,
                child: child,
              ));

  static showWarningSheet(
    BuildContext context, {
    required String title,
    required String message,
    required String ctaText,
    required String cancelText,
    required VoidCallback onCtaTap,
    required VoidCallback onCancelTap,
  }) =>
      show(context,
          isScrollControlled: true,
          background: SheetBackground.red,
          child: _WarningSheet(
            title: title,
            message: message,
            ctaText: ctaText,
            cancelText: cancelText,
            onCtaTap: onCtaTap,
            onCancelTap: onCancelTap,
          ));

  static showMultipleSelectionSheet(
    BuildContext context, {
    required String title,
    required List<String> options,
    required List<String> selectedOptions,
  }) =>
      show(context,
          background: SheetBackground.white,
          isScrollControlled: true,
          child: _MultiSelectionSheet(
            title: title,
            options: options,
            selectedOptions: selectedOptions,
          ));

  static showSelectionSheet(
    BuildContext context, {
    required String title,
    required List<String> options,
    String? selected,
  }) =>
      show(context,
          isScrollControlled: true,
          background: SheetBackground.white,
          child: _SelectionSheet(
            title: title,
            options: options,
            selected: selected,
          ));
}

class _SheetBackground extends StatelessWidget {
  final Widget? child;
  final SheetBackground background;
  final bool isScrollControlled;
  const _SheetBackground({
    required this.child,
    required this.background,
    required this.isScrollControlled,
  });

  final double width = double.infinity;

  @override
  Widget build(BuildContext context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Container(
          width: width,
          constraints: isScrollControlled
              ? BoxConstraints(
                  minHeight: 160,
                  maxHeight: ScreenUtil().screenHeight * 0.95,
                )
              : null,
          decoration: BoxDecoration(
              borderRadius: 24.topBorderRadius,
              color:
                  background == SheetBackground.white ? ColorTheme.white : null,
              gradient: switch (background) {
                SheetBackground.white => null,
                SheetBackground.blue => LinearGradient(colors: [
                    ColorTheme.secondary.shade50,
                    ColorTheme.primary.shade100,
                  ]),
                SheetBackground.red => const LinearGradient(
                    stops: [0, 0.25, 1],
                    colors: [
                      Color(0xFFFFE6C1),
                      Color(0xFFFFEEE6),
                      Color(0xFFFFE6E4),
                    ],
                  ),
              }),
          child: Container(
              width: width,
              decoration: BoxDecoration(
                  borderRadius: 24.topBorderRadius,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 0.1, 0.3],
                    colors: [
                      ColorTheme.white.withOpacity(0),
                      ColorTheme.white.withOpacity(0.6),
                      ColorTheme.white,
                    ],
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: 80,
                      height: 4,
                      margin: 16.allPadding,
                      decoration: BoxDecoration(
                        color: background == SheetBackground.white
                            ? ColorTheme.neutral2
                            : ColorTheme.neutral3,
                        borderRadius: 2.borderRadius,
                      )),
                  if (child != null) child!,
                ],
              ))));
}
