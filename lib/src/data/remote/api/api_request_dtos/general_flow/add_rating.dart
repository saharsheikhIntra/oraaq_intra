class AddRatingRequestDto {
  final int orderId;
  final int ratingForUserType;
  final int? merchantId;
  final int? customerId;
  final int ratingBy;
  final int rating;
  final String review;

  AddRatingRequestDto({
    required this.orderId,
    required this.ratingForUserType,
    this.merchantId,
    this.customerId,
    required this.ratingBy,
    required this.rating,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': orderId,
      'rating_for_user_type': ratingForUserType,
      'merchant_id': merchantId,
      'customer_id': customerId,
      'rating_by': ratingBy,
      'rating': rating,
      'review': review,
    };
  }
}
