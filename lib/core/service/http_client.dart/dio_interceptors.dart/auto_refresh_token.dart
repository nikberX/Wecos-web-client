import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wecos_forum/core/constants/app_constants.dart';
import 'package:wecos_forum/features/authorization/domain/entities/token_pair.dart';
import 'package:wecos_forum/features/authorization/domain/repositories/user_repository.dart';

///Performs auto-refresh logic if token was added to request
class AutoRefreshToken extends Interceptor {
  ///Dio whould be locked during refresh, so the instance of dio is passed
  ///via constructor
  Dio fetchDio;

  AutoRefreshToken(this.fetchDio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401 &&
        GetIt.I.get<UserRepository>().access != null) {
      var requestOptions = error.response!.requestOptions;

      fetchDio.lock();
      fetchDio.interceptors.responseLock.lock();
      fetchDio.interceptors.errorLock.lock();

      Dio tokenDio = Dio();

      tokenDio.options.baseUrl = apiPath;
      tokenDio.options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${GetIt.I.get<UserRepository>().access}';

      var responseWithToken;

      try {
        responseWithToken = await tokenDio.post('/auth/refresh-token');
      } on DioError catch (e) {
        handler.reject(e);
      }

      final token = responseWithToken.data['result']['access'];
      final refresh = responseWithToken.data['result']['refresh'];

      GetIt.I.get<UserRepository>().auth =
          TokenPair(access: token, refresh: refresh);

      requestOptions.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';

      fetchDio.unlock();
      fetchDio.interceptors.responseLock.unlock();
      fetchDio.interceptors.errorLock.unlock();

      try {
        Dio againDio = Dio();
        final res = await againDio.fetch(requestOptions);
        handler.resolve(res);
      } on DioError catch (e) {
        handler.reject(e);
      }
    } else {
      return handler.reject(error);
    }
    super.onError(error, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}
