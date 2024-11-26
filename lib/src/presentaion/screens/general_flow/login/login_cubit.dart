import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/social_login_dto.dart';
import 'package:oraaq/src/injection_container.dart';
import 'package:oraaq/src/presentaion/screens/general_flow/login/login_state.dart';

import '../../../../core/enum/social_sign_in_enum.dart';
import '../../../../core/enum/user_type.dart';
import '../../../../data/remote/api/api_request_dtos/general_flow/login_request_dto.dart';
import '../../../../domain/services/authentication_services.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationServices _authenticationServices;
  LoginCubit(this._authenticationServices) : super(LoginStateInitial());

  login(
    String email,
    String password,
  ) async {
    emit(LoginStateLoading());
    var result = await _authenticationServices.login(
      LoginRequestDto(
        email: email,
        password: password,
        role: getIt.get<UserType>().id,
      ),
    );
    result.fold(
      (l) => emit(LoginStateError(l)),
      (r) => emit(LoginStateLoaded(r)),
    );
  }
  

  socialSignIn(SocialSignInEnum signinProvidor, UserType userType) async {
    var result =
        await _authenticationServices.socialSignIn(signinProvidor, userType);
    print(result);
    result.fold(
      (l) => Logger().e(l), 
      (r)async{
        Logger().e(r.displayName);
        log(userType.id.toString());
        log('login social');
        // var result =
        var socialApiRes = await _authenticationServices.loginViaSocial(SocialLoginRequestDto(role: userType.id, email: r.email!, phone: "", provider: "google", socialId: r.uid));
        log(socialApiRes.toString());
        socialApiRes.fold(
      (l) => emit(LoginStateError(l)),
      (res) => emit(LoginStateLoaded(res)),
    );
      },
    );
  }
}
