import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';

class TextStyleTheme {
  static TextTheme get get => TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );

  //
  // DISPLAY
  //

  static TextStyle displayLarge = TextStyle(
    fontSize: 56,
    // height: 0.02,
    fontWeight: FontWeight.w600,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.lora().fontFamily,
  );

  static TextStyle displayMedium = TextStyle(
    fontSize: 45,
    // height: 0.03,
    fontWeight: FontWeight.w600,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.lora().fontFamily,
  );

  static TextStyle displaySmall = TextStyle(
    fontSize: 36,
    // height: 0.03,
    fontWeight: FontWeight.w600,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.lora().fontFamily,
  );

  //
  // HEADLINE
  //

  static TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    // height: 0.04,
    fontWeight: FontWeight.w700,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.lora().fontFamily,
  );

  static TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    // height: 0.04,
    fontWeight: FontWeight.w700,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.lora().fontFamily,
  );

  static TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    // height: 0.06,
    fontWeight: FontWeight.w700,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.lora().fontFamily,
  );

  //
  // TITLE
  //

  static TextStyle titleLarge = TextStyle(
    fontSize: 22,
    // height: 0.06,
    fontWeight: FontWeight.w700,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.barlow().fontFamily,
  );

  static TextStyle titleMedium = TextStyle(
    fontSize: 18,
    // height: 0.07,
    letterSpacing: 0.15,
    fontWeight: FontWeight.w600,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.barlow().fontFamily,
  );

  static TextStyle titleSmall = TextStyle(
    fontSize: 16,
    // height: 0.08,
    letterSpacing: 0.10,
    fontWeight: FontWeight.w600,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.barlow().fontFamily,
  );

  //
  // BODY
  //

  static TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    // height: 0.09,
    fontWeight: FontWeight.w500,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.barlow().fontFamily,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    // height: 0.11,
    fontWeight: FontWeight.w500,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.barlow().fontFamily,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 11,
    // height: 0.11,
    fontWeight: FontWeight.w500,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.barlow().fontFamily,
  );

  //
  // LABEL
  //

  static TextStyle labelLarge = TextStyle(
    fontSize: 14,
    // height: 0.08,
    fontWeight: FontWeight.w500,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.barlow().fontFamily,
  );

  static TextStyle labelMedium = TextStyle(
    fontSize: 12,
    // height: 0.08,
    fontWeight: FontWeight.w500,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.barlow().fontFamily,
  );

  static TextStyle labelSmall = TextStyle(
    fontSize: 11,
    // height: 0.11,
    fontWeight: FontWeight.w500,
    color: ColorTheme.primaryText,
    fontFamily: GoogleFonts.barlow().fontFamily,
  );
}
