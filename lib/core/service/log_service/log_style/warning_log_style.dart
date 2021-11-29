import 'package:colorize/colorize.dart';
import 'package:wecos_forum/core/service/log_service/log_style/i_log_style.dart';

class WarningStyle implements ILogStyle {
  @override
  String stylizePrimary(String message) =>
      Colorize(message).lightRed().bgDarkGray().italic().toString();

  @override
  String stylizeSecondary(String message) =>
      Colorize(message).yellow().underline().toString();
}
