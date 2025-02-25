import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';
import 'package:oraaq/src/core/utils/error_util.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/cancel_customer_request.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/create_order_dto.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/get_merchant_radius.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/accpted_request_response_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/cancel_work_order_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/complete_work_order_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/fetch_offers_for_requests.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/get_all_bids.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/get_merchant_radius_respomse_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/get_merchant_within_radius2.dart';
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
      log("Get Services Error: $e");

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
      log("GET MERCHANTS WITHIN RADIUS Error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK:BIDS FOR CUSTOMER REQUEST
  //
  //
  Future<Either<Failure, List<GetAllBidsResponseDto>>>
      getAllBidsForCutomerRequest(int merchantId) async {
    try {
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
    } catch (e) {
      log("BIDS FOR CUSTOMER REQUEST Error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: GET ACCEPTED REQUESTS
  //
  //
  Future<Either<Failure, List<AcceptedRequestsResponseDto>>>
      getAcceptedRequests(int customerId) async {
    try {
      final result = await _datasource
          .get("${ApiConstants.fetchAcceptedRequests}customer_id=$customerId");
      // log(result.toString());
      return result.fold(
        (l) => Left(l),
        (r) {
          var responseDto = BaseResponseDto.fromJson(
            r.data,
            (data) => data is List
                ? data
                    .map((e) => AcceptedRequestsResponseDto.fromMap(e))
                    .toList()
                : <AcceptedRequestsResponseDto>[],
          ).data;
          return Right(responseDto!);
        },
      );
    } catch (e) {
      log("GET ACCEPTED REQUESTS Error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: CUSTOMER CANCELLED WORK ORDER
  //
  //

  Future<Either<Failure, List<CustomerCancelWorkOrderResponseDto>>>
      getCanceledWorkOrdersForCustomer(int customerId) async {
    try {
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
    } catch (e) {
      log("CUSTOMER CANCELLED WORK ORDER Error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: CUSTOMER COMPLETED WORK ORDER
  //
  //

  Future<Either<Failure, List<CustomerCompletedWorkOrderResponseDto>>>
      getCompletedWorkOrdersForCustomer(int customerId) async {
    try {
      final result = await _datasource.get(
          "${ApiConstants.customerWorkOrders}customer_id=$customerId&order_status_id=3");
      return result.fold(
        (l) => Left(l),
        (r) {
          var responseDto = BaseResponseDto.fromJson(
            r.data,
            (data) => data is List
                ? data
                    .map(
                        (e) => CustomerCompletedWorkOrderResponseDto.fromMap(e))
                    .toList()
                : <CustomerCompletedWorkOrderResponseDto>[],
          ).data;
          return Right(responseDto!);
        },
      );
    } catch (e) {
      log("CUSTOMER COMPLETED WORK ORDER Error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: CUSTOMER NEW REQUEST
  //
  //

  Future<Either<Failure, List<CustomerNewRequestDto>>> getCustomerNewRequests(
      int customerId) async {
    try {
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
    } catch (e) {
      log("CUSTOMER NEW REQUEST Error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: CANCEL CUSTOMER CRATED REQUESTS
  //
  //
  Future<Either<Failure, String>> cancelCustomerCreateRequests(
      cancelCustomerConfirmedRequestsDto cancelRequest) async {
    try {
      final result = await _datasource.put(
        ApiConstants.cancelCustomerConfirmedRequest,
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
    } catch (e) {
      log("CANCEL CUSTOMER CRATED REQUESTS Error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: CUSTOMER NEW REQUEST
  //
  //

  Future<Either<Failure, List<FetchOffersForRequestDto>>>
      fetchOffersForRequests(int requestId) async {
    try {
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
    } catch (e) {
      log("CUSTOMER NEW REQUEST Error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: UPDATE OFFER AMOUNT
  //
  //

  Future<Either<Failure, String>> updateOfferAmount(
      Map<String, dynamic> obj) async {
    try {
      final result =
          await _datasource.put(ApiConstants.updateOfferAmount, data: obj);
      return result.fold(
        (l) => Left(l),
        (r) {
          var responseDto =
              BaseResponseDto.fromJson(r.data, (data) => data).message;
          // log(responseDto.toString());
          return Right(responseDto);
        },
      );
    } catch (e) {
      log("UPDATE OFFER AMOUNT Error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: ACCEPT OR REJECT OFFERS
  //
  //

  Future<Either<Failure, String>> acceptOrRejectOffers(
      Map<String, dynamic> obj) async {
    try {
      final result =
          await _datasource.put(ApiConstants.acceptRejectOffer, data: obj);
      return result.fold(
        (l) => Left(l),
        (r) {
          var responseDto =
              BaseResponseDto.fromJson(r.data, (data) => data).message;
          // log(responseDto.toString());
          return Right(responseDto);
        },
      );
    } catch (e) {
      log("ACCEPT OR REJECT OFFERS Error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: UPDATE OFFER RADIUS
  //
  //

  Future<Either<Failure, String>> updateOfferRadius(
      Map<String, dynamic> obj) async {
    try {
      final result =
          await _datasource.put(ApiConstants.updateOfferRadius, data: obj);
      return result.fold(
        (l) => Left(l),
        (r) {
          var responseDto =
              BaseResponseDto.fromJson(r.data, (data) => data).message;
          // log(responseDto.toString());
          return Right(responseDto);
        },
      );
    } catch (e) {
      log("UPDATE OFFER RADIUS Error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: GET MERCHANT WITHIN RADIUS 2
  //
  //

  Future<Either<Failure, List<GetMerchantWithinRadius2ResponseDto>>>
      getMerchantWithinRadius2(
          double lat, double lng, int radius, int categoryid) async {
    try {
      final result = await _datasource.get(
          '${ApiConstants.getMerchantWithinRadius2}latitude=$lat&longitude=$lng&radius=$radius&category_id=$categoryid');
      return result.fold(
        (l) => Left(l),
        (r) {
          var responseDto = BaseResponseDto.fromJson(
            r.data,
            (data) => data is List
                ? data
                    .map((e) => GetMerchantWithinRadius2ResponseDto.fromMap(e))
                    .toList()
                : <GetMerchantWithinRadius2ResponseDto>[],
          ).data;
          return Right(responseDto!);
        },
      );
    } catch (e) {
      log("GET MERCHANT WITHIN RADIUS 2 Error: $e");
      return Left(handleError(e));
    }
  }

  //
  // MARK: GENERATE ORDER
  //
  Future<Either<Failure, String>> generateOrder(
      GenerateOrderRequestDto dto) async {
    try {
      // log('in map dto: ${dto.toMap()}');
      // log('${jsonEncode(dto.toMap())}');
      final result = await _datasource.post2(ApiConstants.generateOrder,
          data: jsonEncode(dto.toMap())
          // data: dto.toMap(),
          );

      return result.fold(
        (l) => Left(l),
        (r) {
          var responseDto = BaseResponseDto.fromJson(
            r.data,
            (data) =>
                data['message'] is String ? data['message'] as String : '',
          ).message;

          if (responseDto.isNotEmpty) {
            return Right(responseDto);
          } else {
            return Left(Failure(StringConstants.somethingWentWrong));
          }
        },
      );
    } catch (e) {
      log("GENERATE ORDER Error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: CANCEL WORK ORDER
  //
  //

  Future<Either<Failure, String>> cancelWorkOrder(
      int orderId, int customerId) async {
    try {
      final result = await _datasource.put(
        ApiConstants.cancelCustomerConfirmedRequest,
        data: {'order_id': orderId, 'customer_id': customerId},
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
    } catch (e) {
      log("CANCEL WORK ORDER Error: $e");
      return Left(handleError(e));
    }
  }
}
