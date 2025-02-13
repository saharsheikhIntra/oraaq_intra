class NewServiceRequestResponseDto {
  final int serviceRequestId;
  final int bidId;
  final int customerId;
  final String customerName;
  final String distance;
  final String requestDate;
  final String status;
  final List<String> serviceNames;
  final int totalPrice;

  NewServiceRequestResponseDto({
    this.serviceRequestId = -1,
    this.bidId = -1,
    this.customerId = -1,
    this.customerName = '',
    this.distance = '',
    this.requestDate = '',
    this.status = '',
    this.serviceNames = const [],
    this.totalPrice = 0,
  });

  factory NewServiceRequestResponseDto.fromMap(Map<String, dynamic> map) {
    return NewServiceRequestResponseDto(
      serviceRequestId: map['service_request_id'] ?? -1,
      bidId: map['bid_id'] ?? -1,
      customerId: map['customer_id'] ?? -1,
      customerName: map['customer_name'] ?? '',
      distance: map['distance'] ?? '',
      requestDate: map['request_date'] ?? '',
      status: map['status'] ?? '',
      serviceNames: map['service_names'] != null
          ? List<String>.from(map['service_names'])
          : [],
      totalPrice:
          map['total_price'] != null ? (map['total_price'] as num).toInt() : 0,
    );
  }

  @override
  String toString() {
    return 'ServiceRequestResponseDto(serviceRequestId: $serviceRequestId, bid_id : $bidId , customerId: $customerId, customerName: $customerName, distance: $distance, requestDate: $requestDate, status: $status, serviceNames: $serviceNames, totalPrice: $totalPrice)';
  }
}
