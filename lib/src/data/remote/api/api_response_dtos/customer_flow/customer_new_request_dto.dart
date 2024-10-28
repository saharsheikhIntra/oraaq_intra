class CustomerNewRequestDto {
  final int requestId;
  final String category;
  final String amount;
  final String date;
  final int offersReceived;

  CustomerNewRequestDto({
    this.requestId = -1,
    this.category = '',
    this.amount = '',
    this.date = '',
    this.offersReceived = 0,
  });

  factory CustomerNewRequestDto.fromMap(Map<String, dynamic> map) {
    return CustomerNewRequestDto(
      requestId: map['request_id'] ?? -1,
      category: map['category'] ?? '',
      amount: map['amount'] ?? '',
      date: map['date'] ?? '',
      offersReceived: map['offers_received'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'CustomerNewRequestDto(requestId: $requestId, category: $category, amount: $amount, date: $date, offersReceived: $offersReceived)';
  }
}
