import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:oraaq/src/data/remote/api/api_constants.dart';

import '../../../domain/entities/failure.dart';

class ApiDatasource {
  final Dio dio;
  const ApiDatasource(this.dio);

  //
  //<<<<<<<<<<<<<<<<<<<<<<<<<<<---------GET--------->>>>>>>>>>>>>>>>>>>>>>>>>>>
  //

  Future<Either<Failure, Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return Right(
        await dio.get(
          dio.options.baseUrl + endpoint,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          options: options,
          queryParameters: queryParameters,
        ),
      );
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.data["message"] ?? e.toString(),
//           Exception has occurred.
// _TypeError (type 'String' is not a subtype of type 'int' of 'index')
          code: e.response?.statusCode.toString() ?? '-1',
        ),
      );
    }
  }

  //
  //<<<<<<<<<<<<<<<<<<<<<<<<<<---------POST--------->>>>>>>>>>>>>>>>>>>>>>>>>>>
  //

  Future<Either<Failure, Response>> post(
    String endpoint, {
    dynamic data,
    dynamic listData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      Response response = await dio.post(
        dio.options.baseUrl + endpoint,
        data: listData ?? (data == null ? null : FormData.fromMap(data)),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
      // Logger().i(response.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.data["message"] ?? e.toString(),
          code: e.response?.statusCode.toString(),
        ),
      );
    } catch (e) {
      return Left(
        Failure(e.toString()),
      );
    }
  }

  //
  //<<<<<<<<<<<<<<<<<<<<<<<<<---------DELETE--------->>>>>>>>>>>>>>>>>>>>>>>>>>
  //

  Future<Either<Failure, Response>> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return Right(
        await dio.delete(
          dio.options.baseUrl + endpoint,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
      );
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.data["message"] ?? e.toString(),
          code: e.response?.statusCode.toString(),
        ),
      );
    }
  }

  //
  //<<<<<<<<<<<<<<<<<<<<<<<<<<<---------PUT--------->>>>>>>>>>>>>>>>>>>>>>>>>>>
  //

  Future<Either<Failure, Response>> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      Response response = await dio.put(
        dio.options.baseUrl + endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.data["message"] ?? e.toString(),
          code: e.response?.statusCode.toString(),
        ),
      );
    }
  }

  //
  //<<<<<<<<<<<<<<<<<<<<<<<<<<---------PATCH--------->>>>>>>>>>>>>>>>>>>>>>>>>>>
  //

  Future<Either<Failure, Response>> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      Response response = await dio.patch(
        dio.options.baseUrl + endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(
        Failure(
          e.response?.data["message"] ?? e.toString(),
          code: e.response?.statusCode.toString(),
        ),
      );
    }
  }

  //
  //<<<<<<<<<<<<<<<<<<---------FIREBASE-NOTIFICATION--------->>>>>>>>>>>>>>>>>>
  //

  Future sendFcmNotification(Map<String, dynamic> data) async {
    try {
      Dio().post(
        ApiConstants.sendFcmNotification,
        data: data,
        options: Options(headers: {
          "Authorization": "key=\${AppConstants.fcmKey}",
          "Content-Type": "application/json",
        }),
      );
    } on DioException catch (e) {
      Logger().e(e);
    }
  }
}
