part of 'history_screen_cubit.dart';

sealed class HistoryScreenState {}

final class HistoryScreenInitial extends HistoryScreenState {}

class HistoryScreenLoading extends HistoryScreenState {}

class HistoryScreenError extends HistoryScreenState {
  final Failure failure;
  HistoryScreenError(this.failure);
}

class CompletedWorkOrdersLoaded extends HistoryScreenState {
  final List<RequestEntity> completedOrders;
  CompletedWorkOrdersLoaded(this.completedOrders);
}

class CancelledWorkOrdersLoaded extends HistoryScreenState {
  final List<RequestEntity> cancelledOrders;
  CancelledWorkOrdersLoaded(this.cancelledOrders);
}

class HistoryScreenLoaded extends HistoryScreenState {
  final List<RequestEntity> completedOrders;
  final List<RequestEntity> cancelledOrders;
  HistoryScreenLoaded({
    required this.completedOrders,
    required this.cancelledOrders,
  });
}

class RatingSuccessState extends HistoryScreenState {
  final String message;

  RatingSuccessState(this.message);
}

class RatingErrorState extends HistoryScreenState {
  final Failure failure;

  RatingErrorState(this.failure);
}
