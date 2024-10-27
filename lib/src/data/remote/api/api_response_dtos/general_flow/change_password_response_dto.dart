class ChangePasswordResponseDto {
  final String? status;
  final String? message;

  ChangePasswordResponseDto({
    required this.status,
    required this.message,
  });

  factory ChangePasswordResponseDto.fromMap(Map<String, dynamic> map) {
    return ChangePasswordResponseDto(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
    );
  }
}
