class GetAllNewRequestsResponseDto {
  final int serviceRequestId;
  final int customerId;
  final String customerName;
  final String distance;
  final String requestDate;
  final String status;
  final List<String> services;
  final double totalPrice;

  GetAllNewRequestsResponseDto({
    required this.serviceRequestId,
    required this.customerId,
    required this.customerName,
    required this.distance,
    required this.requestDate,
    required this.status,
    required this.services,
    required this.totalPrice,
  });

  factory GetAllNewRequestsResponseDto.fromMap(Map<String, dynamic> map) {
    return GetAllNewRequestsResponseDto(
      serviceRequestId: map['service_request_id'] ?? 0,
      customerId: map['customer_id'] ?? 0,
      customerName: map['customer_name'] ?? '',
      distance: map['distance'] ?? '',
      requestDate: map['request_date'] ?? '',
      status: map['status'] ?? '',
      services: map['service_names'].cast<String>(),
      totalPrice: map['total_price']?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'GetAllServiceRequestsDto(serviceRequestId: $serviceRequestId, customerId: $customerId, customerName: $customerName, distance: $distance, requestDate: $requestDate, status: $status, services: $services, totalPrice: $totalPrice)';
  }
}
