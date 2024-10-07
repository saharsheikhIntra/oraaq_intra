import '../../../../domain/entities/category_entity.dart';
import '../../../../domain/entities/failure.dart';

sealed class CustomerHomeState {}

final class CustomerHomeStateInitial extends CustomerHomeState {}

final class CustomerHomeStateLoading extends CustomerHomeState {}

final class CustomerHomeStateError extends CustomerHomeState {
  final Failure error;
  CustomerHomeStateError(this.error);
}

final class CustomerHomeStateCategories extends CustomerHomeState {
  final List<CategoryEntity> categories;
  CustomerHomeStateCategories(this.categories);
}
