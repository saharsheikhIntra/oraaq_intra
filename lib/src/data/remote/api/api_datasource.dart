import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:oraaq/src/core/utils/error_util.dart';
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
      dynamic res = await dio.get(
          dio.options.baseUrl + endpoint,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          options: options,
          queryParameters: queryParameters,
        );
    
      return Right(res);

      // return Right(
      //   await dio.get(
      //     dio.options.baseUrl + endpoint,
      //     onReceiveProgress: onReceiveProgress,
      //     cancelToken: cancelToken,
      //     options: options,
      //     queryParameters: queryParameters,
      //   ),
      // );
    } on DioException catch (e) {
      log(e.toString());
      return Left(handleDioError(e));
//         Failure(
//           e.response?.data["message"].toString() ?? e.toString() ,
// //           Exception has occurred.
// // _TypeError (type 'String' is not a subtype of type 'int' of 'index')
//           code: e.response?.statusCode.toString() ?? '-1',
//         ),
    } catch (e) {
      log(e.toString());
      return Left(handleError(e));
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
      
      return Right(response);
    } on DioException catch (e) {
      log(e.toString());
      return Left(handleDioError(e));
      // return Left(
      //   Failure(
      //     e.response?.data["message"] ?? e.toString(),
      //     code: e.response?.statusCode.toString() ?? '-1',
      //   ),
      // );
    } catch (e) {
      log(e.toString());
      return Left(handleError(e));
      // return Left(
      //   Failure(e.toString()),
      // );
    }
  }

  //<<<<<<<<<<<<<<<<<<<<<<<<<<---------POST 2 - ONLY FOR GENERATE ORDER--------->>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<Either<Failure, Response>> post2(
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
      // log('api data scource ${FormData.fromMap(data)}');
      Response response = await dio.post(
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
      log(e.toString());
      return Left(handleDioError(e));
      // return Left(
      //   Failure(
      //     e.response?.data["message"] ?? e.toString(),
      //     code: e.response?.statusCode.toString() ?? '-1',
      //   ),
      // );
    } catch (e) {
      log(e.toString());
      return Left(handleError(e));
      // return Left(
      //   Failure(e.toString()),
      // );
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
      log(e.toString());
      return Left(handleDioError(e));
      // return Left(
      //   Failure(
      //     e.response?.data["message"] ?? e.toString(),
      //     code: e.response?.statusCode.toString(),
      //   ),
      // );
    } catch (e) {
      log(e.toString());
      return Left(handleError(e));
      // return Left(
      //   Failure(e.toString()),
      // );
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
      log(e.toString());

      return Left(handleDioError(e));
      // Failure(
      //   e.response?.data["message"] ?? e.toString(),
      //   code: e.response?.statusCode.toString() ?? '-1',
      // ),
    } catch (e) {
      log(e.toString());
      return Left(handleError(e));
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
      log(e.toString());
      return Left(handleDioError(e));
      // return Left(
      //   Failure(
      //     e.response?.data["message"] ?? e.toString(),
      //     code: e.response?.statusCode.toString(),
      //   ),
      // );
    } catch (e) {
      log(e.toString());
      return Left(handleError(e));
      // return Left(
      //   Failure(e.toString()),
      // );
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
