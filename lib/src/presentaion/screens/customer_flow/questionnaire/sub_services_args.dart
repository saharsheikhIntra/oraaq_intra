import 'package:oraaq/src/domain/entities/category_entity.dart';
import 'package:oraaq/src/domain/entities/service_entity.dart';

class SubServicesArgs {
  final CategoryEntity category;
  final List<ServiceEntity> selectedMainServices;

  SubServicesArgs(this.selectedMainServices, this.category);
}
