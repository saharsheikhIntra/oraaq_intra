import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final double? value;
  const LoadingIndicator({super.key, this.size = 48, this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
          width: size,
          height: size,
          child: const CircularProgressIndicator(
            strokeWidth: 8,
            value: 0,
          )),
      SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            value: value,
            strokeCap: StrokeCap.round,
          )),
    ]);
  }
}
