class ChangePasswordRequestDto {
  final int userId;
  final String currentPassword;
  final String newPassword;

  ChangePasswordRequestDto({
    required this.userId,
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'current_password': currentPassword,
      'new_password': newPassword,
    };
  }
}
