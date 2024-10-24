part of '../change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

class LoginStateInitial extends ChangePasswordState {}

final class ChangePasswordStateLoading extends ChangePasswordState {}

final class ChangePasswordStateLoaded extends ChangePasswordState {
  final String message;
  ChangePasswordStateLoaded(
    this.message,
  );
}

final class ChangePasswordStateError extends ChangePasswordState {
  final Failure error;
  ChangePasswordStateError(this.error);
}
