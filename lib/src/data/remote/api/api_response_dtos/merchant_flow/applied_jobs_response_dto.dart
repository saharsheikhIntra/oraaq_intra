class AppliedJobsResponseDto {
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
  final double latitude;
  final double longitude;
  final String requestDate;
  final int rating;
  final String status;
  final String distance;

  AppliedJobsResponseDto(
      {this.workOrderId = -1,
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
      this.latitude = 0.0,
      this.longitude = 0.0,
      this.requestDate = '',
      this.rating = 0,
      this.status = '',
      this.distance = ''});

  factory AppliedJobsResponseDto.fromMap(Map<String, dynamic> map) {
    return AppliedJobsResponseDto(
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
      latitude: map['latitude'] != null
          ? double.tryParse(map['latitude'].toString()) ?? 0.0
          : 0.0,
      longitude: map['longitude'] != null
          ? double.tryParse(map['longitude'].toString()) ?? 0.0
          : 0.0,
      requestDate: map['request_date'] ?? '',
      rating: map['rating'] ?? 0,
      status: map['status'] ?? '',
      distance: map['distance'] ?? '',
    );
  }

  @override
  String toString() {
    return 'CancelWorkOrderResponseDto(workOrderId: $workOrderId, requestId: $requestId, bidId: $bidId, bidAmount: $bidAmount, bidDate: $bidDate, serviceNames: $serviceNames, serviceRequestId: $serviceRequestId, customerId: $customerId, customerName: $customerName, customerContactNumber: $customerContactNumber, customerEmail: $customerEmail, latitude: $latitude, longitude: $longitude, requestDate: $requestDate,rating:$rating, status: $status, distance: $distance)';
  }
}
