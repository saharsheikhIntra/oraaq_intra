import 'package:oraaq/src/presentaion/screens/merchant_flow/merchant_home/merchant_home_screen_cubit.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/widgets/no_data_found.dart';

class WorkInProgressScreen extends StatefulWidget {
  const WorkInProgressScreen({
    super.key,
  });

  @override
  State<WorkInProgressScreen> createState() => _WorkInProgressScreenState();
}

class _WorkInProgressScreenState extends State<WorkInProgressScreen> {
  final MerchantHomeScreenCubit _cubit = getIt<MerchantHomeScreenCubit>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //CRON job
      _cubit.fetchWorkInProgressOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringConstants.approvedJobs),
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
            }
            if (state is CancelMerchantOrderState) {
              DialogComponent.hideLoading(context);
              _cubit.fetchWorkInProgressOrders();
              Toast.show(
                context: context,
                variant: SnackbarVariantEnum.success,
                title: state.message,
              );
            }
          },
          builder: (context, state) {
            if (state is WorkInProgressOrdersLoaded) {
              return state.workInProgressOrders.isEmpty
                  ? const NoDataFound(
                      text: StringConstants.firstMerchantOrder,
                      fontSize: 12,
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: state.workInProgressOrders.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      separatorBuilder: (context, index) => 12.verticalSpace,
                      itemBuilder: (BuildContext context, int index) {
                        final order = state.workInProgressOrders[index];

                        return GestureDetector(
                          onTap: () {
                            SheetComponenet.show(context,
                                isScrollControlled: true,
                                child: NewQuoteSheet(
                                    name: order.customerName,
                                    email: order.customerEmail,
                                    phoneNumber: order.customerContactNumber,
                                    servicesList: order.serviceNames,
                                    workOrderId: order.workOrderId,
                                    onCancel: () {
                                      context.pop();
                                      _cubit.cancelWorkOrder(order.workOrderId);
                                    },
                                    onSubmit: (double bidAmmount) =>
                                        context.pop(),
                                    defaultValue:
                                        order.bidAmount.toDouble(), //15000,
                                    variant: NewQuoteSheetSheetVariant
                                        .alreadyQuoted));
                          },
                          child: SizedBox(
                            width: 245,
                            child: ApprovedRequestCard(
                              userName: order.customerName,
                              distance: order.distance
                                  .toString(), // Placeholder, update as needed
                              date: order.requestDate.formattedDate(),
                              time: order.requestDate.to12HourFormat,
                              price: order.bidAmount.toString(),
                              variant: ApprovedRequestCardVariant.urgent,
                            ),
                          ),
                        );
                      },
                    );
            } else {
              return const Center(child: Text('No Data'));
            }
          },
        ),
      ),
    );
  }
}
