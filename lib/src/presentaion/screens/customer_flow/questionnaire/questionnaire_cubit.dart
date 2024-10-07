import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oraaq/src/domain/services/services_service.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/questionnaire/questionnaire_states.dart';

class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  final ServicesService _service;
  QuestionnaireCubit(this._service) : super(QuestionnaireStateInitial());

  Future<void> fetchServices(int id) async {
    emit(QuestionnaireStateLoading());
    var result = await _service.getServices(id);
    result.fold(
      (l) => emit(QuestionnaireStateFetchError(l)),
      (r) => emit(QuestionnaireStateServicesloaded(r)),
    );
  }
}
