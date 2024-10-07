import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final UserEntity user;
  RegisterSuccess(this.user);
}

final class RegisterError extends RegisterState {
  Failure error;
  RegisterError(this.error);
}
