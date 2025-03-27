import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';
import 'package:oraaq/src/core/utils/error_util.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/change_password.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/update_customer_request_dto.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/forget_password_dto.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/set_new_password.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/social_login_dto.dart';

import 'package:oraaq/src/data/remote/api/api_request_dtos/merchant_flow/update_merchant_profile_request_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/forget_password_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/generate_otp.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/get_token_response_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/register_response_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/verify_otp.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/customer_flow/update_customer_profile_response_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/merchant_flow/update_merchant_profile_response_dto.dart';

import '../../../../domain/entities/failure.dart';
import '../api_constants.dart';
import '../api_datasource.dart';
import '../api_request_dtos/general_flow/login_request_dto.dart';
import '../api_request_dtos/general_flow/register_request_dto.dart';
import '../api_response_dtos/general_flow/base_response_dto.dart';
import '../api_response_dtos/general_flow/login_response_dto.dart';

class ApiAuthRepository {
  final ApiDatasource _datasource;
  ApiAuthRepository(this._datasource);

  //
  //
  // MARK: GET TOKEN
  //
  //

  Future<Either<Failure, String>> getToken() async {
    try {
      var result = await _datasource.post(ApiConstants.getToken);
      return result.fold(
        (l) => Left(l),
        (r) => Right(GetTokenResponseDto.fromMap(r.data).access),
      );
    } catch (e) {
      log("Get Token error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: LOGIN
  //
  //

  Future<Either<Failure, LoginResponseDto>> login(
    LoginRequestDto dto,
  ) async {
    try {
      Either<Failure, Response> result = await _datasource.post(
        ApiConstants.login,
        data: dto.toMap(),
      );
      return result.fold(
        (l) => Left(l),
        (r) {
          var res = BaseResponseDto.fromJson(
            r.data,
            (data) => LoginResponseDto.fromMap(data),
          ).data;

          if (res == null) Left(Failure(StringConstants.somethingWentWrong));
          return Right(res!);
        },
      );
    } catch (e) {
      log("Login error: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: LOGIN social
  //
  //

  Future<Either<Failure, LoginResponseDto>> loginViaSocial(
    SocialLoginRequestDto dto,
  ) async {
    try {
      Either<Failure, Response> result = await _datasource.post(
        ApiConstants.loginViaSocial,
        data: dto.toMap(),
      );
      return result.fold(
        (l) => Left(l),
        (r) {
          var res = BaseResponseDto.fromJson(
            r.data,
            (data) => LoginResponseDto.fromMap(data),
          ).data;
          if (res == null) Left(Failure(StringConstants.somethingWentWrong));
          return Right(res!);
        },
      );
    } catch (e) {
      log("Login with Social: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: REGISTER
  //
  //

  Future<Either<Failure, RegisterResponseDto>> register(
    RegisterRequestDto dto,
  ) async {
    try {
      Either<Failure, Response> result = await _datasource.post(
        ApiConstants.register,
        data: dto.toMap(),
      );
      return result.fold(
        (l) => Left(l),
        (r) {
          var res = BaseResponseDto.fromJson(
            r.data,
            (data) => RegisterResponseDto.fromMap(data),
          ).data;
          if (res == null) {
            Left(Failure(StringConstants.somethingWentWrong));
          }
          return Right(res!);
        },
      );
    } catch (e) {
      log("Register: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: GENERATE OTP
  //
  //
  Future<Either<Failure, GenerateOtpResponseDto>> generateOtp(
      int userId) async {
    try {
      final result = await _datasource.get(
        "${ApiConstants.generateOtp}?user_id=$userId",
      );

      return result.fold(
        (l) => Left(l),
        (r) {
          var responseDto = GenerateOtpResponseDto.fromMap(r.data);
          return Right(responseDto);
        },
      );
    } catch (e) {
      log("Generate OTP: $e");
      return Left(handleError(e));
    }
  }
  //
  //
  // MARK: VERIFY OTP
  //
  //

  Future<Either<Failure, VerifyOtpResponseDto>> verifyOtp(
      int userId, int otp) async {
    try {
      final result = await _datasource.get(
        "${ApiConstants.verifyOtp}?user_id=$userId&otp_value=$otp",
      );

      return result.fold(
        (l) => Left(l),
        (r) {
          var responseDto = VerifyOtpResponseDto.fromMap(r.data);
          return Right(responseDto);
        },
      );
    } catch (e) {
      log("Verify OTP: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: CHANGE PASSWORD
  //
  //
  Future<Either<Failure, String>> changePassword(
      ChangePasswordRequestDto dto) async {
    try {
      final result = await _datasource.put(
        ApiConstants.changePassword,
        data: dto.toMap(),
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
      log("Change Password: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: SET NEW PASSWORD
  //
  //
  Future<Either<Failure, String>> setNewPassword(
      SetNewPasswordRequestDto dto) async {
    try {
      final result = await _datasource.put(
        ApiConstants.setNewPassword,
        data: dto.toMap(),
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
      log("Set New Password: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: UPDATE MERCHANT PROFILE
  //
  //
  // Future<Either<Failure, UpdateMerchantProfileResponseDto>> updateMerchantProfile(
  Future<Either<Failure, UpdateMerchantProfileResponseDto>>
      updateMerchantProfile(
    UpdateMerchantProfileRequestDto dto,
  ) async {
    try {
      Either<Failure, Response> result = await _datasource.put(
        ApiConstants.updateMerchantProfile,
        data: dto.toMap(),
      );
      debugPrint("Raw response: ${result.fold((l) => l, (r) => r.data)}");

      return result.fold(
        (l) => Left(l),
        (r) {
          debugPrint("Raw response: ${result.fold((l) => l, (r) => r.data)}");

          var res = BaseResponseDto.fromJson(
            r.data,
            (data) => UpdateMerchantProfileResponseDto.fromMap(data),
          ).data;
          if (res == null) Left(Failure(StringConstants.somethingWentWrong));
          return Right(res!);
          //return Right(BaseResponseDto.fromJson(r.data, (data) => data).data!);
        },
      );
    } catch (e) {
      log("Update Merchant Profile: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: UPDATE CUSTOMER PROFILE
  //
  //

  // Future<Either<Failure, UpdateMerchantProfileResponseDto>> updateMerchantProfile(
  Future<Either<Failure, UpdateCustomerProfileResponseDto>>
      updateCustomerProfile(
    UpdateCustomerRequestDto dto,
  ) async {
    try {
      Either<Failure, Response> result = await _datasource.put(
        ApiConstants.updateCustomerProfile,
        data: dto.toMap(),
      );
      debugPrint("Raw response: ${result.fold((l) => l, (r) => r.data)}");

      return result.fold(
        (l) => Left(l),
        (r) {
          debugPrint("Raw response: ${result.fold((l) => l, (r) => r.data)}");

          var res = BaseResponseDto.fromJson(
            r.data,
            (data) => UpdateCustomerProfileResponseDto.fromMap(data),
          ).data;
          if (res == null) Left(Failure(StringConstants.somethingWentWrong));
          return Right(res!);
        },
      );
    } catch (e) {
      log("UPDATE CUSTOMER PROFILE: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: FORGET PASSWORD
  //
  //
  Future<Either<Failure, ForgetPasswordResponseDto>> forgetPassword(
      ForgetPasswordRequestDto dto) async {
    try {
      final result = await _datasource.post(ApiConstants.forgetPassword,
          data: dto.toMap());
      return result.fold((l) => left(l), (r) {
        var responseDto = BaseResponseDto.fromJson(
            r.data, (data) => ForgetPasswordResponseDto.fromMap(data)).data;
        if (responseDto == null)
          Left(Failure(StringConstants.somethingWentWrong));
        // ForgetPasswordResponseDto.fromMap(r.data);
        return right(responseDto!);
      });
    } catch (e) {
      log("Forget Password: $e");
      return Left(handleError(e));
    }
  }

  //
  //
  // MARK: LOGOUT
  //
  //

  logout() {}
  resendOtp() {}
}
