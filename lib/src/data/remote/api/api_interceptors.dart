import 'package:dio/dio.dart';
import 'package:oraaq/src/data/local/local_auth_repository.dart';
import 'package:oraaq/src/imports.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constants.dart';

class RequestInterceptor extends Interceptor {
  final Dio dio;
  RequestInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String token = "";
    var result = await getIt.get<LocalAuthRepository>().getToken();
    result.fold((l) {}, (r) => token = r ?? "");
    if (token.isEmpty) {
      // If token is empty, you might want to fetch a new one immediately
      token = await _refreshTokenMethod();
      await getIt.get<LocalAuthRepository>().setToken(token);
    }
    options.headers[ApiConstants.tokenKey] = 'Bearer $token';
    // options.headers = {ApiConstants.tokenKey: 'Bearer $token'};
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    debugPrint("Response data: ${response.data}");
    debugPrint("Response headers: ${response.headers}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      RequestOptions options = err.response!.requestOptions;
      try {
        String token = await _refreshTokenMethod();
        await getIt.get<LocalAuthRepository>().setToken(token);
        options.headers[ApiConstants.tokenKey] = 'Bearer $token';
        final response = await dio.request(options.path,
            data: options.data,
            queryParameters: options.queryParameters,
            options: Options(
              method: options.method,
              headers: options.headers,
            ));
        return handler.resolve(response);
      } catch (e) {
        return handler.reject(err);
      }
    }
    super.onError(err, handler);
  }

  Future<String> _refreshTokenMethod() async {
    try {
      debugPrint(
          "Attempting to fetch new token from: ${ApiConstants.baseUrl2 + ApiConstants.getToken}");
      final response = await Dio().post(
        ApiConstants.baseUrl2 + ApiConstants.getToken,
      );

      debugPrint("Status code: ${response.statusCode}");
      debugPrint("Response data: ${response.data}");

      // final response = await Dio().post(
      // ApiConstants.baseUrl + ApiConstants.getToken,
      // data: {
      //   "username": "testuser",
      //   "password": "testpassword",
      // },
      // );
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['access'] != null) {
        var token = response.data['access'];
        debugPrint("New token fetched: $token");
        return token;
      } else {
        debugPrint("Unexpected response structure: ${response.data}");
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      debugPrint("Error while refreshing token: $e");
      throw Exception('Failed to refresh token');
    }
  }
}

class LoggerInterceptor extends Interceptor {
  static PrettyDioLogger interceptor = PrettyDioLogger(
    responseHeader: true,
    requestHeader: true,
    requestBody: true,
  );
}
