import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:oraaq/src/domain/entities/failure.dart';

Failure handleDioError(DioException e) {
  debugPrint(
      'DioException: ${e.toString()}'); // Logs detailed error for debugging

  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return Failure(
      "Connection timeout. Please try again.",
      type: FailureType.timeout,
    );
  } else if (e.type == DioExceptionType.badResponse) {
    if (e.response?.statusCode == 401) {
      return Failure(
        "Authentication failed. Please login again.",
        code: e.response?.statusCode.toString(),
        type: FailureType.authentication,
      );
    } else if (e.response?.statusCode == 500) {
      return Failure(
        "Server error. Please try later.",
        code: e.response?.statusCode.toString(),
        type: FailureType.server,
      );
    }
    return Failure(
      e.response?.data["message"] ?? "An unexpected error occurred.",
      code: e.response?.statusCode.toString(),
      type: FailureType.server,
    );
  } else if (e.type == DioExceptionType.connectionError) {
    return Failure(
      "Check your internet connection.",
      type: FailureType.network,
    );
  }

  return Failure(
    "An unexpected error occurred.",
    type: FailureType.unknown,
  );
}

Failure handleError(dynamic error) {
  debugPrint('Error: ${error.toString()}'); // Logs unexpected errors
  if (error is DioException) {
    return handleDioError(error);
  }
  return Failure("Something went wrong.", type: FailureType.unknown);
}
