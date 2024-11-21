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
import 'package:oraaq/src/injection_container.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/pick_location/pick_location_arguement.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_argument.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_cubit.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_states.dart';
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

  final List<ServiceEntity> _selectedOptions = [];
  final List<ServiceEntity> _services = [];
  final List<ServiceEntity> _selectedCategories = []; //new
  bool _isSelectingCategories = true; // Start with Stage 1

  @override
  void initState() {
    // _cubit.fetchQuestions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.fetchServices(widget.args.category.id);
    });
    super.initState();
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
                // actions: [
                //   if (_services.isNotEmpty)
                //     ValueListenableBuilder(
                //         valueListenable: _currentPage,
                //         builder: (context, value, child) => Stack(
                //               alignment: Alignment.center,
                //               children: [
                //                 LoadingIndicator(
                //                   value: value / (_services.length + 1),
                //                   size: 24,
                //                 ),
                //                 Text("$value",
                //                     style: const TextStyle(
                //                       height: 0,
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.w900,
                //                     )).wrapInPadding(1.bottomPadding),
                //               ],
                //             ).wrapInPadding(12.horizontalPadding))
                // ],
              ),
              body: SafeArea(
                child: _isSelectingCategories
                    ? _buildTopLevelServices() // Stage 1: Show top-level services
                    : _buildSubServiceNavigation(), // Stage 2: Show sub-services
                //  _services.isEmpty
                // ? const NoDataFound(
                //     text: StringConstants.failedToFetchServices)
                // : Column(children: [
                //     const Text(StringConstants
                //         .getTheBestSalonServicesAtYourFingerTips),
                //     Expanded(
                //         child: PageView.builder(
                //             controller: _pageController,
                //             itemCount: _services.length + 1,
                //             itemBuilder: (context, index) {
                //               List<QuestionModel> newList =
                //                   _selectedOptions
                //                       .map((e) => QuestionModel(
                //                           id: e.serviceId,
                //                           name: e.shortTitle,
                //                           prompt: '',
                //                           level: -1,
                //                           isSelected: true,
                //                           questions: [],
                //                           fee: e.price.toInt()))
                //                       .toList();
                //               return index < _services.length
                //                   ? QuestionsPage(
                //                       service: _services[index],
                //                       onSelect: (selected) {
                //                         for (var e in selected) {
                //                           _selectedOptions.contains(e)
                //                               ? _selectedOptions.remove(e)
                //                               : _selectedOptions.add(e);
                //                         }
                //                       },
                //                       onNext: () {
                //                         _currentPage.value = index + 2;
                //                         _pageController.nextPage(
                //                           duration: 600.milliseconds,
                //                           curve: Curves.easeInOutCubic,
                //                         );
                //                       },
                //                       onPrevious: () {
                //                         if (index != 0) {
                //                           _currentPage.value = index;
                //                         }
                //                         _pageController.previousPage(
                //                           duration: 600.milliseconds,
                //                           curve: Curves.easeInOutCubic,
                //                         );
                //                       },
                //                     )
                //                   : MakeOfferPage(
                //                       onChanged: (offer) =>
                //                           Logger().i(offer),
                //                       selectedServices: newList,
                //                       // selectedServices: const [],
                //                       onContinue:
                //                           (String datetimeSelected,
                //                               int amount,
                //                               int userOfferAmount) {
                //                         log('amount: $amount userOfferAmount: $userOfferAmount');
                //                         context.pushNamed(
                //                             arguments:
                //                                 PickLocationScreenArgument(
                //                                     widget
                //                                         .args.category.id,
                //                                     newList,
                //                                     datetimeSelected,
                //                                     amount,
                //                                     userOfferAmount),
                //                             RouteConstants
                //                                 .pickLocationRoute);
                //                       },
                //                       onPrevious: () {
                //                         if (index != 0) {
                //                           _currentPage.value = index;
                //                         }
                //                         _pageController.previousPage(
                //                           duration: 600.milliseconds,
                //                           curve: Curves.easeInOutCubic,
                //                         );
                //                       });
                //             })),
                //   ])
              ));
        }));
  }

  Widget _buildTopLevelServices() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _services.length,
            itemBuilder: (context, index) {
              final service = _services[index];
              return SingleQuestionTile(
                title: service.shortTitle,
                subtitle: service.description,
                onChanged: (isSelected) {
                  setState(() {
                    if (isSelected) {
                      if (!_selectedCategories.contains(service)) {
                        _selectedCategories.add(service);
                        // Add selected service
                        log(_selectedCategories.toString());
                      }
                    } else {
                      _selectedCategories
                          .remove(service); // Remove unselected service
                    }
                  });
                },
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_selectedCategories.isNotEmpty) {
              setState(() {
                _isSelectingCategories =
                    false; // Switch to sub-services navigation
              });
            } else {
              Toast.show(
                context: context,
                variant: SnackbarVariantEnum.warning,
                title: "Please select at least one category.",
              );
            }
          },
          child: Text("Next"),
        ),
      ],
    );
  }

  // Widget _buildSubServiceNavigation() {
  //   return PageView.builder(
  //     controller: _pageController,
  //     itemCount: _selectedCategories.length + 1, // +1 for final review page
  //     onPageChanged: (page) => _currentPage.value = page + 1,
  //     itemBuilder: (context, index) {
  //       List<QuestionModel> newList = _selectedOptions
  //           .map((e) => QuestionModel(
  //               id: e.serviceId,
  //               name: e.shortTitle,
  //               prompt: '',
  //               level: -1,
  //               isSelected: true,
  //               questions: [],
  //               fee: e.price.toInt()))
  //           .toList();
  //       log(newList.toString());
  //       if (index < _selectedCategories.length) {
  //         final category = _selectedCategories[index];
  //         return QuestionsPage(
  //           service: category, // Show sub-services for this category
  //           onSelect: (selectedSubServices) {
  //             for (var service in selectedSubServices) {
  //               if (!_selectedOptions.contains(service)) {
  //                 _selectedOptions
  //                     .add(service); // Add user-selected sub-services
  //               }
  //             }
  //           },
  //           onNext: () {
  //             _pageController.nextPage(
  //               duration: const Duration(milliseconds: 500),
  //               curve: Curves.easeInOut,
  //             );
  //           },
  //           onPrevious: () {
  //             _pageController.previousPage(
  //               duration: const Duration(milliseconds: 500),
  //               curve: Curves.easeInOut,
  //             );
  //           },
  //         );
  //       } else {
  //         return MakeOfferPage(
  //           selectedServices: newList, // Pass all selected sub-services
  //           onChanged: (offer) => log("Offer: $offer"),
  //           onContinue:
  //               (String datetimeSelected, int amount, int userOfferAmount) {
  //             Navigator.pushNamed(
  //               context,
  //               RouteConstants.pickLocationRoute,
  //               arguments: PickLocationScreenArgument(
  //                 widget.args.category.id,
  //                 newList,
  //                 datetimeSelected,
  //                 amount,
  //                 userOfferAmount,
  //               ),
  //             );
  //           },
  //           onPrevious: () {
  //             _pageController.previousPage(
  //               duration: const Duration(milliseconds: 500),
  //               curve: Curves.easeInOut,
  //             );
  //           },
  //         );
  //       }
  //     },
  //   );
  // }
  final ValueNotifier<List<ServiceEntity>> _selectedOptionsNotifier =
      ValueNotifier([]);

  Widget _buildSubServiceNavigation() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _selectedCategories.length + 1, // +1 for MakeOfferPage
      onPageChanged: (page) => _currentPage.value = page + 1,
      itemBuilder: (context, index) {
        if (index < _selectedCategories.length) {
          final category = _selectedCategories[index];
          return QuestionsPage(
            service: category,
            onSelect: (selectedSubServices) {
              // Merge new selections with existing ones
              final updatedSelections = [..._selectedOptionsNotifier.value];
              for (var service in selectedSubServices) {
                if (!updatedSelections.contains(service)) {
                  updatedSelections.add(service);
                }
              }

              // Update the notifier
              _selectedOptionsNotifier.value = updatedSelections;
              log("Updated _selectedOptions: ${_selectedOptionsNotifier.value}");
            },
            // onSelect: (selectedSubServices) {
            //   // Update _selectedOptions dynamically
            //   _selectedOptionsNotifier.value = [...selectedSubServices];
            //   log("Updated _selectedOptions: ${_selectedOptionsNotifier.value}");
            // },
            onNext: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            onPrevious: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          );
        } else {
          return ValueListenableBuilder<List<ServiceEntity>>(
            valueListenable: _selectedOptionsNotifier,
            builder: (context, selectedOptions, _) {
              return MakeOfferPage(
                selectedServices: selectedOptions.map((service) {
                  return QuestionModel(
                    id: service.serviceId,
                    name: service.shortTitle,
                    prompt: service.prompt,
                    level: -1,
                    isSelected: true,
                    questions: [],
                    fee: service.price.toInt(),
                  );
                }).toList(),
                onChanged: (offer) => log("Offer updated: $offer"),
                onContinue:
                    (String datetimeSelected, int amount, int userOfferAmount) {
                  log("Offer details: DateTime=$datetimeSelected, Amount=$amount, UserOffer=$userOfferAmount");
                  Navigator.pushNamed(
                    context,
                    RouteConstants.pickLocationRoute,
                    arguments: PickLocationScreenArgument(
                      widget.args.category.id,
                      selectedOptions.map((service) {
                        return QuestionModel(
                          id: service.serviceId,
                          name: service.shortTitle,
                          prompt: '',
                          level: -1,
                          isSelected: true,
                          questions: [],
                          fee: service.price.toInt(),
                        );
                      }).toList(),
                      datetimeSelected,
                      amount,
                      userOfferAmount,
                    ),
                  );
                },
                onPrevious: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
