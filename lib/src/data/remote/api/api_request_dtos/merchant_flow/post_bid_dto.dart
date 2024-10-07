class PostBidRequestDto {
  final int requestId;
  final int merchantId;
  final double bidAmount;
  PostBidRequestDto({
    required this.requestId,
    required this.merchantId,
    required this.bidAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'request_id': requestId,
      'merchant_id': merchantId,
      'bid_amount': bidAmount,
    };
  }
}
