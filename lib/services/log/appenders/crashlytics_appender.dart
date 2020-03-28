import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../log_level.dart';
import '../log_message.dart';
import 'log_appender.dart';

class CrashlyticsAppender implements LogAppender {
  factory CrashlyticsAppender() => _instance;
  CrashlyticsAppender._internal();
  static final CrashlyticsAppender _instance = CrashlyticsAppender._internal();

  ///Write a log message to the console.
  @override
  void write(LogMessage logMessage) {
    if (logMessage.level != LogLevel.Error || logMessage.exception == null || logMessage.stack == null) {
      return;
    }

    if (logMessage.informationCollector != null) {
      final FlutterErrorDetails details = FlutterErrorDetails(
          exception: logMessage.exception,
          stack: logMessage.stack,
          context: logMessage.context,
          informationCollector: logMessage.informationCollector);
      Crashlytics.instance.recordFlutterError(details);
    } else {
      Crashlytics.instance.recordError(logMessage.exception, logMessage.stack, context: logMessage.context);
    }
  }
}
