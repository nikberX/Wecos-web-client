import 'package:colorize/colorize.dart';
import 'package:wecos_forum/core/service/log_service/log_style/i_log_style.dart';

class DebugStyle implements ILogStyle {
  @override
  String stylizePrimary(String message) =>
      Colorize(message).bold().blue().bgDarkGray().toString();

  @override
  String stylizeSecondary(String message) =>
      Colorize(message).blue().underline().toString();
}
