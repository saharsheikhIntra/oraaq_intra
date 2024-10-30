class GenerateOrderResponseDto {
  final String status;
  final String message;
  final int orderId;

  GenerateOrderResponseDto({
    required this.status,
    required this.message,
    required this.orderId,
  });

  factory GenerateOrderResponseDto.fromMap(Map<String, dynamic> map) {
    return GenerateOrderResponseDto(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
      orderId: map['order_id'] ?? -1,
    );
  }
}
