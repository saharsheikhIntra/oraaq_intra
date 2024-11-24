import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:oraaq/src/core/extensions/widget_extension.dart';
import 'package:oraaq/src/data/local/questionnaire/question_model.dart';
import 'package:oraaq/src/domain/entities/service_entity.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/pick_location/pick_location_arguement.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/sub_services_args.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/make_offer_page.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/questions_accordion.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/questions_page.dart';

class SubServicesScreen extends StatefulWidget {
  final SubServicesArgs args;

  const SubServicesScreen({
    super.key,
    required this.args,
  });

  @override
  State<SubServicesScreen> createState() => _SubServicesScreenState();
}

class _SubServicesScreenState extends State<SubServicesScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  final _currentPage = ValueNotifier<int>(1);
  final List<ServiceEntity> _selectedSubServices = [];

  void _handleSelection(List<ServiceEntity> selected) {
    // Track selected sub-services
    setState(() {
      _selectedSubServices
          .addAll(selected.where((e) => !_selectedSubServices.contains(e)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sub Services"),
        actions: [
          if (widget.args.selectedMainServices.isNotEmpty)
            ValueListenableBuilder(
                valueListenable: _currentPage,
                builder: (context, value, child) => Stack(
                      alignment: Alignment.center,
                      children: [
                        LoadingIndicator(
                          value:
                              value / (widget.args.selectedMainServices.length),
                          size: 24,
                        ),
                        Text("$value",
                            style: const TextStyle(
                              height: 0,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            )).wrapInPadding(1.bottomPadding),
                      ],
                    ).wrapInPadding(12.horizontalPadding))
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.args.selectedMainServices.length,
        onPageChanged: (page) => _currentPage.value = page + 1,
        itemBuilder: (context, index) {
          final service = widget.args.selectedMainServices[index];

          return (index < widget.args.selectedMainServices.length)
              ? QuestionsPage(
                  service: service,
                  onSelect: _handleSelection,
                  onNext: () {
                    if (index < widget.args.selectedMainServices.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutCubic,
                      );
                    }
                  },
                  onPrevious: () {
                    if (index > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                )
              : MakeOfferPage(
                  onChanged: (offer) => Logger().i(offer),
                  onContinue: (String datetimeSelected, int amount,
                      int userOfferAmount) {
                    log('amount: $amount userOfferAmount: $userOfferAmount');
                    context.pushNamed(
                        arguments: PickLocationScreenArgument(
                            widget.args.category.id,
                            _selectedSubServices
                                .map((e) => QuestionModel(
                                    id: e.serviceId,
                                    name: e.shortTitle,
                                    prompt: '',
                                    level: -1,
                                    isSelected: true,
                                    questions: [],
                                    fee: e.price.toInt()))
                                .toList(),
                            datetimeSelected,
                            amount,
                            userOfferAmount),
                        RouteConstants.pickLocationRoute);
                  },
                  onPrevious: () {
                    if (index != 0) {
                      _currentPage.value = index;
                    }
                    _pageController.previousPage(
                      duration: 600.milliseconds,
                      curve: Curves.easeInOutCubic,
                    );
                  },
                  selectedServices: _selectedSubServices
                      .map((e) => QuestionModel(
                          id: e.serviceId,
                          name: e.shortTitle,
                          prompt: '',
                          level: -1,
                          isSelected: true,
                          questions: [],
                          fee: e.price.toInt()))
                      .toList());
        },
      ),
    );
  }
}
