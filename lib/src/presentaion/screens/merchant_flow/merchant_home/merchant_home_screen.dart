import 'dart:developer';

import 'package:oraaq/src/core/enum/merchant_jobs_filter.dart';
import 'package:oraaq/src/core/extensions/double_extension.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_home/merchant_home_screen_cubit.dart';
import 'package:oraaq/src/presentaion/widgets/no_data_found.dart';

class MerchantHomeScreen extends StatefulWidget {
  const MerchantHomeScreen({super.key});

  @override
  State<MerchantHomeScreen> createState() => _MerchantHomeScreenState();
}

class _MerchantHomeScreenState extends State<MerchantHomeScreen> {
  final MerchantHomeScreenCubit _cubit = getIt<MerchantHomeScreenCubit>();
  //get userID
  final user = getIt<UserEntity>();
  MerchantJobsFilter selectedFilter = MerchantJobsFilter.newRequests;

  final ValueNotifier<List<RequestEntity>> workInProgressOrdersNotifier =
      ValueNotifier([]);
  final ValueNotifier<List<NewServiceRequestResponseDto>>
      serviceRequestsNotifier = ValueNotifier([]);
  final ValueNotifier<List<NewServiceRequestResponseDto>>
      allServiceRequestsNotifier = ValueNotifier([]);
  final ValueNotifier<List<RequestEntity>> appliedJobsNotifier =
      ValueNotifier([]);

  final cron = Cron();

