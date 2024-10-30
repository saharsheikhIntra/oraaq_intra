class ForgetPasswordRequestDto {
  final String email;

  ForgetPasswordRequestDto({
    this.email = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  @override
  String toString() {
    return 'ForgetPasswordRequestDto(email: $email)';
  }
}
