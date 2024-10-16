import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/change_password_response_dto.dart';

import '../../../../domain/entities/failure.dart';

sealed class ChangePasswordState {}

class ChangePasswordStateInitial extends ChangePasswordState {}

final class ChangePasswordStateLoading extends ChangePasswordState {}

final class ChangePasswordStateSuccess extends ChangePasswordState {
  final ChangePasswordResponseDto response;
  ChangePasswordStateSuccess(
    this.response
  );
}

final class ChangePasswordStateError extends ChangePasswordState {
  final Failure error;
  ChangePasswordStateError(this.error);
}
