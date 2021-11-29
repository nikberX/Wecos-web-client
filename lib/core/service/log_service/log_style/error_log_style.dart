import 'package:colorize/colorize.dart';
import 'package:wecos_forum/core/service/log_service/log_style/i_log_style.dart';

class ErrorStyle implements ILogStyle {
  @override
  String stylizePrimary(String message) =>
      Colorize(message).lightRed().underline().bold().toString();

  @override
  String stylizeSecondary(String message) =>
      Colorize(message).lightRed().underline().bgDarkGray().toString();
}
