import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:oraaq/src/core/constants/route_constants.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';
import 'package:oraaq/src/core/extensions/num_extension.dart';
import 'package:oraaq/src/core/extensions/widget_extension.dart';
import 'package:oraaq/src/data/local/questionnaire/question_model.dart';
import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/injection_container.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/pick_location/pick_location_arguement.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_argument.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_cubit.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_states.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/sub_services_args.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/make_offer_page.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/questions_page.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/single_question_tile.dart';
import 'package:oraaq/src/presentaion/widgets/loading_indicator.dart';
import 'package:oraaq/src/presentaion/widgets/no_data_found.dart';
import 'package:oraaq/src/presentaion/widgets/toast.dart';

import '../../../../domain/entities/service_entity.dart';
import '../../../widgets/dialog_component.dart';

class QuestionnaireScreen extends StatefulWidget {
  final QuestionnaireArgument args;
  const QuestionnaireScreen({
    super.key,
    required this.args,
  });

  @override
  State<QuestionnaireScreen> createState() => QuestionnaireStateScreen();
}

class QuestionnaireStateScreen extends State<QuestionnaireScreen> {
  final _cubit = getIt.get<QuestionnaireCubit>();
  final PageController _pageController = PageController(viewportFraction: 0.9);
  final _currentPage = ValueNotifier<int>(1);

  final List<ServiceEntity> _services = [];
  final List<ServiceEntity> _selectedMainServices =
      []; // Track selected services

  final List<ServiceEntity> _selectedOptions = []; // Track options

  @override
  void initState() {
    // _cubit.fetchQuestions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.fetchServices(widget.args.category.id);
    });
    super.initState();
  }

  void _showHairLengthBottomSheet(ServiceEntity hairService) {
    // Display the bottom sheet
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Hair Length",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              16.verticalSpace,
              ListView.builder(
                shrinkWrap: true,
                itemCount: hairService.services.length,
                itemBuilder: (context, index) {
                  final subService = hairService.services[index];
                  return ListTile(
                    title: Text(subService.shortTitle),
                    onTap: () {
                      // Add the selected sub-service to _selectedMainServices
                      setState(() {
                        _selectedMainServices.remove(hairService);
                        _selectedMainServices.add(subService);
                      });
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToSubServicesScreen() {
    if (_selectedMainServices.isEmpty) {
      Toast.show(
        context: context,
        variant: SnackbarVariantEnum.warning,
        title: "Please select at least one service",
      );
      return;
    }

    Navigator.pushNamed(
      context,
      RouteConstants.subServiceRoute,
      arguments: SubServicesArgs(_selectedMainServices, widget.args.category),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _cubit,
        child: BlocConsumer<QuestionnaireCubit, QuestionnaireState>(
            listener: (context, state) {
          switch (state) {
            case QuestionnaireStateInitial():
              break;
            case QuestionnaireStateFetchError(error: Failure error):
              DialogComponent.hideLoading(context);
              Toast.show(
                context: context,
                variant: SnackbarVariantEnum.warning,
                title: error.message,
              );
              break;
            case QuestionnaireStateLoading():
              DialogComponent.showLoading(context);
              break;
            case QuestionnaireStateServicesloaded(
                services: List<ServiceEntity> services
              ):
              DialogComponent.hideLoading(context);
              _services.clear();
              _services.addAll(services);
              break;
          }
        }, builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.args.category.name),
                actions: [
                  if (_services.isNotEmpty)
                    ValueListenableBuilder(
                        valueListenable: _currentPage,
                        builder: (context, value, child) => Stack(
                              alignment: Alignment.center,
                              children: [
                                LoadingIndicator(
                                  value: value / (_services.length + 1),
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
              body: SafeArea(
                child: _services.isEmpty
                    ? const NoDataFound(
                        text: StringConstants.failedToFetchServices)
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: _services.length,
                                itemBuilder: (context, index) {
                                  final service = _services[index];
                                  return SingleQuestionTile(
                                      title: service.shortTitle,
                                      subtitle: service.description,
                                      onChanged: (val) {
                                        if (val) {
                                          if (!_selectedMainServices
                                              .contains(service)) {
                                            _selectedMainServices.add(service);
                                            if (service.shortTitle ==
                                                "Hair Services") {
                                              _showHairLengthBottomSheet(
                                                  service);
                                            }
                                            log(_selectedMainServices
                                                .toString());
                                          }
                                        } else {
                                          _selectedMainServices.remove(service);
                                          log(_selectedMainServices.toString());
                                        }
                                      });
                                }),
                          ),
                          // CustomButton(
                          //   text: StringConstants.next,
                          //   onPressed: () {
                          //     if (_selectedMainServices.isEmpty) {
                          //       Toast.show(
                          //         context: context,
                          //         variant: SnackbarVariantEnum.warning,
                          //         title: "Please select at least one service",
                          //       );
                          //       return;
                          //     }
                          //     Navigator.pushNamed(
                          //         context, RouteConstants.subServiceRoute, arguments: SubServicesArgs(_selectedMainServices));
                          //   },
                          // )
                          CustomButton(
                            text: StringConstants.next,
                            onPressed: _navigateToSubServicesScreen,
                          ),
                        ],
                      ),
              ));
        }));
  }
}
