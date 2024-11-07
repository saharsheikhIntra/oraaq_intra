import 'package:oraaq/src/core/enum/user_type.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';

// class UpdateMerchantProfileResponseDto {
//   final UpdateMerchantProfileResponseUserDto user;

//   UpdateMerchantProfileResponseDto({
//     required this.user,
//   });

//   factory UpdateMerchantProfileResponseDto.fromMap(Map<String, dynamic> map) {
//     return UpdateMerchantProfileResponseDto(
//       user: map['user'] != null
//           ? UpdateMerchantProfileResponseUserDto.fromMap(map['user'])
//           : UpdateMerchantProfileResponseUserDto(),
//     );
//   }
// }

class UpdateMerchantProfileResponseDto {
  final int? merchantId; // UPDATED
  final int? merchantUserId; // NEW
  final String? merchantName;
  final String? email;
  final String? phone;
  final String? role;
  final int? serviceType;
  final String? cnicNtn;
  final String? openingTime;
  final String? closingTime;
  final String? holidays;
  final double? latitude; // UPDATED
  final double? longitude;
  final String? isVerified;

  UpdateMerchantProfileResponseDto({
    this.merchantId, // UPDATED
    this.merchantUserId, // NEW
    this.merchantName,
    this.email,
    this.phone,
    this.role,
    this.serviceType,
    this.cnicNtn,
    this.openingTime,
    this.closingTime,
    this.holidays,
    this.latitude, // UPDATED
    this.longitude,
    this.isVerified,
  });

  // factory UpdateMerchantProfileResponseDto.fromMap(Map<String, dynamic> map) {
  //   return UpdateMerchantProfileResponseDto(
  //     merchantId: map['merchant_id'] != null ? map['merchant_id'] as int : null,
  //     merchantUserId: map['merchant_user_id'] != null
  //         ? map['merchant_user_id'] as int
  //         : null,
  //     // id: map['merchant_id'] != null ? map['merchant_id'] as int : null,
  //     name:
  //         map['merchant_name'] != null ? map['merchant_name'] as String : null,
  //     email: map['email'] != null ? map['email'] as String : null,
  //     phone: map['merchant_number'] != null
  //         ? map['merchant_number'] as String
  //         : null,
  //     role: map['role'] != null ? map['role'] as String : null,
  //     serviceType:
  //         map['service_type'] != null ? map['service_type'] as int : null,
  //     cnicNtn: map['cnic'] != null ? map['cnic'] as String : null,
  //     openingTime:
  //         map['opening_time'] != null ? map['opening_time'] as String : null,
  //     closingTime:
  //         map['closing_time'] != null ? map['closing_time'] as String : null,
  //     holidays: map['off_days'] != null ? map['off_days'] as String : null,
  //     latitude: map['latitude'] != null ? map['latitude'] as String : null,
  //     longitude: map['longitude'] != null ? map['longitude'] as String : null,
  //   );
  // }

  // @override
  // String toString() {
  //   return 'UpdateMerchantProfileResponseUserDto(merchantId: $merchantId, merchantUserId: $merchantUserId, name: $name, email: $email, phone: $phone, role: $role, service_type: $serviceType, cnic_ntn: $cnicNtn, opening_time: $openingTime, closing_time: $closingTime, holidays: $holidays, latitude: $latitude, longitude: $longitude,)';
  // }

  factory UpdateMerchantProfileResponseDto.fromMap(Map<String, dynamic> map) {
    return UpdateMerchantProfileResponseDto(
      merchantId: map['merchant_id'] != null ? map['merchant_id'] as int : null,
      merchantUserId: map['merchant_user_id'] != null
          ? map['merchant_user_id'] as int
          : null, // NEW
      merchantName:
          map['merchant_name'] != null ? map['merchant_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['merchant_number'] != null
          ? map['merchant_number'] as String
          : null,
      role: map['role'] != null ? map['role'] as String : null,
      serviceType:
          map['service_type'] != null ? map['service_type'] as int : null,
      cnicNtn: map['cnic'] != null ? map['cnic'] as String : null,
      openingTime:
          map['opening_time'] != null ? map['opening_time'] as String : null,
      closingTime:
          map['closing_time'] != null ? map['closing_time'] as String : null,
      holidays: map['holidays'] != null ? map['holidays'] as String : null,

      latitude:
          map['latitude'] != null ? (map['latitude'] as num).toDouble() : null,
      longitude: map['longitude'] != null
          ? (map['longitude'] as num).toDouble()
          : null,
      isVerified: map['is_otp_verified'] != null
          ? map['is_otp_verified'] as String
          : null,
    );
  }
  @override
  String toString() {
    return 'UpdateMerchantProfileResponseDto(merchantId: $merchantId, merchantUserId: $merchantUserId, merchantName: $merchantName, email: $email, phone: $phone, role: $role, serviceType: $serviceType, cnicNtn: $cnicNtn, openingTime: $openingTime, closingTime: $closingTime, holidays: $holidays, latitude: $latitude, longitude: $longitude, isVerified: $isVerified)';
  }

  UserEntity copyUserEntity(UserEntity curr) {
    return UserEntity(
      id: merchantId ?? curr.id,
      userId: merchantUserId ?? curr.userId,
      name: merchantName ?? curr.name,
      email: email ?? curr.email,
      phone: phone ?? curr.phone,
      role: UserType.merchant,
      // UserType.values.firstWhere(
      //   (e) => e.title.toLowerCase() == role?.toLowerCase(),
      //   orElse: () => curr.role,
      // ),
      serviceType: serviceType ?? curr.serviceType,
      cnicNtn: cnicNtn ?? curr.cnicNtn,
      openingTime: openingTime ?? curr.openingTime,
      closingTime: closingTime ?? curr.closingTime,
      holidays: holidays ?? curr.holidays,
      latitude: latitude?.toString() ?? curr.latitude,
      longitude: longitude?.toString() ?? curr.longitude,
      isOtpVerified: "Y",
      token: "",
    );
  }
}
