import 'package:flutter/material.dart';

class ColorTheme {
  static const int _primaryDefault = 0xFF0079FF;
  static const MaterialColor primary = MaterialColor(
    _primaryDefault,
    {
      50: Color(0xFFE3F2FF),
      100: Color(0xFFC9E5FF),
      200: Color(0xFF8CCAFF),
      300: Color(0xFF48AFFF),
      400: Color(0xFF0094FF),
      500: Color(_primaryDefault),
      600: Color(0xFF0062D3),
      700: Color(0xFF00479F),
      800: Color(0xFF00326B),
      900: Color(0xFF001935),
    },
  );

  static const int _secondaryDefault = 0xFF00DFB4;
  static const MaterialColor secondary = MaterialColor(
    _secondaryDefault,
    {
      50: Color(0xFFDFFFFA),
      100: Color(0xFFC3FEF4),
      200: Color(0xFF80FCE4),
      300: Color(0xFF29F4D5),
      400: Color(0xFF00E6C4),
      500: Color(_secondaryDefault),
      600: Color(0xFF00D0A0),
      700: Color(0xFF009C79),
      800: Color(0xFF006951),
      900: Color(0xFF003429),
    },
  );

  static const Color black = Color(0xFF000000);
  static const Color primaryText = Color(0xFF000D1B);
  static const Color secondaryText = Color(0xFF475662);
  static const Color onPrimary = Color(0xFF002540);
  static const Color onSecondary = Color(0xFF003A31);
  static const Color error = Color(0xFFFF3F32);
  static const Color transparent = Color(0x00F7F9FF);
  static const Color scaffold = Color(0xFFF7F9FF);
  static const Color neutral1 = Color(0xFFF0F5FA);
  static const Color neutral2 = Color(0xFFD0D9E0);
  static const Color neutral3 = Color(0xFF8998A3);
  static const Color white = Color(0xFFFFFFFF);
}
