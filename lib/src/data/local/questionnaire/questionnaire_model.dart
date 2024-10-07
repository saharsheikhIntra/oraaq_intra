import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:oraaq/src/data/local/questionnaire/question_model.dart';

class QuestionnaireModel {
  final List<QuestionModel> questionnaire;
  QuestionnaireModel({required this.questionnaire});

  QuestionnaireModel copyWith(List<QuestionModel>? questionnaire) => QuestionnaireModel(questionnaire: questionnaire ?? this.questionnaire);

  factory QuestionnaireModel.fromMap(Map<String, dynamic> map) =>
      QuestionnaireModel(questionnaire: List<QuestionModel>.from((map['questionnaire'] as List).map<QuestionModel>((x) => QuestionModel.fromMap(x))));

  factory QuestionnaireModel.fromJson(String source) => QuestionnaireModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'QuestionnaireModel(questions: $questionnaire)';

  @override
  bool operator ==(covariant QuestionnaireModel other) {
    if (identical(this, other)) return true;
    return listEquals(other.questionnaire, questionnaire);
  }

  @override
  int get hashCode => questionnaire.hashCode;
}
