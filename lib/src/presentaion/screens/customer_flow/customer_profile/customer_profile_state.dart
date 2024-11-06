part of 'customer_profile_cubit.dart';

@immutable
sealed class CustomerProfileState {}

final class CustomerProfileInitial extends CustomerProfileState {}

final class CustomerProfileLoading extends CustomerProfileState {}

final class CustomerProfileUpdated extends CustomerProfileState {
  final UserEntity user;
  CustomerProfileUpdated(this.user);
}

final class CustomerProfileLogoutSuccess extends CustomerProfileState {}
