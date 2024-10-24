part of 'customer_edit_profile_cubit.dart';

sealed class CustomerEditProfileState {}

final class CustomerEditProfileInitial extends CustomerEditProfileState {}

final class CustomerEditProfileLoading extends CustomerEditProfileState {}

final class CustomerEditProfileSuccess extends CustomerEditProfileState {
  final UserEntity user;
  CustomerEditProfileSuccess(this.user);
}

final class CustomerEditProfileError extends CustomerEditProfileState {
  final Failure error;
  CustomerEditProfileError(this.error);
}
