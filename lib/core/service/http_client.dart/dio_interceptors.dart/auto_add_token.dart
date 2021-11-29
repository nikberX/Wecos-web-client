import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wecos_forum/features/authorization/domain/repositories/user_repository.dart';

/// If token field in user repo is not empty, adds it to auth header
class AutoAddToken extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? access = GetIt.I.get<UserRepository>().access;
    if (access != null) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer ${access}}';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    super.onError(error, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}
