import 'package:flutter/foundation.dart';

class ServiceEntity {
  final int serviceId;
  final String shortTitle;
  final String description;
  final num price;
  final String prompt;
  final bool isServiceGroup;
  final bool isLastLeaf;
  final List<ServiceEntity> services;
  final bool isRadio;
  ServiceEntity({
    required this.serviceId,
    required this.shortTitle,
    required this.description,
    required this.price,
    required this.prompt,
    required this.isServiceGroup,
    required this.isLastLeaf,
    required this.services,
    required this.isRadio,
  });

  ServiceEntity copyWith({
    int? serviceId,
    String? shortTitle,
    String? description,
    num? price,
    String? prompt,
    bool? isServiceGroup,
    bool? isLastLeaf,
    List<ServiceEntity>? services,
    bool? isRadio,
  }) {
    return ServiceEntity(
      serviceId: serviceId ?? this.serviceId,
      shortTitle: shortTitle ?? this.shortTitle,
      description: description ?? this.description,
      price: price ?? this.price,
      prompt: prompt ?? this.prompt,
      isServiceGroup: isServiceGroup ?? this.isServiceGroup,
      isLastLeaf: isLastLeaf ?? this.isLastLeaf,
      services: services ?? this.services,
      isRadio: isRadio ?? this.isRadio,
    );
  }

  @override
  String toString() {
    return 'ServiceEntity(serviceId: $serviceId, shortTitle: $shortTitle, description: $description, price: $price, prompt: $prompt, isServiceGroup: $isServiceGroup, isLastLeaf: $isLastLeaf, services: $services, isRadio: $isRadio)';
  }

  @override
  bool operator ==(covariant ServiceEntity other) {
    if (identical(this, other)) return true;

    return other.serviceId == serviceId &&
        other.shortTitle == shortTitle &&
        other.description == description &&
        other.price == price &&
        other.prompt == prompt &&
        other.isServiceGroup == isServiceGroup &&
        other.isLastLeaf == isLastLeaf &&
        other.isRadio == isRadio &&
        listEquals(other.services, services);
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
        shortTitle.hashCode ^
        description.hashCode ^
        price.hashCode ^
        prompt.hashCode ^
        isServiceGroup.hashCode ^
        isLastLeaf.hashCode ^
        services.hashCode ^
        isRadio.hashCode;
  }
}
