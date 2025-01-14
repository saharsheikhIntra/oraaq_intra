// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:oraaq/src/core/enum/user_type.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';
import 'package:oraaq/src/imports.dart';

class LoginResponseDto {
  final dynamic user;
  final String token;
  LoginResponseDto({
    required this.user,
    required this.token,
  });

  // UserType currentType = getIt.get<UserType>();

  factory LoginResponseDto.fromMap(Map<String, dynamic> map) {
    log('is otp lrd: ${map['user']['is_otp_verified']}');
    return LoginResponseDto(
      user: getIt.get<UserType>() != UserType.merchant
          ? map['user'] != null
              ? LoginResponseConsumerDto.fromMap(map['user'])
              : LoginResponseConsumerDto(customerId: -1)
          : map['user'] != null
              ? LoginResponseUserDto.fromMap(map['user'])
              : LoginResponseUserDto(),
      token: map['token'] != null ? map['token'] as String : "",
    );
  }
}

abstract class LoginResponseGeneralDto {
  UserEntity get toUserEntity;
}

class LoginResponseUserDto {
  final int merchantId;
  final int merchantUserId;
  final String merchantName;
  final String email;
  final String merchantNumber;
  final String isActive;
  final String? cnic;
  final String phone;
  final double latitude;
  final double longitude;
  // final String latitude;
  // final String longitude;
  final String? offDays;
  final String openingTime;
  final String closingTime;
  final int? serviceType;
  final String isOtpVerified;
  final String isSocial;

  LoginResponseUserDto({
    this.merchantId = -1,
    this.merchantUserId = -1,
    this.merchantName = "",
    this.email = "",
    this.merchantNumber = "",
    this.isActive = "N",
    this.cnic = "",
    this.phone = "",
    this.latitude = 0.0,
    this.longitude = 0.0,
    // this.latitude = "",
    // this.longitude = "",
    this.offDays = "",
    this.openingTime = "",
    this.closingTime = "",
    this.serviceType = -1,
    this.isOtpVerified = "N",
    this.isSocial = "N",
  });

  factory LoginResponseUserDto.fromMap(Map<String, dynamic> map) {
    return LoginResponseUserDto(
      merchantId: map['merchant_id'] != null ? map['merchant_id'] as int : -1,
      merchantUserId: map['merchant_user_id'] is int
          ? map['merchant_user_id'] as int
          : int.parse(map['merchant_user_id']),
      merchantName:
          map['merchant_name'] != null ? map['merchant_name'] as String : "",
      email: map['email'] != null ? map['email'] as String : "",
      merchantNumber: map['merchant_number'] != null
          ? map['merchant_number'] as String
          : "",
      isActive: map['is_active'] != null ? map['is_active'] as String : "",
      cnic: map['cnic'] != null ? map['cnic'] as String : "",
      phone: map['phone'] != null ? map['phone'] as String : "",
      latitude: map['latitude'] != null ? map['latitude'] as double : 0.0,
      longitude: map['longitude'] != null ? map['longitude'] as double : 0.0,
      offDays: map['off_days'] != null ? map['off_days'] as String : "",
      openingTime:
          map['opening_time'] != null ? map['opening_time'] as String : "",
      closingTime:
          map['closing_time'] != null ? map['closing_time'] as String : "",
      serviceType:
          map['service_type'] != null ? map['service_type'] as int : -1,
      isOtpVerified: map['is_otp_verified'] != null
          ? map['is_otp_verified'] as String
          : "",
      isSocial: map['is_social'] != null ? map['is_social'] as String : "",

      // id: map['id'] != null ? map['id'] as int : -1,
      // name: map['name'] != null ? map['name'] as String : "",
      // email: map['email'] != null ? map['email'] as String : "",
      // phone: map['phone'] != null ? map['phone'] as String : "",
      // role: map['role'] != null ? map['role'] as String : "",
      // serviceType: map['service_type'] != null ? map['service_type'] as int : -1,
      // cnicNtn: map['cnic_ntn'] != null ? map['cnic_ntn'] as String : "",
      // openingTime: map['opening_time'] != null ? map['opening_time'] as String : "",
      // closingTime: map['closing_time'] != null ? map['closing_time'] as String : "",
      // holidays: map['holidays'] != null ? map['holidays'] as String : "",
      // latitude: map['latitude'] != null ? map['latitude'] as String : "",
      // longitude: map['longitude'] != null ? map['longitude'] as String : "",
    );
  }

