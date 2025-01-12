import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:oraaq/src/domain/entities/failure.dart';

class ErrorUtil {
  static final Logger _logger = Logger();

  /// Logs the error and returns a `Failure` object with a user-friendly message
  static Failure handleError(dynamic error, [StackTrace? stackTrace]) {
    // Log the error details for debugging
    _logger.e(
      "Error occurred",
      error: error,
      stackTrace: stackTrace,
    );

    if (error is DioException) {
      // Handle Dio-specific errors
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Failure(
            "Connection timeout. Please check your internet connection and try again.",
          );

        case DioExceptionType.badResponse:
          // Extract status code and message if available
          final statusCode = error.response?.statusCode;
          final statusMessage = error.response?.statusMessage;
          _logger.e(
            "Server responded with status code: $statusCode, message: $statusMessage",
          );

          // Optionally handle specific status codes
          if (statusCode == 404) {
            return Failure("Resource not found.");
          } else if (statusCode == 500) {
            return Failure("Internal server error. Please try again later.");
          }
          return Failure("Server error. Status code: $statusCode.");

        case DioExceptionType.cancel:
          return Failure("Request was cancelled. Please try again.");

        case DioExceptionType.unknown:
          return Failure("An unexpected error occurred. Please try again.");

        default:
          return Failure("An unknown error occurred. Please try again.");
      }
    }

    // Fallback for non-Dio exceptions
    if (error is FormatException) {
      return Failure("Data format is incorrect. Please contact support.");
    } else if (error is TimeoutException) {
      return Failure("The operation timed out. Please try again.");
    }

    // Generic error for unhandled exceptions
    return Failure("Something went wrong.");
  }
}
