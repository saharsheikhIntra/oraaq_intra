import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/presentaion/widgets/sub_services_wrap_view.dart';

import '../../config/themes/color_theme.dart';
import '../../config/themes/text_style_theme.dart';

enum CompletedRequestCardVariant {
  customer,
  merchant,
}

class CompletedRequestCard extends StatelessWidget {
  final List<String> servicesList;
  final CompletedRequestCardVariant variant;
  final String userName;
  final String? profileName;
  final String duration;
  final String date;
  final String ratings;
  final String price;
  final int rating;
  final VoidCallback onTap;
  const CompletedRequestCard({
    super.key,
    required this.userName,
    required this.duration,
    required this.date,
    required this.ratings,
    required this.price,
    required this.servicesList,
    required this.rating,
    required this.variant,
    this.profileName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: 12.borderRadius,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: ColorTheme.white,
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
                      color: ColorTheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyleTheme.titleSmall.copyWith(
                      color: ColorTheme.primary,
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              SubServicesChipWrapView(
                  servicesList: servicesList,
                  variant: SubServicesChipWrapViewVariant.forRequestCard),
              20.verticalSpace,
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTime(Symbols.calendar_month_rounded, date),
                    6.verticalSpace,
                    _buildTime(Symbols.star_half_rounded, ratings),
                  ],
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: ColorTheme.neutral1,
                      width: 1.0,
                    ),
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    color: ColorTheme.scaffold,
                    child: Column(
                      children: [
                        Text(
                          variant == CompletedRequestCardVariant.customer
                              ? "Rate Customer"
                              : "Rate Merchant",
                          style: TextStyleTheme.labelSmall.copyWith(
                              color: ColorTheme.secondaryText,
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                        3.verticalSpace,
                        Row(children: [
                          _buildStar(rating >= 1),
                          _buildStar(rating >= 2),
                          _buildStar(rating >= 3),
                          _buildStar(rating >= 4),
                          _buildStar(rating >= 5),
                        ]),
                      ],
                    ),
                  ),
                ),
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

  Widget _buildStar(bool isHighlighted) {
    return Icon(
      Symbols.star_rounded,
      fill: isHighlighted ? 1 : 0,
      color: isHighlighted ? ColorTheme.secondary : ColorTheme.neutral3,
      size: 20,
    );
  }
}
