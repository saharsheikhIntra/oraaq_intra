class ChangePasswordResponceDto {
  final String status;
  final String message;

  ChangePasswordResponceDto({
    required this.status,
    required this.message,
  });

  factory ChangePasswordResponceDto.fromMap(Map<String, dynamic> map) {
    return ChangePasswordResponceDto(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
    );
  }
}
