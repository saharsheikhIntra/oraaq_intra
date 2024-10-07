import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/presentaion/widgets/request_status_chip.dart';
import 'package:oraaq/src/presentaion/widgets/sub_services_wrap_view.dart';

import '../../config/themes/color_theme.dart';
import '../../config/themes/text_style_theme.dart';

enum NewRequestCardVariant {
  newRequest,
  alreadyApplied,
}

class NewRequestCard extends StatelessWidget {
  final List<String> servicesList;
  final String userName;
  final String distance;
  final String date;
  final String time;
  final String price;
  final String buttonText;
  final NewRequestCardVariant variant;

  const NewRequestCard({
    super.key,
    required this.servicesList,
    required this.userName,
    required this.distance,
    required this.date,
    required this.time,
    required this.price,
    required this.buttonText,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        color: ColorTheme.white,
        borderRadius: 12.borderRadius,
        border: Border.all(color: ColorTheme.neutral1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(userName, style: TextStyleTheme.titleMedium)),
              if (variant == NewRequestCardVariant.alreadyApplied)
                RequestStatusChip(
                  buttonText: buttonText,
                  size: RequestStatusChipSize.medium,
                  color: RequestStatusChipColor.green,
                ),
              if (variant == NewRequestCardVariant.newRequest)
                // Text(
                //   distance,
                //   textAlign: TextAlign.end,
                //   style: TextStyleTheme.bodyLarge,
                // ),
                RequestStatusChip(
                  buttonText: buttonText,
                  size: RequestStatusChipSize.medium,
                  color: RequestStatusChipColor.green,
                ),
            ],
          ),
          8.verticalSpace,
          SubServicesChipWrapView(
              servicesList: servicesList,
              variant: SubServicesChipWrapViewVariant.forRequestCard),
          16.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text("Rs",
                        style: TextStyleTheme.labelSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.primary,
                        )),
                    3.horizontalSpace,
                    Text(
                      price,
                      style: TextStyleTheme.titleLarge
                          .copyWith(color: ColorTheme.primary),
                    ),
                  ],
                ),
              ),
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
              16.horizontalSpace,
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
        ],
      ),
    );
  }
}
