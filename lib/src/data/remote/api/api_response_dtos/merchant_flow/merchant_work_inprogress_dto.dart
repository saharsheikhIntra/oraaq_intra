class InProgressWorkOrderResponseDto {
  final int workOrderId;
  final int requestId;
  final int bidId;
  final double bidAmount;
  final String bidDate;
  final List<String> serviceNames;
  final int serviceRequestId;
  final int customerId;
  final String customerName;
  final String customerContactNumber;
  final String customerEmail;
  final String distance;
  final String requestDate;
  final String status;

  InProgressWorkOrderResponseDto({
    this.workOrderId = -1,
    this.requestId = -1,
    this.bidId = -1,
    this.bidAmount = 0.0,
    this.bidDate = '',
    this.serviceNames = const [],
    this.serviceRequestId = -1,
    this.customerId = -1,
    this.customerName = '',
    this.customerContactNumber = '',
    this.customerEmail = '',
    this.distance = '',
    this.requestDate = '',
    this.status = '',
  });

  factory InProgressWorkOrderResponseDto.fromMap(Map<String, dynamic> map) {
    return InProgressWorkOrderResponseDto(
      workOrderId: map['work_order_id'] ?? -1,
      requestId: map['request_id'] ?? -1,
      bidId: map['bid_id'] ?? -1,
      bidAmount: map['bid_amount'] != null ? map['bid_amount'].toDouble() : 0.0,
      bidDate: map['bid_date'] ?? '',
      serviceNames: map['service_names'] != null
          ? List<String>.from(map['service_names'])
          : [],
      serviceRequestId: map['service_request_id'] ?? -1,
      customerId: map['customer_id'] ?? -1,
      customerName: map['customer_name'] ?? '',
      customerContactNumber: map['customer_contact_number'] ?? '',
      customerEmail: map['customer_email'] ?? '',
      distance: map['distance'] ?? '',
      requestDate: map['request_date'] ?? '',
      status: map['status'] ?? '',
    );
  }

  @override
  String toString() {
    return 'InProgressWorkOrderResponseDto(workOrderId: $workOrderId, requestId: $requestId, bidId: $bidId, bidAmount: $bidAmount, bidDate: $bidDate, serviceNames: $serviceNames, serviceRequestId: $serviceRequestId, customerId: $customerId, customerName: $customerName, customerContactNumber: $customerContactNumber, customerEmail: $customerEmail, distance: $distance, requestDate: $requestDate, status: $status)';
  }
}
