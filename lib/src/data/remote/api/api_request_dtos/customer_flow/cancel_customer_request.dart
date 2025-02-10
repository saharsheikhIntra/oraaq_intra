class cancelCustomerConfirmedRequestsDto {
  final int orderId;
  final int customerId;

  cancelCustomerConfirmedRequestsDto({
    this.orderId = -1,
    this.customerId = -1,
  });

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'customer_id': customerId,
    };
  }

  @override
  String toString() {
    return 'cancelCustomerCreatedRequestsDto(orderId: $orderId, customerId: $customerId)';
  }
}
