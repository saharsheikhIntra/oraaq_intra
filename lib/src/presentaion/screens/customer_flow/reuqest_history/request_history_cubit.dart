import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/cancel_customer_request.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/accpted_request_response_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/domain/entities/failure.dart';

import 'package:oraaq/src/domain/services/services_service.dart';
import 'package:oraaq/src/imports.dart';

part 'request_history_state.dart';

class RequestHistoryCubit extends Cubit<RequestHistoryState> {
  final ServicesService _servicesRepository;
  RequestHistoryCubit(this._servicesRepository)
      : super(RequestHistoryInitial());

  UserEntity user = getIt.get<UserEntity>();

   Future<List<CustomerNewRequestDto>> fetchOnlyNewRequests() async { 
    final newRequestResult =
        await _servicesRepository.getCustomerNewRequests(1);
    if (
        newRequestResult.isLeft()) {
      final failure =
          newRequestResult.fold((l) => l, (r) => null);
      emit(RequestHistoryScreenError(failure!));
      throw failure;
    } else {
      final newOrders = newRequestResult.getOrElse(() => []);
      return newOrders;

    }
  }

    //
// MARK: Fetch only new requests
//
  Future<void> fetchNewRequests() async {
    emit(RequestHistoryScreenLoading());

    final result = await _servicesRepository.getCustomerNewRequests(250);

    result.fold(
      (l) {
        emit(RequestHistoryScreenError(l));
      },
      (r) {
        emit(NewRequestWorkOrdersLoaded(r));
      },
    );
  }

  Future<void> fetchWorkOrders() async {
    emit(RequestHistoryScreenLoading());
    final completedResult =
        await _servicesRepository.getCompletedWorkOrdersForCustomer(1);
    final cancelledResult =
        await _servicesRepository.getCanceledWorkOrdersForCustomer(1);
    final newRequestResult =
        await _servicesRepository.getCustomerNewRequests(user.id);

    if (completedResult.isLeft() ||
        cancelledResult.isLeft() ||
        newRequestResult.isLeft()) {
      final failure = completedResult.fold((l) => l, (r) => null) ??
          cancelledResult.fold((l) => l, (r) => null) ??
          newRequestResult.fold((l) => l, (r) => null);
      emit(RequestHistoryScreenError(failure!));
    } else {
      final completedOrders = completedResult.getOrElse(() => []);
      final cancelledOrders = cancelledResult.getOrElse(() => []);
      final newOrders = newRequestResult.getOrElse(() => []);
      emit(RequestHistoryScreenLoaded(
        completedOrders: completedOrders,
        cancelledOrders: cancelledOrders,
        newRequestWorkOrders: newOrders,
      ));
      // emit(NewRequestWorkOrdersLoaded(newOrders));
      // emit(CompletedRequestWorkOrdersLoaded(completedOrders));
      // emit(CancelledRequestWorkOrdersLoaded(cancelledOrders));
    }
  }

  //
// MARK: ACCEPTED REQUESTS
//
  Future<void> fetchAcceptedRequest() async {
    // emit(RequestHistoryScreenLoading());

    final result = await _servicesRepository.getAcceptedRequests(250);

    result.fold(
      (l) {
        emit(RequestHistoryScreenError(l));
      },
      (r) {
        emit(CustomerHomeStateAcceptedJobs(r));
      },
    );
  }

  // MARK: CANCEL CUSTOMER CREATED REQUEST
  Future cancelCustomerCreatedRequest(int requestId) async {
    emit(RequestHistoryScreenLoading());
    final result = await _servicesRepository.cancelCustomerCreatedRequest(
        cancelCustomerCreatedRequestsDto(requestId: requestId));
    result.fold((l) => emit(RequestHistoryScreenError(l)),
        (r) => emit(CancelCustomerRequestSuccessState(r)));
  }
}
