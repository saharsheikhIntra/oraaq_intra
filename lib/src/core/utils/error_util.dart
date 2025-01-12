import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:oraaq/src/domain/entities/failure.dart';

class ErrorUtil {
  static final Logger _logger = Logger();

  // Logs the error and returns a Failure object with a user-friendly message
  static Failure handleError(dynamic error, [StackTrace? stackTrace]) {
    // Log the error for debugging
    _logger.e("Error: $error", error: error, stackTrace: stackTrace);

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Failure(
              "Connection timeout. Please check your internet connection and try again.");
        case DioExceptionType.badResponse:
          return Failure("Server error. Please try again later.");
        case DioExceptionType.cancel:
          return Failure("Request was cancelled. Please try again.");
        case DioExceptionType.unknown:
          return Failure("An unexpected error occurred. Please try again.");
        default:
          return Failure("Something went wrong. Please try again.");
      }
    }

    // Handle other exceptions
    return Failure("Something went wrong. Please try again.");
  }
}
