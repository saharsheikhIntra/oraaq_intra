import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/merchant_flow/post_bid_request_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/merchant_flow/get_all_new_request_response_dto.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';
import 'package:oraaq/src/domain/services/job_management_service.dart';

import '../../../../data/remote/api/api_response_dtos/merchant_flow/get_all_new_request_dto.dart';
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

  Future<void> fetchWorkInProgressOrders() async {
    //emit(MerchantHomeLoading());

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

  Future<void> fetchAllServiceRequests() async {
    // emit(MerchantHomeLoading());
    final result = await _jobManagementService.getAllServiceRequests(
        user.serviceType, user.id);
    result.fold(
      (l) => emit(MerchantHomeError(l)),
      (r) => emit(AllServiceRequestsLoaded(r)),
    );
  }

  Future<void> fetchAllServiceRequestsCron() async {
    final result = await _jobManagementService.getAllServiceRequests(
        user.serviceType, user.id);
    result.fold(
      (l) => emit(MerchantHomeCronError(l)),
      (r) => emit(AllServiceRequestsCronLoaded(r)),
    );
  }

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

  Future<void> fetchAppliedJobs() async {
    emit(MerchantHomeLoading());
    final result = await _jobManagementService.getAppliedJobsForMerchant(3);
    result.fold(
      (l) => emit(MerchantHomeError(l)),
      (r) => emit(AppliedJobsLoaded(r)),
    );
  }

  Future<void> cancelWorkOrder(int workOrderId) async {
    // emit(MerchantHomeLoading());
    final result = await _jobManagementService.cancelWorkOrder(workOrderId);
    result.fold(
      (l) {
        emit(MerchantHomeError(l));
      },
      (r) {
        emit(CancelMerchantOrderState(r));
      },
    );
  }

  Future<void> postBid(int requestId, double bidAmount) async {
    // emit(MerchantHomeLoading());

    final user = getIt.get<UserEntity>();
    final bidRequest = PostBidRequestDto(
      requestId: requestId,
      merchantId: user.id,
      bidAmount: bidAmount,
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


  //
  Future<void> fetchAllNewRequests() async {
    final result = await _jobManagementService.getAllNewRequests(
        user.id);
    result.fold(
      (l) => emit(getAllNewRequestError(l)),
      (r) => emit(getAllNewRequestLoaded(r)),
    );
  }

}
