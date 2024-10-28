import 'package:oraaq/src/core/extensions/widget_extension.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/reuqest_history/request_history_cubit.dart';

import '../../../widgets/ongoing_request_card.dart';

import '../../../widgets/sheets/request_sheet.dart';

class RequestHistoryScreen extends StatefulWidget {
  const RequestHistoryScreen({super.key});

  @override
  State<RequestHistoryScreen> createState() => _RequestHistoryScreenState();
}

class _RequestHistoryScreenState extends State<RequestHistoryScreen> {
  final RequestHistoryCubit _cubit = getIt<RequestHistoryCubit>();

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
        length: 3,
        child: Scaffold(
            appBar: AppBar(
                title: const Text(StringConstants.requestHistory),
                bottom: TabBar(
                  indicatorPadding: 16.horizontalPadding,
                  splashBorderRadius: 12.topBorderRadius,
                  tabs: const [
                    Tab(
                        text: "On Going",
                        icon: Icon(Symbols.award_star_rounded)),
                    Tab(
                        text: "Completed",
                        icon: Icon(Symbols.beenhere_rounded)),
                    Tab(
                        text: "Cancelled",
                        icon: Icon(Symbols.disabled_by_default_rounded)),
                  ],
                )),
            body: BlocConsumer<RequestHistoryCubit, RequestHistoryState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is RequestHistoryScreenLoading) {
                  DialogComponent.showLoading(context);
                }
                if (state is RequestHistoryScreenError) {
                  DialogComponent.hideLoading(context);
                  Toast.show(
                    context: context,
                    variant: SnackbarVariantEnum.warning,
                    title: state.failure.message,
                  );
                }
                if (state is RequestHistoryScreenLoaded) {
                  DialogComponent.hideLoading(context);
                }
              },
              builder: (context, state) {
                if (state is RequestHistoryScreenLoaded) {
                  return TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //
                      //
                      // MARK: On-going orders tab
                      //
                      //
                      ListView(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        children: [
                          Text(
                            StringConstants.acceptedRequests,
                            style: TextStyleTheme.titleSmall
                                .copyWith(color: ColorTheme.secondaryText),
                          ).wrapInPadding(16.horizontalPadding),
                          12.verticalSpace,
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 15,
                              padding: 16.horizontalPadding,
                              itemBuilder: (BuildContext context, int index) =>
                                  Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: GestureDetector(
                                  onTap: () => SheetComponenet.show(
                                    context,
                                    isScrollControlled: true,
                                    child: RequestSheet(
                                      onCancel: () {},
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: 96,
                                    width: 245,
                                    child: OnGoingRequestCard(
                                      userName: "Ali Hassan",
                                      duration: "4hr 30 mints",
                                      date: "21st May",
                                      time: "6:00 am",
                                      profileName: "Zain Hashim",
                                      price: "10,000",
                                      servicesList: const [],
                                      variant: OngoingRequestCardVariant
                                          .offerReceived,
                                      onTap: () => SheetComponenet.show(
                                        context,
                                        isScrollControlled: true,
                                        child: RequestSheet(
                                          onCancel: () {},
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          24.verticalSpace,
                          Text(
                            StringConstants.requests,
                            style: TextStyleTheme.titleSmall
                                .copyWith(color: ColorTheme.secondaryText),
                          ).wrapInPadding(16.horizontalPadding),
                          12.verticalSpace,
                          state.newRequestWorkOrders.isNotEmpty
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: state.newRequestWorkOrders.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: 16.horizontalPadding,
                                  separatorBuilder: (context, index) =>
                                      12.verticalSpace,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    CustomerNewRequestDto currentRequest =
                                        state.newRequestWorkOrders[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: OnGoingRequestCard(
                                        userName: "Ali Hassan",
                                        duration: "4hr 30 mints",
                                        date: DateTime.tryParse(
                                                currentRequest.date)!
                                            .formattedDate(),
                                        time: DateTime.tryParse(
                                                currentRequest.date)!
                                            .to12HourFormat,
                                        // profileName: "Zain Hashim",
                                        price: currentRequest.amount.toString(),
                                        servicesList: const [],
                                        variant:
                                            OngoingRequestCardVariant.waiting,
                                        onTap: () => context.pushNamed(
                                          RouteConstants
                                              .offeredReceivedScreenRoute,
                                        ),
                                      ),
                                    );
                                  })
                              : const Text('No data'),
                        ],
                      ),
                      //
                      //
                      // MARK: Completed orders tab
                      //
                      //
                      state.completedOrders.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              itemCount: state.completedOrders.length,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              separatorBuilder: (context, index) =>
                                  12.verticalSpace,
                              itemBuilder: (BuildContext context, int index) {
                                RequestEntity currentRequest =
                                    state.completedOrders[index];
                                return CompletedRequestCard(
                                  userName: currentRequest.customerName,
                                  date: currentRequest.requestDate
                                      .formattedDate(),
                                  ratings: currentRequest.rating.toString(),
                                  price: currentRequest.bidAmount.toString(),
                                  servicesList: currentRequest.serviceNames,
                                  duration: '4 hr 40 mints',
                                  rating: currentRequest.rating!,
                                  variant: CompletedRequestCardVariant.merchant,
                                  onTap: () {
                                    SheetComponenet.show(
                                      context,
                                      isScrollControlled: true,
                                      child: const CompletedJobSheet(
                                          rating: 0,
                                          variant: CompletedJobSheetVariant
                                              .customer),
                                    );
                                  },
                                );
                              })
                          : const Text('No data'),
                      //
                      //
                      // MARK: Cancelled orders tab
                      //
                      //
                      state.cancelledOrders.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              itemCount: state.cancelledOrders.length,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              separatorBuilder: (context, index) =>
                                  12.verticalSpace,
                              itemBuilder: (BuildContext context, int index) {
                                RequestEntity currentRequest =
                                    state.cancelledOrders[index];
                                return CancelRequestCard(
                                  userName: currentRequest.customerName,
                                  duration: "4hr 30 mints",
                                  date: currentRequest.requestDate
                                      .formattedDate(),
                                  time: "6:00 am",
                                  price: "10,000",
                                  servicesList: const [
                                    "Hair cut",
                                    "Hair",
                                    "Hair extension",
                                    "Hair extension"
                                  ],
                                  onTap: () {},
                                );
                              })
                          : const Text('No data'),
                    ],
                  );
                } else {
                  return const Text('No data');
                }
              },
            )),
      ),
    );
  }
}
