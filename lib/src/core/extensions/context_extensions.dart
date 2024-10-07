import 'package:flutter/material.dart';

extension OnContext on BuildContext {
  popAllNamed(
    String route, {
    dynamic arguments,
  }) =>
      Navigator.of(this).pushNamedAndRemoveUntil(
        route,
        arguments: arguments,
        (Route<dynamic> route) => false,
      );
}
