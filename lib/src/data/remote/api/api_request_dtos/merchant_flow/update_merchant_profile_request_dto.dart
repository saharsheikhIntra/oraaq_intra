class UpdateMerchantProfileRequestDto {
  final int merchantId;
  final int merchantUserId;
  final String merchantName;
  final String merchantNumber;
  final String cnic;
  final String email;
  final double latitude;
  final double longitude;
  final String openingTime;
  final String closingTime;
  final int serviceType;
  final String holidays; // Change to String for consistency with API

  UpdateMerchantProfileRequestDto({
    required this.merchantId, // NEW
    required this.merchantUserId,
    required this.merchantName,
    required this.merchantNumber,
    required this.cnic,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.openingTime,
    required this.closingTime,
    required this.serviceType,
    required this.holidays, // Change type to String
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'merchant_id': merchantId,
      'merchant_user_id': merchantUserId,
      'merchant_name': merchantName,
      'merchant_number': merchantNumber,
      'cnic': cnic,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'service_type': serviceType,
      'holidays': holidays, // Send as a single string, e.g., "friday,saturday"
    };
  }
}
