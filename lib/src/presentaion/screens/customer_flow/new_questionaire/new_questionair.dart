// import 'dart:developer';

// import 'package:awesome_extensions/awesome_extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:logger/logger.dart';
// import 'package:oraaq/src/core/constants/route_constants.dart';
// import 'package:oraaq/src/core/constants/string_constants.dart';
// import 'package:oraaq/src/core/extensions/num_extension.dart';
// import 'package:oraaq/src/core/extensions/widget_extension.dart';
// import 'package:oraaq/src/data/local/questionnaire/question_model.dart';
// import 'package:oraaq/src/domain/entities/failure.dart';
// import 'package:oraaq/src/injection_container.dart';
// import 'package:oraaq/src/presentaion/screens/customer_flow/new_questionaire/widgets/make_offer_page.dart';
// import 'package:oraaq/src/presentaion/screens/customer_flow/new_questionaire/widgets/questions_page.dart';
// import 'package:oraaq/src/presentaion/screens/customer_flow/pick_location/pick_location_arguement.dart';
// import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/filter_ques.dart';
// import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_argument.dart';
// import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_cubit.dart';
// import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_states.dart';
// import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/make_offer_page.dart';
// import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/questions_page.dart';
// import 'package:oraaq/src/presentaion/widgets/loading_indicator.dart';
// import 'package:oraaq/src/presentaion/widgets/no_data_found.dart';
// import 'package:oraaq/src/presentaion/widgets/toast.dart';

// import '../../../../domain/entities/service_entity.dart';
// import '../../../widgets/dialog_component.dart';

// class NewQuestionnaireScreen extends StatefulWidget {
//   final QuestionnaireArgument args;
//   const NewQuestionnaireScreen({
//     super.key,
//     required this.args,
//   });

//   @override
//   State<NewQuestionnaireScreen> createState() => NewQuestionnaireStateScreen();
// }

// class NewQuestionnaireStateScreen extends State<NewQuestionnaireScreen> {
//   final _cubit = getIt.get<QuestionnaireCubit>();
//   final PageController _pageController = PageController(viewportFraction: 0.9);
//   final _currentPage = ValueNotifier<int>(1);
//   final List<ServiceEntity> _services = [];
//   final List<ServiceEntity> _selectedServices = [];
//  List<ServiceEntity> _selectedOptions = [];

