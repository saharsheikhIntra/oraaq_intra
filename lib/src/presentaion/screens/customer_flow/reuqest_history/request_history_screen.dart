import 'dart:developer';

import 'package:oraaq/src/core/enum/customer_jobs_filters.dart';

import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/accpted_request_response_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/combine_requests_response_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/offer_recieved/offer_recieved_arguments.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/reuqest_history/request_history_cubit.dart';
import 'package:oraaq/src/presentaion/widgets/no_data_found.dart';

import '../../../widgets/ongoing_request_card.dart';

import '../../../widgets/sheets/request_sheet.dart';
import 'package:badges/badges.dart' as badges;

class RequestHistoryScreen extends StatefulWidget {
  const RequestHistoryScreen({super.key});

  @override
  State<RequestHistoryScreen> createState() => _RequestHistoryScreenState();
}

class _RequestHistoryScreenState extends State<RequestHistoryScreen> {
  final RequestHistoryCubit _cubit = getIt<RequestHistoryCubit>();

  final ValueNotifier<List<RequestEntity>> completedCustomerWorkOrderNotifier =
      ValueNotifier([]);
  final ValueNotifier<List<RequestEntity>> cancelledCustomerWorkOrderNotifier =
      ValueNotifier([]);
  final ValueNotifier<List<CustomerNewRequestDto>>
      newRequestCustomerWorkOrderNotifier = ValueNotifier([]);
  final ValueNotifier<List<AcceptedRequestsResponseDto>> acceptedJobs =
      ValueNotifier([]);
  final ValueNotifier<List<CombineRequestsResponseDto>> combineJobs =
      ValueNotifier([]);
  CustomerJobsFilter selectedFilter = CustomerJobsFilter.allRequests;
  void filterRequests(String filter) {
    if (filter == "All Requests") {
      // _cubit.fetchAllServiceRequests();
    } else if (filter == "Accepted Requests") {
      // _cubit.fetchAcceptedRequest();
    } else if (filter == "Pending Requests") {
      // _cubit.fetchServiceRequests();
    }
  }

  String getSelectedServiceName() {
    if (selectedFilter == CustomerJobsFilter.pendingRequests) {
      return StringConstants.pendingRequests;
    } else if (selectedFilter == CustomerJobsFilter.acceptedRequest) {
      return StringConstants.acceptedRequest;
    } else if (selectedFilter == CustomerJobsFilter.allRequests) {
      return StringConstants.allRequests;
    } else {
      return '';
    }
  }

  final cron = Cron();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.fetchWorkOrders();
      _cubit.fetchCombineRequest();
      _cubit.fetchAcceptedRequest();
      _cubit.fetchNewRequests();
      // cron.schedule(
      //   Schedule(seconds: 10),
      //   () {
      //     log('run cron');

