import 'package:dartz/dartz.dart';
import 'package:oraaq/src/core/enum/request_status_enum.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/get_merchant_radius.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/accpted_request_response_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/customer_new_request_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/get_all_bids.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/get_merchant_radius_respomse_dto.dart';
import 'package:oraaq/src/domain/entities/failure.dart';
import 'package:oraaq/src/domain/entities/request_entity.dart';
import 'package:oraaq/src/domain/entities/service_entity.dart';

import '../../core/constants/string_constants.dart';
import '../../data/remote/api/api_repositories/services_repository.dart';

class ServicesService {
  final ServicesRepository _servicesRepository;
  ServicesService(this._servicesRepository);

  //

  Map<int, List<ServiceEntity>> servicesByCategoryid = {};

  //

  Future<Either<Failure, List<ServiceEntity>>> getServices(int id) async {
    try {
      if (servicesByCategoryid[id] != null &&
          servicesByCategoryid[id]!.isNotEmpty) {
        return Right(servicesByCategoryid[id]!);
      }
      final result = await _servicesRepository.getServices(id);
      return result.fold(
        (l) => Left(l),
        (r) {
          servicesByCategoryid[id] = r.serviceGroup
              .map(
                (e) => e.toServiceEntity,
              )
              .toList();
          return Right(servicesByCategoryid[id]!);
        },
      );
    } catch (e) {
      return Left(Failure('${StringConstants.failedToFetchServices}: $e'));
    }
  }

  Future<Either<Failure, List<GetMerchantWithinRadiusResponseDto>>>
      getMerchantsWithinRadius(
    GetMerchantWithinRadiusRequestDto dto,
  ) async {
    try {
      final result = await _servicesRepository.getMerchantsWithinRadius(dto);
      return result.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } catch (e) {
      return Left(Failure('Failed to fetch merchants: $e'));
    }
  }

  //
  // MARK: GET BIDS ON SERVICE REQUEST
  //
  Future<Either<Failure, List<GetAllBidsResponseDto>>> getAllServiceRequests(
      int merchantId) async {
    var result =
        await _servicesRepository.getAllBidsForCutomerRequest(merchantId);
    return result.fold(
      (l) => Left(l),
      (r) async {
        return Right(r);
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
    var result = await _servicesRepository.getAcceptedRequests(customerId);
    return result.fold(
      (l) => Left(l),
      (r) async {
        return Right(r);
      },
    );
  }

  //
  //
  // MARK: CUSTOMER CANCEL-WORK-ORDER
  //
  //

  Future<Either<Failure, List<RequestEntity>>> getCanceledWorkOrdersForCustomer(
      int customerId) async {
    var result =
        await _servicesRepository.getCanceledWorkOrdersForCustomer(customerId);
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
                  customerId: e.merchantId,
                  customerName: e.merchantName,
                  customerContactNumber: '',
                  customerEmail: e.merchantEmail,
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
  // MARK: CUSTOMER COMPLETE-WORK-ORDER
  //
  //

  Future<Either<Failure, List<RequestEntity>>>
      getCompletedWorkOrdersForCustomer(int customerId) async {
    var result =
        await _servicesRepository.getCompletedWorkOrdersForCustomer(customerId);
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
                  customerId: e.merchantId,
                  customerName: e.merchantName,
                  customerContactNumber: e.merchantContactNumber,
                  customerEmail: e.merchantEmail,
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
  // MARK: CUSTOMER NEW REQUEST
  //
  //

  Future<Either<Failure, List<CustomerNewRequestDto>>> getCustomerNewRequests(
      int customerId) async {
    var result = await _servicesRepository.getCustomerNewRequests(customerId);
    return result.fold(
      (l) => Left(l),
      (r) async {
        var requests = r
            .map((e) => CustomerNewRequestDto(
                requestId: e.requestId,
                amount: e.amount,
                category: e.category,
                date: e.date,
                offersReceived: e.offersReceived))
            .toList();
        return Right(requests);
      },
    );
  }
}
