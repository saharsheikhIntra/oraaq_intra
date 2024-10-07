import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/presentaion/widgets/request_status_chip.dart';
import 'package:oraaq/src/presentaion/widgets/sub_services_wrap_view.dart';

import '../../config/themes/color_theme.dart';
import '../../config/themes/text_style_theme.dart';

class CancelRequestCard extends StatelessWidget {
  final List<String> servicesList;
  final String userName;
  final String duration;
  final String date;
  final String time;
  final String price;
  final VoidCallback onTap;

  const CancelRequestCard({
    super.key,
    required this.userName,
    required this.duration,
    required this.date,
    required this.time,
    required this.price,
    required this.servicesList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: 12.borderRadius,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
        decoration: BoxDecoration(
          color: ColorTheme.white,
          borderRadius: 12.borderRadius,
          border: Border.all(color: ColorTheme.neutral1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    userName,
                    style: TextStyleTheme.titleMedium,
                  ),
                ),
                const RequestStatusChip(
                  buttonText: "Cancelled",
                  size: RequestStatusChipSize.small,
                  color: RequestStatusChipColor.red,
                )
              ],
            ),
            8.verticalSpace,
            SubServicesChipWrapView(
                servicesList: servicesList,
                variant: SubServicesChipWrapViewVariant.forRequestCard),
            12.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "Rs ",
                        style: TextStyleTheme.labelMedium.copyWith(
                          color: ColorTheme.neutral3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(price,
                          style: TextStyleTheme.titleLarge
                              .copyWith(color: ColorTheme.neutral3)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildTime(Symbols.calendar_month_rounded, date),
                    6.verticalSpace,
                    _buildTime(Symbols.alarm_rounded, time),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildTime(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          text,
          textAlign: TextAlign.end,
          style: TextStyleTheme.bodySmall.copyWith(
            color: ColorTheme.secondaryText,
          ),
        ),
        8.horizontalSpace,
        Icon(
          icon,
          size: 18.0,
          color: ColorTheme.neutral3,
        ),
      ],
    );
  }
}
