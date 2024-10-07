class GetAllRequestsResponseDto {
  final int serviceRequestId;
  final int customerId;
  final String customerName;
  final double latitude;
  final double longitude;
  final String requestDate;
  final String status;
  final String services;
  final double totalPrice;

  GetAllRequestsResponseDto({
    required this.serviceRequestId,
    required this.customerId,
    required this.customerName,
    required this.latitude,
    required this.longitude,
    required this.requestDate,
    required this.status,
    required this.services,
    required this.totalPrice,
  });

  factory GetAllRequestsResponseDto.fromMap(Map<String, dynamic> map) {
    return GetAllRequestsResponseDto(
      serviceRequestId: map['service_request_id'] ?? 0,
      customerId: map['customer_id'] ?? 0,
      customerName: map['customer_name'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      requestDate: map['request_date'] ?? '',
      status: map['status'] ?? '',
      services: map['services'] ?? '',
      totalPrice: map['total_price']?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'GetAllServiceRequestsDto(serviceRequestId: $serviceRequestId, customerId: $customerId, customerName: $customerName, latitude: $latitude, longitude: $longitude, requestDate: $requestDate, status: $status, services: $services, totalPrice: $totalPrice)';
  }
}
