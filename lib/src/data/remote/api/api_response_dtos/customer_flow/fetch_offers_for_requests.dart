class FetchOffersForRequestDto {
  final int offerId;
  final String merchantName;
  final String merchantEmail;
  final String distance;
  final double offerAmount;
  final double merchantLatitude;
  final double merchantLongitude;

  FetchOffersForRequestDto({
    this.offerId = -1,
    this.merchantName = '',
    this.merchantEmail = '',
    this.distance = '',
    this.offerAmount = 0.0,
    this.merchantLatitude = 0.0,
    this.merchantLongitude = 0.0,
  });

  factory FetchOffersForRequestDto.fromMap(Map<String, dynamic> map) {
    return FetchOffersForRequestDto(
      offerId: map['offer_id'] ?? -1,
      merchantName: map['merchant_name'] ?? '',
      merchantEmail: map['merchant_email'] ?? '',
      distance: map['distance'] ?? '',
      offerAmount: map['offer_amount'] != null ? map['offer_amount'].toDouble() : 0.0,
      merchantLatitude: map['merchant_latitude'] != null ? map['merchant_latitude'].toDouble() : 0.0,
      merchantLongitude: map['merchant_longitude'] != null ? map['merchant_longitude'].toDouble() : 0.0,
    );
  }

  @override
  String toString() {
    return 'FetchOffersForRequestDto(offerId: $offerId, merchantName: $merchantName, merchantEmail: $merchantEmail, distance: $distance, offerAmount: $offerAmount, merchantLatitude: $merchantLatitude, merchantLongitude: $merchantLongitude)';
  }
}
