part of 'merchant_profile_screen_cubit.dart';

@immutable
sealed class MerchantProfileScreenState {}

final class MerchantProfileScreenInitial extends MerchantProfileScreenState {}

final class MerchantProfileScreenLoading extends MerchantProfileScreenState {}

final class MerchantProfileScreenLogoutSuccess extends MerchantProfileScreenState {}

// final class MerchantProfileScreenLoaded extends MerchantProfileScreenState {
//   final UserEntity user;
//   MerchantProfileScreenLoaded(this.user);
// }

final class MerchantProfileScreenUpdated extends MerchantProfileScreenState {
  final UserEntity user;
  MerchantProfileScreenUpdated(this.user);
}