//   @override
//   void initState() {
//     // _cubit.fetchQuestions();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _cubit.fetchServices(widget.args.category.id);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => _cubit,
//         child: BlocConsumer<QuestionnaireCubit, QuestionnaireState>(
//             listener: (context, state) {
//           switch (state) {
//             case QuestionnaireStateInitial():
//               break;
//             case QuestionnaireStateFetchError(error: Failure error):
//               DialogComponent.hideLoading(context);
//               Toast.show(
//                 context: context,
//                 variant: SnackbarVariantEnum.warning,
//                 title: error.message,
//               );
//               break;
//             case QuestionnaireStateLoading():
//               DialogComponent.showLoading(context);
//               break;
//             case QuestionnaireStateServicesloaded(
//                 services: List<ServiceEntity> services
//               ):
//               DialogComponent.hideLoading(context);
//               _services.clear();
//               _services.addAll(services);
//               break;
//           }
//         }, builder: (context, state) {
//           return Scaffold(
//               appBar: AppBar(
//                 title: Text(widget.args.category.name),
//                 // actions: [
//                 //   if (_services.isNotEmpty)
//                 //     ValueListenableBuilder(
//                 //         valueListenable: _currentPage,
//                 //         builder: (context, value, child) => Stack(
//                 //               alignment: Alignment.center,
//                 //               children: [
//                 //                 LoadingIndicator(
//                 //                   value: value / (_services.length + 1),
//                 //                   size: 24,
//                 //                 ),
//                 //                 Text("$value",
//                 //                     style: const TextStyle(
//                 //                       height: 0,
//                 //                       fontSize: 12,
//                 //                       fontWeight: FontWeight.w900,
//                 //                     )).wrapInPadding(1.bottomPadding),
//                 //               ],
//                 //             ).wrapInPadding(12.horizontalPadding))
//                 // ],
//               ),
//               // body: SafeArea(
//               //     child: _services.isEmpty
//               //         ? const NoDataFound(
//               //             text: StringConstants.failedToFetchServices)
//               //         : Column(children: [
//               //             const Text(StringConstants
//               //                 .getTheBestSalonServicesAtYourFingerTips),
//               //             Expanded(
//               //                 child: PageView.builder(
//               //               controller: _pageController,
//               //               itemCount: _selectedServices.length + 1,
//               //               itemBuilder: (context, index){
//               //                 List<QuestionModel> newList = _selectedOptions
//               //                               .map((e) => QuestionModel(
//               //                                   id: e.serviceId,
//               //                                   name: e.shortTitle,
//               //                                   prompt: '',
//               //                                   level: -1,
//               //                                   isSelected: true,
//               //                                   questions: [],
//               //                                   fee: e.price.toInt()))
//               //                               .toList();
//               //                 return index < _services.length
//               //                       ? QuestionsPage2(
//               //                           service: _services[index],
//               //                           onSelect: (selected) {
//               //                             for (var e in selected) {
//               //                               _selectedOptions.contains(e)
//               //                                   ? _selectedOptions.remove(e)
//               //                                   : _selectedOptions.add(e);
//               //                             }
//               //                           },
//               //                           onNext: () {
//               //                             _currentPage.value = index + 2;
//               //                             _pageController.nextPage(
//               //                               duration: 600.milliseconds,
//               //                               curve: Curves.easeInOutCubic,
//               //                             );
//               //                           },
//               //                           onPrevious: () {
//               //                             if (index != 0) {
//               //                               _currentPage.value = index;
//               //                             }
//               //                             _pageController.previousPage(
//               //                               duration: 600.milliseconds,
//               //                               curve: Curves.easeInOutCubic,
//               //                             );
//               //                           },
//               //                         )
//               //                       : MakeOfferPage2(
//               //                           onChanged: (offer) => Logger().i(offer),
//               //                           selectedServices: newList,
//               //                           // selectedServices: const [],
//               //                           onContinue: (String datetimeSelected,int amount, int userOfferAmount){
//               //                             log('amount: $amount userOfferAmount: $userOfferAmount');
//               //                             context.pushNamed(
//               //                               arguments: PickLocationScreenArgument(widget.args.category.id, newList,datetimeSelected,amount,userOfferAmount),
//               //                               RouteConstants.pickLocationRoute);
//               //                           },
//               //                           onPrevious: () {
//               //                             if (index != 0) {
//               //                               _currentPage.value = index;
//               //                             }
//               //                             _pageController.previousPage(
//               //                               duration: 600.milliseconds,
//               //                               curve: Curves.easeInOutCubic,
//               //                             );
//               //                           });
//               //               }

