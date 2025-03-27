import 'package:bloc/bloc.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/cancel_customer_request.dart';
import 'package:oraaq/src/domain/services/services_service.dart';
import 'package:oraaq/src/imports.dart';

import '../../../../domain/services/job_management_service.dart';
import 'customer_home_state.dart';

class CustomerHomeCubit extends Cubit<CustomerHomeState> {
  final ServicesService _servicesRepository;
  final JobManagementService _jobManagementService;
  final ServicesService _servicesService;
  CustomerHomeCubit(
    this._jobManagementService,
    this._servicesService,
    this._servicesRepository,
  ) : super(CustomerHomeStateInitial());
  final user = getIt.get<UserEntity>();
// MARK: chnged
  Future<void> fetchCategories() async {
    emit(CustomerHomeStateLoading());
    final result = await _jobManagementService.newCategories();
    result.fold(
      (l) => emit(CustomerHomeStateError(l)),
      (r) => emit(CustomerHomeStateCategories(r)),
    );
  }

// MARK: chnged
  //
// MARK: ACCEPTED REQUESTS
//
  Future<void> fetchAcceptedRequest() async {
    emit(CustomerHomeStateLoading());

    final result = await _servicesService.getAcceptedRequests(user.id);

    result.fold(
      (l) {
        emit(CustomerHomeStateError(l));
      },
      (r) {
        emit(CustomerHomeStateAcceptedJobs(r));
      },
    );
  }
  // MARK: chnged

  // MARK: CANCEL CUSTOMER CREATED REQUEST
  Future cancelCustomerCreatedRequest(int requestId) async {
    emit(CustomerHomeStateLoading());

    final result =
        await _servicesRepository.cancelWorkOrder(requestId, user.id);
    // await _servicesService.cancelCustomerCreatedRequest(
    //     cancelCustomerCreatedRequestsDto(requestId: requestId));
    result.fold((l) => emit(CustomerHomeStateError(l)),
        (r) => emit(CancelCustomerRequestSuccessState(r)));
  }
}
