import 'dart:io';

import 'package:dio/dio.dart';

abstract class IApiService {
  Dio get();
  void serviceGenerator();
  BaseOptions getBaseOptions();
  HttpClient httpClientCreate(HttpClient client);
}
