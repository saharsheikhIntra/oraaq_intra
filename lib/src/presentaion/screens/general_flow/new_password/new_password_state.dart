part of 'new_password_cubit.dart';

@immutable
sealed class NewPasswordState {}

final class NewPasswordInitial extends NewPasswordState {}

final class NewPasswordStateLoading extends NewPasswordState {}

final class NewPasswordStateSuccess extends NewPasswordState {
  final String response;
  NewPasswordStateSuccess(this.response);
}

final class NewPasswordStateError extends NewPasswordState {
  final Failure error;
  NewPasswordStateError(this.error);
}
