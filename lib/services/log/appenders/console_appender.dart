import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/widgets.dart';

import '../log_level.dart';
import '../log_message.dart';
import 'log_appender.dart';

class ConsoleAppender implements LogAppender {
  factory ConsoleAppender() => _instance;
  ConsoleAppender._internal();
  static final ConsoleAppender _instance = ConsoleAppender._internal();

  ///Write a log message to the console.
  @override
  void write(LogMessage logMessage) {
    if (logMessage.level == LogLevel.Error) {
      // errors will be logged to the console by the Crashlytics appender
      // else we would use FlutterError.dumpErrorToConsole
      return;
    }

    // this doesn't really work well in iOS
    // https://github.com/flutter/flutter/issues/20663
    final AnsiPen titlePen = AnsiPen()..white(bold: true);
    final AnsiPen messagePen = AnsiPen()..white(bold: false);

    String message = '';
    message += titlePen('${DateTime.now()} [${logMessage.levelText}] ${logMessage.zone} - ');
    message += messagePen(logMessage.message);

    if (logMessage.data != null) {
      message += ' | data: ${logMessage.data}';
    }

    print(message);

    if (logMessage.exception != null) {
      final FlutterErrorDetails details = FlutterErrorDetails(
          exception: logMessage.exception,
          stack: logMessage.stack,
          context: logMessage.context,
          informationCollector: logMessage.informationCollector,
          silent: true);
      FlutterError.dumpErrorToConsole(details);
    }
  }
}
