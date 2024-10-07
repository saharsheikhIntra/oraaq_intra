import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/core/extensions/widget_extension.dart';

import '../../../../config/themes/color_theme.dart';
import '../../../../config/themes/text_style_theme.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../widgets/cancel_request_card.dart';
import '../../../widgets/completed_request_card.dart';
import '../../../widgets/ongoing_request_card.dart';
import '../../../widgets/sheets/completed_job_sheet.dart';
import '../../../widgets/sheets/request_sheet.dart';
import '../../../widgets/sheets/sheet_component.dart';

class RequestHistoryScreen extends StatefulWidget {
  const RequestHistoryScreen({super.key});

  @override
  State<RequestHistoryScreen> createState() => _RequestHistoryScreenState();
}

class _RequestHistoryScreenState extends State<RequestHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
              title: const Text(StringConstants.requestHistory),
              bottom: TabBar(
                indicatorPadding: 16.horizontalPadding,
                splashBorderRadius: 12.topBorderRadius,
                tabs: const [
                  Tab(text: "On Going", icon: Icon(Symbols.award_star_rounded)),
                  Tab(text: "Completed", icon: Icon(Symbols.beenhere_rounded)),
                  Tab(
                      text: "Cancelled",
                      icon: Icon(Symbols.disabled_by_default_rounded)),
                ],
              )),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
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
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                          onTap: () => SheetComponenet.show(
                            context,
                            isScrollControlled: true,
                            child: const RequestSheet(),
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
                              variant: OngoingRequestCardVariant.offerReceived,
                              onTap: () => SheetComponenet.show(
                                context,
                                isScrollControlled: true,
                                child: const RequestSheet(),
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
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: 16,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: 16.horizontalPadding,
                    separatorBuilder: (context, index) => 12.verticalSpace,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: OnGoingRequestCard(
                        userName: "Ali Hassan",
                        duration: "4hr 30 mints",
                        date: "21st May",
                        time: "6:00 am",
                        profileName: "Zain Hashim",
                        price: "10,000",
                        servicesList: const [],
                        variant: OngoingRequestCardVariant.waiting,
                        onTap: () => context.pushNamed(
                          RouteConstants.offeredReceivedScreenRoute,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 3,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                separatorBuilder: (context, index) => 12.verticalSpace,
                itemBuilder: (BuildContext context, int index) =>
                    CompletedRequestCard(
                  userName: "AC REPAIRING",
                  date: "4th March",
                  ratings: "4 / 5",
                  price: "12000",
                  servicesList: const [],
                  duration: '4 hr 40 mints',
                  rating: 2,
                  variant: CompletedRequestCardVariant.merchant,
                  onTap: () {
                    SheetComponenet.show(
                      context,
                      isScrollControlled: true,
                      child: const CompletedJobSheet(
                          rating: 0,
                          variant: CompletedJobSheetVariant.customer),
                    );
                  },
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 3,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                separatorBuilder: (context, index) => 12.verticalSpace,
                itemBuilder: (BuildContext context, int index) =>
                    CancelRequestCard(
                  userName: "AC REPAIRED",
                  duration: "4hr 30 mints",
                  date: "21st May",
                  time: "6:00 am",
                  price: "10,000",
                  servicesList: const [
                    "Hair cut",
                    "Hair",
                    "Hair extension",
                    "Hair extension"
                  ],
                  onTap: () {},
                ),
              ),
            ],
          )),
    );
  }
}
