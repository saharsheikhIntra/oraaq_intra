import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/add_rating.dart';

import 'package:oraaq/src/data/remote/api/api_response_dtos/merchant_flow/get_all_new_response_dto.dart';

import '../../../../domain/entities/failure.dart';
import '../api_constants.dart';
import '../api_datasource.dart';
import '../api_request_dtos/merchant_flow/post_bid_request_dto.dart';
import '../api_response_dtos/merchant_flow/applied_jobs_response_dto.dart';
import '../api_response_dtos/general_flow/base_response_dto.dart';
import '../api_response_dtos/merchant_flow/cancel_work_order_dto.dart';
import '../api_response_dtos/merchant_flow/category_response_dto.dart';
import '../api_response_dtos/merchant_flow/merchant_completed_order_response_dto.dart';
import '../api_response_dtos/merchant_flow/merchant_work_inprogress_dto.dart';

class JobManagementRepository {
  final ApiDatasource _datasource;
  JobManagementRepository(this._datasource);

  //
  //
  // MARK: GET CATEGORY
  //
  //

  Future<Either<Failure, List<CategoryResponseDto>>> getCategories() async {
    try {
      final result = await _datasource.get(ApiConstants.getAllCategories);
      return result.fold(
          (l) => Left(l),
          (r) => Right(
                BaseResponseDto.fromJson(
                      r.data,
                      (data) => data['categories'] is List
                          ? (data['categories'] as List)
                              .map((e) => CategoryResponseDto.fromMap(e))
                              .toList()
                          : null,
                    ).data ??
                    [],

                //     r.data,
                //     (data) =>
                //     data is List
                //         ? data
                //             .map(
                //               (e) => CategoryResponseDto.fromMap(e),
                //             )
                //             .toList()
                //         : null).data ??
                // [],
              ));
    } catch (e) {
      return Left(Failure('Failed to fetch categories: $e'));
    }
  }

  //
  //
  // MARK: COMPLETED WORK ORDER
  //
  //

