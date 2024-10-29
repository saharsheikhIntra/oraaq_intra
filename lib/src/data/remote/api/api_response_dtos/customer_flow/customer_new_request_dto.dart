class CustomerNewRequestDto {
  final int requestId;
  final String category;
  final String amount;
  final String date;
  final List<String> services;
  final int offersReceived;
  final String radius;
  final String duration;

  CustomerNewRequestDto({
    this.requestId = -1,
    this.category = '',
    this.amount = '',
    this.date = '',
    this.services = const [],
    this.offersReceived = 0,
    this.radius = '',
    this.duration = '',
  });

  factory CustomerNewRequestDto.fromMap(Map<String, dynamic> map) {
    return CustomerNewRequestDto(
      requestId: map['request_id'] ?? -1,
      category: map['category'] ?? '',
      amount: map['amount'] ?? '',
      date: map['date'] ?? '',
      services: map['services'] != null ? List<String>.from(map['services']) : [],
      offersReceived: map['offers_received'] ?? 0,
      radius: map['radius'] ?? '',
      duration: map['duration'] ?? '',
    );
  }

  @override
  String toString() {
    return 'CustomerNewRequestDto(requestId: $requestId, category: $category, amount: $amount, date: $date, services: $services, offersReceived: $offersReceived, radius: $radius, duration: $duration)';
  }
}
