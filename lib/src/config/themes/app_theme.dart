import 'package:flutter/material.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';

class AppTheme {
  static ThemeData get = ThemeData(
      useMaterial3: true,
      textTheme: TextStyleTheme.get,
      colorSchemeSeed: ColorTheme.primary,
      visualDensity: VisualDensity.comfortable,
      scaffoldBackgroundColor: ColorTheme.scaffold,
      splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
      dividerTheme: const DividerThemeData(color: ColorTheme.neutral1, thickness: 2),
      iconTheme: const IconThemeData(
        grade: -25,
        weight: 300,
        opticalSize: 48,
        color: ColorTheme.primaryText,
      ),
      appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          backgroundColor: ColorTheme.scaffold,
          titleTextStyle: TextStyleTheme.titleMedium),
      tabBarTheme: TabBarTheme(
          labelColor: ColorTheme.primary,
          dividerColor: ColorTheme.neutral2,
          indicatorColor: ColorTheme.primary,
          labelStyle: TextStyleTheme.labelLarge,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelStyle: TextStyleTheme.labelLarge,
          unselectedLabelColor: ColorTheme.secondaryText),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(shape: _buttonBorder)),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(shape: _buttonBorder)),
      outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(shape: _buttonBorder)),
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: ColorTheme.primary,
          linearTrackColor: ColorTheme.primary.shade50,
          circularTrackColor: ColorTheme.primary.shade50,
          refreshBackgroundColor: ColorTheme.primary.shade50),
      inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          hintStyle: TextStyleTheme.bodyMedium,
          labelStyle: TextStyleTheme.labelLarge,
          border: _inputBorder(),
          enabledBorder: _inputBorder(),
          errorBorder: _inputBorder(borderColor: ColorTheme.error, borderWidth: 1),
          focusedErrorBorder: _inputBorder(borderColor: ColorTheme.error, borderWidth: 2),
          disabledBorder: _inputBorder(borderColor: ColorTheme.neutral2, borderWidth: 1.5),
          focusedBorder: _inputBorder(borderColor: ColorTheme.primary.shade400, borderWidth: 2)));

  static OutlineInputBorder _inputBorder({
    Color borderColor = ColorTheme.secondaryText,
    double borderWidth = 1,
  }) {
    return OutlineInputBorder(
        borderRadius: 8.borderRadius,
        borderSide: BorderSide(
          color: borderColor,
          width: borderWidth,
        ));
  }

  static final _buttonBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0));
}
