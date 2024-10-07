import 'dart:math' as math;

import 'package:flutter/material.dart';

extension OnWidget on Widget {
  Padding wrapInPadding(EdgeInsetsGeometry padding) =>
      Padding(padding: padding, child: this);

  Opacity withOpacity(double opacity) => Opacity(opacity: opacity, child: this);

  Widget flipHorizontally() => Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: this,
      );
}
