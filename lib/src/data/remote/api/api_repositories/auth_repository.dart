import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:oraaq/src/core/constants/string_constants.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/change_password.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/customer_flow/update_customer_request_dto.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/forget_password_dto.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/set_new_password.dart';
import 'package:oraaq/src/data/remote/api/api_request_dtos/general_flow/social_login_dto.dart';

import 'package:oraaq/src/data/remote/api/api_request_dtos/merchant_flow/update_merchant_profile_request_dto.dart';
import 'package:oraaq/src/data/remote/api/api_response_dtos/general_flow/change_password_response_dto.dart';
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
    var result = await _datasource.post(ApiConstants.getToken);
    return result.fold(
      (l) => Left(l),
      (r) => Right(GetTokenResponseDto.fromMap(r.data).access),
    );
  }

  //
  //
  // MARK: LOGIN
  //
  //

  Future<Either<Failure, LoginResponseDto>> login(
    LoginRequestDto dto,
  ) async {
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
  }

  //
  //
  // MARK: LOGIN social
  //
  //

  Future<Either<Failure, LoginResponseDto>> loginViaSocial(
    SocialLoginRequestDto dto,
  ) async {
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
  }

  //
  //
  // MARK: REGISTER
  //
  //

  Future<Either<Failure, RegisterResponseDto>> register(
    RegisterRequestDto dto,
  ) async {
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
  }

  //
  //
  // MARK: GENERATE OTP
  //
  //
  Future<Either<Failure, GenerateOtpResponseDto>> generateOtp(
      int userId) async {
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
  }
  //
  //
  // MARK: VERIFY OTP
  //
  //

  Future<Either<Failure, VerifyOtpResponseDto>> verifyOtp(
      int userId, int otp) async {
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
  }

  //
  //
  // MARK: CHANGE PASSWORD
  //
  //
  Future<Either<Failure, String>> changePassword(
      ChangePasswordRequestDto dto) async {
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
  }

  //
  //
  // MARK: SET NEW PASSWORD
  //
  //
  Future<Either<Failure, String>> setNewPassword(
      SetNewPasswordRequestDto dto) async {
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
    Either<Failure, Response> result = await _datasource.put(
      ApiConstants.updateMerchantProfile,
      data: dto.toMap(),
    );
    print("Raw response: ${result.fold((l) => l, (r) => r.data)}");

    return result.fold(
      (l) => Left(l),
      (r) {
        print("Raw response: ${result.fold((l) => l, (r) => r.data)}");

        var res = BaseResponseDto.fromJson(
          r.data,
          (data) => UpdateMerchantProfileResponseDto.fromMap(data),
        ).data;
        if (res == null) Left(Failure(StringConstants.somethingWentWrong));
        return Right(res!);
        //return Right(BaseResponseDto.fromJson(r.data, (data) => data).data!);
      },
    );
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
    Either<Failure, Response> result = await _datasource.put(
      ApiConstants.updateCustomerProfile,
      data: dto.toMap(),
    );
    print("Raw response: ${result.fold((l) => l, (r) => r.data)}");

    return result.fold(
      (l) => Left(l),
      (r) {
        print("Raw response: ${result.fold((l) => l, (r) => r.data)}");

        var res = BaseResponseDto.fromJson(
          r.data,
          (data) => UpdateCustomerProfileResponseDto.fromMap(data),
        ).data;
        if (res == null) Left(Failure(StringConstants.somethingWentWrong));
        return Right(res!);
      },
    );
  }

  //
  //
  // MARK: FORGET PASSWORD
  //
  //
  Future<Either<Failure, ForgetPasswordResponseDto>> forgetPassword(
      ForgetPasswordRequestDto dto) async {
    final result =
        await _datasource.put(ApiConstants.forgetPassword, data: dto.toMap());
    return result.fold((l) => left(l), (r) {
      var responseDto = ForgetPasswordResponseDto.fromMap(r.data);
      return right(responseDto);
    });
  }

  //
  //
  // MARK: LOGOUT
  //
  //

  logout() {}
  resendOtp() {}
}
