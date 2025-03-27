class GenerateOrderRequestDto {
  final OrderMasterRequestDto orderMaster;
  final List<OrderDetailRequestDto> orderDetail;

  GenerateOrderRequestDto({
    required this.orderMaster,
    required this.orderDetail,
  });

  Map<String, dynamic> toMap() {
    return {
      'order_master': orderMaster.toMap(),
      'order_detail': orderDetail.map((detail) => detail.toMap()).toList(),
    };
  }
}

class OrderMasterRequestDto {
  final int customerId;
  final String orderRequiredDate;
  final int categoryId;
  final int totalAmount;
  final int customerAmount;
  final double latitude;
  final double longitude;
  final double radius;

  OrderMasterRequestDto({
    required this.customerId,
    required this.orderRequiredDate,
    required this.categoryId,
    required this.totalAmount,
    required this.customerAmount,
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

  Map<String, dynamic> toMap() {
    return {
      'customer_id': customerId,
      'order_required_date': orderRequiredDate,
      'category_id': categoryId,
      'total_amount': totalAmount,
      'customer_amount': customerAmount,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
    };
  }
}

class OrderDetailRequestDto {
  final int serviceId;
  final double unitPrice;

  OrderDetailRequestDto({
    required this.serviceId,
    required this.unitPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'service_id': serviceId,
      'unit_price': unitPrice,
    };
  }
}
