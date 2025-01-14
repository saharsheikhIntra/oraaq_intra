// class Failure {
//   final String message;
//   String? code;

//   Failure(
//     this.message, {
//     this.code = '-1',
//   });

//   @override
//   bool operator ==(covariant Failure other) {
//     if (identical(this, other)) return true;
//     return other.message == message;
//   }

//   @override
//   int get hashCode => message.hashCode;
// }

class Failure {
  final String message;
  final String? code; // HTTP or custom error code
  final FailureType type; // Enum for categorizing error type

  Failure(
    this.message, {
    this.code = '-1',
    this.type = FailureType.unknown,
  });

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;
    return other.message == message && other.type == type && other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ type.hashCode ^ code.hashCode;
}

enum FailureType {
  network, // For connection issues
  server, // For server-side errors (5xx)
  authentication, // For authentication/authorization errors (401, 403)
  timeout, // For request/response timeouts
  validation, // For input validation errors
  unknown, // For any unexpected error
}
