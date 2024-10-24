import 'package:bloc/bloc.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/update_customer_request_dto.dart';
import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';
import 'package:oraaq/src/domain/services/authentication_services.dart';
import 'package:oraaq/src/imports.dart';
part 'customer_edit_profile_state.dart';

class CustomerEditProfileCubit extends Cubit<CustomerEditProfileState> {
  final AuthenticationServices _authServices;
  final UserEntity user = getIt.get<UserEntity>();
  CustomerEditProfileCubit(this._authServices) : super(CustomerEditProfileInitial());
  

  updateCustomerProfile({required String name,required String email,required String phone,required double latitude,required double longitude})async{
    emit(CustomerEditProfileLoading());
    print("Loading state emitted");
    var dto = UpdateCustomerRequestDto(
      customerId: user.id,
      customerName: name,
      email: email,
      phone: phone,
      latitude: latitude,
      longitude: longitude,
    );
    print("DTO created: ${dto.toMap()}");
    var result = await _authServices.updateCustomerProfile(dto);
    print("Result from service: $result");
    result.fold(
      (l) {
        emit(CustomerEditProfileError(l));
      },
      (r) {
        emit(CustomerEditProfileSuccess(r));
      },
    );
  }

}
