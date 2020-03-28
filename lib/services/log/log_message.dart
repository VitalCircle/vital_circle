import 'package:flutter/foundation.dart';

import 'log_level.dart';

class LogMessage {
  String zone;
  LogLevel level;
  DateTime timestamp;
  String message;
  Map data;
  dynamic exception;
  StackTrace stack;
  DiagnosticsNode context;
  InformationCollector informationCollector;

  /// Get the human readable version of the log level.
  String get levelText {
    switch (level) {
      case LogLevel.Trace:
        return 'TRACE';
      case LogLevel.Debug:
        return 'DEBUG';
      case LogLevel.Info:
        return 'INFO';
      case LogLevel.Warn:
        return 'WARN';
      case LogLevel.Error:
        return 'ERROR';
      case LogLevel.All:
      case LogLevel.Off:
        break;
    }
    return null;
  }
}
