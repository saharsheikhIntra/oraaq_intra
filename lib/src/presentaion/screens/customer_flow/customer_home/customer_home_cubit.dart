import 'package:bloc/bloc.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/cancel_customer_request.dart';
import 'package:oraaq/src/domain/services/services_service.dart';

import '../../../../domain/services/job_management_service.dart';
import 'customer_home_state.dart';

class CustomerHomeCubit extends Cubit<CustomerHomeState> {
  final JobManagementService _jobManagementService;
  final ServicesService _servicesService;
  CustomerHomeCubit(
    this._jobManagementService,
    this._servicesService,
  ) : super(CustomerHomeStateInitial());

  Future<void> fetchCategories() async {
    emit(CustomerHomeStateLoading());
    final result = await _jobManagementService.getCategories();
    result.fold(
      (l) => emit(CustomerHomeStateError(l)),
      (r) => emit(CustomerHomeStateCategories(r)),
    );
  }

  //
// MARK: ACCEPTED REQUESTS
//
  Future<void> fetchAcceptedRequest() async {
    emit(CustomerHomeStateLoading());

    final result = await _servicesService.getAcceptedRequests(250);

    result.fold(
      (l) {
        emit(CustomerHomeStateError(l));
      },
      (r) {
        emit(CustomerHomeStateAcceptedJobs(r));
      },
    );
  }

  // MARK: CANCEL CUSTOMER CREATED REQUEST
  Future cancelCustomerCreatedRequest(int requestId) async {
    emit(CustomerHomeStateLoading());
    final result = await _servicesService.cancelCustomerCreatedRequest(
        cancelCustomerCreatedRequestsDto(requestId: requestId));
    result.fold((l) => emit(CustomerHomeStateError(l)),
        (r) => emit(CancelCustomerRequestSuccessState(r)));
  }
}
