class CombineRequestsResponseDto {
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
  final String request_status;

  final String category;

  final int offersReceived;
  final String radius;
  final String duration;

  CombineRequestsResponseDto({
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
    this.request_status = '',
    this.category = '',
    this.offersReceived = 0,
    this.radius = '',
    this.duration = '',
  });
  factory CombineRequestsResponseDto.fromMap(Map<String, dynamic> map) {
    return CombineRequestsResponseDto(
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
      request_status: map['request_status'] ?? '',
      category: map['category'] ?? '',
      offersReceived: map['offers_received'] ?? 0,
      radius: map['radius'] ?? '',
      duration: map['duration'] ?? '',
    );
  }
  @override
  String toString() {
    return 'CombineRequestsResponseDto(requestId: $requestId, orderId: $orderId, customerId: $customerId, customerName: $customerName, serviceName: $serviceName, services: $services, amount: $amount, date: $date, merchantName: $merchantName, merchantEmail: $merchantEmail, merchantPhone: $merchantPhone, distance: $distance, request_status: $request_status, category: $category, offersReceived: $offersReceived, radius: $radius, duration: $duration)';
  }
}
