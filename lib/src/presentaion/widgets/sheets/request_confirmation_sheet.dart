import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/config/themes/color_theme.dart';
import 'package:oraaq/src/core/constants/route_constants.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/presentaion/widgets/custom_button.dart';
import '../../../config/themes/text_style_theme.dart';
import '../sub_services_wrap_view.dart';

class RequestConfirmationSheet extends StatefulWidget {
  final dynamic onConfirm;
  // final String address;
  // final String serviceType;
  // final
  const RequestConfirmationSheet({
    super.key,
    required this.onConfirm,
  });

  @override
  State<RequestConfirmationSheet> createState() =>
      _RequestConfirmationSheetState();
}

class _RequestConfirmationSheetState extends State<RequestConfirmationSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.verticalSpace,
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Ready To Proceed?",
              style: TextStyleTheme.headlineLarge
                  .copyWith(color: ColorTheme.secondaryText),
            )),
        16.verticalSpace,
        Column(children: [
          const Divider(
            thickness: 1,
            color: ColorTheme.neutral1,
          ),
          _buildDetails(
            Symbols.location_on_rounded,
            "Address",
            "123, ABC Street, Gulshan-e-Iqbal Block 12, Karachi, Pakistan.",
            valueStyle:
                TextStyleTheme.labelLarge.copyWith(color: ColorTheme.neutral3),
          ),
          _buildDetails(
            Symbols.build_rounded,
            "Service Type",
            "AC Repairing",
          ),
          _buildDetails(
            Symbols.payments_rounded,
            "Offered Amount",
            "Rs 15000",
          ),
          _buildDetails(
            Symbols.calendar_month_rounded,
            "Date",
            "3rd March",
          ),
          _buildDetails(
            Symbols.alarm_rounded,
            "Time",
            "3:30 pm",
          ),
          Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: const SubServicesChipWrapView(
                servicesList: [
                  "Hair cut",
                  "Hair",
                  "Hair extension",
                  "Hair cut",
                  "Hair cut",
                  "Hair extension"
                ],
                variant: SubServicesChipWrapViewVariant.forSheets,
              )),
        ]),
        12.verticalSpace,
        Padding(
          padding: 24.horizontalPadding,
          child: CustomButton(
            width: double.infinity,
            type: CustomButtonType.primary,
            text: "Submit Request",
            onPressed: () {
              widget.onConfirm();
              context.pushNamed(RouteConstants.customerHomeScreenRoute);
            },
          ),
        ),
        24.verticalSpace,
      ],
    );
  }

  Widget _buildDetails(
    IconData icon,
    String text,
    String value, {
    Color valueColor = ColorTheme.neutral3,
    TextStyle? valueStyle,
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
                Expanded(
                  child: Text(
                    text,
                    style: TextStyleTheme.bodyLarge
                        .copyWith(color: ColorTheme.neutral3),
                  ),
                ),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.end,
                    value,
                    style: valueStyle ??
                        TextStyleTheme.titleSmall.copyWith(color: valueColor),
                  ),
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
