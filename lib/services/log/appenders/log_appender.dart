import '../log_message.dart';

abstract class LogAppender {
  void write(LogMessage logMessage);
}
