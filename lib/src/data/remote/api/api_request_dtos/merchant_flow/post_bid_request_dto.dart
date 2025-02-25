class PostBidRequestDto {
  final int orderId;
  final int merchantId;
  final int bidAmount;
  final int createdBy;

  PostBidRequestDto({
    required this.orderId,
    required this.merchantId,
    required this.bidAmount,
    required this.createdBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'merchant_id': merchantId,
      'bid_amount': bidAmount,
      'created_by': createdBy,
    };
  }
}
