import 'dart:developer' as developer;

import 'package:intl/intl.dart';
import 'package:oraaq/src/core/extensions/widget_extension.dart';
import 'package:oraaq/src/data/local/questionnaire/question_model.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/widgets/sub_services_wrap_view.dart';

class MakeOfferPage extends StatefulWidget {
  final Function(int selectedOffer) onChanged;
  final List<QuestionModel> selectedServices;
  final dynamic onContinue;
  final VoidCallback onPrevious;
  const MakeOfferPage({
    super.key,
    required this.onChanged,
    required this.onContinue,
    required this.onPrevious,
    required this.selectedServices,
  });

  @override
  State<MakeOfferPage> createState() => _MakeOfferPageState();
}

class _MakeOfferPageState extends State<MakeOfferPage> {
  final ValueNotifier<int> _selectedOffer = ValueNotifier(0);
  int _standardCharges = 0;
  final TextEditingController _dateTimeController = TextEditingController();
  DateTime? selectedDateTime;
  var tempVal = '';

  int getPercentage(int amount, double percentage) {
    var newVal = amount != 0 ? (amount * percentage) : 0;
    return newVal.toInt();
  }

  @override
  void initState() {
    _selectedOffer.value = widget.selectedServices
        .map(
          (e) => e.fee,
        )
        // .reduce(
        //   (a, b) => a + b,
        // )
        .fold(0, (a, b) => a + b)
        .floor();
    _standardCharges = _selectedOffer.value;
    super.initState();
  }

