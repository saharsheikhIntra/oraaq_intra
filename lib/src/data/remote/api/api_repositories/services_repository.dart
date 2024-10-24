import 'package:dartz/dartz.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/get_merchant_radius.dart';
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
}
