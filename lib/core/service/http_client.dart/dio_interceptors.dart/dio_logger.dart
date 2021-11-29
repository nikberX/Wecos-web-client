import 'package:dio/dio.dart';
import 'package:wecos_forum/core/service/log_service/logger.dart';

///Logs requests, errors and responses to console using colorized fonts
class DioLogger extends Interceptor {
  Logger globalLogger;

  DioLogger(this.globalLogger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    globalLogger.info(
        'Perform request on', '${options.method} : ${options.uri}');
    globalLogger.info('Headers', _printMapAsTable(options.headers));
    globalLogger.info('Body', _printMapAsTable(options.data));
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    try {
      globalLogger.error(
          '${error.response?.statusCode} status catched with DioErrorType ${error.type} and body: ',
          _printMapAsTable(error.response?.data ?? {}));
    } catch (e) {}

    super.onError(error, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      globalLogger.success('Response', _printMapAsTable(response.data));
    } catch (e) {}

    super.onResponse(response, handler);
  }

  String _printMapAsTable(Map? map, [int tab = 0]) {
    if (map == null || map.isEmpty) return '';
    String result = "{";
    result = result + "\n";
    map.forEach((key, value) {
      result = result + _printKeyValue(key, value, tab) + '\n';
    });
    result += ("\t" * tab) + "}";
    return result;
  }

  String _printKeyValue(String key, dynamic value, int tab) {
    if (value is List) {
      int index = 0;
      String result = "";
      value.forEach((element) {
        result += _printKeyValue('$index', element, tab) + '\n';
        index++;
      });
      return result;
    }
    if (value is Map) {
      return "$key: ${_printMapAsTable(value, tab + 1)}";
    }
    return ("\t" * tab) + "$key: ${value.toString()}";
  }
}

class TokenDioLogger extends Interceptor {
  Logger globalLogger;

  TokenDioLogger(this.globalLogger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    globalLogger.warning('Trying to refresh token', ' requesting new token');

    globalLogger.info(
        'Perform request on', '${options.method} : ${options.uri}');
    globalLogger.info('Headers', _printMapAsTable(options.headers));
    globalLogger.info('Body', _printMapAsTable(options.data));
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    globalLogger.critical(
        '${error.response?.statusCode} Error catched while trying to refresh token, rejecting DioErrorType ${error.type}, body: ',
        _printMapAsTable(error.response?.data));
    super.onError(error, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    globalLogger.success(
        'Response with token:', _printMapAsTable(response.data));
    super.onResponse(response, handler);
  }

  String _printMapAsTable(Map? map, [int tab = 0]) {
    if (map == null || map.isEmpty) return '';
    String result = "{\n";
    map.forEach((key, value) {
      result = result + _printKeyValue(key, value, tab) + '\n';
    });
    result += ("\t" * tab) + "}";
    return result;
  }

  String _printKeyValue(String key, dynamic value, int tab) {
    if (value is List<Map>) {
      int index = 0;
      String result = "";
      value.forEach((element) {
        result += _printKeyValue('$index:', element, tab);
        index++;
      });
      return result;
    }
    if (value is Map) {
      return "$key: ${_printMapAsTable(value, tab + 1)}";
    }
    return ("\t" * tab) + "$key: ${value.toString()}";
  }
}
