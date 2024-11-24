import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oraaq/src/core/extensions/widget_extension.dart';
import 'package:oraaq/src/domain/entities/service_entity.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/sub_services_args.dart';
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
          return QuestionsPage(
            service: service,
            onSelect: _handleSelection,
            onNext: () {
              if (index < widget.args.selectedMainServices.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
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
          );
        },
      ),
    );
  }
}
