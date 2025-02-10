import 'dart:developer';

import 'package:oraaq/src/core/extensions/double_extension.dart';
import 'package:oraaq/src/imports.dart';

import '../sub_services_wrap_view.dart';

enum NewQuoteSheetSheetVariant {
  newQuote,
  alreadyQuoted,
}

class NewQuoteSheet extends StatefulWidget {
  final String? sheetName;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? distance;
  final List<String>? servicesList;
  final String? date;
  final String? time;
  final double defaultValue;
  final NewQuoteSheetSheetVariant variant;
  final int? workOrderId;
  //final MerchantHomeScreenCubit? cubit;
  final VoidCallback onCancel;
  final Function(double) onSubmit;

  const NewQuoteSheet({
    super.key,
    this.sheetName = "",
    this.name,
    this.phoneNumber,
    this.email,
    this.distance,
    this.servicesList,
    this.date,
    this.time,
    required this.defaultValue,
    required this.variant,
    this.workOrderId,
    required this.onCancel,
    required this.onSubmit,
  });

  @override
  State<NewQuoteSheet> createState() => _NewQuoteSheetState();
}

class _NewQuoteSheetState extends State<NewQuoteSheet> {
  double _defaultValue = 0;
  late TextEditingController _amountController;
  final int minAmount = 100;
  final int maxAmount = 1000; //might be needed from backend
  String? _errorMessage;

  @override
  void initState() {
    _defaultValue = widget.defaultValue;
    _amountController = TextEditingController(text: _defaultValue.asIntString);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
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
                    // _buildDetails(Symbols.phone_rounded,
                    //     widget.phoneNumber ?? "031234563451"),
                    // 12.verticalSpace,
                    // _buildDetails(
                    //     Symbols.mail_rounded, widget.email ?? "amber.doe@mail,com"),
                    // 12.verticalSpace,
                    _buildDetails(
                        Symbols.my_location_rounded, widget.distance ?? "N/A"),
                  ],
                )),
            25.verticalSpace,
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
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
            Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTime(Symbols.calendar_month_rounded,
                        widget.date ?? "3rd March"),
                    16.horizontalSpace,
                    _buildTime(Symbols.alarm_rounded, widget.time ?? "3:30 pm"),
                  ],
                )),
            4.verticalSpace,
            if (widget.variant == NewQuoteSheetSheetVariant.newQuote)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomButton(
                      type: CustomButtonType.tertiary,
                      icon: Symbols.remove_rounded,
                      onPressed: () {
                        _decrement();
                      },
                    ),
                    const Spacer(),
                    // const Text(
                    //   "Rs ",
                    //   style: TextStyle(
                    //     color: ColorTheme.secondaryText,
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 32.0,
                    //   ),
                    // ),
                    // Text(
                    //   "$_defaultValue",
                    //   style: const TextStyle(
                    //     color: ColorTheme.secondaryText, //ColorTheme.primary,
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 32.0,
                    //   ),
                    // ),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        style: TextStyleTheme.titleLarge
                            .copyWith(color: ColorTheme.secondary),
                        controller: _amountController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          //border: InputBorder.none,
                          enabledBorder: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                // color: ColorTheme.onSecondary,
                                style: BorderStyle.solid),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _defaultValue =
                                double.tryParse(value) ?? _defaultValue;
                            _errorMessage = null;
                          });
                        },
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      type: CustomButtonType.tertiary,
                      icon: Symbols.add_rounded,
                      onPressed: () {
                        _increment();
                      },
                    ),
                  ],
                ),
              ),
            if (_errorMessage != null)
              Align(
                alignment: Alignment.center,

                //  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyleTheme.labelSmall
                      .copyWith(color: ColorTheme.error),
                ),
              ),
            if (widget.variant == NewQuoteSheetSheetVariant.alreadyQuoted)
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 24.0),
                child: Row(
                  children: [
                    Text(
                      StringConstants.offered,
                      style: TextStyleTheme.titleSmall
                          .copyWith(color: ColorTheme.neutral3),
                    ),
                    const Spacer(),
                    Text(
                      "Rs",
                      style: TextStyleTheme.titleLarge
                          .copyWith(color: ColorTheme.primary),
                    ),
                    Text(
                      _defaultValue.asIntString,
                      style: TextStyleTheme.titleLarge
                          .copyWith(color: ColorTheme.primary),
                    )
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 24, 24, 28),
              child: CustomButton(
                  width: double.infinity,
                  type: widget.variant == NewQuoteSheetSheetVariant.newQuote
                      ? CustomButtonType.primary
                      : CustomButtonType.primary,
                  text: widget.sheetName != ""
                      ? "Action"
                      : widget.variant == NewQuoteSheetSheetVariant.newQuote
                          ? StringConstants.sendQuote
                          : StringConstants.cancel,
                  onPressed: () {
                    if (widget.variant ==
                        NewQuoteSheetSheetVariant.alreadyQuoted) {
                      SheetComponenet.showWarningSheet(
                        context,
                        title: StringConstants.cancelJobTitle,
                        message: StringConstants.cancelJobMessage,
                        ctaText: "Cancel Job",
                        cancelText:
                            "${widget.sheetName == "" ? "Keep" : "Complete"} Job",
                        onCtaTap: () {
                          // widget.cubit!.cancelWorkOrder(widget.workOrderId ?? -1, getIt<UserEntity>().id);

                          widget.onCancel();
                          context.pop();

                          //context.popUntil(RouteConstants.merchantHomeScreenRoute);
                        },
                        onCancelTap: () {
                          // widget.cubit!.cancelWorkOrder(widget.workOrderId ?? -1, getIt<UserEntity>().id);

                          widget.onSubmit(0.0);
                          context.pop();

                          //context.popUntil(RouteConstants.merchantHomeScreenRoute);
                        },
                        // context
                        //     .popUntil(RouteConstants.merchantHomeScreenRoute),
                      );
                    } else {
                      if (_defaultValue < minAmount ||
                          _defaultValue > maxAmount) {
                        setState(() {
                          _errorMessage =
                              'Please enter an amount between $minAmount and $maxAmount';
                        });
                        // Show error
                        // Toast.show(
                        //   context: context,
                        //   variant: SnackbarVariantEnum.warning,
                        //   title: 'Invalid Ammount',
                        //   message:
                        //       'Please enter an amount between $minAmount and $maxAmount',
                        // );
                      } else {
                        widget.onSubmit(_defaultValue);
                        debugPrint("default value sent in api $_defaultValue");
                        //context.pop();
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(IconData icon, String text) => Row(children: [
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
  void _increment() {
    if (_defaultValue < maxAmount) {
      setState(() {
        _defaultValue += 25;
        _amountController.text = _defaultValue.asIntString;
        _errorMessage = null;
      });
    }
    // setState(() {

    //  _defaultValue++;
    // });
  }

  void _decrement() {
    if (_defaultValue >= minAmount) {
      setState(() {
        _defaultValue -= 25;
        _amountController.text = _defaultValue.asIntString;
        _errorMessage = null;
      });
    }
    // if (widget.defaultValue > 0) {
    //   setState(() {
    //     _defaultValue--;
    //   });
    // }
  }
}
