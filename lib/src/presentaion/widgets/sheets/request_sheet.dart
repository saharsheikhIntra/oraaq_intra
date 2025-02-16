import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/presentaion/widgets/custom_button.dart';
import 'package:oraaq/src/presentaion/widgets/sheets/sheet_component.dart';

import '../../../config/themes/text_style_theme.dart';
import '../../../core/constants/string_constants.dart';
import '../sub_services_wrap_view.dart';

class RequestSheet extends StatefulWidget {
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? distance;
  final String? serviceName;
  final List<String>? servicesList;
  final String? date;
  final String? time;
  final String? amount;
  final VoidCallback onCancel;

  const RequestSheet({
    super.key,
    this.name,
    this.phoneNumber,
    this.email,
    this.distance,
    this.servicesList,
    this.date,
    this.time,
    this.amount,
    this.serviceName,
    required this.onCancel,
    //  required this.onCancel,
  });

  @override
  State<RequestSheet> createState() => _RequestSheetState();
}

class _RequestSheetState extends State<RequestSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.verticalSpace,
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              widget.name ?? StringConstants.johnDoe,
              style: TextStyleTheme.displaySmall,
            )),
        16.verticalSpace,
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Column(
              children: [
                // _buildTime(Symbols.phone_rounded, widget.phoneNumber ?? "N/A"),
                // 12.verticalSpace,
                // _buildTime(Symbols.mail_rounded, widget.email ?? "N/A"),
                // 12.verticalSpace,
                _buildTime(
                    Symbols.my_location_rounded, widget.distance ?? "N/A"),
              ],
            )),
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
            _buildDetails(
              Symbols.calendar_month_rounded,
              "Date",
              widget.date ?? "N/A",
            ),
            _buildDetails(
              Symbols.alarm_rounded,
              "Time",
              widget.time ?? "N/A",
            ),
            _buildDetails(
              Symbols.build_rounded,
              "Service Type",
              widget.serviceName ?? "N/A",
            ),
            _buildDetails(
              Symbols.payments_rounded,
              "Service Charges",
              widget.amount ?? "N/A",
            ),
          ]),
        ),
        Padding(
          padding: 24.horizontalPadding,
          child: CustomButton(
            width: double.infinity,
            type: CustomButtonType.primary,
            text: "Action",
            onPressed: () {
              SheetComponenet.showWarningSheet(context,
                  title: "What would you like to do?",
                  message:
                      "You can either cancel the order or keep it continue. Select an option below.",
                  ctaText: "Cancel Order",
                  cancelText: "Keep Order", onCtaTap: () {
                widget.onCancel();
                context.pop();
                context.pop();
                
                // context.popUntil(RouteConstants.customerHomeScreenRoute);
              },
                  // context.popUntil(RouteConstants.customerHomeScreenRoute),
                  onCancelTap: () {
                // widget.onCancel();
                context.pop();
                context.pop();

                // context.popUntil(RouteConstants.customerHomeScreenRoute);
              }
                  // context.popUntil(RouteConstants.customerHomeScreenRoute),
                  );
            },
          ),
        ),
        24.verticalSpace,
      ],
    );
  }

  Widget _buildTime(IconData icon, String text) => Row(children: [
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: 8.borderRadius,
            color: ColorTheme.neutral1,
            border: Border.all(
              color: ColorTheme.neutral2,
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: 18.0,
            color: ColorTheme.secondaryText,
          ),
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
}
