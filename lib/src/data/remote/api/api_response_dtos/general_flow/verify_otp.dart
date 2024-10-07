class VerifyOtpResponseDto {
  final String status;
  final String message;

  VerifyOtpResponseDto({
    required this.status,
    required this.message,
  });

  factory VerifyOtpResponseDto.fromMap(Map<String, dynamic> map) {
    return VerifyOtpResponseDto(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
    );
  }
}
