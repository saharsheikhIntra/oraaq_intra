import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/register_request_dto.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/register/register_state.dart';

import '../../../../core/enum/user_type.dart';
import '../../../../domain/services/authentication_services.dart';
import '../../../../injection_container.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationServices _authServices;
  RegisterCubit(this._authServices) : super(RegisterInitial());

  register({
    required String userName,
    required String password,
    required String phone,
    required String email,
  }) async {
    emit(RegisterLoading());
    var type = getIt.get<UserType>();
    var result = await _authServices.register(RegisterRequestDto(
      userName: userName,
      encryptedPassword: password,
      phone: phone,
      userTypeId: type.id,
      email: email,
    ));
    result.fold(
      (l) => emit(RegisterError(l)),
      (r) => emit(RegisterSuccess(r)),
    );
  }
}
