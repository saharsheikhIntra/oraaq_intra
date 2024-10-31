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

final class OffersAmountUpdated extends OffersRecievedState {
  final String message;
  OffersAmountUpdated(this.message);
}
final class OffersAmountUpdatingError extends OffersRecievedState {
  final Failure failure;
  OffersAmountUpdatingError(this.failure);
}

final class OfferRadiusUpdated extends OffersRecievedState {
  final String message;
  OfferRadiusUpdated(this.message);
}
final class OfferRadiusUpdatingError extends OffersRecievedState {
  final Failure failure;
  OfferRadiusUpdatingError(this.failure);
}

final class OfferAccepted extends OffersRecievedState {
  final String message;
  OfferAccepted(this.message);
}
final class OfferRejected extends OffersRecievedState {
  final Failure failure;
  OfferRejected(this.failure);
}

