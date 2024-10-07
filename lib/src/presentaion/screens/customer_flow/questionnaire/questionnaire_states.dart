import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/domain/entities/service_entity.dart';

sealed class QuestionnaireState {}

class QuestionnaireStateInitial extends QuestionnaireState {}

class QuestionnaireStateLoading extends QuestionnaireState {}

class QuestionnaireStateServicesloaded extends QuestionnaireState {
  final List<ServiceEntity> services;
  QuestionnaireStateServicesloaded(this.services);
}

class QuestionnaireStateFetchError extends QuestionnaireState {
  final Failure error;
  QuestionnaireStateFetchError(this.error);
}