  @override
  String toString() {
    return 'LoginResponseUserDto(merchantId: $merchantId, merchantUserId: $merchantUserId, merchantName: $merchantName, email: $email, merchantNumber: $merchantNumber, isActive: $isActive, cnic: $cnic, phone: $phone, latitude: $latitude, longitude: $longitude, offDays: $offDays, openingTime: $openingTime, closingTime: $closingTime, serviceType: $serviceType, isOtpVerified: $isOtpVerified, isSocial: $isSocial)';
  }

  UserEntity get toUserEntity {
    //print(this);
    return UserEntity(
      id: merchantId,
      userId: merchantUserId,
      name: merchantName,
      email: email,
      phone: phone,
      role: UserType.values.firstWhere(
        (e) => e.value.toLowerCase() == 'merchant',
        orElse: () => UserType.customer,
      ),
      serviceType: serviceType ?? -1,
      cnicNtn: cnic ?? "",
      openingTime: openingTime,
      closingTime: closingTime,
      holidays: offDays ?? "",
      latitude: latitude.toString(),
      longitude: longitude.toString(),
      isOtpVerified: isOtpVerified,
      isSocial: isSocial,
      token: "",
    );
  }
}

class LoginResponseConsumerDto {
  final int? customerUserId;
  final int? customerId;
  final String? name;
  final String? source;
  final String? phoneNumber;
  final String? email;
  final String? isActive;
  final String? emergencyNo;
  final String? latitude;
  final String? longitude;
  final String? isOtpVerified;
  final String? isSocial;
  LoginResponseConsumerDto(
      {this.customerId,
      this.customerUserId,
      this.name,
      this.source,
      this.phoneNumber,
      this.email,
      this.isActive,
      this.emergencyNo,
      this.latitude,
      this.longitude,
      this.isOtpVerified = 'N',
      this.isSocial});

  factory LoginResponseConsumerDto.fromMap(Map<String, dynamic> map) {
    return LoginResponseConsumerDto(
      customerUserId: map['customer_user_id'] is int
          ? map['customer_user_id'] as int
          : int.parse(map['customer_user_id']),
      customerId: map['customer_id'] as int,
      name:
          map['customer_name'] != null ? map['customer_name'] as String : null,
      // source: map['source'] != null ? map['source'] as String : null,
      phoneNumber: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      isActive: map['is_active'] != null ? map['is_active'] as String : null,
      // emergencyNo:
      //     map['emergency_no'] != null ? map['emergency_no'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'].toString() : null,
      longitude: map['longitude'] != null ? map['longitude'].toString() : null,
      isOtpVerified: map['is_otp_verified'] != null
          ? map['is_otp_verified'] as String
          : "",
      isSocial: map['is_social'] != null ? map['is_social'] as String : "",
    );
  }

  UserEntity get toUserEntity {
    return UserEntity(
      id: customerId ?? -1,
      userId: customerUserId ?? -1,
      name: name ?? "",
      email: email ?? "",
      phone: phoneNumber ?? "",
      role: UserType.customer,
      serviceType: -1,
      cnicNtn: "",
      token: "",
      openingTime: "",
      closingTime: "",
      holidays: "",
      latitude: latitude ?? "",
      longitude: longitude ?? "",
      isOtpVerified: isOtpVerified ?? "",
      isSocial: isSocial ?? "",
    );
  }
}
