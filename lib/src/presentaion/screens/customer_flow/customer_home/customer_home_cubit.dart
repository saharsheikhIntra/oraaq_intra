import 'package:bloc/bloc.dart';

import '../../../../domain/services/job_management_service.dart';
import 'customer_home_state.dart';

class CustomerHomeCubit extends Cubit<CustomerHomeState> {
  final JobManagementService _jobManagementService;
  CustomerHomeCubit(
    this._jobManagementService,
  ) : super(CustomerHomeStateInitial());

  Future<void> fetchCategories() async {
    emit(CustomerHomeStateLoading());
    final result = await _jobManagementService.getCategories();
    result.fold(
      (l) => emit(CustomerHomeStateError(l)),
      (r) => emit(CustomerHomeStateCategories(r)),
    );
  }
}
