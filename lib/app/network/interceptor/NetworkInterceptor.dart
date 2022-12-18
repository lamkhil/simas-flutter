// ignore_for_file: file_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/app_pages.dart';

class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = GetStorage().read('token');
    if (token != null) {
      options.headers
          .addAll({HttpHeaders.authorizationHeader: "Bearer $token"});
    }
    return super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (response.data['message'] == "Unauthenticated.") {
      Get.offAllNamed(Routes.HOME);
      GetStorage().erase();
    }
    return super.onResponse(response, handler);
  }
}
