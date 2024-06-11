import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:kanban_board/application/network/remote_client/iApService.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../common/logger/log.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class ApiService extends Interceptor implements IApiService {
  @override
  Dio get() => _dio;

  @override
  BaseOptions getBaseOptions() {
    return BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com/',
        receiveDataWhenStatusError: true,
        headers: {HttpHeaders.acceptHeader: "application/json"},
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60));
  }

  @override
  HttpClient httpClientCreate(HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }

  @override
  void serviceGenerator() {
    _dio = Dio(getBaseOptions());
    _dio.interceptors.add(this);
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        httpClientCreate;
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    d("onRequest");
    d('path: ${options.path}');

    // if (_isTokenRequired) {
    //
    //   options.headers
    //       .addAll({HttpHeaders.authorizationHeader: 'Bearer ${token}'});
    // }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    d("onResponse");
    d('status code: ${response.statusCode}');

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    d("onError");
    d('status code: ${err.response?.statusCode}');
    return handler.next(err);
  }

  late Dio _dio;
}
