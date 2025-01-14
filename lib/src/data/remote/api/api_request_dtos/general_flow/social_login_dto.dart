// // ignore_for_file: public_member_api_docs, sort_constructors_first

// class SocialLoginRequestDto {
//   final String userType;
//   final String name;
//   final String email;
//   final String deviceType;
//   final String deviceToken;
//   final String platformType;
//   final String platformId;
//   SocialLoginRequestDto({
//     required this.userType,
//     required this.name,
//     required this.email,
//     required this.deviceType,
//     required this.deviceToken,
//     required this.platformType,
//     required this.platformId,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'user_type': userType,
//       'name': name,
//       'email': email,
//       'device_type': deviceType,
//       'device_token': deviceToken,
//       'platform_type': platformType,
//       'platform_id': platformId,
//     };
//   }
// }

// // ignore_for_file: public_member_api_docs, sort_constructors_first

class SocialLoginRequestDto {
  final String userName;
  final int role;
  final String email;
  final String phone;
  final String provider;
  final String socialId;
  SocialLoginRequestDto({
    required this.userName,
    required this.role,
    required this.email,
    required this.phone,
    required this.provider,
    required this.socialId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_name': userName,
      'email': email,
      'social_id': socialId,
      'phone': phone,
      'provider': provider,
      'role': role,
    };
  }
}
