import 'package:wecos_forum/core/service/log_service/log_strategies/i_log_strategy.dart';

class ConsoleLogStrategy implements ILogStrategy {
  @override
  void log(String message) => print(message);
}
