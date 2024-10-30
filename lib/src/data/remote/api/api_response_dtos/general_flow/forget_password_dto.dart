class ForgetPasswordResponseDto {
  final int otp;
  final String email;
  final String phone;

  ForgetPasswordResponseDto({
    this.otp = -1,
    this.email = '',
    this.phone = '',
  });

  factory ForgetPasswordResponseDto.fromMap(Map<String, dynamic> map) {
    return ForgetPasswordResponseDto(
      otp: map['OTP'] ?? -1,
      email: map['Email'] ?? '',
      phone: map['Phone'] ?? '',
    );
  }

  @override
  String toString() {
    return 'OtpResponseDto(otp: $otp, email: $email, phone: $phone)';
  }
}
