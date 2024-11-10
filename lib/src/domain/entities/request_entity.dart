import 'package:flutter/foundation.dart';
import 'package:oraaq/src/core/enum/request_status_enum.dart';

class RequestEntity {
  final int workOrderId;
  final int requestId;
  final int serviceRequestId;
  final String? serviceType;
  final List<String> serviceNames; // Updated to handle list
  final int customerId;
  final String customerName;
  final String customerContactNumber;
  final String customerEmail;
  final double? latitude;
  final double? longitude;
  final String? distance;
  final DateTime requestDate;
  final RequestStatusEnum status;
  final int bidId;
  final double bidAmount;
  final int? rating;
  final int? ratingCustomer;
  final int? ratingMerchant;
  final DateTime bidDate;
  RequestEntity({
    required this.workOrderId,
    required this.requestId,
    required this.serviceRequestId,
    this.serviceType,
    required this.serviceNames,
    required this.customerId,
    required this.customerName,
    required this.customerContactNumber,
    required this.customerEmail,
    this.latitude,
    this.longitude,
    this.distance,
    required this.requestDate,
    required this.status,
    required this.bidId,
    required this.bidAmount,
    this.rating,
    this.ratingCustomer,
    this.ratingMerchant,
    required this.bidDate,
  });

  RequestEntity copyWith({
    int? workOrderId,
    int? requestId,
    int? serviceRequestId,
    String? serviceType,
    List<String>? serviceNames,
    int? customerId,
    String? customerName,
    String? customerContactNumber,
    String? customerEmail,
    double? latitude,
    double? longitude,
    String? distance,
    DateTime? requestDate,
    RequestStatusEnum? status,
    int? bidId,
    double? bidAmount,
    int? rating,
    int? ratingCustomer,
    int? ratingMerchant,
    DateTime? bidDate,
  }) {
    return RequestEntity(
      workOrderId: workOrderId ?? this.workOrderId,
      requestId: requestId ?? this.requestId,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceNames: serviceNames ?? this.serviceNames,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerContactNumber:
          customerContactNumber ?? this.customerContactNumber,
      customerEmail: customerEmail ?? this.customerEmail,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      distance: distance ?? this.distance,
      requestDate: requestDate ?? this.requestDate,
      status: status ?? this.status,
      bidId: bidId ?? this.bidId,
      bidAmount: bidAmount ?? this.bidAmount,
      rating: rating ?? this.rating,
      ratingCustomer: ratingCustomer ?? this.ratingCustomer,
      ratingMerchant: ratingMerchant ?? this.ratingMerchant,
      serviceType: serviceType ?? this.serviceType,
      bidDate: bidDate ?? this.bidDate,
    );
  }

  @override
  String toString() {
    return 'RequestEntity(workOrderId: $workOrderId, requestId: $requestId, serviceRequestId: $serviceRequestId, serviceType: $serviceType, serviceNames: $serviceNames, customerId: $customerId, customerName: $customerName, customerContactNumber: $customerContactNumber, customerEmail: $customerEmail, latitude: $latitude, longitude: $longitude, distance: $distance, requestDate: $requestDate, status: $status, bidId: $bidId, bidAmount: $bidAmount, rating:$rating, ratingCustomer:$ratingCustomer, ratingMerchant:$ratingMerchant, bidDate: $bidDate)';
  }

  @override
  bool operator ==(covariant RequestEntity other) {
    if (identical(this, other)) return true;

    return other.workOrderId == workOrderId &&
        other.requestId == requestId &&
        other.serviceRequestId == serviceRequestId &&
        listEquals(other.serviceNames, serviceNames) &&
        other.serviceType == serviceType &&
        other.customerId == customerId &&
        other.customerName == customerName &&
        other.customerContactNumber == customerContactNumber &&
        other.customerEmail == customerEmail &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.distance == distance &&
        other.requestDate == requestDate &&
        other.status == status &&
        other.bidId == bidId &&
        other.bidAmount == bidAmount &&
        other.rating == rating &&
        other.ratingCustomer == ratingCustomer &&
        other.ratingMerchant == ratingMerchant &&
        other.bidDate == bidDate;
  }

  @override
  int get hashCode {
    return workOrderId.hashCode ^
        requestId.hashCode ^
        serviceRequestId.hashCode ^
        serviceType.hashCode ^
        serviceNames.hashCode ^
        customerId.hashCode ^
        customerName.hashCode ^
        customerContactNumber.hashCode ^
        customerEmail.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        distance.hashCode ^
        requestDate.hashCode ^
        status.hashCode ^
        bidId.hashCode ^
        bidAmount.hashCode ^
        rating.hashCode ^
        ratingCustomer.hashCode ^
        ratingMerchant.hashCode ^
        bidDate.hashCode;
  }
}
