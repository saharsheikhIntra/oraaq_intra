import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';
import 'package:oraaq/src/injection_container.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/change_password_request_dto.dart';
import 'package:oraaq/src/domain/services/authentication_services.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthenticationServices _authenticationServices;

  ChangePasswordCubit(this._authenticationServices)
      : super(ChangePasswordStateInitial());
  UserEntity user = getIt.get<UserEntity>();

  changePassword(String oldPassword, String newPassword) async {
    emit(ChangePasswordStateLoading());

    var result = await _authenticationServices.changePassword(
      ChangePasswordRequestDto(
        newPassword: newPassword,
        userId: user.userId,
        currentPassword: oldPassword,
      ),
    );

    result.fold(
      (l) => emit(ChangePasswordStateError(l)),
      (r) => emit(ChangePasswordStateLoaded(r)),
    );
  }
}
