// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChangePasswordRequestDto {
  final int userId;
  final String currentPassword;
  final String newPassword;
  ChangePasswordRequestDto({
    required this.userId,
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'current_password': currentPassword,
      'new_password': newPassword,
    };
  }
}
