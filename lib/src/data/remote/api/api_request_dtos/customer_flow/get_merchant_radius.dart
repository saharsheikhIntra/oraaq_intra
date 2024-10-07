class GetMerchantWithinRadiusRequestDto {
  final double latitude;
  final double longitude;
  final double radius;
  final int categoryId;

  GetMerchantWithinRadiusRequestDto({
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'category_id': categoryId,
    };
  }
}
