import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/presentaion/widgets/request_status_chip.dart';
import 'package:oraaq/src/presentaion/widgets/sub_services_wrap_view.dart';

import '../../config/themes/color_theme.dart';
import '../../config/themes/text_style_theme.dart';

enum OngoingRequestCardVariant {
  waiting,
  offerAccepted,
  offerReceived,
}

class OnGoingRequestCard extends StatelessWidget {
  final List<String> servicesList;
  final OngoingRequestCardVariant variant;
  final String userName;
  final String? profileName;
  final String duration;
  final String date;
  final String time;
  final String price;
  final VoidCallback onTap;
  const OnGoingRequestCard({
    super.key,
    required this.userName,
    required this.duration,
    required this.date,
    required this.time,
    required this.price,
    required this.servicesList,
    required this.variant,
    this.profileName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap: onTap,
      borderRadius: 12.borderRadius,
      child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          
          decoration: BoxDecoration(
            color: ColorTheme.white,
            border: Border.all(
                color: variant == OngoingRequestCardVariant.offerAccepted
                    ? ColorTheme.neutral2
                    : ColorTheme.white),
            borderRadius: 12.borderRadius,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                      child: Text(userName,
                          style: TextStyleTheme.titleSmall.copyWith(
                            color: ColorTheme.secondaryText,
                          ))),
                  Text(
                    "Rs ",
                    style: TextStyleTheme.labelSmall.copyWith(
                      color: ColorTheme.secondaryText,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyleTheme.titleSmall.copyWith(
                      color: ColorTheme.secondaryText,
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              SubServicesChipWrapView(
                servicesList: servicesList,
                variant: SubServicesChipWrapViewVariant.forRequestCard,
              ),
              20.verticalSpace,
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTime(Symbols.calendar_month_rounded, date),
                    6.verticalSpace,
                    _buildTime(Symbols.alarm_rounded, time),
                  ],
                ),
                const Spacer(),
                if (variant == OngoingRequestCardVariant.waiting)
                  Text(
                    duration,
                    style: TextStyleTheme.labelLarge.copyWith(
                      color: ColorTheme.primary,
                    ),
                  ),
                if (variant == OngoingRequestCardVariant.offerAccepted)
                  const RequestStatusChip(
                    buttonText: "4 Offers Accepted",
                    size: RequestStatusChipSize.large,
                    color: RequestStatusChipColor.green,
                  ),
                if (variant == OngoingRequestCardVariant.offerReceived)
                  Row(children: [
                    const Icon(
                      Symbols.account_circle_rounded,
                      color: ColorTheme.primary,
                      size: 18.0,
                    ),
                    4.horizontalSpace,
                    Text(
                      profileName!,
                      style: TextStyleTheme.labelLarge.copyWith(
                        color: ColorTheme.primary,
                      ),
                    ),
                  ])
              ]),
            ],
          )),
    );
  }

  Widget _buildTime(IconData icon, String text) => Row(children: [
        Icon(
          icon,
          color: ColorTheme.neutral3,
          size: 18.0,
        ),
        8.horizontalSpace,
        Text(text,
            style: TextStyleTheme.bodySmall.copyWith(
              color: ColorTheme.secondaryText,
            )),
      ]);
}
