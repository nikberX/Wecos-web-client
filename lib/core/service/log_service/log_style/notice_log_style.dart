import 'package:colorize/colorize.dart';
import 'package:wecos_forum/core/service/log_service/log_style/i_log_style.dart';

class NoticeStyle implements ILogStyle {
  @override
  String stylizePrimary(String message) =>
      Colorize(message).yellow().bgLightMagenta().toString();

  @override
  String stylizeSecondary(String message) =>
      Colorize(message).lightCyan().italic().toString();
}
