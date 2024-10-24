import 'package:dartz/dartz.dart';
import 'package:oraaq/src/core/enum/request_status_enum.dart';
import 'package:oraaq/src/data/remote/api/api_repositories/job_management_repository.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/add_rating.dart';
import 'package:oraaq/src/domain/entities/request_entity.dart';

import '../../data/remote/api/api_request_dtos/merchant_flow/post_bid_request_dto.dart';
import '../../data/remote/api/api_response_dtos/merchant_flow/applied_jobs_response_dto.dart';
import '../../data/remote/api/api_response_dtos/merchant_flow/get_all_new_response_dto.dart';
import '../entities/category_entity.dart';
import '../entities/failure.dart';

class JobManagementService {
  final JobManagementRepository _jobsRepository;
  JobManagementService(this._jobsRepository);

  //
  // MARK: GET CATEGORY
  //

  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    var result = await _jobsRepository.getCategories();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r.map((e) => e.toCategoryEntity).toList()),
    );
  }

  //
  //
  // MARK: GET COMPLETED ORDERS
  //
  //

  Future<Either<Failure, List<RequestEntity>>>
      getCompletedWorkOrdersForMerchant(int merchantId) async {
    var result =
        await _jobsRepository.getCompletedWorkOrdersForMerchant(merchantId);
    return result.fold(
      (l) => Left(l),
      (r) async {
        var entities = r
            .map((e) => RequestEntity(
                  workOrderId: e.workOrderId,
                  requestId: e.requestId,
                  serviceRequestId: e.serviceRequestId,
                  serviceNames: e.serviceNames,
                  customerId: e.customerId,
                  customerName: e.customerName,
                  customerContactNumber: e.customerContactNumber,
                  customerEmail: e.customerEmail,
                  latitude: e.latitude,
                  longitude: e.longitude,
                  requestDate:
                      DateTime.tryParse(e.requestDate) ?? DateTime.now(),
                  status: RequestStatusEnum.completed,
                  bidId: e.bidId,
                  bidAmount: e.bidAmount,
                  rating: e.rating,
                  bidDate: DateTime.tryParse(e.bidDate) ?? DateTime.now(),
                ))
            .toList();
        return Right(entities);
      },
    );
  }

  //
  //
  // MARK: CANCEL-WORK-ORDER
  //
  //

  Future<Either<Failure, List<RequestEntity>>> getCanceledWorkOrdersForMerchant(
      int merchantId) async {
    var result =
        await _jobsRepository.getCanceledWorkOrdersForMerchant(merchantId);
    return result.fold(
      (l) => Left(l),
      (r) async {
        var entities = r
            .map((e) => RequestEntity(
                  workOrderId: e.workOrderId,
                  requestId: e.requestId,
                  serviceRequestId: e.serviceRequestId,
                  serviceNames:
                      e.serviceNames, // This will be a list of service names
                  customerId: e.customerId,
                  customerName: e.customerName,
                  customerContactNumber: e.customerContactNumber,
                  customerEmail: e.customerEmail,
                  latitude: e.latitude,
                  longitude: e.longitude,
                  requestDate:
                      DateTime.tryParse(e.requestDate) ?? DateTime.now(),
                  status: RequestStatusEnum
                      .cancelled, // Assuming this is for cancelled orders
                  bidId: e.bidId,
                  bidAmount: e.bidAmount,
                  rating: e.rating,
                  bidDate: DateTime.tryParse(e.bidDate) ?? DateTime.now(),
                ))
            .toList();
        return Right(entities);
      },
    );
  }

  //
  //
  // MARK: GET APPLIED JOBS
  //
  //

  Future<Either<Failure, List<RequestEntity>>> getAppliedJobsForMerchant(
      int merchantId) async {
    var result = await _jobsRepository.getAppliedJobsForMerchant(merchantId);
    return result.fold(
      (l) => Left(l),
      (r) async {
        var entities = r
            .map((e) => RequestEntity(
                  workOrderId: e.workOrderId,
                  requestId: e.requestId,
                  serviceRequestId: e.serviceRequestId,
                  serviceNames:
                      e.serviceNames, // This will be a list of service names
                  customerId: e.customerId,
                  customerName: e.customerName,
                  customerContactNumber: e.customerContactNumber,
                  customerEmail: e.customerEmail,
                  latitude: e.latitude,
                  longitude: e.longitude,
                  requestDate:
                      DateTime.tryParse(e.requestDate) ?? DateTime.now(),
                  status: RequestStatusEnum
                      .pending, // Assuming this is for cancelled orders
                  bidId: e.bidId,
                  bidAmount: e.bidAmount,
                  rating: e.rating,
                  bidDate: DateTime.tryParse(e.bidDate) ?? DateTime.now(),
                ))
            .toList();
        return Right(entities);
      },
    );
  }

  //
  //
  // MARK: MERCHANT WORK IN PROGRESS
  //
  //
  Future<Either<Failure, List<RequestEntity>>>
      getWorkInProgressOrdersForMerchant(int merchantId) async {
    var result =
        await _jobsRepository.getWorkInProgressOrdersForMerchant(merchantId);
    return result.fold((l) => Left(l), (r) async {
      var entities = r
          .map((e) => RequestEntity(
                workOrderId: e.workOrderId,
                requestId: e.requestId,
                serviceRequestId: e.serviceRequestId,
                serviceNames: e.serviceNames,
                customerId: e.customerId,
                customerName: e.customerName,
                customerContactNumber: e.customerContactNumber,
                customerEmail: e.customerEmail,
                distance: e.distance,
                requestDate: DateTime.tryParse(e.requestDate) ?? DateTime.now(),
                status: RequestStatusEnum.inProgress,
                bidId: e.bidId,
                bidAmount: e.bidAmount,
                bidDate: DateTime.tryParse(e.bidDate) ?? DateTime.now(),
              ))
          .toList();
      return Right(entities);
    });
  }

  //
  // MARK: GET ALL SERVICE REQUESTS
  //
  Future<Either<Failure, List<NewServiceRequestResponseDto>>>
      getAllServiceRequests(int merchantId) async {
    var result = await _jobsRepository.getAllServiceRequests(merchantId);
    return result.fold(
      (l) => Left(l),
      (r) async {
        return Right(r);
      },
    );
  }

  //
  //
  // MARK: CANCEL WORK ORDER
  //
  //
  Future<Either<Failure, String>> cancelWorkOrder(
      int workOrderId, int merchantId) async {
    var result = await _jobsRepository.cancelWorkOrder(workOrderId, merchantId);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  //
  //
  // MARK: POST BID
  //
  //

  Future<Either<Failure, String>> postBid(PostBidRequestDto bidRequest) async {
    return await _jobsRepository.postBid(bidRequest);
  }

  //
  //
  // MARK: ADD RATINGS
  //
  //
  Future<Either<Failure, String>> addRating(
      AddRatingRequestDto ratingRequest) async {
    return await _jobsRepository.addRating(ratingRequest);
  }
}
