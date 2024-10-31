class GetMerchantWithinRadius2ResponseDto {
  final String merchantId;
  final String shortTitle;
  final String merchantName;
  final double latitude;
  final double longitude;
  final String phone;
  final String email;
  final String distance;

  GetMerchantWithinRadius2ResponseDto({
    this.merchantId = '',
    this.shortTitle = '',
    this.merchantName = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.phone = '',
    this.email = '',
    this.distance = '',
  });

  factory GetMerchantWithinRadius2ResponseDto.fromMap(Map<String, dynamic> map) {
    return GetMerchantWithinRadius2ResponseDto(
      merchantId: map['merchant_id'] ?? '',
      shortTitle: map['short_title'] ?? '',
      merchantName: map['merchant_name'] ?? '',
      latitude: map['latitude'] != null ? map['latitude'].toDouble() : 0.0,
      longitude: map['longitude'] != null ? map['longitude'].toDouble() : 0.0,
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      distance: map['distance'] ?? '',
    );
  }

  @override
  String toString() {
    return 'GetMerchantWithinRadius2ResponseDto(merchantId: $merchantId, shortTitle: $shortTitle, merchantName: $merchantName, latitude: $latitude, longitude: $longitude, phone: $phone, email: $email, distance: $distance)';
  }
}