//               //             )),
//               //           ]),
//               //           ),
//               body: SafeArea(
//                   child: _services.isEmpty
//                       ? const NoDataFound(
//                           text: StringConstants.failedToFetchServices)
//                       : Column(children: [
//                           const Text(StringConstants
//                               .getTheBestSalonServicesAtYourFingerTips),
//                           Expanded(
//                               child: PageView.builder(
//                             controller: _pageController,
//                             itemCount: _selectedOptions.length + 1,
//                             itemBuilder: (context, index){
//                               List<QuestionModel> newList = _selectedOptions
//                                             .map((e) => QuestionModel(
//                                                 id: e.serviceId,
//                                                 name: e.shortTitle,
//                                                 prompt: '',
//                                                 level: -1,
//                                                 isSelected: true,
//                                                 questions: [],
//                                                 fee: e.price.toInt()))
//                                             .toList();
//                               return index < _services.length
//                                     ? QuestionsPage2(
//                                         service: _services,
//                                         onSelect: (selected) {
//                                           log(selected.toString());
//                                           log(selected.length.toString());
//                                           for (var e in selected) {
//                                             _selectedOptions.contains(e)
//                                                 ? _selectedOptions.remove(e)
//                                                 : _selectedOptions.add(e);
//                                           }
//                                             _selectedOptions.addAll(selected);
//                                           // setState(() {
//                                           // });
//                                           log('selectedOptions: ${_selectedOptions.length}');
//                                         },
//                                         onNext: () {
//                                           _currentPage.value = index + 2;
//                                           _pageController.nextPage(
//                                             duration: 600.milliseconds,
//                                             curve: Curves.easeInOutCubic,
//                                           );
//                                           context.push(FilterQues(filterServices: _selectedOptions));
//                                         },
//                                         onPrevious: () {
//                                           if (index != 0) {
//                                             _currentPage.value = index;
//                                           }
//                                           _pageController.previousPage(
//                                             duration: 600.milliseconds,
//                                             curve: Curves.easeInOutCubic,
//                                           );
//                                         },
//                                       )
//                                     : MakeOfferPage2(
//                                         onChanged: (offer) => Logger().i(offer),
//                                         selectedServices: newList,
//                                         // selectedServices: const [],
//                                         onContinue: (String datetimeSelected,int amount, int userOfferAmount){
//                                           log('amount: $amount userOfferAmount: $userOfferAmount');
//                                           context.pushNamed(
//                                             arguments: PickLocationScreenArgument(widget.args.category.id, newList,datetimeSelected,amount,userOfferAmount),
//                                             RouteConstants.pickLocationRoute);
//                                         },
//                                         onPrevious: () {
//                                           if (index != 0) {
//                                             _currentPage.value = index;
//                                           }
//                                           _pageController.previousPage(
//                                             duration: 600.milliseconds,
//                                             curve: Curves.easeInOutCubic,
//                                           );
//                                         });
//                             }

//                           )),
//                         ]),
//                         ),
//                         );
//         }));
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:oraaq/src/data/local/questionnaire/question_model.dart';
import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/domain/entities/service_entity.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/new_questionaire/NewQuestionnaireArgument.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/new_questionaire/widgets/questions_accordion.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/new_questionaire/widgets/questions_page.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/new_questionaire/widgets/single_question_tile.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/pick_location/pick_location_arguement.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_argument.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_cubit.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_states.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/make_offer_page.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/questions_page.dart';
import 'package:oraaq/src/presentaion/widgets/no_data_found.dart';
import 'package:oraaq/src/presentaion/widgets/sub_services_wrap_view.dart';

class NewQuestionnaireScreen extends StatefulWidget {
  final NewQuestionnaireArgument args;
  const NewQuestionnaireScreen({
    super.key,
    required this.args,
  });

  @override
  State<NewQuestionnaireScreen> createState() => _NewQuestionnaireScreenState();
}

class _NewQuestionnaireScreenState extends State<NewQuestionnaireScreen> {
  final _cubit = getIt.get<QuestionnaireCubit>();
  final PageController _pageController = PageController(viewportFraction: 0.9);
  final _currentPage = ValueNotifier<int>(1);
  final List<ServiceEntity> _services = [];
  final List<ServiceEntity> _selectedServices = [];
  List<ServiceEntity> _selectedOptions = [];

