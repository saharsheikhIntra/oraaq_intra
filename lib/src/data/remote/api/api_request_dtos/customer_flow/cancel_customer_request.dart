class cancelCustomerCreatedRequestsDto {
  final int requestId;

  cancelCustomerCreatedRequestsDto({
    this.requestId = -1,
  });

  Map<String, dynamic> toMap() {
    return {
      'request_id': requestId,
    };
  }

  @override
  String toString() {
    return 'cancelCustomerCreatedRequestsDto(requestId: $requestId)';
  }
}
