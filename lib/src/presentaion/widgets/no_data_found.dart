import 'package:flutter/material.dart';
import 'package:oraaq/src/core/constants/asset_constants.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';

import '../../config/themes/color_theme.dart';

class NoDataFound extends StatelessWidget {
  final String? tempText;
  final String? text;

  final double? fontSize;
  const NoDataFound({
    this.tempText,
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
          tempText != null
              ? Positioned(
                  bottom: 24,
                  child: Text(tempText ?? StringConstants.noDataFound,
                      style: TextStyle(
                        fontSize: fontSize ?? 24,
                        fontWeight: FontWeight.w600,
                        color: ColorTheme.secondaryText,
                      )))
              : const SizedBox.shrink(),
          Positioned(
              bottom: tempText == null ? 24 : 10,
              child: Text(text ?? StringConstants.noDataFound,
                  style: TextStyle(
                    fontSize: fontSize ?? 24,
                    fontWeight: FontWeight.w600,
                    color: ColorTheme.secondaryText,
                  ))),
        ],
      ));
}
