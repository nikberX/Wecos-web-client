import 'package:dio/dio.dart';
import 'package:wecos_forum/core/constants/app_constants.dart';

class HttpClient {
  late Dio fetchDio;

  HttpClient() {
    fetchDio = Dio();

    fetchDio.options.baseUrl = apiPath;
  }

  void addInterceptor(Interceptor interceptor) {
    fetchDio.interceptors.add(interceptor);
  }

  Future<Response?> get(String path, [Map<String, dynamic>? query]) {
    if (query == null) return fetchDio.get(path);
    query.removeWhere((key, value) => value == null);
    return fetchDio.get(path, queryParameters: query);
  }

  Future<Response?> post(String path, [Map<String, dynamic> data = const {}]) =>
      fetchDio.post(path, data: data);

  Future<Response?> put(String path, [Map<String, dynamic> data = const {}]) =>
      fetchDio.put(path, data: data);

  Future<Response?> delete(String path,
          [Map<String, dynamic> data = const {}]) =>
      fetchDio.delete(path, data: data);
}
