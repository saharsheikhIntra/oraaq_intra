import 'package:oraaq/src/domain/entities/category_entity.dart';
import 'package:oraaq/src/domain/entities/service_entity.dart';

class NewQuestionnaireArgument {
  final CategoryEntity category;
  final List<ServiceEntity> services;
  final List<ServiceEntity> selectedServices;
  final bool isOpen;

  NewQuestionnaireArgument(this.category, this.services, this.selectedServices, this.isOpen);
}