  Future<Either<Failure, List<CompletedWorkOrderResponseMerchantDto>>>
      getCompletedWorkOrdersForMerchant(int merchantId) async {
    final result = await _datasource.get(
        "${ApiConstants.getCompletedWorkOrderMerchant}merchant_id=$merchantId&order_status_id=3");
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data,
          (data) => data is List
              ? data
                  .map((e) => CompletedWorkOrderResponseMerchantDto.fromMap(e))
                  .toList()
              : <CompletedWorkOrderResponseMerchantDto>[],
        ).data;
        return Right(responseDto!);
      },
    );
  }

  //
  //
  // MARK: CANCELLED WORK ORDER
  //
  //

  Future<Either<Failure, List<CancelWorkOrderResponseDto>>>
      getCanceledWorkOrdersForMerchant(int merchantId) async {
    final result = await _datasource.get(
      "${ApiConstants.getCanceledWorkOrdersForMerchant}merchant_id=$merchantId&order_status_id=2",
    );
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data,
          (data) => data is List
              ? data.map((e) => CancelWorkOrderResponseDto.fromMap(e)).toList()
              : <CancelWorkOrderResponseDto>[],
        ).data;
        return Right(responseDto!);
      },
    );
  }

  //
  //
  // MARK: GET APPLIED JOBS
  //
  //

  Future<Either<Failure, List<AppliedJobsResponseDto>>>
      getAppliedJobsForMerchant(int merchantId) async {
    // final result = await _datasource.get(
    //     "${ApiConstants.getAppliedJobsForMerchant}merchant_id=$merchantId&order_status_id=22");
    final result = await _datasource.get(
        "${ApiConstants.getAppliedJobsNew}merchant_id=$merchantId");
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
            r.data,
            (data) => data is List
                ? data.map((e) => AppliedJobsResponseDto.fromMap(e)).toList()
                : <AppliedJobsResponseDto>[]).data;
        return Right(responseDto!);
      },
    );
  }

  //
  //
  // MARK: MERCHANT WORK IN PROGRESS
  //
  //

  Future<Either<Failure, List<InProgressWorkOrderResponseDto>>>
      getWorkInProgressOrdersForMerchant(int merchantId) async {
    final result = await _datasource
        .get("${ApiConstants.getWorkInProgressOrdersForMerchant}$merchantId");
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
          r.data,
          (data) => data is List
              ? data
                  .map((e) => InProgressWorkOrderResponseDto.fromMap(e))
                  .toList()
              : <InProgressWorkOrderResponseDto>[],
        ).data;
        return Right(responseDto!);
      },
    );
  }

  //
  // MARK: GET ALL SERVICE REQUESTS
  //

  Future<Either<Failure, List<NewServiceRequestResponseDto>>>
      getAllServiceRequests(int merchantId) async {
    final result = await _datasource
        .get("${ApiConstants.getAllServiceRequests}$merchantId");
    return result.fold(
      (l) => Left(l),
      (r) {
        var responseDto = BaseResponseDto.fromJson(
            r.data,
            (data) => data is List
                ? data
                    .map((e) => NewServiceRequestResponseDto.fromMap(e))
                    .toList()
                : <NewServiceRequestResponseDto>[]).data;
        return Right(responseDto!);
      },
    );
  }

  //
  // MARK: GET SERVICE REQUESTS
  //

  Future<Either<Failure, List<NewServiceRequestResponseDto>>>
      getServiceRequests(int merchantId) async {
    final result = await _datasource
        .get("${ApiConstants.getAllRequests}$merchantId");
    return result.fold(
      (l) { 
        return Left(l);
      },
      (r) {
        var responseDto = BaseResponseDto.fromJson(
            r.data,
            (data) => data is List
                ? data
                    .map((e) => NewServiceRequestResponseDto.fromMap(e))
                    .toList()
                : <NewServiceRequestResponseDto>[]).data;
        log('3 $responseDto');
        return Right(responseDto!);
      },
    );
  }

  //
  //
  // MARK: CANCEL WORK ORDER
  //
  //

  Future<Either<Failure, String>> cancelWorkOrder(
      int biddingId, int merchantId) async {
    final result = await _datasource.put(
      "${ApiConstants.cancelMerchantWorkOrder}bidding_id=$biddingId&merchant_id=$merchantId&order_status_id=2",
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
  // MARK: COMPLETE WORK ORDER
  //
  //

  Future<Either<Failure, String>> completeWorkOrder(
      int biddingId, int merchantId) async {
    final result = await _datasource.put(
      "${ApiConstants.cancelMerchantWorkOrder}bidding_id=$biddingId&merchant_id=$merchantId&order_status_id=3",
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
  // MARK: POST BID
  //
  //
  Future<Either<Failure, String>> postBid(PostBidRequestDto bidRequest) async {
    final result = await _datasource.post(
      ApiConstants.postBid,
      data: bidRequest.toMap(),
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
  // MARK: ADD RATINGS
  //

  Future<Either<Failure, String>> addRating(
      AddRatingRequestDto ratingRequest) async {
    final result = await _datasource.post(
      ApiConstants.addRating,
      data: ratingRequest.toMap(),
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
  // MARK: GET ALL NEW REQUESTS
  //

  Future<Either<Failure, List<NewServiceRequestResponseDto>>> getAllNewRequests(
      int merchantId) async {
    final result = await _datasource
        .get("${ApiConstants.getAllServiceRequests}$merchantId");
    log('1 $result');
    return result.fold(
      (l) => Left(l),
      (r) {
        log('2 $r');
        var responseDto = BaseResponseDto.fromJson(
            r.data,
            (data) => data is List
                ? data
                    .map((e) => NewServiceRequestResponseDto.fromMap(e))
                    .toList()
                : <NewServiceRequestResponseDto>[]).data;
        return Right(responseDto!);
      },
    );
  }

  //
  //
  // MARK: CANCEL WORK ORDER FROM MERCHANT APPLIED REQUESTS
  //
  //

  Future<Either<Failure, String>> cancelWorkOrderFromMerchantAppliedRequests(
      int biddingId, int merchantId) async {
    final result = await _datasource.put(
      "${ApiConstants.cancelMerchantWorkOrderForAppliedRequests}bid_id=$biddingId&merchant_id=$merchantId",
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

}


