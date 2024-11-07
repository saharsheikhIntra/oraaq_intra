import 'package:oraaq/src/core/enum/user_type.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';

class RegisterResponseDto {
  final RegisterResponseUserDto user;
  final String token;
  RegisterResponseDto({
    required this.user,
    required this.token,
  });

  factory RegisterResponseDto.fromMap(Map<String, dynamic> map) {
    return RegisterResponseDto(
      user: map['user'] != null
          ? RegisterResponseUserDto.fromMap(map['user'])
          : RegisterResponseUserDto(),
      token: map['token'] != null ? map['token'] as String : "",
    );
  }
}

class RegisterResponseUserDto {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String role;
  final int? userId;
  final String? cnic;
  final String? isActive;
  final String? openingTime;
  final String? closingTime;
  final String? latitude;
  final String? longitude;
  final String? offDays;
  final int? serviceType;
  final String isOtpVerified;

  RegisterResponseUserDto({
    this.id = -1,
    this.name = "",
    this.phone = "",
    this.email = "",
    this.role = "",
    this.userId,
    this.cnic,
    this.isActive,
    this.openingTime,
    this.closingTime,
    this.latitude,
    this.longitude,
    this.offDays,
    this.serviceType,
    this.isOtpVerified = "",
  });

  factory RegisterResponseUserDto.fromMap(Map<String, dynamic> map) {
    return RegisterResponseUserDto(
      id: map['id'] != null ? map['id'] as int : -1,
      name: map['name'] != null ? map['name'] as String : "",
      phone: map['phone'] != null ? map['phone'] as String : "",
      email: map['email'] != null ? map['email'] as String : "",
      role: map['role'] != null ? map['role'] as String : "",
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      cnic: map['cnic'] != null ? map['cnic'] as String : null,
      isActive: map['is_active'] != null ? map['is_active'] as String : null,
      openingTime:
          map['opening_time'] != null ? map['opening_time'] as String : null,
      closingTime:
          map['closing_time'] != null ? map['closing_time'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      offDays: map['off_days'] != null ? map['off_days'] as String : null,
      serviceType:
          map['service_type'] != null ? map['service_type'] as int : -1,
      isOtpVerified: map['is_otp_verified'] != null
          ? map['is_otp_verified'] as String
          : "",
    );
  }

  @override
  String toString() {
    return 'RegisterResponseUserDto(id: $id, name: $name, phone: $phone, email: $email, role: $role, userId: $userId, cnic: $cnic, isActive: $isActive, openingTime: $openingTime, closingTime: $closingTime, latitude: $latitude, longitude: $longitude, offDays: $offDays, serviceType: $serviceType, isOtpVerified: $isOtpVerified)';
  }

  UserEntity get toUserEntity {
    return UserEntity(
      id: id,
      userId: userId ?? -1,
      name: name,
      email: email,
      phone: phone,
      role: UserType.values.firstWhere(
        (e) => e.title.toLowerCase() == role.toLowerCase(),
        orElse: () => UserType.customer,
      ),
      serviceType: serviceType ?? -1,
      cnicNtn: cnic ?? "",
      openingTime: openingTime ?? "",
      closingTime: closingTime ?? "",
      holidays: offDays ?? "",
      latitude: latitude ?? "",
      longitude: longitude ?? "",
      isOtpVerified: isOtpVerified,
      token: "",
    );
  }
}
