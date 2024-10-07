part of 'otp_cubit.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpLoading extends OtpState {}

final class OtpGenerated extends OtpState {
  final GenerateOtpResponseDto otpResponse;
  OtpGenerated(this.otpResponse);
}

final class OtpVerified extends OtpState {
  final String message;
  OtpVerified(this.message);
}

final class OtpError extends OtpState {
  final Failure error;
  OtpError(this.error);
}
