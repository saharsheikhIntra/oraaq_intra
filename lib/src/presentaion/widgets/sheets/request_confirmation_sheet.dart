import 'package:oraaq/src/imports.dart';
import '../sub_services_wrap_view.dart';

class RequestConfirmationSheet extends StatefulWidget {
  final dynamic onConfirm;
  final String address;
  final String serviceType;
  final String offeredAmount;
  final String datetime;
  final List<String> services;
  const RequestConfirmationSheet({
    super.key,
    required this.onConfirm,
    required this.address,
    required this.serviceType,
    required this.offeredAmount,
    required this.datetime,
    required this.services,
  });

  @override
  State<RequestConfirmationSheet> createState() =>
      _RequestConfirmationSheetState();
}

class _RequestConfirmationSheetState extends State<RequestConfirmationSheet> {
  String getCategory(String id) {
    switch (id) {
      case "1":
        return "AC Service";
      case "2":
        return "Salon";
      case "21":
        return "Catering";
      case "41":
        return "Mechanic";
      default:
        return 'Not found';
    }
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
            widget.address,
            valueStyle:
                TextStyleTheme.labelLarge.copyWith(color: ColorTheme.neutral3),
          ),
          _buildDetails(
            Symbols.build_rounded,
            "Service Type",
            getCategory(widget.serviceType),
          ),
          _buildDetails(
            Symbols.payments_rounded,
            "Offered Amount",
            widget.offeredAmount,
          ),
          _buildDetails(
            Symbols.calendar_month_rounded,
            "Date",
            DateTime.tryParse(widget.datetime)!.formattedDate(),
          ),
          _buildDetails(
            Symbols.alarm_rounded,
            "Time",
            DateTime.tryParse(widget.datetime)!.to12HourFormat,
          ),
          Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: SubServicesChipWrapView(
                servicesList: widget.services,
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