      //     _cubit.fetchNewRequests();
      //   },
      // );
    });
  }

  // @override
  // void dispose() {
  //   cron.close();
  //   super.dispose();
  // }

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
                        text: "All requests",
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
                log("Current state: ${state.runtimeType}");
                if (state is RequestHistoryScreenLoading) {
                  DialogComponent.showLoading(context);
                }
                if (state is RequestHistoryScreenError) {
                  _cubit.fetchWorkOrders();
                  _cubit.fetchCombineRequest();
                  _cubit.fetchAcceptedRequest();
                  _cubit.fetchNewRequests();

                  DialogComponent.hideLoading(context);

                  Toast.show(
                    context: context,
                    variant: SnackbarVariantEnum.warning,
                    title: state.failure.message,
                  );
                }
                if (state is RequestHistoryScreenLoaded) {
                  newRequestCustomerWorkOrderNotifier.value =
                      state.newRequestWorkOrders;
                  completedCustomerWorkOrderNotifier.value =
                      state.completedOrders;
                  cancelledCustomerWorkOrderNotifier.value =
                      state.cancelledOrders;
                  DialogComponent.hideLoading(context);
                }

                if (state is CustomerHomeStateAcceptedJobs) {
                  // DialogComponent.hideLoading(context);
                  acceptedJobs.value = state.acceptedJobs;
                }
                if (state is CustomerHomeStateCombineJobs) {
                  // DialogComponent.hideLoading(context);
                  combineJobs.value = state.combineJobs;
                }
                if (state is NewRequestWorkOrdersLoaded) {
                  DialogComponent.hideLoading(context);
                  newRequestCustomerWorkOrderNotifier.value =
                      state.newRequestWorkOrdersLoaded;
                }
                if (state is CancelCustomerRequestSuccessState) {
                  DialogComponent.hideLoading(context);
                  _cubit.fetchAcceptedRequest();

                  Toast.show(
                    context: context,
                    variant: SnackbarVariantEnum.success,
                    title: state.message,
                  );
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
                if (state is CancelCustomerOrderState) {
                  DialogComponent.hideLoading(context);
                  _cubit.fetchWorkOrders();
                  _cubit.fetchAcceptedRequest();
                  _cubit.fetchCombineRequest();
                  Toast.show(
                    context: context,
                    variant: SnackbarVariantEnum.success,
                    title: state.message,
                  );
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
                          Padding(
                            padding: 16.horizontalPadding,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    getSelectedServiceName(),
                                    style: TextStyleTheme.titleMedium.copyWith(
                                      color: ColorTheme.secondaryText,
                                    ),
                                  ),
                                ),
                                CustomButton(
                                  text: 'Filter',
                                  size: CustomButtonSize.small,
                                  type: CustomButtonType.tertiary,
                                  icon: Symbols.filter_list_rounded,
                                  onPressed: () {
                                    SheetComponenet.showSelectionSheet(
                                      context,
                                      title: "Filter Requests by",
                                      selected: selectedFilter.value,
                                      options: CustomerJobsFilter.values
                                          .map((e) => e.value)
                                          .toList(),
                                    ).then((value) {
                                      if (value != null) {
                                        var temp = CustomerJobsFilter.values
                                            .firstWhere(
                                          (e) => e.value == value,
                                          orElse: () => CustomerJobsFilter
                                              .pendingRequests,
                                        );
                                        if (temp != selectedFilter) {
                                          setState(() {
                                            selectedFilter = temp;
                                          });
                                          filterRequests(value);
                                        }
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          12.verticalSpace,
                          if (selectedFilter ==
                              CustomerJobsFilter.acceptedRequest)
                            ValueListenableBuilder(
                              valueListenable: acceptedJobs,
                              builder: (context, value, child) {
                                return value.isNotEmpty
                                    ? _acceptedRequestsView(value)
                                    : const NoDataFound(
                                        text: StringConstants.firstOrder,
                                        fontSize: 12,
                                      );
                              },
                            ),

                          //
                          //
                          // MARK: pending requests
                          //
                          //

                          if (selectedFilter ==
                              CustomerJobsFilter.pendingRequests)
                            ValueListenableBuilder(
                                valueListenable:
                                    newRequestCustomerWorkOrderNotifier,
                                builder: (context, value, child) {
                                  return value.isNotEmpty
                                      ? _pendingRequestsView(value)
                                      : const NoDataFound(
                                          text: StringConstants.firstOrder,
                                          fontSize: 14,
                                        );
                                }),

                          if (selectedFilter == CustomerJobsFilter.allRequests)
                            ValueListenableBuilder(
                                valueListenable: combineJobs,
                                builder: (context, value, child) {
                                  return value.isNotEmpty
                                      ? _combineRequestsView(value)
                                      : const NoDataFound(
                                          text: StringConstants.firstOrder,
                                          fontSize: 14,
                                        );
                                })
                        ],
                      ),
                      //
                      //
                      // MARK: Completed orders tab
                      //
                      //
                      ValueListenableBuilder(
                          valueListenable: completedCustomerWorkOrderNotifier,
                          builder: (context, value, child) {
                            return value.isNotEmpty
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: value.length,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    separatorBuilder: (context, index) =>
                                        12.verticalSpace,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      RequestEntity currentRequest =
                                          state.completedOrders[index];
                                      log('ratingC: ${currentRequest.ratingCustomer}, ratingM: ${currentRequest.ratingMerchant}');
                                      return CompletedRequestCard(
                                        userName: currentRequest.customerName,
                                        date: currentRequest.requestDate
                                            .formattedDate(),
                                        ratings:
                                            '${currentRequest.ratingMerchant ?? 0}',
                                        price:
                                            currentRequest.bidAmount.toString(),
                                        servicesList:
                                            currentRequest.serviceNames,
                                        duration: '4 hr 40 mints',
                                        rating:
                                            currentRequest.ratingCustomer ?? 0,
                                        variant: CompletedRequestCardVariant
                                            .merchant,
                                        onTap: () async {
                                          final rating =
                                              await SheetComponenet.show(
                                            context,
                                            isScrollControlled: true,
                                            child: CompletedJobSheet(
                                                totalAmount: currentRequest
                                                    .bidAmount
                                                    .toString(),
                                                rating: currentRequest
                                                        .ratingCustomer ??
                                                    0,
                                                userName:
                                                    currentRequest.customerName,
                                                email: currentRequest
                                                    .customerEmail,
                                                serviceType:
                                                    currentRequest.serviceType,
                                                phoneNumber: currentRequest
                                                    .customerContactNumber,
                                                servicesList:
                                                    currentRequest.serviceNames,
                                                date: currentRequest.requestDate
                                                    .formattedDate(),
                                                time: currentRequest
                                                    .requestDate.to12HourFormat,
                                                ratingByMerchant: currentRequest
                                                    .ratingMerchant
                                                    .toString(),
                                                variant:
                                                    CompletedJobSheetVariant
                                                        .customer),
                                          );
                                          log('rating selected: $rating');

                                          if (rating != null && rating > 0) {
                                            _cubit.submitRating(
                                                state.completedOrders[index]
                                                    .workOrderId,
                                                state.completedOrders[index]
                                                    .customerId,
                                                rating);
                                          }
                                        },
                                      );
                                    })
                                : const NoDataFound(
                                    text: StringConstants.firstOrder,
                                    fontSize: 14,
                                  );
                            // const Center(
                            //     child: Text('No Data'),
                            //   );
                          }),
                      //
                      //
                      // MARK: Cancelled orders tab
                      //
                      //
                      ValueListenableBuilder(
                          valueListenable: cancelledCustomerWorkOrderNotifier,
                          builder: (context, value, child) {
                            return value.isNotEmpty
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: value.length,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    separatorBuilder: (context, index) =>
                                        12.verticalSpace,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      RequestEntity currentRequest =
                                          state.cancelledOrders[index];
                                      return CancelRequestCard(
                                        userName: currentRequest.customerName,
                                        duration: "4hr 30 mints",
                                        date: currentRequest.requestDate
                                            .formattedDate(),
                                        time: currentRequest
                                            .requestDate.to12HourFormat,
                                        price:
                                            currentRequest.bidAmount.toString(),
                                        servicesList:
                                            currentRequest.serviceNames,
                                        onTap: () {},
                                      );
                                    })
                                : const NoDataFound(
                                    text: StringConstants.firstCancelOrder,
                                    fontSize: 14,
                                  );
                            // const Center(
                            //     child: Text('No Data'),
                            //   );
                          }),
                    ],
                  );
                } else {
                  return const NoDataFound(
                    text: StringConstants.firstOrder,
                    fontSize: 14,
                  );
                  // const Text('No data');
                }
              },
            )),
      ),
    );
  }

  Widget _acceptedRequestsView(List<AcceptedRequestsResponseDto> acceptedJobs) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: acceptedJobs.length,
      padding: 16.horizontalPadding,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: GestureDetector(
          onTap: () => SheetComponenet.show(
            context,
            isScrollControlled: true,
            child: RequestSheet(
              onCancel: () {
                // context.pop();
                // _cubit.cancelWorkOrder(acceptedJobs
                //   .value[index].orderId);
              },
            ),
          ),
          child: SizedBox(
            height: 120,
            width: 245,
            child: OnGoingRequestCard(
              userName: acceptedJobs[index].serviceName,
              duration: "9hr 30 mints",
              date: DateTime.tryParse(acceptedJobs[index].date)!
                  .formattedDate(), //"21st May",
              time: DateTime.tryParse(acceptedJobs[index].date)!
                  .to12HourFormat, //"6:00 am",
              profileName: acceptedJobs[index].merchantName, //"Zain Hashim",
              price: acceptedJobs[index].amount, //"10,000",
              servicesList: const [],
              variant: OngoingRequestCardVariant.offerReceived,
              onTap: () => SheetComponenet.show(
                context,
                isScrollControlled: true,
                child: RequestSheet(
                  onCancel: () {
                    // context.pop();
                    _cubit.cancelWorkOrder(acceptedJobs[index].orderId);
                  },
                  name: acceptedJobs[index].merchantName,
                  email: acceptedJobs[index].merchantEmail,
                  phoneNumber: acceptedJobs[index].merchantPhone,
                  amount: acceptedJobs[index].amount,
                  date: DateTime.tryParse(acceptedJobs[index].date)!
                      .formattedDate(),
                  time: DateTime.tryParse(acceptedJobs[index].date)!
                      .to12HourFormat,
                  distance: acceptedJobs[index].distance,
                  serviceName: acceptedJobs[index].serviceName,
                  servicesList: acceptedJobs[index].services,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _pendingRequestsView(List<CustomerNewRequestDto> value) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: value.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: 16.horizontalPadding,
        separatorBuilder: (context, index) => 12.verticalSpace,
        itemBuilder: (BuildContext context, int index) {
          ValueNotifier<CustomerNewRequestDto> currentRequest =
              ValueNotifier(value[index]);
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: currentRequest.value.offersReceived != 0
                ? badges.Badge(
                    badgeStyle: const badges.BadgeStyle(
                        badgeColor: ColorTheme.secondary),
                    position: badges.BadgePosition.topEnd(top: -15, end: 1),
                    badgeContent: Text(
                      currentRequest.value.offersReceived.toString(),
                    ),
                    child: OnGoingRequestCard(
                      userName: currentRequest.value.category,
                      duration: currentRequest.value.duration,
                      date: DateTime.tryParse(currentRequest.value.date)!
                          .formattedDate(),
                      time: DateTime.tryParse(currentRequest.value.date)!
                          .to12HourFormat,
                      profileName: "Zain Hashim",
                      price: currentRequest.value.amount.toString(),
                      servicesList: currentRequest.value.services,
                      variant: OngoingRequestCardVariant.waiting,
                      onTap: () {
                        log("services list: ${currentRequest.value.services.toString()}");
                        context.pushNamed(
                          RouteConstants.offeredReceivedScreenRoute,
                          arguments: OfferRecievedArguments(currentRequest),
                        );
                      },
                    ))
                : OnGoingRequestCard(
                    userName: currentRequest.value.category,
                    duration: currentRequest.value.duration,
                    date: DateTime.tryParse(currentRequest.value.date)!
                        .formattedDate(),
                    time: DateTime.tryParse(currentRequest.value.date)!
                        .to12HourFormat,
                    profileName: "Zain Hashim",
                    price: currentRequest.value.amount.toString(),
                    servicesList: currentRequest.value.services,
                    variant: OngoingRequestCardVariant.waiting,
                    onTap: () {
                      log("services list: ${currentRequest.value.services.toString()}");
                      context.pushNamed(
                        RouteConstants.offeredReceivedScreenRoute,
                        arguments: OfferRecievedArguments(currentRequest),
                      );
                    },
                  ),
          );
        });
  }

  Widget _combineRequestsView(List<CombineRequestsResponseDto> value) {
    print('_combineRequestsView $value');
    return ListView.separated(
        shrinkWrap: true,
        itemCount: value.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: 16.horizontalPadding,
        separatorBuilder: (context, index) => 12.verticalSpace,
        itemBuilder: (BuildContext context, int index) {
          ValueNotifier<CombineRequestsResponseDto> currentRequest =
              ValueNotifier(value[index]);

          return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: currentRequest.value.offersReceived != 0
                  ? badges.Badge(
                      badgeStyle: const badges.BadgeStyle(
                          badgeColor: ColorTheme.secondary),
                      position: badges.BadgePosition.topEnd(top: -15, end: 1),
                      badgeContent: Text(
                        currentRequest.value.offersReceived.toString(),
                      ),
                      child: OnGoingRequestCard(
                        buttonText: currentRequest.value.request_status,
                        userName: currentRequest.value.category,
                        duration: currentRequest.value.duration,
                        date: DateTime.tryParse(currentRequest.value.date)!
                            .formattedDate(),
                        time: DateTime.tryParse(currentRequest.value.date)!
                            .to12HourFormat,
                        profileName: "Zain Hashim",
                        price: currentRequest.value.amount.toString(),
                        servicesList: currentRequest.value.services,
                        variant: OngoingRequestCardVariant.waiting,
                        onTap: () {
                          log("services list: ${currentRequest.value.services.toString()}");
                          context.pushNamed(
                            RouteConstants.offeredReceivedScreenRoute,
                            arguments: OfferRecievedArguments(currentRequest),
                          );
                        },
                      ))
                  : OnGoingRequestCard(
                      buttonText: currentRequest.value.request_status,
                      userName: currentRequest.value.request_status == 'pending'
                          ? currentRequest.value.category
                          : currentRequest.value.serviceName,
                      duration: currentRequest.value.request_status == 'pending'
                          ? currentRequest.value.duration
                          : currentRequest.value.merchantName,
                      date: DateTime.tryParse(currentRequest.value.date)!
                          .formattedDate(),
                      time: DateTime.tryParse(currentRequest.value.date)!
                          .to12HourFormat,
                      profileName: "Zain Hashim",
                      price: currentRequest.value.amount.toString(),
                      servicesList: currentRequest.value.services,
                      variant: OngoingRequestCardVariant.waiting,
                      onTap: () {
                        currentRequest.value.request_status == 'pending'
                            ?
                            // log("services list: ${currentRequest.value.services.toString()}");
                            context.pushNamed(
                                RouteConstants.offeredReceivedScreenRoute,
                                arguments:
                                    OfferRecievedArguments(currentRequest),
                              )
                            : SheetComponenet.show(
                                context,
                                isScrollControlled: true,
                                child: RequestSheet(
                                  onCancel: () {
                                    // context.pop();
                                    _cubit.cancelWorkOrder(
                                        currentRequest.value.orderId);
                                  },
                                  name: currentRequest.value.merchantName,
                                  email: currentRequest.value.merchantEmail,
                                  phoneNumber:
                                      currentRequest.value.merchantPhone,
                                  amount: currentRequest.value.amount,
                                  date: DateTime.tryParse(
                                          currentRequest.value.date)!
                                      .formattedDate(),
                                  time: DateTime.tryParse(
                                          currentRequest.value.date)!
                                      .to12HourFormat,
                                  distance: currentRequest.value.distance,
                                  serviceName: currentRequest.value.serviceName,
                                  servicesList: currentRequest.value.services,
                                ),
                              );
                      },
                    ));
        });
  }
}
