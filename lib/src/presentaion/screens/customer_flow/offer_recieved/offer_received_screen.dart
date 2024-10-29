import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/config/themes/text_style_theme.dart';
import 'package:oraaq/src/core/extensions/datetime_extensions.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/fetch_offers_for_requests.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/injection_container.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/offer_recieved/offer_recieved_arguments.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/offer_recieved/offers_recieved_cubit.dart';
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
  const OfferReceivedScreen({required this.args, super.key});

  @override
  State<OfferReceivedScreen> createState() => _OfferReceivedScreenState();
}

class _OfferReceivedScreenState extends State<OfferReceivedScreen> {
  final OffersRecievedCubit _cubit = getIt<OffersRecievedCubit>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('offer recived init state runinng');
      _cubit.fetchOffersForRequest(widget.args.customerNewRequest.requestId);
    });
  }

  final ValueNotifier<List<FetchOffersForRequestDto>> bids =
      ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    CustomerNewRequestDto currentRequest = widget.args.customerNewRequest;
    // log('offer recieved screen: ${currentRequest!.services}');
    log('offer recieved screen: ${currentRequest.services}');

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
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocListener<OffersRecievedCubit, OffersRecievedState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is OffersRecievedLoading) {
              DialogComponent.showLoading(context);
            }
            if (state is OffersRecievedError) {
              DialogComponent.hideLoading(context);
              log('error: ${state.error.message}');
            }
            if (state is OffersRecievedLoaded) {
              DialogComponent.hideLoading(context);
              log('loaded: ${state.bids}');
              bids.value = state.bids;

            }
          },
          child: SingleChildScrollView(
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
                                DateTime.tryParse(currentRequest.date)!
                                    .formattedDate(),
                              ),
                              6.verticalSpace,
                              _buildTime(
                                  Symbols.alarm_rounded,
                                  DateTime.tryParse(currentRequest.date)!
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
                  variant:
                      SubServicesChipWrapViewVariant.forOfferReceivedScreen,
                ),
                20.verticalSpace,
                _buildDetails("You Offered", currentRequest.amount, () {
                  SheetComponenet.show(context,
                      child: ChangeOfferSheet(
                        defaultValue: int.parse(currentRequest.amount),
                        variant: ChangeOfferSheetVariant.price,
                        onTap: (int value)async {
                          log(value.toString());
                          log('update amount');
                          Map<String,dynamic> data = {
                            'request_id': currentRequest.requestId,
                            'new_offer_amount': value,
                          };
                          String? messsage = await _cubit.updateOfferAmount(data);
                          log(messsage.toString());
                        
                          context.pop();
                        },
                      ));
                }, isRadius: false),
                _buildDetails("Search Radius", currentRequest.radius, () {
                  SheetComponenet.show(context,
                      child: ChangeOfferSheet(
                        defaultValue: 50,
                        variant: ChangeOfferSheetVariant.distance,
                        onTap: (){
                          log('update radius');
                        },
                      ));
                }, isRadius: true),
                16.verticalSpace,
                SizedBox(
                  height: 412,
                  child: currentRequest.offersReceived == 0
                      ? const Center(
                          child: ToastMessageCard(
                            heading: StringConstants.waitingMerchant,
                            message: StringConstants.waitingToastDetail,
                          ),
                        )
                      : ValueListenableBuilder(
                        valueListenable: bids,
                        builder: (context,value,child) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.length,
                              itemBuilder: (BuildContext context, int index){
                                FetchOffersForRequestDto bid = value[index];
                                return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12.0),
                                child: MerchantOfferCard(
                                  userName: bid.merchantName,
                                  distance: bid.distance,
                                  phoneNo: "",
                                  email: bid.merchantEmail,
                                  price: bid.offerAmount.toString(),
                                  onAccept: () {},
                                  onReject: () {},
                                  onDistanceTap: () {},
                                ),
                              );
                              },
                            );
                        }
                      ),
                ),
                30.verticalSpace,
              ],
            ),
          ),
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
