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
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_argument.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_cubit.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_states.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/make_offer_page.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/widgets/questions_page.dart';
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
                      : Column(children: [
                          const Text(StringConstants
                              .getTheBestSalonServicesAtYourFingerTips),
                          Expanded(
                              child: PageView.builder(
                            controller: _pageController,
                            itemCount: _services.length + 1,
                            itemBuilder: (context, index) =>
                                index < _services.length
                                    ? QuestionsPage(
                                        service: _services[index],
                                        onSelect: (selected) {
                                          for (var e in selected) {
                                            _selectedOptions.contains(e)
                                                ? _selectedOptions.remove(e)
                                                : _selectedOptions.add(e);
                                          }
                                        },
                                        onNext: () {
                                          _currentPage.value = index + 2;
                                          _pageController.nextPage(
                                            duration: 600.milliseconds,
                                            curve: Curves.easeInOutCubic,
                                          );
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
                                      )
                                    : MakeOfferPage(
                                        onChanged: (offer) => Logger().i(offer),
                                        selectedServices: _selectedOptions
                                            .map((e) => QuestionModel(
                                                name: e.shortTitle,
                                                prompt: '',
                                                level: -1,
                                                isSelected: true,
                                                questions: [],
                                                fee: e.price.toInt()))
                                            .toList(),
                                        // selectedServices: const [],
                                        onContinue: () => context.pushNamed(
                                            arguments: widget.args.category.id,
                                            RouteConstants.pickLocationRoute),
                                        onPrevious: () {
                                          if (index != 0) {
                                            _currentPage.value = index;
                                          }
                                          _pageController.previousPage(
                                            duration: 600.milliseconds,
                                            curve: Curves.easeInOutCubic,
                                          );
                                        }),
                          )),
                        ])));
        }));
  }
}
