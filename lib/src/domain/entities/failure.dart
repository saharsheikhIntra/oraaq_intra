class Failure {
  final String message;
  String? code;
  
  Failure(
    this.message, {
    this.code = '-1',
  });

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;
    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
