import 'dart:math' as math;

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/get_merchant_radius.dart';
import 'package:oraaq/src/domain/services/services_service.dart';
import 'package:oraaq/src/presentaion/screens/customer_flow/pick_location/pick_location_state.dart';

class PickLocationCubit extends Cubit<PickLocationState> {
  final ServicesService _servicesService;
  PickLocationCubit(this._servicesService) : super(PickLocationStateInitial());

  recenter() {}

  changeSearchRadius(double radius) {
    emit(PickLocationStateChangeSearchRadius(radius));
  }

  search(LatLng center, double radius) async {
    List<LatLng> results = [];

    /// GENERATING RANDOM RESULTS
    final int resultsCount = (3 * radius).toInt();
    for (int i = 0; i < resultsCount; i++) {
      const double earthRadius = 6371.0;
      final randomDistance = radius * math.Random().nextDouble();
      final randomAngle = math.Random().nextDouble() * 2 * math.pi;
      final double latitudeOffset =
          randomDistance / earthRadius * (180 / math.pi);
      final double longitudeOffset = randomDistance /
          (earthRadius * math.cos(center.latitude * math.pi / 180)) *
          (180 / math.pi);
      final double newLatitude =
          center.latitude + latitudeOffset * math.cos(randomAngle);
      final double newLongitude =
          center.longitude + longitudeOffset * math.sin(randomAngle);
      results.add(LatLng(newLatitude, newLongitude));
    }

    await Future.delayed(1000.milliseconds);
    emit(PickLocationStateSearchResults(results));
  }

  changePosition(LatLng latlng) async {
    emit(PickLocationStateChangePosition(latlng));
  }

  Future<void> searchMerchant(
      LatLng center, double radius, int categoryId) async {
    // emit(PickLocationStateLoading());

    final dto = GetMerchantWithinRadiusRequestDto(
      latitude: center.latitude,
      longitude: center.longitude,
      radius: radius,
      categoryId: categoryId,
    );

    final result = await _servicesService.getMerchantsWithinRadius(dto);
    result.fold(
      (failure) => emit(PickLocationStateError(failure)),
      (merchants) {
        final List<LatLng> merchantPositions = merchants
            .map((merchant) => LatLng(merchant.latitude, merchant.longitude))
            .toList();
        emit(PickLocationStateMerchantsLoaded(merchantPositions));
      },
    );
  }
}
