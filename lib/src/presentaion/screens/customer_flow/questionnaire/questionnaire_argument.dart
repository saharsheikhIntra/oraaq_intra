import 'package:oraaq/src/domain/entities/category_entity.dart';
import 'package:oraaq/src/domain/entities/service_entity.dart';

class QuestionnaireArgument {
  final CategoryEntity category;
  final List<ServiceEntity> selectedCategories;
  QuestionnaireArgument(this.category, this.selectedCategories);
}
