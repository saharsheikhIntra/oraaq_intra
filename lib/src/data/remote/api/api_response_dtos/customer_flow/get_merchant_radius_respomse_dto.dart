class GetMerchantWithinRadiusResponseDto {
  final double latitude;
  final double longitude;

  GetMerchantWithinRadiusResponseDto({
    required this.latitude,
    required this.longitude,
  });

  factory GetMerchantWithinRadiusResponseDto.fromMap(Map<String, dynamic> map) {
    return GetMerchantWithinRadiusResponseDto(
      latitude: map['latitude'] != null ? map['latitude'] as double : 0.0,
      longitude: map['longitude'] != null ? map['longitude'] as double : 0.0,
    );
  }
}
