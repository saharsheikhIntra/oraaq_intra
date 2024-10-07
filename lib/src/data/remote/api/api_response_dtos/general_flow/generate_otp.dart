class GenerateOtpResponseDto {
  final String status;
  final String message;
  final int otp;

  GenerateOtpResponseDto({
    required this.status,
    required this.message,
    required this.otp,
  });

  factory GenerateOtpResponseDto.fromMap(Map<String, dynamic> map) {
    return GenerateOtpResponseDto(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
      otp: map['OTP'] ?? 0,
    );
  }
}
