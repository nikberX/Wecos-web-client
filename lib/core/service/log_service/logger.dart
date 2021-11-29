import 'package:wecos_forum/core/service/log_service/log_strategies/i_log_strategy.dart';
import 'package:wecos_forum/core/service/log_service/log_style/critical_error_log_style.dart';
import 'package:wecos_forum/core/service/log_service/log_style/debug_log_style.dart';
import 'package:wecos_forum/core/service/log_service/log_style/error_log_style.dart';
import 'package:wecos_forum/core/service/log_service/log_style/i_log_style.dart';
import 'package:wecos_forum/core/service/log_service/log_style/info_log_style.dart';
import 'package:wecos_forum/core/service/log_service/log_style/notice_log_style.dart';
import 'package:wecos_forum/core/service/log_service/log_style/success_log_style.dart';
import 'package:wecos_forum/core/service/log_service/log_style/warning_log_style.dart';

class Logger {
  ILogStrategy logStrategy;

  Logger({required this.logStrategy});

  /// Critical conditions.
  ///
  /// Example: Application component unavailable, unexpected exception.
  ///
  /// @param string $message
  /// @return void
  void critical(String message, dynamic data) =>
      _log(message, CriticalErrorStyle(), data);

  /// Runtime errors that do not require immediate action but should typically
  /// be logged and monitored.
  ///
  ///@param string $message
  ///@return void
  void error(String message, dynamic data) => _log(message, ErrorStyle(), data);

  /// Exceptional occurrences that are not errors.
  ///
  /// Example: Use of deprecated APIs, poor use of an API, undesirable things
  /// that are not necessarily wrong.
  ///
  /// @param string $message
  /// @return void
  void warning(String message, dynamic data) =>
      _log(message, WarningStyle(), data);

  /// Normal but significant events.
  ///
  /// @param string $message
  /// @return void
  void notice(String message, dynamic data) =>
      _log(message, NoticeStyle(), data);

  ///Interesting events.
  ///
  ///Example: User logs in, SQL logs.
  ///
  ///@param string $message
  ///@return void
  void info(String message, dynamic data) => _log(message, InfoStyle(), data);

  ///Detailed debug information.
  ///@param string $message
  ///@return void
  void debug(String message, dynamic data) => _log(message, DebugStyle(), data);

  void success(String message, dynamic data) =>
      _log(message, SuccessStyle(), data);

  void _log(String message, ILogStyle style, dynamic data) =>
      logStrategy.log(style.stylizePrimary(message) +
          ' ' +
          style.stylizeSecondary(data.toString()));
}
