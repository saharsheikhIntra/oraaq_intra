import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/extensions/datetime_extensions.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/offer_recieved/offer_recieved_arguments.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_home/merchant_home_screen.dart';
import 'package:oraaq/src/presentaion/widgets/merchant_offer_card.dart';
import 'package:oraaq/src/presentaion/widgets/sheets/change_offer_sheet.dart';
import 'package:oraaq/src/presentaion/widgets/toast_message_card.dart';

import '../../../../config/themes/color_theme.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../widgets/sheets/sheet_component.dart';
import '../../../widgets/sub_services_wrap_view.dart';

class OfferReceivedScreen extends StatefulWidget {
  final OfferRecievedArguments args;
  const OfferReceivedScreen({required this.args,super.key});

  @override
  State<OfferReceivedScreen> createState() => _OfferReceivedScreenState();
}

class _OfferReceivedScreenState extends State<OfferReceivedScreen> {
// CustomerNewRequestDto? currentRequest;
  @override
  void initState() {
    super.initState();
    // currentRequest = widget.args.customerNewRequest;
  }

  @override
  Widget build(BuildContext context) {
    CustomerNewRequestDto currentRequest = widget.args.customerNewRequest;
    // log('offer recieved screen: ${currentRequest!.services}');
    int offerCount = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.transparent,
        title: const Text(
          StringConstants.offersReceived,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Center(
              child: Text(
                '${currentRequest!.duration}',
                style:
                    TextStyleTheme.labelLarge.copyWith(color: ColorTheme.error),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  12.verticalSpace,
                  Row(
                    children: [
                      Text(
                        StringConstants.saloon,
                        style: TextStyleTheme.displaySmall
                            .copyWith(color: ColorTheme.secondaryText),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildTime(
                            Symbols.calendar_month_rounded,
                            DateTime.tryParse(
                                                    currentRequest.date)!.formattedDate(),
                          ),
                          6.verticalSpace,
                          _buildTime(Symbols.alarm_rounded, DateTime.tryParse(
                                                    currentRequest.date)!
                                                .to12HourFormat),
                        ],
                      ),
                    ],
                  ),
                  28.verticalSpace,
                ],
              ),
            ),
            SubServicesChipWrapView(
              servicesList: currentRequest.services,
              variant: SubServicesChipWrapViewVariant.forOfferReceivedScreen,
            ),
            20.verticalSpace,
            _buildDetails("You Offered", currentRequest.amount, () {
              SheetComponenet.show(context,
                  child: ChangeOfferSheet(
                    defaultValue: int.parse(currentRequest.amount),
                    variant: ChangeOfferSheetVariant.price,
                  ));
            }, isRadius: false),
            _buildDetails("Search Radius", currentRequest.radius, () {
              SheetComponenet.show(context,
                  child: const ChangeOfferSheet(
                    defaultValue: 50,
                    variant: ChangeOfferSheetVariant.distance,
                  ));
            }, isRadius: true),
            16.verticalSpace,
            SizedBox(
              height: 412,
              child: offerCount == 0
                  ? const Center(
                      child: ToastMessageCard(
                        heading: StringConstants.waitingMerchant,
                        message: StringConstants.waitingToastDetail,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: offerCount,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: MerchantOfferCard(
                          userName: "John Doe",
                          distance: "9 km away",
                          phoneNo: "0322 2345673",
                          email: "ambar.doe@mail.com",
                          price: "15,000",
                          onAccept: () {},
                          onReject: () {},
                          onDistanceTap: () {},
                        ),
                      ),
                    ),
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }

  Row _buildTime(
    IconData icon,
    String text,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          text,
          textAlign: TextAlign.end,
          style: TextStyleTheme.labelLarge.copyWith(
            color: ColorTheme.secondaryText,
          ),
        ),
        8.horizontalSpace,
        Icon(
          icon,
          size: 20.0,
          color: ColorTheme.secondaryText,
        ),
      ],
    );
  }

  Widget _buildDetails(String text, String value, VoidCallback onTap,
      {bool isRadius = false}) {
    return Container(
      decoration: BoxDecoration(
        color: ColorTheme.neutral1,
        border: Border.all(color: ColorTheme.neutral2, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyleTheme.labelLarge
                  .copyWith(color: ColorTheme.secondaryText),
            ),
            const Spacer(),
            Text(
              isRadius ? "$value Km" : "Rs $value",
              style: TextStyleTheme.titleSmall,
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onTap,
              child: const Icon(Icons.border_color_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
