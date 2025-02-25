import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';

import '../../config/themes/color_theme.dart';
import '../../config/themes/text_style_theme.dart';

enum ApprovedRequestCardVariant { urgent, normal }

class ApprovedRequestCard extends StatelessWidget {
  final String userName;
  final String distance;
  final String date;
  final String time;
  final String price;
  final ApprovedRequestCardVariant variant;
  const ApprovedRequestCard({
    super.key,
    required this.userName,
    required this.distance,
    required this.date,
    required this.time,
    required this.price,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorTheme.black.withOpacity(0.02),
            blurRadius: 7,
            offset: const Offset(0, 8),
          ),
        ],
        color: ColorTheme.white,
        border: Border.all(
            color: variant == ApprovedRequestCardVariant.normal
                ? ColorTheme.neutral1
                : ColorTheme.secondary),
        borderRadius: 12.borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(userName, style: TextStyleTheme.titleSmall)),
              Text(distance, style: TextStyleTheme.bodyLarge),
              2.horizontalSpace,
              const Icon(
                Symbols.near_me_rounded,
                color: ColorTheme.primary,
                size: 20,
              ),
            ],
          ),
          2.verticalSpace,
          Row(
            children: [
              const Icon(
                Symbols.calendar_month_rounded,
                color: ColorTheme.neutral3,
                size: 16,
              ),
              4.horizontalSpace,
              Text(date,
                  style: TextStyleTheme.bodySmall.copyWith(
                    color: ColorTheme.secondaryText,
                  )),
              8.horizontalSpace,
              const Icon(
                Symbols.alarm_rounded,
                color: ColorTheme.neutral3,
                size: 16,
              ),
              4.horizontalSpace,
              Text(time,
                  style: TextStyleTheme.bodySmall
                      .copyWith(color: ColorTheme.secondaryText)),
            ],
          ),
          20.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Rs ",
                style: TextStyleTheme.bodySmall.copyWith(
                    color: ColorTheme.primary, fontWeight: FontWeight.bold),
              ),
              2.horizontalSpace,
              Text(
                price,
                style: TextStyleTheme.titleSmall
                    .copyWith(color: ColorTheme.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
