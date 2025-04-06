class AcceptedRequestsResponseDto {
  final int requestId;
  final int orderId;
  final int customerId;
  final String customerName;
  final String serviceName;
  final List<String> services;
  final String amount;
  final String date;
  final String merchantName;
  final String merchantEmail;
  final String merchantPhone;
  final String distance;

  AcceptedRequestsResponseDto({
    this.requestId = -1,
    this.orderId = -1,
    this.customerId = -1,
    this.customerName = '',
    this.serviceName = '',
    this.services = const [],
    this.amount = '',
    this.date = '',
    this.merchantName = '',
    this.merchantEmail = '',
    this.merchantPhone = '',
    this.distance = '',
  });

  factory AcceptedRequestsResponseDto.fromMap(Map<String, dynamic> map) {
    return AcceptedRequestsResponseDto(
      requestId: map['request_id'] ?? -1,
      orderId: map['order_id'] ?? -1,
      customerId: map['customer_id'] ?? -1,
      customerName: map['customer_name'] ?? '',
      serviceName: map['service_name'] ?? '',
      services:
          map['services'] != null ? List<String>.from(map['services']) : [],
      amount: map['amount'] ?? '',
      date: map['date'] ?? '',
      merchantName: map['merchant_name'] ?? '',
      merchantEmail: map['merchant_email'] ?? '',
      merchantPhone: map['merchant_phone'] ?? '',
      distance: map['distance'] ?? '',
    );
  }

  @override
  String toString() {
    return 'AcceptedRequestsResponseDto(requestId: $requestId, orderId: $orderId, customerId: $customerId, customerName: $customerName, serviceName: $serviceName, services: $services, amount: $amount, date: $date, merchantName: $merchantName, merchantEmail: $merchantEmail, merchantPhone: $merchantPhone, distance: $distance)';
  }
}
