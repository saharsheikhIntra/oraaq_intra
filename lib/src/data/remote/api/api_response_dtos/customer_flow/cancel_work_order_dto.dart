class CustomerCancelWorkOrderResponseDto {
  final int workOrderId;
  final int requestId;
  final int bidId;
  final double bidAmount;
  final String bidDate;
  final List<String> serviceNames;
  final int serviceRequestId;
  final int merchantId;
  final String merchantName;
  final String merchantEmail;
  final double latitude;
  final double longitude;
  final String requestDate;
  final int rating;
  final String status;

  CustomerCancelWorkOrderResponseDto({
    this.workOrderId = -1,
    this.requestId = -1,
    this.bidId = -1,
    this.bidAmount = 0.0,
    this.bidDate = '',
    this.serviceNames = const [],
    this.serviceRequestId = -1,
    this.merchantId = -1,
    this.merchantName = '',
    this.merchantEmail = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.requestDate = '',
    this.rating = 0,
    this.status = '',
  });

  factory CustomerCancelWorkOrderResponseDto.fromMap(Map<String, dynamic> map) {
    return CustomerCancelWorkOrderResponseDto(
      workOrderId: map['work_order_id'] ?? -1,
      requestId: map['request_id'] ?? -1,
      bidId: map['bid_id'] ?? -1,
      bidAmount: map['bid_amount'] != null ? map['bid_amount'].toDouble() : 0.0,
      bidDate: map['bid_date'] ?? '',
      serviceNames: map['service_names'] != null
          ? List<String>.from(map['service_names'])
          : [],
      serviceRequestId: map['service_request_id'] ?? -1,
      merchantId: map['merchant_id'] ?? -1,
      merchantName: map['merchant_name'] ?? '',
      merchantEmail: map['merchant_email'] ?? '',
      latitude: map['latitude'] != null ? map['latitude'].toDouble() : 0.0,
      longitude: map['longitude'] != null ? map['longitude'].toDouble() : 0.0,
      requestDate: map['request_date'] ?? '',
      rating: map['rating'] ?? 0,
      status: map['status'] ?? '',
    );
  }

  @override
  String toString() {
    return 'CustomerCancelWorkOrderResponseDto(workOrderId: $workOrderId, requestId: $requestId, bidId: $bidId, bidAmount: $bidAmount, bidDate: $bidDate, serviceNames: $serviceNames, serviceRequestId: $serviceRequestId, merchantId: $merchantId, merchantName: $merchantName, merchantEmail: $merchantEmail, latitude: $latitude, longitude: $longitude, requestDate: $requestDate, rating: $rating, status: $status)';
  }
}