  @override
  void initState() {
    // _cubit.fetchQuestions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ignore: unnecessary_null_comparison
      if(widget.args.services.isEmpty){
        _cubit.fetchServices(widget.args.category.id);
        log('message: if run');
      }
      else{
        // _cubit.emit(QuestionnaireStateServicesloaded(widget.args.services));
        // log('message: else run');
        _services.clear();
        _services.addAll(widget.args.services);
        _selectedOptions.addAll(widget.args.selectedServices);
        setState(() {
          
        });
        log(widget.args.services.length.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocConsumer<QuestionnaireCubit, QuestionnaireState>(listener: (context, state) {
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
              // setState(() {
                
              // });
              break;
          }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.args.category.name),
          ),
          body: 
          SafeArea(
                  child: _services.isEmpty
                      ? const NoDataFound(
                          text: StringConstants.failedToFetchServices)
                      : Column(children: [
                          const Text(StringConstants
                              .getTheBestSalonServicesAtYourFingerTips),
                          12.verticalSpace,
                    SubServicesChipWrapView(
                      servicesList:
                          _selectedOptions.map((e) => e.shortTitle).toList(),
                      variant: SubServicesChipWrapViewVariant.forQuestionnaire,
                    ),
                    28.verticalSpace,
                          Expanded(
                              child: ListView.builder(itemCount: _services.length,itemBuilder: (context, index) {
                                ServiceEntity currentService = _services[index];
                                return widget.args.isOpen && currentService.isLastLeaf == false ? QuestionsAccordion2(service: currentService, onChanged: (val){
                                  
                                  if(val.isLastLeaf){
                                     _selectedOptions.contains(val) ? _selectedOptions.remove(val) : _selectedOptions.add(val);
                                  }
                                  else{
                                    _selectedServices.contains(val) ? _selectedServices.remove(val) : _selectedServices.add(val);
                                  }
                                  log("is last leaf: ${val.isLastLeaf} \n selected services: ${_selectedServices.length} \n selected options: ${_selectedOptions.length}");
                                  setState(() {
                                    
                                  });
                                  // log(val.toString());
                                  // log(currentService.isLastLeaf.toString());
                                  // log(widget.args.isOpen.toString());
                                  // log(val.toString());
                                },) : SingleQuestionTile2(title: currentService.shortTitle, subtitle: currentService.description, onChanged: (val){
                                  log(val.toString());
                                  if(widget.args.isOpen){
                                    if(val){
                                      currentService.isLastLeaf ? _selectedOptions.add(currentService):_selectedServices.add(currentService);
                                    }
                                    else{
                                      currentService.isLastLeaf ? _selectedOptions.remove(currentService):_selectedServices.remove(currentService);
                                    }
                                  }
                                  else{
                                    if(val){
                                    _selectedServices.add(currentService);
                                  }
                                  else{
                                    _selectedServices.remove(currentService);
                                  }
                                  log("c selected services length: ${_selectedServices.length}");
                                  log("c selected options length: ${_selectedOptions.length}");
                                  log("c selected services : ${_selectedServices}");
                                  log("c selected options : ${_selectedOptions}");
                                }});
                              },)),
                            CustomButton(onPressed: (){
                              // context.pop();
                              if (!(_selectedServices.isEmpty && widget.args.isOpen)) {
                                context.push(NewQuestionnaireScreen(args: NewQuestionnaireArgument(widget.args.category,_selectedServices, _selectedOptions,true)));
                              } else {
                                List<QuestionModel> newList = _selectedOptions
                                            .map((e) => QuestionModel(
                                                id: e.serviceId,
                                                name: e.shortTitle,
                                                prompt: '',
                                                level: -1,
                                                isSelected: true,
                                                questions: [],
                                                fee: e.price.toInt()))
                                            .toList();
                                context.push(Scaffold(appBar: AppBar(
                                  title: Text('Make Offer'),
                                ),body: MakeOfferPage(onChanged: (val){}, onContinue: (String datetimeSelected,int amount, int userOfferAmount){
                                  log('amount: $amount userOfferAmount: $userOfferAmount');
                                          context.pushNamed(
                                            arguments: PickLocationScreenArgument(widget.args.category.id, newList,datetimeSelected,amount,userOfferAmount),
                                            RouteConstants.pickLocationRoute);
                                }, onPrevious: (){}, selectedServices: newList),));
                              }
                              log('button tap');
                            },text: 'Next',)
                        ])));
      },),
    );
  }
}
