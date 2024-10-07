import 'package:flutter/material.dart';

extension OnColor on Color {
  String colorToHex() {
    final alpha = this.alpha << 24;
    final red = this.red << 16;
    final green = this.green << 8;
    final blue = this.blue;

    final hexCode = (alpha + red + green + blue).toRadixString(16).padLeft(8, '0');
    return '#$hexCode';
  }
}
