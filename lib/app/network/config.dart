import 'package:dio/dio.dart';

import 'interceptor/LoggingInterceptors.dart';
import 'interceptor/NetworkInterceptor.dart';

final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8000/api/',
    connectTimeout: 30000,
    receiveTimeout: 30000,
    headers: {"Content-Type": "application/json", "Accept": "application/json"},
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    }))
  ..interceptors.add(LoggingInterceptors())
  ..interceptors.add(NetworkInterceptor());
