class RegisterRequestDto {
  final String userName;
  final String encryptedPassword;
  final String phone;
  final int userTypeId;
  final String email;

  RegisterRequestDto({
    required this.userName,
    required this.encryptedPassword,
    required this.phone,
    required this.userTypeId,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_name': userName,
      'encrypted_password': encryptedPassword,
      'phone': phone,
      'user_type_id': userTypeId,
      'email': email,
    };
  }
}
