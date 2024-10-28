import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/domain/entities/failure.dart';

import 'package:oraaq/src/domain/services/services_service.dart';
import 'package:oraaq/src/imports.dart';

part 'request_history_state.dart';

class RequestHistoryCubit extends Cubit<RequestHistoryState> {
  final ServicesService _servicesRepository;
  RequestHistoryCubit(this._servicesRepository)
      : super(RequestHistoryInitial());

  // UserEntity user = getIt.get<UserEntity>();

  Future<void> fetchWorkOrders() async {
    emit(RequestHistoryScreenLoading());
    final completedResult =
        await _servicesRepository.getCompletedWorkOrdersForCustomer(1);
    final cancelledResult =
        await _servicesRepository.getCanceledWorkOrdersForCustomer(1);
    final newRequestResult =
        await _servicesRepository.getCustomerNewRequests(1);

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
    }
  }
}
