import 'package:flutter/foundation.dart';

class QuestionModel {
  final String name;
  final String prompt;
  final int level;
  final int fee;
  bool isSelected;
  final List<QuestionModel> questions;

  QuestionModel({
    required this.name,
    required this.prompt,
    required this.level,
    required this.isSelected,
    required this.questions,
    required this.fee,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      prompt: map['prompt'] == null ? "" : map['prompt'] as String,
      name: map['name'] as String,
      level: map['level'] as int,
      fee: map['fee'] ?? 0,
      isSelected: false,
      questions: map['questions'] == null
          ? []
          : List<QuestionModel>.from(
              (map['questions'] as List).map<QuestionModel>(
                (x) => QuestionModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
    );
  }

  @override
  String toString() => "Question(name: $name, prompt: $prompt, level: $level, fee: $fee, questions: $questions)";

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;
    return other.name == name && other.prompt == prompt && other.level == level && other.fee == fee && listEquals(other.questions, questions);
  }

  @override
  int get hashCode => prompt.hashCode ^ name.hashCode ^ level.hashCode ^ fee.hashCode ^ questions.hashCode;

  QuestionModel copyWith({
    String? name,
    String? prompt,
    int? level,
    bool? isSelected,
    int? fee,
    List<QuestionModel>? questions,
  }) {
    return QuestionModel(
      name: name ?? this.name,
      prompt: prompt ?? this.prompt,
      level: level ?? this.level,
      fee: fee ?? this.fee,
      isSelected: isSelected ?? this.isSelected,
      questions: questions ?? this.questions,
    );
  }
}
