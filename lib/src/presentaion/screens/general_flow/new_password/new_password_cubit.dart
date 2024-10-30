import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/set_new_password.dart';
import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/domain/services/authentication_services.dart';

part 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  final AuthenticationServices _authenticationServices;
  NewPasswordCubit(this._authenticationServices) : super(NewPasswordInitial());

  setNewPassword(String email, String newPassword) async {
    emit(NewPasswordStateLoading());
    var result = await _authenticationServices.setNewPassword(
      SetNewPasswordRequestDto(
        email: email,
        newPassword: newPassword,
      ),
    );
    result.fold(
      (l) => emit(NewPasswordStateError(l)),
      (r) => emit(NewPasswordStateSuccess(r)),
    );
  }
}
