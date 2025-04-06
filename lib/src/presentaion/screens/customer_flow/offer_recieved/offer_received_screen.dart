import 'dart:developer';

// import 'packagter_bloc/flutter_bloc.dart';
import 'package:oraaq/src/core/extensions/double_extension.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/fetch_offers_for_requests.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/customer_home/customer_home_screen.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/offer_recieved/offer_recieved_arguments.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/offer_recieved/offers_recieved_cubit.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/request_history/request_history_cubit.dart';
import 'package:oraaq/src/presentaion/widgets/merchant_offer_card.dart';
import 'package:oraaq/src/presentaion/widgets/sheets/change_offer_sheet.dart';
import 'package:oraaq/src/presentaion/widgets/toast_message_card.dart';

import '../../../widgets/sub_services_wrap_view.dart';

class OfferReceivedScreen extends StatefulWidget {
  final OfferRecievedArguments args;
  const OfferReceivedScreen({required this.args, super.key});

  @override
  State<OfferReceivedScreen> createState() => _OfferReceivedScreenState();
}

class _OfferReceivedScreenState extends State<OfferReceivedScreen> {
  final OffersRecievedCubit _cubit = getIt<OffersRecievedCubit>();
  final RequestHistoryCubit _requestHistoryCubit = getIt<RequestHistoryCubit>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('offer recived init state runinng');
      _cubit.fetchOffersForRequest(
          widget.args.customerNewRequest.value.requestId);
    });
  }

  final ValueNotifier<List<FetchOffersForRequestDto>> bids = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    ValueNotifier currentRequest = widget.args.customerNewRequest;
    // log('offer recieved screen: ${currentRequest!.services}');
    log('offer recieved screen: ${currentRequest.value.services}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.transparent,
        title: const Text(
          StringConstants.offersReceived,
        ),
        leading: InkWell(
            onTap: () async {
              context.pop();
              context.pushReplacementNamed(
                  RouteConstants.requestHistoryScreenRoute);
            },
            child: const Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Center(
              child: Text(
                currentRequest.value.duration,
                style:
                    TextStyleTheme.labelLarge.copyWith(color: ColorTheme.error),
              ),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: currentRequest,
          builder: (context, value, child) {
            return BlocProvider(
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
                    Toast.show(
                        context: context,
                        variant: SnackbarVariantEnum.warning,
                        title: state.error.message);
                  }
                  if (state is OffersRecievedLoaded) {
                    DialogComponent.hideLoading(context);
                    log('loaded: ${state.bids}');
                    bids.value = state.bids;
                  }
                  if (state is OffersAmountUpdated) {
                    log('updated: ${state.message}');
                    Toast.show(
                        context: context,
                        variant: SnackbarVariantEnum.success,
                        title: state.message);
                  }
                  if (state is OfferRadiusUpdated) {
                    log('updated: ${state.message}');
                    Toast.show(
                        context: context,
                        variant: SnackbarVariantEnum.success,
                        title: state.message);
                  }
                  if (state is OfferAccepted) {
                    log('updated: ${state.message}');
                    context.pushReplacementNamed(
                        RouteConstants.requestHistoryScreenRoute);
                    // context.pushAndRemoveUntil(const CustomerHomeScreen());
                    Toast.show(
                        context: context,
                        variant: SnackbarVariantEnum.success,
                        title: state.message);
                  }
                  if (state is OfferRejected) {
                    log('updated: ${state.failure.message}');
                    context.pushReplacementNamed(
                        RouteConstants.requestHistoryScreenRoute);
                    // context.pushAndRemoveUntil(const CustomerHomeScreen());
                    Toast.show(
                        context: context,
                        variant: SnackbarVariantEnum.warning,
                        title: state.failure.message);
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
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Text(
                                  widget.args.customerNewRequest.value.category,
                                  // StringConstants.saloon,
                                  style: TextStyleTheme.headlineMedium.copyWith(
                                      color: ColorTheme.secondaryText),
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _buildTime(
                                      Symbols.calendar_month_rounded,
                                      DateTime.tryParse(value.date)!
                                          .formattedDate(),
                                    ),
                                    6.verticalSpace,
                                    _buildTime(
                                        Symbols.alarm_rounded,
                                        DateTime.tryParse(value.date)!
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
                        servicesList: currentRequest.value.services,
                        variant: SubServicesChipWrapViewVariant
                            .forOfferReceivedScreen,
                      ),
                      20.verticalSpace,
                      _buildDetails("You Offered", value.amount, () {
                        SheetComponenet.show(context,
                            child: ChangeOfferSheet(
                              defaultValue: int.parse(value.amount),
                              variant: ChangeOfferSheetVariant.price,
                              onTap: (int val) async {
                                log(val.toString());
                                log('update amount');
//  value.amount = val.toString();
                                Map<String, dynamic> data = {
                                  'request_id': value.requestId,
                                  'new_offer_amount': val,
                                };
                                String? messsage =
                                    await _cubit.updateOfferAmount(data);
                                log('last message: ${messsage.toString()}');

                                context.pop();
                                context.pop();
                                setState(() {});
                              },
                            ));
                      }, isRadius: false),
                      _buildDetails("Search Radius", value.radius, () {
                        SheetComponenet.show(context,
                            child: ChangeOfferSheet(
                              defaultValue: int.parse(
                                value.radius
                                    .replaceAll(RegExp(r'[^0-9]'), '')
                                    .trim(),
                              ), //int.parse(value.radius),
                              variant: ChangeOfferSheetVariant.distance,
                              onTap: (int val) async {
                                log(val.toString());
                                log('update amount');
                                // value.amount = val.toString();
                                Map<String, dynamic> data = {
                                  'request_id': value.requestId,
                                  'new_radius': val,
                                };
                                String? messsage =
                                    await _cubit.updateOfferRadius(data);
                                // log('last message: ${messsage.toString()}');
                                context.pop();
                                context.pop();
                                setState(() {});
                              },
                            ));
                      }, isRadius: true),
                      16.verticalSpace,
                      SizedBox(
                        height: 412,
                        child: currentRequest.value.offersReceived == 0
                            ? const Center(
                                child: ToastMessageCard(
                                  heading: StringConstants.waitingMerchant,
                                  message: StringConstants.waitingToastDetail,
                                ),
                              )
                            : ValueListenableBuilder(
                                valueListenable: bids,
                                builder: (context, value, child) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      FetchOffersForRequestDto bid =
                                          value[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 12.0),
                                        child: MerchantOfferCard(
                                          userName: bid.merchantName,
                                          distance: bid.distance,
                                          // phoneNo: "",
                                          // email: "",
                                          price: bid.offerAmount.asIntString,
                                          onAccept: () async {
                                            Map<String, dynamic> data = {
                                              'offer_id': bid.offerId,
                                              'bid_status': 2
                                            };
                                            await _cubit
                                                .acceptOrRejectOffer(data);
                                          },
                                          onReject: () async {
                                            Map<String, dynamic> data = {
                                              'offer_id': bid.offerId,
                                              'bid_status': 3
                                            };
                                            await _cubit
                                                .acceptOrRejectOffer(data);
                                          },
                                          onDistanceTap: () {
                                            LauncherUtil.openMap(
                                              bid.merchantLatitude,
                                              bid.merchantLongitude,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                }),
                      ),
                      30.verticalSpace,
                    ],
                  ),
                ),
              ),
            );
          }),
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
              isRadius ? "$value" : "Rs $value",
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
