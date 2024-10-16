import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/change_password_requset_dto.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';
import 'package:oraaq/src/domain/services/authentication_services.dart';
import 'package:oraaq/src/imports.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/change_password/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState>{
  final AuthenticationServices _authenticationServices;
  ChangePasswordCubit(this._authenticationServices) : super(ChangePasswordStateInitial());
  final UserEntity user = getIt.get<UserEntity>();

  changePassword(String currentPassword, String newPassword) async {
    emit(ChangePasswordStateLoading());
    var result = await _authenticationServices.changePassword(ChangePasswordRequestDto(userId: user.userId, currentPassword: currentPassword, newPassword: newPassword));
    result.fold(
      (l) => emit(ChangePasswordStateError(l)),
      (r) => emit(ChangePasswordStateSuccess(r)),
    );
  }
}