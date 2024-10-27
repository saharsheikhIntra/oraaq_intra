import 'package:oraaq/src/core/enum/user_type.dart';
import 'package:oraaq/src/domain/entities/user_entity.dart';

class UpdateCustomerProfileResponseDto {
  final int? customerUserId;
  final int? customerId;
  final String? name;
  final String? email;
  final String? phone;
  final double? latitude;
  final double? longitude;

  UpdateCustomerProfileResponseDto({
    this.customerUserId,
    this.customerId,
    this.name,
    this.email,
    this.phone,
    this.latitude,
    this.longitude,
  });

  factory UpdateCustomerProfileResponseDto.fromMap(Map<String, dynamic> map) {
    return UpdateCustomerProfileResponseDto(
      customerUserId: map['customer_user_id'] != null ? map['customer_user_id'] as int : null,
      customerId: map['customer_id'] != null ? map['customer_id'] as int : null,
      name: map['customer_name'] != null ? map['customer_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      latitude: map['latitude'] != null ? (map['latitude'] as num).toDouble() : null,
      longitude: map['longitude'] != null ? (map['longitude'] as num).toDouble() : null
    );
  }

  @override
  String toString() {
    return 'UpdateCustomerProfileResponseDto(customerUserId: $customerUserId, customerId: $customerId, customerName: $name, email: $email, phone: $phone, latitude: $latitude, longitude: $longitude)';
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'customer_user_id': customerUserId,
  //     'customer_id': customerId,
  //     'customer_name': customerName,
  //     'email': email,
  //     'phone': phone,
  //     'latitude': latitude,
  //     'longitude': longitude
  //   };
  // }

  UserEntity copyUserEntity(UserEntity curr) {
    return UserEntity(
      
      id: customerUserId ?? curr.id,
      userId: customerUserId ?? curr.userId,
      name: name ?? curr.name,
      email:  email ?? curr.email,
      phone:  phone ?? curr.phone,
      latitude:   latitude.toString(),
      longitude:  longitude.toString(), 
      role: UserType.customer, 
      serviceType: -1, 
      cnicNtn: '', 
      token: '', 
      openingTime: '', 
      closingTime: '', 
      holidays: '',

    );
  }
}