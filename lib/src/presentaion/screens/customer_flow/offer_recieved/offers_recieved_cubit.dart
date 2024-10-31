import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/fetch_offers_for_requests.dart';
import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/domain/services/services_service.dart';

part 'offers_recieved_state.dart';

class OffersRecievedCubit extends Cubit<OffersRecievedState> {
  final ServicesService _servicesRepository;
  OffersRecievedCubit( this._servicesRepository) : super(OffersRecievedInitial());


  updateOfferAmount(Map<String,dynamic> obj)async {
    // emit(OffersRecievedLoading());
    final result = await _servicesRepository.updateOfferAmount(obj);
    log('ON CUBIT: ${result.toString()}');
    result.fold((l) {
      emit(OffersAmountUpdatingError(l));
    }, (r) {
      emit(OffersAmountUpdated(r));
    },);
  }

  updateOfferRadius(Map<String,dynamic> obj)async {
    // emit(OffersRecievedLoading());
    final result = await _servicesRepository.updateOfferRadius(obj);
    log('ON CUBIT: ${result.toString()}');
    result.fold((l) {
      emit(OfferRadiusUpdatingError(l));
    }, (r) {
      emit(OfferRadiusUpdated(r));
    },);
  }

  acceptOrRejectOffer(Map<String,dynamic> obj)async {
    // emit(OffersRecievedLoading());
    final result = await _servicesRepository.acceptOrRejectOffer(obj);
    log('ON CUBIT aro: ${result.toString()}');
    result.fold((l) {
      emit(OfferRejected(l));
    }, (r) {
      emit(OfferAccepted(r));
    },);
  }

  Future<void> fetchOffersForRequest(int requestId) async {
    emit(OffersRecievedLoading());
    final result = await _servicesRepository.fetchOffersForRequests(requestId);
    result.fold(
      (l) => emit(OffersRecievedError(l)),
      (r) => emit(OffersRecievedLoaded(r)),
    );
  }
}
