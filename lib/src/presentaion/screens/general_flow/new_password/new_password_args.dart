import 'package:oraaq/src/core/enum/user_type.dart';

class NewPasswordArgs {
  final UserType selectedUserType;
  final String email;
  NewPasswordArgs(this.selectedUserType, this.email);
}
