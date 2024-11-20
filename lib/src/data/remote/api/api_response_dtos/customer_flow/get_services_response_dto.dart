import '../../../../../domain/entities/service_entity.dart';

class GetServicesResponseDto {
  final List<ServiceResponseDto> serviceGroup;
  GetServicesResponseDto(this.serviceGroup);

  factory GetServicesResponseDto.fromMap(Map<String, dynamic> map) {
    return GetServicesResponseDto(map['service_group'] is List
        ? List<ServiceResponseDto>.from(
            (map['service_group']).map<ServiceResponseDto>(
              (x) => ServiceResponseDto.fromMap(x),
            ),
          )
        : <ServiceResponseDto>[]);
  }
}

class ServiceResponseDto {
  final int serviceId;
  final String shortTitle;
  final String description;
  final num price;
  final String prompt;
  final bool isServiceGroup;
  final bool isLastLeaf;
  final bool isRadio;
  final List<ServiceResponseDto> services;

  ServiceResponseDto({
    required this.serviceId,
    required this.shortTitle,
    required this.description,
    required this.price,
    required this.prompt,
    required this.isServiceGroup,
    required this.isLastLeaf,
    required this.services,
    this.isRadio = false,
  });

  factory ServiceResponseDto.fromMap(Map<String, dynamic> map) {
    return ServiceResponseDto(
        serviceId: map['service_id'] is int ? map['service_id'] : -1,
        shortTitle: map['short_title'] is String ? map['short_title'] : "",
        description: map['description'] is String ? map['description'] : "",
        price: map['price'] is num ? map['price'] : 0,
        prompt: map['prompt'] is String ? map['prompt'] : "",
        isServiceGroup: map['is_service_group'] == "Y",
        isLastLeaf: map['is_last_leaf'] == "Y",
        isRadio: map['is_radio'] == "Y",
        services: map['services'] is List
            ? List<ServiceResponseDto>.from(
                (map['services']).map<ServiceResponseDto>(
                  (x) => ServiceResponseDto.fromMap(x),
                ),
              )
            : <ServiceResponseDto>[]);
  }

  ServiceEntity get toServiceEntity => ServiceEntity(
        serviceId: serviceId,
        shortTitle: shortTitle,
        description: description,
        price: price,
        prompt: prompt,
        isServiceGroup: isServiceGroup,
        isLastLeaf: isLastLeaf,
        isRadio: isRadio,
        services: services.map((e) => e.toServiceEntity).toList(),
      );
}
