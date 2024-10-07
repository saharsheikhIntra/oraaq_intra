part of 'merchant_edit_profile_cubit.dart';

@immutable
sealed class MerchantEditProfileState {}

final class MerchantEditProfileInitial extends MerchantEditProfileState {}

final class MerchantProfileStateLoading extends MerchantEditProfileState {}

final class MerchantProfileStateSuccess extends MerchantEditProfileState {
  final UserEntity user;
  MerchantProfileStateSuccess(this.user);
}

final class MerchantProfileStateError extends MerchantEditProfileState {
  final Failure error;
  MerchantProfileStateError(this.error);
}

final class MerchantProfileStateCategoriesLoaded extends MerchantEditProfileState {
  final List<CategoryEntity> categories;
  MerchantProfileStateCategoriesLoaded(this.categories);
}
