// ignore_for_file: public_member_api_docs, sort_constructors_first

// class GetTokenResponseDto {
//   final String refresh;
//   final String access;
//   GetTokenResponseDto({
//     required this.refresh,
//     required this.access,
//   });

//   factory GetTokenResponseDto.fromMap(Map<String, dynamic> map) {
//     return GetTokenResponseDto(
//       refresh: map['refresh'] as String,
//       access: map['access'] as String,
//     );
//   }
// }

class GetTokenResponseDto {
  final String access;
  GetTokenResponseDto({
    required this.access,
  });

  factory GetTokenResponseDto.fromMap(Map<String, dynamic> map) {
    return GetTokenResponseDto(
      access: map['access'] as String,
    );
  }
}
