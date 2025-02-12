import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/widgets/custom_button.dart';

import '../../../config/themes/text_style_theme.dart';
import '../sub_services_wrap_view.dart';

enum CompletedJobSheetVariant {
  customer,
  merchant,
}

class CompletedJobSheet extends StatefulWidget {
  final String? userName;
  final String? phoneNumber;
  final String? email;
  final List<String>? servicesList;
  final String? date;
  final String? time;
  final String? totalAmount;
  final String? serviceType;
  final int rating;
  final String? ratingByMerchant;
  final CompletedJobSheetVariant variant;
  const CompletedJobSheet({
    super.key,
    this.userName,
    this.phoneNumber,
    this.email,
    this.servicesList,
    this.date,
    this.time,
    this.totalAmount,
    this.serviceType = '',
    required this.rating,
    required this.variant,
    this.ratingByMerchant,
  });

  @override
  State<CompletedJobSheet> createState() => _CompletedJobSheetSheetState();
}

class _CompletedJobSheetSheetState extends State<CompletedJobSheet> {
  UserEntity user = getIt<UserEntity>();
  int rating = 0;

  @override
  void initState() {
    rating = widget.rating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.verticalSpace,
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              widget.userName ?? StringConstants.secondUser,
              style: TextStyleTheme.displaySmall
                  .copyWith(fontSize: 36, fontWeight: FontWeight.w600),
            )),
        // 8.verticalSpace,
        // Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 23.0),
        //     child: Row(
        //       children: [
        //         _buildTime(Symbols.phone_rounded,
        //             widget.phoneNumber ?? "031234563451"),
        //         16.horizontalSpace,
        //         _buildTime(
        //             Symbols.mail_rounded, widget.email ?? "amber.doe@mail,com"),
        //       ],
        //     )),
        25.verticalSpace,
        Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            color: ColorTheme.neutral1,
            child: SubServicesChipWrapView(
              servicesList: widget.servicesList ??
                  [
                    "Hair cut",
                    "Hair",
                    "Hair extension",
                    "Hair cut",
                    "Hair cut",
                    "Hair extension"
                  ],
              variant: SubServicesChipWrapViewVariant.forCompletedJobSheet,
            )),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          color: ColorTheme.white,
          child: Column(children: [
            if (widget.variant == CompletedJobSheetVariant.customer)
              _buildDetails(
                Symbols.build_rounded,
                "Service Type",
                widget.serviceType ?? "Ac Repair",
                valueColor: ColorTheme.primaryText,
              ),
            _buildDetails(
              Symbols.calendar_month_rounded,
              "Date",
              widget.date ?? "3rd March",
            ),
            _buildDetails(
              Symbols.alarm_rounded,
              "Time",
              widget.time ?? "3:30 pm",
            ),
            _buildDetails(
              Symbols.star_half_rounded,
              user.role == UserType.customer
                  ? "Rated by Merchant"
                  : "Rated by Customer",
              widget.ratingByMerchant ?? "4 / 5",
            ),
            _buildDetails(
              Symbols.payments_rounded,
              "Service Charges",
              widget.totalAmount ?? "Rs 0",
            ),
          ]),
        ),
        Center(
          child: Text(
            widget.variant == CompletedJobSheetVariant.customer
                ? StringConstants.rateMerchant
                : StringConstants.rateCustomer,
            style: TextStyleTheme.titleSmall,
          ),
        ),
        4.verticalSpace,
        Container(
            height: 48,
            alignment: Alignment.center,
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  5,
                  (index) => _buildStar(index),
                ))),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 24, 23, 20),
          child: CustomButton(
            width: double.infinity,
            type: CustomButtonType.primary,
            text: StringConstants.rateNow,
            onPressed: widget.rating == 0 &&
                    rating > 0 //rating > 0 && widget.rating != rating
                ? () => context.pop(result: rating)
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildTime(IconData icon, String text) => Row(children: [
        Icon(
          icon,
          size: 18.0,
          color: ColorTheme.secondaryText,
        ),
        6.horizontalSpace,
        Text(text,
            style: TextStyleTheme.bodyMedium.copyWith(
              color: ColorTheme.secondaryText,
            )),
      ]);

  Widget _buildDetails(
    IconData icon,
    String text,
    String value, {
    Color valueColor = ColorTheme.neutral3,
  }) =>
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20.0,
                  color: ColorTheme.neutral3,
                ),
                12.horizontalSpace,
                Text(
                  text,
                  style: TextStyleTheme.bodyLarge
                      .copyWith(color: ColorTheme.neutral3),
                ),
                const Spacer(),
                Text(
                  value,
                  style: TextStyleTheme.labelLarge.copyWith(color: valueColor),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: ColorTheme.neutral1,
          ),
        ],
      );

  Widget _buildStar(int index) {
    bool isSelected = rating > index;
    return Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: 12.borderRadius,
            onTap: widget.rating == 0 // Prevent re-rating if already rated
                ? () => setState(() => rating = index + 1)
                : null,
            //() => setState(() => rating = index + 1),
            child: Icon(
              Symbols.star_rate_rounded,
              size: 48,
              fill: isSelected ? 1 : 0,
              color: isSelected ? ColorTheme.secondary : ColorTheme.neutral3,
            )));
  }
}
