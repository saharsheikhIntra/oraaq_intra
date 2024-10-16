

import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/change_password_responce_dto.dart';
import 'package:oraaq/src/domain/entities/failure.dart';

abstract class ChangePasswordState {
  const ChangePasswordState();

  List<Object?> get props => [];
}

class ChangePasswordStateInitial extends ChangePasswordState {}

class ChangePasswordStateLoading extends ChangePasswordState {}

class ChangePasswordStateLoaded extends ChangePasswordState {
  final ChangePasswordResponceDto res;

  const ChangePasswordStateLoaded(this.res);


}

class ChangePasswordStateError extends ChangePasswordState {
  final Failure error;

  const ChangePasswordStateError(this.error);

}
