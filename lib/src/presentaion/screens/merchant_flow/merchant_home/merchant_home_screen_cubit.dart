import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/merchant_flow/post_bid_request_dto.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';
import 'package:oraaq/src/domain/services/job_management_service.dart';

import '../../../../data/remote/api/api_response_dtos/merchant_flow/applied_jobs_response_dto.dart';
import '../../../../data/remote/api/api_response_dtos/merchant_flow/get_all_new_response_dto.dart';
import '../../../../domain/entities/failure.dart';
import '../../../../domain/entities/request_entity.dart';
import '../../../../injection_container.dart';

part 'merchant_home_screen_state.dart';

class MerchantHomeScreenCubit extends Cubit<MerchantHomeScreenState> {
  final JobManagementService _jobManagementService;
  MerchantHomeScreenCubit(
    this._jobManagementService,
  ) : super(MerchantHomeScreenInitial());
  final user = getIt.get<UserEntity>();
//
// MARK: WORK IN PROGRESS ORDERS
//
  Future<void> fetchWorkInProgressOrders() async {
    emit(MerchantHomeLoading());

    final result =
        await _jobManagementService.getWorkInProgressOrdersForMerchant(user.id);

    result.fold(
      (l) {
        emit(MerchantHomeError(l));
      },
      (r) {
        emit(WorkInProgressOrdersLoaded(r));
      },
    );
  }

//
// MARK: NEW SERVICE REQUESTS
//
  Future<void> fetchAllServiceRequests() async {
    emit(MerchantHomeLoading());
    final result = await _jobManagementService.getAllServiceRequests(user.id);
    result.fold(
      (l) => emit(MerchantHomeError(l)),
      (r) => emit(AllServiceRequestsLoaded(r)),
    );
  }

//
// MARK: NEW SERVICE REQUESTS CRON
//
  Future<void> fetchAllServiceRequestsCron() async {
    final result = await _jobManagementService.getAllServiceRequests(user.id);
    result.fold(
      (l) => emit(MerchantHomeCronError(l)),
      (r) => emit(AllServiceRequestsCronLoaded(r)),
    );
  }

//
// MARK: IN PROGRESS CRON
//
  Future<void> fetchWorkInProgressOrdersCron() async {
    final result =
        await _jobManagementService.getWorkInProgressOrdersForMerchant(user.id);

    result.fold(
      (l) {
        emit(MerchantHomeCronError(l));
      },
      (r) {
        emit(WorkInProgressOrdersCronLoaded(r));
      },
    );
  }

//
// MARK: FETCH APPLIED JOBS
//
  Future<void> fetchAppliedJobs() async {
    emit(MerchantHomeLoading());
    final result = await _jobManagementService.getAppliedJobsForMerchant(user.id);
    result.fold(
      (l) => emit(MerchantHomeError(l)),
      (r) => emit(AppliedJobsLoaded(r)),
    );
  }

//
// MARK: CANCEL WORK ORDER
//
  Future<void> cancelWorkOrder(int biddingId) async {
    emit(MerchantHomeLoading());
    final result =
        await _jobManagementService.cancelWorkOrder(biddingId, user.id);
    result.fold(
      (l) {
        emit(MerchantHomeError(l));
      },
      (r) {
        emit(CancelMerchantOrderState(r));
      },
    );
  }

  //
// MARK: COMPLETE WORK ORDER
//
  Future<void> completeWorkOrder(int biddingId) async {
    emit(MerchantHomeLoading());
    final result =
        await _jobManagementService.completeWorkOrder(biddingId, user.id);
    result.fold(
      (l) {
        emit(MerchantHomeError(l));
      },
      (r) {
        emit(CompleteMerchantOrderState(r));
      },
    );
  }

//
// MARK: CANCEL WORK ORDER FROM MERCHANT APPLIED REQUESTS
//
  Future<void> cancelWorkOrderFromMerchantAppliedRequests(int biddingId) async {
    emit(MerchantHomeLoading());
    final result =
        await _jobManagementService.cancelWorkOrderFromMerchantAppliedRequests(biddingId, user.id);
    result.fold(
      (l) {
        emit(MerchantHomeError(l));
      },
      (r) {
        emit(CancelMerchantOrderState(r));
      },
    );
  }

//
// MARK: POST BID
//
  Future<void> postBid(int orderId, double bidAmount) async {
    // emit(MerchantHomeLoading());

    final bidRequest = PostBidRequestDto(
      orderId: orderId,
      merchantId: user.id,
      bidAmount: bidAmount,
      createdBy: user.userId,
    );

    final result = await _jobManagementService.postBid(bidRequest);

    result.fold(
      (l) {
        emit(MerchantHomeError(l));
      },
      (r) {
        emit(BidPostedSuccessState(r));
      },
    );
  }
}
