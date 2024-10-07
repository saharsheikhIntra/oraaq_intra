import 'package:oraaq/src/domain/entities/user_entity.dart';

import '../../../../domain/entities/failure.dart';

sealed class LoginState {}

class LoginStateInitial extends LoginState {}

final class LoginStateLoading extends LoginState {}

final class LoginStateLoaded extends LoginState {
  final UserEntity user;
  //final String message;
  LoginStateLoaded(
    this.user,
  );
}

final class LoginStateError extends LoginState {
  final Failure error;
  LoginStateError(this.error);
}
