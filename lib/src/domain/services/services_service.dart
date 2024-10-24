import 'package:dartz/dartz.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/get_merchant_radius.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/get_all_bids.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/get_merchant_radius_respomse_dto.dart';
import 'package:oraaq/src/domain/entities/failure.dart';
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
}
