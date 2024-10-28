import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/accpted_request_response_dto.dart';

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

final class CustomerHomeStateAcceptedJobs extends CustomerHomeState {
  final List<AcceptedRequestsResponseDto> acceptedJobs;
  CustomerHomeStateAcceptedJobs(this.acceptedJobs);
}
