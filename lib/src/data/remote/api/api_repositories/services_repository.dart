import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/cancel_customer_request.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/get_merchant_radius.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/accpted_request_response_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/cancel_work_order_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/complete_work_order_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/fetch_offers_for_requests.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/get_all_bids.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/get_merchant_radius_respomse_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/get_services_response_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/base_response_dto.dart';

import '../../../../domain/entities/failure.dart';
import '../api_constants.dart';
import '../api_datasource.dart';

class ServicesRepository {
  final ApiDatasource _datasource;
  ServicesRepository(this._datasource);

  Future<Either<Failure, GetServicesResponseDto>> getServices(int id) async {
    try {
      final result =
          await _datasource.get(ApiConstants.getServices + id.toString());
      return result.fold(
        (l) => Left(l),
        (r) => Right(GetServicesResponseDto.fromMap(r.data)),
      );
    } catch (e) {
      return Left(Failure('${StringConstants.failedToFetchServices}: $e'));
    }
  }

  //
  //
  // MARK: GET MERCHANTS WITHIN RADIUS
  //
  //
  Future<Either<Failure, List<GetMerchantWithinRadiusResponseDto>>>
      getMerchantsWithinRadius(GetMerchantWithinRadiusRequestDto dto) async {
    try {
      final result = await _datasource.post(
        ApiConstants.getMerchantWithinRadius,
        data: dto.toMap(),
      );

      // Handle the response
      return result.fold(
        (l) => Left(l),
        (r) {
          var responseDto = BaseResponseDto.fromJson(
                r.data,
                (data) => (data['merchants'] as List<dynamic>)
                    .map((e) => GetMerchantWithinRadiusResponseDto.fromMap(
                        e as Map<String, dynamic>))
                    .toList(),
              ).data ??
              <GetMerchantWithinRadiusResponseDto>[];

          return Right(responseDto);
        },
      );
    } catch (e) {
      return Left(Failure('${StringConstants.failedToFetchMerchants}: $e'));
    }
  }

  //
  //
  // MARK:BIDS FOR CUSTOMER REQUEST
  //
  //
  Future<Either<Failure, List<GetAllBidsResponseDto>>>
      getAllBidsForCutomerRequest(int merchantId) async {
    final result =
        await _datasource.get("${ApiConstants.getAllBids}$merchantId");
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data,
          (data) => data is List
              ? data.map((e) => GetAllBidsResponseDto.fromMap(e)).toList()
              : <GetAllBidsResponseDto>[],
        ).data;
        return Right(responseDto!);
      },
    );
  }

  //
  //
  // MARK: GET ACCEPTED REQUESTS
  //
  //
  Future<Either<Failure, List<AcceptedRequestsResponseDto>>>
      getAcceptedRequests(int customerId) async {
    final result = await _datasource
        .get("${ApiConstants.fetchAcceptedRequests}customer_id=$customerId");
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data,
          (data) => data is List
              ? data.map((e) => AcceptedRequestsResponseDto.fromMap(e)).toList()
              : <AcceptedRequestsResponseDto>[],
        ).data;
        return Right(responseDto!);
      },
    );
  }

  //
  //
  // MARK: CUSTOMER CANCELLED WORK ORDER
  //
  //

  Future<Either<Failure, List<CustomerCancelWorkOrderResponseDto>>>
      getCanceledWorkOrdersForCustomer(int customerId) async {
    final result = await _datasource.get(
      "${ApiConstants.customerWorkOrders}customer_id=$customerId&order_status_id=2",
    );
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data,
          (data) => data is List
              ? data
                  .map((e) => CustomerCancelWorkOrderResponseDto.fromMap(e))
                  .toList()
              : <CustomerCancelWorkOrderResponseDto>[],
        ).data;
        return Right(responseDto!);
      },
    );
  }

  //
  //
  // MARK: CUSTOMER COMPLETED WORK ORDER
  //
  //

  Future<Either<Failure, List<CustomerCompletedWorkOrderResponseDto>>>
      getCompletedWorkOrdersForCustomer(int customerId) async {
    final result = await _datasource.get(
        "${ApiConstants.customerWorkOrders}customer_id=$customerId&order_status_id=3");
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data,
          (data) => data is List
              ? data
                  .map((e) => CustomerCompletedWorkOrderResponseDto.fromMap(e))
                  .toList()
              : <CustomerCompletedWorkOrderResponseDto>[],
        ).data;
        return Right(responseDto!);
      },
    );
  }

  //
  //
  // MARK: CUSTOMER NEW REQUEST
  //
  //

  Future<Either<Failure, List<CustomerNewRequestDto>>> getCustomerNewRequests(
      int customerId) async {
    final result = await _datasource
        .get("${ApiConstants.fetchServiceRequests}$customerId");
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data,
          (data) => data is List
              ? data.map((e) => CustomerNewRequestDto.fromMap(e)).toList()
              : <CustomerNewRequestDto>[],
        ).data;
        return Right(responseDto!);
      },
    );
  }

  //
  //
  // MARK: CANCEL CUSTOMER CRATED REQUESTS
  //
  //
  Future<Either<Failure, String>> cancelCustomerCreateRequests(
      cancelCustomerCreatedRequestsDto cancelRequest) async {
    final result = await _datasource.put(
      ApiConstants.cancelCustomerCreatedRequest,
      data: cancelRequest.toMap(),
    );

    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data,
          (data) => data.toString(),
        ).message;
        return Right(responseDto);
      },
    );
  }

  //
  //
  // MARK: CUSTOMER NEW REQUEST
  //
  //

  Future<Either<Failure, List<FetchOffersForRequestDto>>> fetchOffersForRequests(
      int requestId) async {
    final result = await _datasource
        .get("${ApiConstants.fetchOffersForRequest}$requestId");
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data,
          (data) => data is List
              ? data.map((e) => FetchOffersForRequestDto.fromMap(e)).toList()
              : <FetchOffersForRequestDto>[],
        ).data;
        return Right(responseDto!);
      },
    );
  }

  //
  //
  // MARK: UPDATE OFFER AMOUNT
  //
  //

  Future<Either<Failure, String>> updateOfferAmount
  (
      Map<String,dynamic> obj) async {
    final result = await _datasource
        .put(ApiConstants.updateOfferAmount,data: obj);
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data
          ,
          (data) => data
        ).message;
        log(responseDto.toString());
        return Right(responseDto);
      },
    );
  }

  //
  //
  // MARK: ACCEPT OR REJECT OFFERS
  //
  //

  Future<Either<Failure, String>> acceptOrRejectOffers
  (
      Map<String,dynamic> obj) async {
    final result = await _datasource
        .put(ApiConstants.acceptRejectOffer,data: obj);
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data
          ,
          (data) => data
        ).message;
        log(responseDto.toString());
        return Right(responseDto);
      },
    );
  }

  //
  //
  // MARK: UPDATE OFFER RADIUS
  //
  //

  Future<Either<Failure, String>> updateOfferRadius
  (
      Map<String,dynamic> obj) async {
    final result = await _datasource
        .put(ApiConstants.updateOfferRadius,data: obj);
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data
          ,
          (data) => data
        ).message;
        log(responseDto.toString());
        return Right(responseDto);
      },
    );
  }

}
