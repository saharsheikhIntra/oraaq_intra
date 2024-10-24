part of 'merchant_home_screen_cubit.dart';

@immutable
sealed class MerchantHomeScreenState {}

final class MerchantHomeScreenInitial extends MerchantHomeScreenState {}

class MerchantHomeLoading extends MerchantHomeScreenState {}

class MerchantHomeError extends MerchantHomeScreenState {
  final Failure failure;
  MerchantHomeError(this.failure);
}

class WorkInProgressOrdersLoaded extends MerchantHomeScreenState {
  final List<RequestEntity> workInProgressOrders;
  WorkInProgressOrdersLoaded(this.workInProgressOrders);
}

class AllServiceRequestsLoaded extends MerchantHomeScreenState {
  final List<GetAllRequestsResponseDto> serviceRequests;
  AllServiceRequestsLoaded(this.serviceRequests);
}

class AppliedJobsLoaded extends MerchantHomeScreenState {
  final List<RequestEntity> appliedJobs;
  AppliedJobsLoaded(this.appliedJobs);
}

// class JobsLoaded extends MerchantHomeScreenState {
//   final List<AppliedJobsResponseDto> appliedJobs;
//   final List<RequestEntity> workInProgressOrders;
//   final List<GetAllRequestsResponseDto> serviceRequests;

//   JobsLoaded({
//     required this.appliedJobs,
//     required this.workInProgressOrders,
//     required this.serviceRequests,
//   });
// }

class CancelMerchantOrderState extends MerchantHomeScreenState {
  final String message;
  CancelMerchantOrderState(this.message);
}

class BidPostedSuccessState extends MerchantHomeScreenState {
  final String message;
  BidPostedSuccessState(this.message);
}

// mark: CRON STATES

class MerchantHomeCronError extends MerchantHomeScreenState {
  final Failure failure;
  MerchantHomeCronError(this.failure);
}

class WorkInProgressOrdersCronLoaded extends MerchantHomeScreenState {
  final List<RequestEntity> workInProgressOrders;
  WorkInProgressOrdersCronLoaded(this.workInProgressOrders);
}

class AllServiceRequestsCronLoaded extends MerchantHomeScreenState {
  final List<GetAllRequestsResponseDto> serviceRequests;
  AllServiceRequestsCronLoaded(this.serviceRequests);
}
class getAllNewRequestLoading extends MerchantHomeScreenState {

}
class getAllNewRequestError extends MerchantHomeScreenState {
  final Failure failure;
  getAllNewRequestError(this.failure);
}
class getAllNewRequestLoaded extends MerchantHomeScreenState {
  final List<GetAllNewRequestsResponseDto> serviceRequests;
  getAllNewRequestLoaded(this.serviceRequests);
}
