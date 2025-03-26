// ignore_for_file: public_member_api_docs, sort_constructors_first

class LoginRequestDto {
  final String email;
  final String password;
  final int role;
  LoginRequestDto({
    required this.email,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "email": email,
      "password": password,
      "role": role,
    };
  }
}
