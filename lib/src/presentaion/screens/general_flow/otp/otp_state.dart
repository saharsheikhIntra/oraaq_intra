part of 'otp_cubit.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpLoading extends OtpState {}

final class OtpGenerated extends OtpState {
  final GenerateOtpResponseDto otpResponse;
  OtpGenerated(this.otpResponse);
}

final class OtpVerified extends OtpState {}

final class OtpError extends OtpState {
  final Failure error;
  OtpError(this.error);
}

final class ForgetPasswordLoadingState extends OtpState {}

final class ForgetPasswordScreenLogoutSuccess extends OtpState {}

final class ForgetPasswordSuccessState extends OtpState {
  final ForgetPasswordResponseDto response;
  //final String message;
  ForgetPasswordSuccessState(
    this.response,
  );
}

final class ForgetPasswordErrorState extends OtpState {
  final Failure error;
  ForgetPasswordErrorState(this.error);
}
