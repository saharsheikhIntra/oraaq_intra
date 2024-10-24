import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/change_password.dart';
import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/domain/services/authentication_services.dart';
import 'package:oraaq/src/imports.dart';

part 'cubit/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthenticationServices _authenticationServices;
  ChangePasswordCubit(this._authenticationServices)
      : super(ChangePasswordInitial());
  final user = getIt.get<UserEntity>();
  ChangePassword(String oldPassword, String newPassword) async {
    emit(ChangePasswordStateLoading());
    var result = await _authenticationServices.changePassword(
      ChangePasswordRequestDto(
        appUserId: user.userId,
        currentPassword: oldPassword,
        newPassword: newPassword,
      ),
    );
    result.fold(
      (l) => emit(ChangePasswordStateError(l)),
      (r) => emit(ChangePasswordStateLoaded(r)),
    );
  }
}
