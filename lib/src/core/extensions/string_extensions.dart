import 'package:flutter/material.dart';

extension OnString on String {
  Color hexToColor() {
    final hexString = replaceFirst('#', '');
    if (hexString.length != 6) {
      throw ArgumentError('Invalid hex string length: $hexString');
    }

    final red = int.parse(hexString.substring(0, 2), radix: 16);
    final green = int.parse(hexString.substring(2, 4), radix: 16);
    final blue = int.parse(hexString.substring(4, 6), radix: 16);

    return Color(0xFF000000 | (red << 16) | (green << 8) | blue);
  }
}
