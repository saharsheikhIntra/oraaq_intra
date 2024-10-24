class UpdateCustomerRequestDto {
  final int customerId;
  final String customerName;
  final String email;
  final String phone;
  final double longitude;
  final double latitude;

  UpdateCustomerRequestDto({
    required this.customerId,
    required this.customerName,
    required this.email,
    required this.phone,
    required this.longitude,
    required this.latitude,
  });


  Map<String, dynamic> toMap() {
    return {
      'customer_id': customerId,
      'customer_name': customerName,
      'email': email,
      'phone': phone,
      'longitude': longitude,
      'latitude': latitude
    };
  }
}