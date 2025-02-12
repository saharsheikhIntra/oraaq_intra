import 'dart:developer';

import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_history/history_screen_cubit.dart';
import 'package:oraaq/src/imports.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryScreenCubit _cubit = getIt<HistoryScreenCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.fetchWorkOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                title: const Text(StringConstants.requestHistory),
                bottom: TabBar(
                  indicatorPadding: 16.horizontalPadding,
                  splashBorderRadius: 12.topBorderRadius,
                  tabs: const [
                    Tab(
                        text: "Completed",
                        icon: Icon(Symbols.beenhere_rounded)),
                    Tab(
                        text: "Cancelled",
                        icon: Icon(Symbols.disabled_by_default_rounded)),
                  ],
                )),
            body: BlocConsumer<HistoryScreenCubit, HistoryScreenState>(
              listener: (context, state) {
                if (state is HistoryScreenLoading) {
                  DialogComponent.showLoading(context);
                }
                if (state is HistoryScreenError) {
                  DialogComponent.hideLoading(context);
                  Toast.show(
                    context: context,
                    variant: SnackbarVariantEnum.warning,
                    title: state.failure.message,
                  );
                }
                if (state is HistoryScreenLoaded) {
                  DialogComponent.hideLoading(context);
                }
                if (state is RatingSuccessState) {
                  _cubit.fetchWorkOrders();
                  Toast.show(
                    context: context,
                    variant: SnackbarVariantEnum.success,
                    title: state.message,
                  );
                }
                if (state is RatingErrorState) {
                  _cubit.fetchWorkOrders();
                  Toast.show(
                    context: context,
                    variant: SnackbarVariantEnum.warning,
                    title: state.failure.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is HistoryScreenLoaded) {
                  return TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      state.completedOrders.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              itemCount: state.completedOrders.length, //3,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              separatorBuilder: (context, index) =>
                                  12.verticalSpace,
                              itemBuilder: (BuildContext context, int index) =>
                                  CompletedRequestCard(
                                userName: state.completedOrders[index]
                                    .customerName, //"AC REPAIRING",
                                date: state.completedOrders[index].requestDate
                                    .formattedDate(), //"4th March",
                                ratings: state
                                    .completedOrders[index].ratingCustomer
                                    .toString(),
                                // "4 / 5",
                                price: state.completedOrders[index].bidAmount
                                    .toString(), //"12000",
                                servicesList: state.completedOrders[index]
                                    .serviceNames, //const [],
                                duration: '4 hr 40 mints',
                                rating: state.completedOrders[index]
                                        .ratingMerchant ??
                                    0,
                                variant: CompletedRequestCardVariant.customer,
                                onTap: () async {
                                  final rating = await SheetComponenet.show(
                                    context,
                                    isScrollControlled: true,
                                    child: CompletedJobSheet(
                                        userName: state.completedOrders[index]
                                            .customerName,
                                        phoneNumber: state
                                            .completedOrders[index]
                                            .customerContactNumber,
                                        email: state.completedOrders[index]
                                            .customerEmail,
                                        date: state
                                            .completedOrders[index].requestDate
                                            .formattedDate(),
                                        time: state.completedOrders[index]
                                            .requestDate.to12HourFormat,
                                        servicesList: state
                                            .completedOrders[index]
                                            .serviceNames,
                                        totalAmount: state
                                            .completedOrders[index].bidAmount
                                            .toString(),
                                        ratingByMerchant: state
                                            .completedOrders[index]
                                            .ratingCustomer
                                            .toString(),
                                        rating: state.completedOrders[index]
                                                .rating ??
                                            0,
                                        variant:
                                            CompletedJobSheetVariant.merchant),
                                  );
                                  log('rating: ${rating.toString()}');
                                  if (rating != null && rating > 0) {
                                    _cubit.submitRating(
                                        state
                                            .completedOrders[index].workOrderId,
                                        state.completedOrders[index].customerId,
                                        rating);
                                  }
                                },
                              ),
                            )
                          : const Center(child: Text('No Data')),
                      state.cancelledOrders.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              itemCount: state.cancelledOrders.length, //3,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              separatorBuilder: (context, index) =>
                                  12.verticalSpace,
                              itemBuilder: (BuildContext context, int index) =>
                                  CancelRequestCard(
                                userName: state.cancelledOrders[index]
                                    .customerName, //"AC REPAIRED",
                                duration: "4hr 30 mints",
                                date: state.cancelledOrders[index].requestDate
                                    .formattedDate(), //"21st May",
                                time: state.cancelledOrders[index].requestDate
                                    .to12HourFormat, //"6:00 am",
                                price: state.cancelledOrders[index].bidAmount
                                    .toString(), //"10,000",
                                servicesList:
                                    state.cancelledOrders[index].serviceNames,

                                onTap: () {},
                              ),
                            )
                          : const Center(child: Text('No Data')),
                    ],
                  );
                } else {
                  return const Center(child: Text('No Data'));
                }
              },
            )),
      ),
    );
  }
}
