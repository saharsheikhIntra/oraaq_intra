class SetNewPasswordRequestDto {
  final String email;
  final String newPassword;

  SetNewPasswordRequestDto({
    this.email = '',
    this.newPassword = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'new_password': newPassword,
    };
  }

  @override
  String toString() {
    return 'SetNewPasswordRequestDto(email: $email, newPassword: $newPassword)';
  }
}
