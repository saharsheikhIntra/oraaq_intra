import 'package:flutter/material.dart';
import 'package:oraaq/src/core/constants/asset_constants.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';

import '../../config/themes/color_theme.dart';

class NoDataFound extends StatelessWidget {
  final String? text;
  final double? fontSize;
  const NoDataFound({
    this.text,
    super.key,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) => Center(
          child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            AssetConstants.noDataFound,
            color: ColorTheme.scaffold,
            colorBlendMode: BlendMode.multiply,
          ),
          Positioned(
              bottom: 24,
              child: Text(text ?? StringConstants.noDataFound,
                  style: TextStyle(
                    fontSize: fontSize ?? 24,
                    fontWeight: FontWeight.w600,
                    color: ColorTheme.secondaryText,
                  ))),
        ],
      ));
}
