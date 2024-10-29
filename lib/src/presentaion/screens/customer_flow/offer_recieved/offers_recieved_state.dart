part of 'offers_recieved_cubit.dart';

@immutable
sealed class OffersRecievedState {}

final class OffersRecievedInitial extends OffersRecievedState {}

final class OffersRecievedLoading extends OffersRecievedState {}

final class OffersRecievedLoaded extends OffersRecievedState {
  final List<FetchOffersForRequestDto> bids;

  OffersRecievedLoaded(this.bids);
}

final class OffersRecievedError extends OffersRecievedState {
  final Failure error;
  OffersRecievedError(this.error);
}

