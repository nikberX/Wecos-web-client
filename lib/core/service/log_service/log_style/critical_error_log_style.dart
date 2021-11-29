import 'package:colorize/colorize.dart';
import 'package:wecos_forum/core/service/log_service/log_style/i_log_style.dart';

class CriticalErrorStyle implements ILogStyle {
  @override
  String stylizePrimary(String message) =>
      Colorize(message).red().bold().bgDarkGray().underline().toString();

  @override
  String stylizeSecondary(String message) =>
      Colorize(message).bgRed().bold().toString();
}
