import 'dart:developer';

import 'package:oraaq/src/core/extensions/widget_extension.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/accpted_request_response_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/offer_recieved/offer_recieved_arguments.dart';
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

  final ValueNotifier<List<RequestEntity>> completedCustomerWorkOrderNotifier =
      ValueNotifier([]);
  final ValueNotifier<List<RequestEntity>> cancelledCustomerWorkOrderNotifier =
      ValueNotifier([]);
  final ValueNotifier<List<CustomerNewRequestDto>>
      newRequestCustomerWorkOrderNotifier = ValueNotifier([]);
  final ValueNotifier<List<AcceptedRequestsResponseDto>> acceptedJobs =
      ValueNotifier([]);

  final cron = Cron();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.fetchWorkOrders();
      _cubit.fetchAcceptedRequest();
      cron.schedule(
        Schedule(minutes: 1),
        () {
            log('run cron');
           _cubit.fetchNewRequests();
        },
      );
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
                if(state is NewRequestWorkOrdersLoaded){
                  DialogComponent.hideLoading(context);
                  newRequestCustomerWorkOrderNotifier.value = state.newRequestWorkOrdersLoaded;
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
                            child: ValueListenableBuilder(
                              valueListenable: acceptedJobs,
                              builder: (context, value, child) {
                                return value.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: acceptedJobs.value.length,
                                        padding: 16.horizontalPadding,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
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
                                                userName: acceptedJobs
                                                    .value[index].serviceName,
                                                duration: "9hr 30 mints",
                                                date: DateTime.tryParse(
                                                        acceptedJobs
                                                            .value[index].date)!
                                                    .formattedDate(), //"21st May",
                                                time: DateTime.tryParse(
                                                        acceptedJobs
                                                            .value[index].date)!
                                                    .to12HourFormat, //"6:00 am",
                                                profileName: acceptedJobs
                                                    .value[index]
                                                    .merchantName, //"Zain Hashim",
                                                price: acceptedJobs.value[index]
                                                    .amount, //"10,000",
                                                servicesList: const [],
                                                variant:
                                                    OngoingRequestCardVariant
                                                        .offerReceived,
                                                onTap: () =>
                                                    SheetComponenet.show(
                                                  context,
                                                  isScrollControlled: true,
                                                  child: RequestSheet(
                                                    onCancel: () => _cubit
                                                        .cancelCustomerCreatedRequest(
                                                            acceptedJobs
                                                                .value[index]
                                                                .requestId),
                                                    name: acceptedJobs
                                                        .value[index]
                                                        .merchantName,
                                                    email: acceptedJobs
                                                        .value[index]
                                                        .merchantEmail,
                                                    phoneNumber: acceptedJobs
                                                        .value[index]
                                                        .merchantPhone,
                                                    amount: acceptedJobs
                                                        .value[index].amount,
                                                    date: DateTime.tryParse(
                                                            acceptedJobs
                                                                .value[index]
                                                                .date)!
                                                        .formattedDate(),
                                                    time: DateTime.tryParse(
                                                            acceptedJobs
                                                                .value[index]
                                                                .date)!
                                                        .to12HourFormat,
                                                    distance: acceptedJobs
                                                        .value[index].distance,
                                                    serviceName: acceptedJobs
                                                        .value[index]
                                                        .serviceName,
                                                    servicesList: acceptedJobs
                                                        .value[index].services,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: Text('No Data'),
                                      );
                              },
                            ),
                          ),
                          24.verticalSpace,
                          Text(
                            StringConstants.requests,
                            style: TextStyleTheme.titleSmall
                                .copyWith(color: ColorTheme.secondaryText),
                          ).wrapInPadding(16.horizontalPadding),
                          12.verticalSpace,
                          ValueListenableBuilder(
                            valueListenable: newRequestCustomerWorkOrderNotifier,
                            builder: (context,value,child) {
                              return value.isNotEmpty? ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: value.length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: 16.horizontalPadding,
                                      separatorBuilder: (context, index) =>
                                          12.verticalSpace,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        // CustomerNewRequestDto currentRequest =
                                        //     value[index];
                                        ValueNotifier<CustomerNewRequestDto> currentRequest =
                                            ValueNotifier(value[index]);
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 12.0),
                                          child: OnGoingRequestCard(
                                            userName: currentRequest.value.category,
                                            duration: currentRequest.value.duration,
                                            date: DateTime.tryParse(
                                                    currentRequest.value.date)!
                                                .formattedDate(),
                                            time: DateTime.tryParse(
                                                    currentRequest.value.date)!
                                                .to12HourFormat,
                                            profileName: "Zain Hashim",
                                            price: currentRequest.value.amount.toString(),
                                            servicesList: currentRequest.value.services,
                                            variant:
                                                OngoingRequestCardVariant.waiting,
                                            onTap: () {
                                              log("services list: ${currentRequest.value.services.toString()}");
                                              context.pushNamed(
                                              RouteConstants
                                                  .offeredReceivedScreenRoute,
                                                  arguments: OfferRecievedArguments(currentRequest),
                                            );
                                            },
                                          ),
                                        );
                                      }): const Center(
                                child: Center(child: Text('No Data')),
                              );
                            }
                          )
                             
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
                                      return CompletedRequestCard(
                                        userName: currentRequest.customerName,
                                        date: currentRequest.requestDate
                                            .formattedDate(),
                                        ratings:
                                            currentRequest.rating.toString(),
                                        price:
                                            currentRequest.bidAmount.toString(),
                                        servicesList:
                                            currentRequest.serviceNames,
                                        duration: '4 hr 40 mints',
                                        rating: currentRequest.rating!,
                                        variant: CompletedRequestCardVariant
                                            .merchant,
                                        onTap: () {
                                          SheetComponenet.show(
                                            context,
                                            isScrollControlled: true,
                                            child: const CompletedJobSheet(
                                                rating: 0,
                                                variant:
                                                    CompletedJobSheetVariant
                                                        .customer),
                                          );
                                        },
                                      );
                                    })
                                : const Center(
                                    child: Text('No Data'),
                                  );
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
                                        time: currentRequest.requestDate
                                            .to12HourFormat,
                                        price: currentRequest.bidAmount.toString(),
                                        servicesList: currentRequest.serviceNames,
                                        onTap: () {},
                                      );
                                    })
                                : const Center(
                                    child: Text('No Data'),
                                  );
                          }),
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
