class GetAllBidsResponseDto {
  final String consumerName;
  final String consumerPhoneNumber;
  final String consumerEmail;
  final double bidAmount;
  final String location;

  GetAllBidsResponseDto({
    this.consumerName = "",
    this.consumerPhoneNumber = "",
    this.consumerEmail = "",
    this.bidAmount = 0.0,
    this.location = "",
  });

  factory GetAllBidsResponseDto.fromMap(Map<String, dynamic> map) {
    return GetAllBidsResponseDto(
      consumerName: map['consumer_name'] ?? "",
      consumerPhoneNumber: map['consumer_phone_number'] ?? "",
      consumerEmail: map['consumer_email'] ?? "",
      bidAmount: map['bid_amount'] != null
          ? (map['bid_amount'] as num).toDouble()
          : 0.0,
      location: map['location'] ?? "",
    );
  }

  @override
  String toString() {
    return 'BidResponseDto(consumerName: $consumerName, consumerPhoneNumber: $consumerPhoneNumber, consumerEmail: $consumerEmail, bidAmount: $bidAmount, location: $location)';
  }
}
