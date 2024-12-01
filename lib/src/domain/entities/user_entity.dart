// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../core/enum/user_type.dart';

class UserEntity {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String phone;
  final UserType role;
  final int serviceType;
  final String cnicNtn;
  final String token;
  final String openingTime;
  final String closingTime;
  final String holidays;
  final String latitude;
  final String longitude;
  String? isOtpVerified;
  String? isSocial;
  UserEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.serviceType,
    required this.cnicNtn,
    required this.token,
    required this.openingTime,
    required this.closingTime,
    required this.holidays,
    required this.latitude,
    required this.longitude,
    this.isOtpVerified,
    this.isSocial
  });

  UserEntity copyWith({
    int? id,
    int? userId,
    String? name,
    String? email,
    String? phone,
    UserType? role,
    int? serviceType,
    String? cnicNtn,
    String? token,
    String? openingTime,
    String? closingTime,
    String? holidays,
    String? latitude,
    String? longitude,
    String? isOtpVerified,
    String? isSocial
  }) {
    return UserEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      serviceType: serviceType ?? this.serviceType,
      cnicNtn: cnicNtn ?? this.cnicNtn,
      token: token ?? this.token,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      holidays: holidays ?? this.holidays,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      isSocial: isSocial ?? this.isSocial,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      "userId": userId,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.id,
      'serviceType': serviceType,
      'cnicNtn': cnicNtn,
      'token': token,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'holidays': holidays,
      'latitude': latitude,
      'longitude': longitude,
      'is_otp_verified': isOtpVerified,
      'is_social': isSocial,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] as int,
      userId: map['userId'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      role: UserType.values.firstWhere(
        (e) => e.id == map['role'],
        orElse: () => UserType.customer,
      ),
      serviceType: map['serviceType'] as int,
      cnicNtn: map['cnicNtn'] as String,
      token: map['token'] as String,
      openingTime: map['opening_time'] as String,
      closingTime: map['closing_time'] as String,
      holidays: map['holidays'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      isOtpVerified: map['is_otp_verified'] as String,
      isSocial: map['is_social'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserEntity(id: $id,  userId: $userId, name: $name, email: $email, phone: $phone, role: $role, serviceType: $serviceType, cnicNtn: $cnicNtn, token: $token, opening_time: $openingTime, closing_time: $closingTime, holidays: $holidays, latitude: $latitude, longitude: $longitude, is_otp_verified: $isOtpVerified, is_social: $isSocial)';
  }

  @override
  bool operator ==(covariant UserEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.role == role &&
        other.serviceType == serviceType &&
        other.cnicNtn == cnicNtn &&
        other.token == token &&
        other.openingTime == openingTime &&
        other.closingTime == closingTime &&
        other.holidays == holidays &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.isOtpVerified == isOtpVerified &&
        other.isSocial == isSocial;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        role.hashCode ^
        serviceType.hashCode ^
        cnicNtn.hashCode ^
        token.hashCode ^
        openingTime.hashCode ^
        closingTime.hashCode ^
        holidays.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        isOtpVerified.hashCode ^
        isSocial.hashCode;
  }
}
