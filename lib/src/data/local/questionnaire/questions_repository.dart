import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:oraaq/src/data/local/questionnaire/questionnaire_model.dart';
import 'package:oraaq/src/domain/entities/failure.dart';

class QuestionsRepository {
  static Future<Either<Failure, QuestionnaireModel>> get fetch async {
    try {
      String jsonString = await rootBundle.loadString("assets/jsons/questions2.json");
      return Right(QuestionnaireModel.fromJson(jsonString));
    } on Exception catch (e) {
      Logger().e("Error reading file: $e");
      return Left(Failure(e.toString()));
    }
  }
}
