part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoadingState extends ForgetPasswordState {}

final class ForgetPasswordSuccessState extends ForgetPasswordState {
  final ForgetPasswordResponseDto response;
  //final String message;
  ForgetPasswordSuccessState(
    this.response,
  );
}

final class ForgetPasswordErrorState extends ForgetPasswordState {
  final Failure error;
  ForgetPasswordErrorState(this.error);
}
