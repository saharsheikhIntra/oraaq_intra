import 'package:oraaq/src/core/extensions/widget_extension.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/customer_home/customer_home_cubit.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/customer_home/customer_home_state.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/customer_home/widgets/service_card.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_argument.dart';
import 'package:oraaq/src/presentaion/widgets/no_data_found.dart';
import 'package:oraaq/src/presentaion/widgets/ongoing_request_card.dart';

import '../../../widgets/sheets/request_sheet.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final _cubit = getIt.get<CustomerHomeCubit>();
  List<CategoryEntity> _categories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _cubit,
        child: BlocConsumer<CustomerHomeCubit, CustomerHomeState>(
          listener: (context, state) {
            if (state is CustomerHomeStateLoading) {
              DialogComponent.showLoading(context);
            }
            if (state is CustomerHomeStateError) {
              DialogComponent.hideLoading(context);
              Toast.show(
                context: context,
                variant: SnackbarVariantEnum.warning,
                title: state.error.message,
              );
            }
            if (state is CustomerHomeStateCategories) {
              DialogComponent.hideLoading(context);
              _categories = state.categories;
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(ScreenUtil().statusBarHeight + 56),
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  AssetConstants.homeAppbarBackground,
                                ))),
                        child: SafeArea(
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                StringConstants.goodMorning,
                                style: TextStyleTheme.titleSmall.copyWith(color: ColorTheme.neutral3),
                              ),
                              Text(
                                StringConstants.johnDoe,
                                style: TextStyleTheme.displaySmall.copyWith(color: ColorTheme.neutral3),
                              ),
                            ],
                          )),
                          CustomButton(
                            size: CustomButtonSize.small,
                            type: CustomButtonType.tertiary,
                            icon: Symbols.account_circle_filled_rounded,
                            onPressed: () => context.pushNamed(RouteConstants.customerProfileRoute),
                          ),
                        ])))),
                body: ListView(padding: 20.verticalPadding, children: [
                  Padding(
                      padding: 16.horizontalPadding,
                      child: Row(children: [
                        Expanded(
                            child: Text(
                          StringConstants.onGoingJobs,
                          style: TextStyleTheme.titleMedium.copyWith(color: ColorTheme.secondaryText),
                        )),
                        GestureDetector(
                            onTap: () => context.pushNamed(
                                  RouteConstants.requestHistoryScreenRoute,
                                ),
                            child: Text(
                              StringConstants.viewAll,
                              style: TextStyleTheme.labelLarge.copyWith(color: ColorTheme.primary),
                            )),
                      ])),
                  12.verticalSpace,
                  SizedBox(
                      height: 120,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          padding: 16.horizontalPadding,
                          separatorBuilder: (context, index) => 12.horizontalSpace,
                          itemBuilder: (BuildContext context, int index) => GestureDetector(
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
                                    variant: OngoingRequestCardVariant.offerReceived,
                                    onTap: () => SheetComponenet.show(
                                      context,
                                      isScrollControlled: true,
                                      child: const RequestSheet(),
                                    ),
                                  ))))),
                  30.verticalSpace,
                  Text(
                    StringConstants.services,
                    style: TextStyleTheme.titleMedium.copyWith(color: ColorTheme.secondaryText),
                  ).wrapInPadding(16.horizontalPadding),
                  12.verticalSpace,
                  _categories.isEmpty
                      ? const NoDataFound(
                          text: StringConstants.noCategoriesFound,
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          padding: 16.horizontalPadding,
                          itemCount: _categories.length,
                          separatorBuilder: (c, i) => 16.verticalSpace,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (c, i) => ServiceCard(
                              category: _categories[i],
                              onTap: () => context.pushNamed(
                                    RouteConstants.questionnaireRoute,
                                    arguments: QuestionnaireArgument(_categories[i]),
                                  ))),
                ]));
          },
        ));
  }
}
