import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'appenders/console_appender.dart';
import 'appenders/crashlytics_appender.dart';
import 'log_message.dart';

/// Core log service that holds the pipeline for log messages.
/// Must be a singleton.
class LogCoreService {
  factory LogCoreService() => _instance;
  LogCoreService._internal() {
    _initAppenders();
  }
  static final _instance = LogCoreService._internal();

  final StreamController<LogMessage> _messagesStream = StreamController<LogMessage>();

  /// Observable stream of log messages.
  /// Meant for appenders to subscribe on.
  Stream<LogMessage> get messages {
    return _messagesStream.stream;
  }

  /// Log a message.
  void log(LogMessage message) {
    _messagesStream.add(message);
  }

  void _initAppenders() {
    final crashlyticsAppender = CrashlyticsAppender();
    final consoleAppender = ConsoleAppender();
    _messagesStream.stream.listen((logMessage) {
      try {
        crashlyticsAppender.write(logMessage);
        consoleAppender.write(logMessage);
      } catch (error, stack) {
        Crashlytics.instance.recordError(error, stack);
      }
    });
  }
}
