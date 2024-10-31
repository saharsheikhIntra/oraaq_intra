// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oraaq/src/domain/entities/failure.dart';

sealed class PickLocationState {}

class PickLocationStateInitial extends PickLocationState {}

class PickLocationStateLoading extends PickLocationState {}

class GenerateOrderStateLoading extends PickLocationState {}

class PickLocationStateError extends PickLocationState {
  final Failure failure;
  PickLocationStateError(this.failure);
}

class PickLocationStateMerchantsLoaded extends PickLocationState {
  final List<LatLng> merchants;
  PickLocationStateMerchantsLoaded(this.merchants);
}

class PickLocationStateSearchResults extends PickLocationState {
  final List<LatLng> searchedResults;
  PickLocationStateSearchResults(this.searchedResults);
}

class PickLocationStateChangeSearchRadius extends PickLocationState {
  final double radius;
  PickLocationStateChangeSearchRadius(this.radius);
}

class PickLocationStateChangePosition extends PickLocationState {
  final LatLng latlng;
  PickLocationStateChangePosition(this.latlng);
}

class PickLocationStateRecenter extends PickLocationState {}

class OrderStateError extends PickLocationState {
  final Failure failure;
  OrderStateError(this.failure);
}

class OrderStateSuccess extends PickLocationState {
  final String message;
  OrderStateSuccess(this.message);
}
