// part of 'request_history_cubit.dart';

// @immutable
// sealed class RequestHistoryState {}

// final class RequestHistoryInitial extends RequestHistoryState {}

// class RequestHistoryScreenLoading extends RequestHistoryState {}

// class RequestHistoryScreenError extends RequestHistoryState {
//   final Failure failure;
//   RequestHistoryScreenError(this.failure);
// }

// class CompletedRequestWorkOrdersLoaded extends RequestHistoryState {
//   final List<RequestEntity> completedOrders;
//   CompletedRequestWorkOrdersLoaded(this.completedOrders);
// }

// class CancelledRequestWorkOrdersLoaded extends RequestHistoryState {
//   final List<RequestEntity> cancelledOrders;
//   CancelledRequestWorkOrdersLoaded(this.cancelledOrders);
// }

// class NewRequestWorkOrdersLoaded extends RequestHistoryState {
//   final List<CustomerNewRequestDto> newRequestWorkOrdersLoaded;
//   NewRequestWorkOrdersLoaded(this.newRequestWorkOrdersLoaded);
// }

// class RequestHistoryScreenLoaded extends RequestHistoryState {
//   final List<RequestEntity> completedOrders;
//   final List<RequestEntity> cancelledOrders;
//   final List<CustomerNewRequestDto> newRequestWorkOrders;
//   RequestHistoryScreenLoaded({
//     required this.completedOrders,
//     required this.cancelledOrders,
//     required this.newRequestWorkOrders,
//   });
// }

// final class CustomerHomeStateAcceptedJobs extends RequestHistoryState {
//   final List<AcceptedRequestsResponseDto> acceptedJobs;
//   CustomerHomeStateAcceptedJobs(this.acceptedJobs);
// }

// final class CancelCustomerRequestSuccessState extends RequestHistoryState {
//   final String message;
//   CancelCustomerRequestSuccessState(this.message);
// }

// class RatingSuccessState extends RequestHistoryState {
//   final String message;

//   RatingSuccessState(this.message);
// }

// class RatingErrorState extends RequestHistoryState {
//   final Failure failure;

//   RatingErrorState(this.failure);
// }
// class CancelCustomerOrderState extends RequestHistoryState {
//   final String message;
//   CancelCustomerOrderState(this.message);
// }


part of 'request_history_cubit.dart';

@immutable
sealed class RequestHistoryState {}

final class RequestHistoryInitial extends RequestHistoryState {}

class RequestHistoryScreenLoading extends RequestHistoryState {}

class RequestHistoryScreenError extends RequestHistoryState {
  final Failure failure;
  RequestHistoryScreenError(this.failure);
}

class CompletedRequestWorkOrdersLoaded extends RequestHistoryState {
  final List<RequestEntity> completedOrders;
  CompletedRequestWorkOrdersLoaded(this.completedOrders);
}

class CancelledRequestWorkOrdersLoaded extends RequestHistoryState {
  final List<RequestEntity> cancelledOrders;
  CancelledRequestWorkOrdersLoaded(this.cancelledOrders);
}

class NewRequestWorkOrdersLoaded extends RequestHistoryState {
  final List<CustomerNewRequestDto> newRequestWorkOrdersLoaded;
  NewRequestWorkOrdersLoaded(this.newRequestWorkOrdersLoaded);
}

class RequestHistoryScreenLoaded extends RequestHistoryState {
  final List<RequestEntity> completedOrders;
  final List<RequestEntity> cancelledOrders;
  final List<CustomerNewRequestDto> newRequestWorkOrders;
  RequestHistoryScreenLoaded({
    required this.completedOrders,
    required this.cancelledOrders,
    required this.newRequestWorkOrders,
  });
}

final class CustomerHomeStateAcceptedJobs extends RequestHistoryState {
  final List<AcceptedRequestsResponseDto> acceptedJobs;
  CustomerHomeStateAcceptedJobs(this.acceptedJobs);
}

final class CancelCustomerRequestSuccessState extends RequestHistoryState {
  final String message;
  CancelCustomerRequestSuccessState(this.message);
}

class RatingSuccessState extends RequestHistoryState {
  final String message;

  RatingSuccessState(this.message);
}

class RatingErrorState extends RequestHistoryState {
  final Failure failure;

  RatingErrorState(this.failure);
}

class CancelCustomerOrderState extends RequestHistoryState {
  final String message;
  CancelCustomerOrderState(this.message);
}
