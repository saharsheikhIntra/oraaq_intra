class AcceptedRequestsResponseDto {
  final int requestId;
  final String serviceName;
  final String amount;
  final String date;
  final String merchantName;

  AcceptedRequestsResponseDto({
    this.requestId = -1,
    this.serviceName = '',
    this.amount = '',
    this.date = '',
    this.merchantName = '',
  });

  factory AcceptedRequestsResponseDto.fromMap(Map<String, dynamic> map) {
    return AcceptedRequestsResponseDto(
      requestId: map['request_id'] ?? -1,
      serviceName: map['service_name'] ?? '',
      amount: map['amount'] ?? '',
      date: map['date'] ?? '',
      merchantName: map['merchant_name'] ?? '',
    );
  }

  @override
  String toString() {
    return 'AcceptedRequestsResponseDto(requestId: $requestId, serviceName: $serviceName, amount: $amount, date: $date, merchantName: $merchantName)';
  }
}