  @override
  void dispose() {
    _dateTimeController.dispose(); // Clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _selectedOffer.value = widget.selectedServices
        .map(
          (e) => e.fee,
        )
        // .reduce(
        //   (a, b) => a + b,
        // )
        .fold(0, (a, b) => a + b)
        .floor();
    _standardCharges = _selectedOffer.value;
    return Column(
      children: [
        Expanded(
            child: Padding(
                padding: 16.allPadding,
                // decoration: BoxDecoration(
                //   color: ColorTheme.white,
                //   borderRadius: 16.borderRadius,
                //   border: Border.all(color: ColorTheme.neutral2.withOpacity(0.5)),
                //   boxShadow: [
                //     BoxShadow(
                //       color: ColorTheme.black.withOpacity(0.03),
                //       blurRadius: 10,
                //       offset: const Offset(0, 4),
                //     )
                //   ],
                // ),
                child: Column(
                  children: [
                    12.verticalSpace,
                    SubServicesChipWrapView(
                      servicesList:
                          widget.selectedServices.map((e) => e.name).toList(),
                      variant: SubServicesChipWrapViewVariant.forQuestionnaire,
                    ),
                    28.verticalSpace,
                    Text(
                      StringConstants.pleaseEnterYourDesiredOfferAmount,
                      textAlign: TextAlign.center,
                      style: TextStyleTheme.bodyMedium
                          .copyWith(color: ColorTheme.secondaryText),
                    ),
                    32.verticalSpace,
                    Container(
                        padding: 16.verticalPadding,
                        decoration: BoxDecoration(
                          color: ColorTheme.white,
                          borderRadius: 16.borderRadius,
                          border: Border.all(
                              color: ColorTheme.neutral2.withOpacity(0.5)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorTheme.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                StringConstants.preferredSlot,
                                style: TextStyleTheme.titleMedium
                                    .copyWith(fontSize: 14),
                              ),
                            ).wrapInPadding(16.horizontalPadding),
                            Padding(
                              padding: 24.allPadding,
                              child: TextField(
                                controller: _dateTimeController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: ColorTheme.neutral1,
                                  labelText: StringConstants.preferredDateTime,
                                  hintText: StringConstants.selectDateTime,
                                  suffixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  // Show date picker
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: ColorTheme
                                                .onPrimary, // Header background color
                                            onPrimary: ColorTheme
                                                .white, // Header text color
                                            onSurface: ColorTheme
                                                .onSecondary, // Body text color
                                          ),
                                          dialogBackgroundColor: ColorTheme
                                              .white, // Background color
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );

                                  if (pickedDate != null) {
                                    // Show time picker after date is selected
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Theme(
                                          data: ThemeData.light().copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                              primary: ColorTheme
                                                  .onPrimary, // Header background color
                                              onPrimary: ColorTheme
                                                  .white, // Header text color
                                              onSurface: ColorTheme
                                                  .onSecondary, // Body text color
                                            ),
                                            dialogBackgroundColor: ColorTheme
                                                .white, // Background color
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );

                                    if (pickedTime != null) {
                                      // Combine the picked date and time into a DateTime object
                                      setState(() {
                                        selectedDateTime = DateTime(
                                          pickedDate.year,
                                          pickedDate.month,
                                          pickedDate.day,
                                          pickedTime.hour,
                                          pickedTime.minute,
                                        );
                                        // Format and show the selected date and time in the TextField
                                        tempVal = _dateTimeController.text =
                                            DateFormat('yyyy-MM-dd HH:mm')
                                                .format(selectedDateTime!);

                                        _dateTimeController.text =
                                            "${selectedDateTime!.formattedDate()}, ${selectedDateTime!.to12HourFormat}";
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 14, 0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      StringConstants.makeYourOffer,
                                      style: TextStyleTheme.titleMedium,
                                    )),
                                    // Expanded(
                                    //   child: Text(
                                    //       "Amount can be adjust to 10% of standard charges",
                                    //       style: TextStyleTheme.bodyMedium
                                    //           .copyWith(
                                    //               color: ColorTheme.neutral3)),
                                    // ),

                                    GestureDetector(
                                      onTap: () => Toast.show(
                                        context: context,
                                        variant: SnackbarVariantEnum.normal,
                                        title: StringConstants.standardRates,
                                        message: StringConstants
                                                .standardChargesForTheSelectedServicesIsRs +
                                            _standardCharges.toString(),
                                      ),
                                      child: const Icon(Symbols.info_rounded,
                                          color: ColorTheme.neutral3),
                                    ),
                                  ],
                                )),
                            16.verticalSpace,
                            Text("Amount can be adjust to 10% of standard charges",
                                    style: TextStyleTheme.bodyMedium
                                        .copyWith(color: ColorTheme.neutral3))
                                .wrapInPadding(20.horizontalPadding),
                            16.verticalSpace,
                            Padding(
                                padding: 16.horizontalPadding,
                                child: Row(
                                  children: [
                                    CustomButton(
                                      onPressed: () {
                                        int minLimit = _standardCharges -
                                            getPercentage(
                                                _standardCharges, 0.1);
                                        if (_selectedOffer.value > minLimit) {
                                          _selectedOffer.value -= getPercentage(
                                              _standardCharges, 0.1);
                                          if (_selectedOffer.value < minLimit) {
                                            _selectedOffer.value = minLimit;
                                          }
                                        }
                                        widget.onChanged(_selectedOffer.value);
                                      },
                                      type: CustomButtonType.tertiary,
                                      icon: Symbols.remove_rounded,
                                    ),
                                    24.horizontalSpace,
                                    Expanded(
                                        child: ValueListenableBuilder(
                                            valueListenable: _selectedOffer,
                                            builder: (context, value, child) {
                                              return TextField(
                                                controller:
                                                    TextEditingController(
                                                  text: _selectedOffer
                                                      .value.currencyFormat
                                                      .toString(),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                style: TextStyleTheme.titleLarge
                                                    .copyWith(
                                                        fontSize: 24,
                                                        color: ColorTheme
                                                            .secondaryText),
                                                decoration:
                                                    const InputDecoration(
                                                  //border: InputBorder.none,
                                                  enabledBorder:
                                                      UnderlineInputBorder(),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        // color: ColorTheme.onSecondary,
                                                        style:
                                                            BorderStyle.solid),
                                                  ),
                                                ),
                                                onChanged: (text) {
                                                  // Update _selectedOffer when the user manually changes the value
                                                  int? newOffer =
                                                      int.tryParse(text);
                                                  if (newOffer != null) {
                                                    _selectedOffer.value =
                                                        newOffer;
                                                    widget.onChanged(
                                                        _selectedOffer.value);
                                                  }
                                                },
                                              );

                                              // return FittedBox(
                                              //       fit: BoxFit.scaleDown,
                                              //       child: Text(
                                              //         _selectedOffer
                                              //             .value.currencyFormat,
                                              //         textAlign:
                                              //             TextAlign.center,
                                              //         style: TextStyleTheme
                                              //             .titleLarge
                                              //             .copyWith(
                                              //                 fontSize: 32,
                                              //                 color: ColorTheme
                                              //                     .secondaryText),
                                              //       ));
                                            })),
                                    24.horizontalSpace,
                                    CustomButton(
                                      onPressed: () {
                                        int maxLimit = _standardCharges +
                                            getPercentage(
                                                _standardCharges, 0.1);
                                        if (_selectedOffer.value < maxLimit) {
                                          _selectedOffer.value += getPercentage(
                                              _standardCharges, 0.1);
                                          if (_selectedOffer.value > maxLimit) {
                                            _selectedOffer.value = maxLimit;
                                          }
                                        }
                                        widget.onChanged(_selectedOffer.value);
                                      },
                                      type: CustomButtonType.tertiary,
                                      icon: Symbols.add_rounded,
                                    ),
                                  ],
                                )),
                          ],
                        )),
                    // Padding(
                    //   padding: 24.allPadding,
                    //   child: TextField(
                    //     controller: _dateTimeController,
                    //     readOnly: true,
                    //     decoration: const InputDecoration(
                    //       labelText: StringConstants.preferredDateTime,
                    //       hintText: StringConstants.selectDateTime,
                    //       suffixIcon: Icon(Icons.calendar_today),
                    //       border: OutlineInputBorder(),
                    //     ),
                    //     onTap: () async {
                    //       // Show date picker
                    //       DateTime? pickedDate = await showDatePicker(
                    //         context: context,
                    //         initialDate: DateTime.now(),
                    //         firstDate: DateTime.now(),
                    //         lastDate: DateTime(2030),
                    //         builder: (BuildContext context, Widget? child) {
                    //           return Theme(
                    //             data: ThemeData.light().copyWith(
                    //               colorScheme: const ColorScheme.light(
                    //                 primary: ColorTheme
                    //                     .onPrimary, // Header background color
                    //                 onPrimary:
                    //                     ColorTheme.white, // Header text color
                    //                 onSurface: ColorTheme
                    //                     .onSecondary, // Body text color
                    //               ),
                    //               dialogBackgroundColor:
                    //                   ColorTheme.white, // Background color
                    //             ),
                    //             child: child!,
                    //           );
                    //         },
                    //       );

                    //       if (pickedDate != null) {
                    //         // Show time picker after date is selected
                    //         TimeOfDay? pickedTime = await showTimePicker(
                    //           context: context,
                    //           initialTime: TimeOfDay.now(),
                    //           builder: (BuildContext context, Widget? child) {
                    //             return Theme(
                    //               data: ThemeData.light().copyWith(
                    //                 colorScheme: const ColorScheme.light(
                    //                   primary: ColorTheme
                    //                       .onPrimary, // Header background color
                    //                   onPrimary:
                    //                       ColorTheme.white, // Header text color
                    //                   onSurface: ColorTheme
                    //                       .onSecondary, // Body text color
                    //                 ),
                    //                 dialogBackgroundColor:
                    //                     ColorTheme.white, // Background color
                    //               ),
                    //               child: child!,
                    //             );
                    //           },
                    //         );

                    //         if (pickedTime != null) {
                    //           // Combine the picked date and time into a DateTime object
                    //           setState(() {
                    //             selectedDateTime = DateTime(
                    //               pickedDate.year,
                    //               pickedDate.month,
                    //               pickedDate.day,
                    //               pickedTime.hour,
                    //               pickedTime.minute,
                    //             );
                    //             // Format and show the selected date and time in the TextField
                    //             tempVal = _dateTimeController.text =
                    //                 DateFormat('yyyy-MM-dd HH:mm')
                    //                     .format(selectedDateTime!);

                    //             _dateTimeController.text =
                    //                 "${selectedDateTime!.formattedDate()}, ${selectedDateTime!.to12HourFormat}";
                    //           });
                    //         }
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ))),
        Padding(
            padding: 20.horizontalPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  // text:'Back',
                  size: CustomButtonSize.small,
                  icon: Symbols.arrow_back_rounded,
                  type: CustomButtonType.tertiary,
                  onPressed: () {
                    context.pop();
                  },
                ),
                16.horizontalSpace,
                selectedDateTime == null
                    ? CustomButton(
                        type: CustomButtonType.tertiary,
                        text: StringConstants.continu,
                        size: CustomButtonSize.small,
                        iconPosition: CustomButtonIconPosition.trailing,
                        icon: Symbols.arrow_forward_rounded,
                        onPressed: null,
                      )
                    : CustomButton(
                        text: StringConstants.continu,
                        size: CustomButtonSize.small,
                        iconPosition: CustomButtonIconPosition.trailing,
                        icon: Symbols.arrow_forward_rounded,
                        onPressed: () {
                          developer.log(
                              'make offer page userOfferAmount: ${_selectedOffer.value}');
                          widget.onContinue(
                              tempVal, _standardCharges, _selectedOffer.value);
                        },
                      ),
              ],
            )),
        16.verticalSpace,
      ],
    );
  }
}
