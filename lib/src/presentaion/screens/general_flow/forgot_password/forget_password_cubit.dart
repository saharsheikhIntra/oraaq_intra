import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/forget_password_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/forget_password_dto.dart';
import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/domain/services/authentication_services.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthenticationServices _authenticationServices;
  ForgetPasswordCubit(this._authenticationServices)
      : super(ForgetPasswordInitial());
  forgetPassword(String email) async {
    emit(ForgetPasswordLoadingState());
    final resut = await _authenticationServices
        .forgetPassword(ForgetPasswordRequestDto(email: email));
    return resut.fold(
      (l) => emit(ForgetPasswordErrorState(l)),
      (r) => emit(ForgetPasswordSuccessState(r)),
    );
  }
}
