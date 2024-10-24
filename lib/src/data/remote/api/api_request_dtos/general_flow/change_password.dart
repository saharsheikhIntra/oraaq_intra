// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChangePasswordRequestDto {
  final int appUserId;
  final String currentPassword;
  final String newPassword;

  ChangePasswordRequestDto({
    required this.appUserId,
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': appUserId,
      'current_password': currentPassword,
      'new_password': newPassword,
    };
  }
}