  String getSelectedServiceName() {
    if (selectedFilter == MerchantJobsFilter.newRequests) {
      return StringConstants.latestServiceRequests;
    } else if (selectedFilter == MerchantJobsFilter.alreadyQuoted) {
      return StringConstants.alreadyQuoted;
    } else if (selectedFilter == MerchantJobsFilter.allRequests) {
      return StringConstants.allServiceRequests;
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _cubit.fetchWorkInProgressOrders();
      await _cubit.fetchAllServiceRequests();
      await _cubit.fetchAppliedJobs();
      await _cubit.fetchServiceRequests();
      log("Merchant Id : ${user.id}");

      cron.schedule(
        Schedule(seconds: 2),
        () {
          log('cron run');
          _cubit.fetchWorkInProgressOrdersCron();
          _cubit.fetchAllServiceRequestsCron();
          // _cubit.fetchWorkInProgressOrdersCron();
        },
      );
    });
  }

  @override
  void dispose() {
    //cron.close();
    super.dispose();
  }

  void filterRequests(String filter) {
    if (filter == "All Requests") {
      _cubit.fetchAllServiceRequests();
    } else if (filter == "Already Quoted") {
      _cubit.fetchAppliedJobs();
    } else if (filter == "New Requests") {
      _cubit.fetchServiceRequests();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ScreenUtil().statusBarHeight + 77),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AssetConstants.homeAppbarBackground),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   StringConstants.goodMorning,
                          //   style: TextStyleTheme.titleSmall.copyWith(
                          //     color: ColorTheme.neutral3,
                          //   ),
                          // ),
                          Text(
                            DateTime.now().hour >= 6 &&
                                    DateTime.now().hour <= 12
                                ? StringConstants.goodMorning
                                : DateTime.now().hour > 12 &&
                                        DateTime.now().hour <= 16
                                    ? StringConstants.goodAfterNoon
                                    : StringConstants.goodEvening,
                            style: TextStyleTheme.titleSmall
                                .copyWith(color: ColorTheme.neutral3),
                          ),
                          Text(
                            getIt<UserEntity>().name,
                            style: TextStyleTheme.headlineSmall.copyWith(
                                color: ColorTheme.neutral3, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      size: CustomButtonSize.small,
                      type: CustomButtonType.tertiary,
                      icon: Symbols.refresh_rounded,
                      onPressed: () async {
                        await _cubit.fetchWorkInProgressOrders();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                      size: CustomButtonSize.small,
                      type: CustomButtonType.tertiary,
                      icon: Symbols.account_circle_filled_rounded,
                      onPressed: () => context
                          .pushNamed(RouteConstants.merchantProfileRoute)
                          .then((_) => setState(() {})),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: BlocConsumer<MerchantHomeScreenCubit, MerchantHomeScreenState>(
          listener: (context, state) {
            if (state is MerchantHomeLoading) {
              DialogComponent.showLoading(context);
            }
            if (state is MerchantHomeError) {
              DialogComponent.hideLoading(context);
              Toast.show(
                context: context,
                variant: SnackbarVariantEnum.warning,
                title: state.failure.message,
              );
            }
            if (state is WorkInProgressOrdersLoaded) {
              DialogComponent.hideLoading(context);

              workInProgressOrdersNotifier.value = state.workInProgressOrders;
            }

            if (state is AllServiceRequestsLoaded) {
              DialogComponent.hideLoading(context);

              serviceRequestsNotifier.value = state.serviceRequests;
            }
            if (state is ServiceRequestsLoaded) {
              DialogComponent.hideLoading(context);

              allServiceRequestsNotifier.value = state.serviceRequests;
            }
            if (state is WorkInProgressOrdersCronLoaded) {
              log('cron loaded');
              workInProgressOrdersNotifier.value = state.workInProgressOrders;
            }
            if (state is AllServiceRequestsCronLoaded) {
              serviceRequestsNotifier.value = state.serviceRequests;
            }
            if (state is AppliedJobsLoaded) {
              DialogComponent.hideLoading(context);
              appliedJobsNotifier.value = state.appliedJobs;
            }
            if (state is CancelMerchantOrderState) {
              DialogComponent.hideLoading(context);
              _cubit.fetchAppliedJobs();
              _cubit.fetchWorkInProgressOrders();

              Toast.show(
                context: context,
                variant: SnackbarVariantEnum.success,
                title: state.message,
              );
            }
            if (state is CompleteMerchantOrderState) {
              DialogComponent.hideLoading(context);
              _cubit.fetchWorkInProgressOrders();
              Toast.show(
                context: context,
                variant: SnackbarVariantEnum.success,
                title: state.message,
              );
            }
            if (state is BidPostedSuccessState) {
              DialogComponent.hideLoading(context);
              _cubit.fetchAllServiceRequests();
              _cubit.fetchAppliedJobs();
              Toast.show(
                context: context,
                variant: SnackbarVariantEnum.success,
                title: state.message,
              );
              debugPrint(state.message);
            }
          },
          builder: (context, state) {
            debugPrint('Current state: $state');

            return ListView(
              padding: 20.verticalPadding,
              children: [
                Padding(
                  padding: 16.horizontalPadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          StringConstants.approvedJobs,
                          style: TextStyleTheme.titleSmall.copyWith(
                            color: ColorTheme.secondaryText,
                          ),
                        ),
                      ),
                      CustomButton(
                        size: CustomButtonSize.small,
                        type: CustomButtonType.tertiary,
                        text: "View All",
                        onPressed: () {
                          context.pushNamed(
                              RouteConstants.merchantViewAllOrdersRoute);
                        },
                      ),
                      // CustomButton(
                      //   size: CustomButtonSize.small,
                      //   type: CustomButtonType.tertiary,
                      //   icon: Symbols.info_rounded,
                      //   onPressed: () => Toast.show(
                      //     context: context,
                      //     variant: SnackbarVariantEnum.normal,
                      //     title: StringConstants.upcomingJobs,
                      //     message: StringConstants.upcomingToastDetails,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                12.verticalSpace,
                SizedBox(
                    height: 120,
                    child: ValueListenableBuilder<List<RequestEntity>>(
                      valueListenable: workInProgressOrdersNotifier,
                      builder: (context, value, child) {
                        return value.isNotEmpty
                            ? _buildWorkInProgress(value)
                            : const NoDataFound(
                                text: StringConstants.firstMerchantOrder,
                                fontSize: 11,
                              );
                        // const Center(
                        //     child: Text('No Data'),
                        //   );
                      },
                    )),
                40.verticalSpace,
                Padding(
                  padding: 16.horizontalPadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          getSelectedServiceName(),
                          // selectedFilter == MerchantJobsFilter.allRequests
                          //     ? StringConstants.latestServiceRequests
                          //     : StringConstants.alreadyQuoted,
                          style: TextStyleTheme.titleMedium.copyWith(
                            color: ColorTheme.secondaryText,
                          ),
                        ),
                      ),
                      CustomButton(
                        size: CustomButtonSize.small,
                        type: CustomButtonType.tertiary,
                        icon: Symbols.filter_list_rounded,
                        onPressed: () {
                          SheetComponenet.showSelectionSheet(
                            context,
                            title: "Filter Requests by",
                            selected: selectedFilter.value,
                            options: MerchantJobsFilter.values
                                .map((e) => e.value)
                                .toList(),
                          ).then((value) {
                            if (value != null) {
                              var temp = MerchantJobsFilter.values.firstWhere(
                                (e) => e.value == value,
                                orElse: () => MerchantJobsFilter.newRequests,
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
                      16.horizontalSpace,
                      CustomButton(
                        size: CustomButtonSize.small,
                        type: CustomButtonType.tertiary,
                        icon: Symbols.info_rounded,
                        onPressed: () => Toast.show(
                          context: context,
                          variant: SnackbarVariantEnum.normal,
                          title: StringConstants.latestServiceRequests,
                          message: StringConstants.serviceToastDetails,
                        ),
                      ),
                    ],
                  ),
                ),
                12.verticalSpace,
                if (selectedFilter == MerchantJobsFilter.newRequests)
                  ValueListenableBuilder<List<NewServiceRequestResponseDto>>(
                    valueListenable: serviceRequestsNotifier,
                    builder: (context, serviceRequests, child) {
                      return serviceRequests.isNotEmpty
                          ? _buildServiceRequestsView(serviceRequests)
                          : const NoDataFound(
                              text: StringConstants.noRequestFound,
                              fontSize: 12,
                            );
                    },
                  )
                else if (selectedFilter == MerchantJobsFilter.alreadyQuoted)
                  ValueListenableBuilder<List<RequestEntity>>(
                    valueListenable: appliedJobsNotifier,
                    builder:
                        (BuildContext context, dynamic value, Widget? child) {
                      return value.isNotEmpty
                          ? _buildAppliedJobsView(value)
                          : const NoDataFound(
                              text: StringConstants.noRequestFound,
                              fontSize: 12,
                            );
                    },
                  )
                else if (selectedFilter == MerchantJobsFilter.allRequests)
                  ValueListenableBuilder<List<NewServiceRequestResponseDto>>(
                    valueListenable: allServiceRequestsNotifier,
                    builder: (context, serviceRequests, child) {
                      return serviceRequests.isNotEmpty
                          ? _buildAllServiceRequestsView(serviceRequests)
                          : const NoDataFound(
                              text: StringConstants.noRequestFound,
                              fontSize: 12,
                            );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildWorkInProgress(List<RequestEntity> workInProgressOrders) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: workInProgressOrders.length,
      padding: 16.horizontalPadding,
      separatorBuilder: (context, index) => 12.horizontalSpace,
      itemBuilder: (BuildContext context, int index) {
        final order = workInProgressOrders[index];

        log("Order ID : ${order.bidId}");

        return GestureDetector(
          onTap: () {
            SheetComponenet.show(context,
                isScrollControlled: true,
                child: NewQuoteSheet(
                    date: order.requestDate.formattedDate(),
                    time: order.requestDate.to12HourFormat,
                    distance: order.distance.toString(),
                    name: order.customerName,
                    email: order.customerEmail,
                    phoneNumber: order.customerContactNumber,
                    servicesList: order.serviceNames,
                    // distance: order.distance,
                    workOrderId: order.workOrderId,
                    // date: order.requestDate.formattedDate(),
                    // time: order.requestDate.to12HourFormat,
                    sheetName: "Action",
                    onCancel: () {
                      context.pop();
                      _cubit.cancelWorkOrder(order.bidId);
                    },
                    onSubmit: (int bidAmount) {
                      context.pop();
                      _cubit.completeWorkOrder(order.bidId);
                    },
                    defaultValue: order.bidAmount.toInt(), //15000,
                    variant: NewQuoteSheetSheetVariant.alreadyQuoted));
          },
          child: SizedBox(
            width: 245,
            child: ApprovedRequestCard(
              userName: order.customerName,
              distance:
                  order.distance.toString(), // Placeholder, update as needed
              date: order.requestDate.formattedDate(),
              time: order.requestDate.to12HourFormat,
              price: order.bidAmount.asIntString,
              variant: ApprovedRequestCardVariant.urgent,
            ),
          ),
        );
      },
    );
  }

  Widget _buildServiceRequestsView(
      List<NewServiceRequestResponseDto> serviceRequests) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: serviceRequests.length,
      padding: 16.horizontalPadding,
      separatorBuilder: (context, index) => 12.verticalSpace,
      itemBuilder: (BuildContext context, int index) {
        final job = serviceRequests[index];
        log(job.customerName);
        log(job.distance.toString());
        return GestureDetector(
          onTap: () => SheetComponenet.show(context,
              isScrollControlled: true,
              child: NewQuoteSheet(
                  name: job.customerName,
                  date: DateTime.tryParse(job.requestDate)!.formattedDate(),
                  email: job.customerName,
                  distance: job.distance,
                  servicesList: job.serviceNames,
                  time: DateTime.tryParse(job.requestDate)!.to12HourFormat,
                  //"3:30pm",
                  defaultValue: job.totalPrice,
                  onCancel: () => context.pop(),
                  onSubmit: (int bidAmount) =>
                      _cubit.postBid(job.serviceRequestId, bidAmount),
                  variant: NewQuoteSheetSheetVariant.newQuote)),
          child: NewRequestCard(
            buttonText: job.status,
            userName: job.customerName,
            distance: job.distance, //"45 km",
            date: DateTime.tryParse(job.requestDate)!.formattedDate(),
            time: DateTime.tryParse(job.requestDate)!.to12HourFormat,
            price: job.totalPrice.toString(),
            servicesList: job.serviceNames,
            variant: NewRequestCardVariant.newRequest,
          ),
        );
      },
    );
  }

  Widget _buildAllServiceRequestsView(
      List<NewServiceRequestResponseDto> serviceRequests) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: serviceRequests.length,
      padding: 16.horizontalPadding,
      separatorBuilder: (context, index) => 12.verticalSpace,
      itemBuilder: (BuildContext context, int index) {
        final job = serviceRequests[index];
        log(job.toString());
        return GestureDetector(
          onTap: () => SheetComponenet.show(context,
              isScrollControlled: true,
              child: NewQuoteSheet(
                  name: job.customerName,
                  date: DateTime.tryParse(job.requestDate)!.formattedDate(),
                  email: job.customerName,
                  distance: job.distance,
                  servicesList: job.serviceNames,
                  time: DateTime.tryParse(job.requestDate)!
                      .to12HourFormat, //"3:30pm",
                  defaultValue: job.totalPrice,
                  onCancel: () => context.pop(),
                  onSubmit: (int bidAmount) =>
                      _cubit.postBid(job.serviceRequestId, bidAmount),
                  variant: job.status == "Open"
                      ? NewQuoteSheetSheetVariant.newQuote
                      : NewQuoteSheetSheetVariant.alreadyQuoted)),
          child: NewRequestCard(
            buttonText: job.status,
            userName: job.customerName,
            distance: job.distance, //"45 km",
            date: DateTime.tryParse(job.requestDate)!.formattedDate(),
            time: DateTime.tryParse(job.requestDate)!.to12HourFormat,
            price: job.totalPrice.toString(),
            servicesList: job.serviceNames,
            variant: NewRequestCardVariant.newRequest,
          ),
        );
      },
    );
  }

  Widget _buildAppliedJobsView(List<RequestEntity> appliedJobs) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: appliedJobs.length,
      padding: 16.horizontalPadding,
      separatorBuilder: (context, index) => 12.verticalSpace,
      itemBuilder: (BuildContext context, int index) {
        final job = appliedJobs[index];
        return GestureDetector(
          onTap: () => SheetComponenet.show(context,
              isScrollControlled: true,
              child: NewQuoteSheet(
                  name: job.customerName,
                  date: job.bidDate.formattedDate(),
                  // DateTime.tryParse(job.requestDate)!.formattedDate(),
                  distance: job.distance,
                  email: "N/A",
                  phoneNumber: "N/A",
                  servicesList: job.serviceNames,
                  time: job.bidDate.to12HourFormat,
                  //DateTime.tryParse(job.requestDate)!                     .formattedDate(), //"3:30pm",
                  defaultValue: job.bidAmount.toInt(),
                  onCancel: () {
                    context.pop();
                    _cubit
                        .cancelWorkOrderFromMerchantAppliedRequests(job.bidId);
                  },
                  onSubmit: (int bidAmmount) => context.pop(),
                  variant: NewQuoteSheetSheetVariant.alreadyQuoted)),
          child: NewRequestCard(
            buttonText: job.status.name,
            userName: job.customerName,
            distance: job.distance.toString(), //"45 km",
            date: job.bidDate.formattedDate(),
            //DateTime.tryParse(job.bidDate)!.formattedDate(),
            time: job.bidDate.to12HourFormat,
            //DateTime.tryParse(job.bidDate)!.to12HourFormat,
            price: job.bidAmount.asIntString,
            servicesList: job.serviceNames,
            variant: NewRequestCardVariant.alreadyApplied,
          ),
        );
      },
    );
  }
}
