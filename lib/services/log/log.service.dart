import 'package:flutter/foundation.dart';

import 'log_core.dart';
import 'log_level.dart';
import 'log_message.dart';

/// Service used to persist log messages.
class LogService {
  factory LogService() => _instance;
  LogService._internal();
  LogService.zone(this._zone);
  static final _instance = LogService._internal();

  final LogCoreService _core = LogCoreService();
  String _zone;
  LogLevel _level;

  set level(LogLevel level) {
    _level = level;
  }

  /// Is trace logging enabled?
  bool get isTraceEnabled {
    return isLevelEnabled(LogLevel.Trace);
  }

  /// Is debug logging enabled?
  bool get isDebugEnabled {
    return isLevelEnabled(LogLevel.Debug);
  }

  /// Is info logging enabled?
  bool get isInfoEnabled {
    return isLevelEnabled(LogLevel.Info);
  }

  /// Is warn logging enabled?
  bool get isWarnEnabled {
    return isLevelEnabled(LogLevel.Warn);
  }

  /// Is error logging enabled?
  bool get isErrorEnabled {
    return isLevelEnabled(LogLevel.Error);
  }

  bool isLevelEnabled(LogLevel level) {
    final int minLevel = LogLevel.values.indexOf(_level);
    final int targetLevel = LogLevel.values.indexOf(level);
    return minLevel <= targetLevel;
  }

  /// Log a trace level message if that level is enabled.
  void trace(String message, [Map data]) {
    log(LogLevel.Trace, message, data);
  }

  /// Log a debug level message if that level is enabled
  void debug(String message, [Map data, dynamic exception, StackTrace stack]) {
    log(LogLevel.Debug, message, data, exception, stack);
  }

  /// Log an info level message if that level is enabled.
  void info(String message, [Map data, dynamic exception, StackTrace stack]) {
    log(LogLevel.Info, message, data, exception, stack);
  }

  /// Log a warn level message if that level is enabled.
  void warn(String message, [Map data, dynamic exception, StackTrace stack]) {
    log(LogLevel.Warn, message, data, exception, stack);
  }

  /// Log an error level message if that level is enabled.
  void error(dynamic exception, StackTrace stack,
      {String message, Map data, DiagnosticsNode context, InformationCollector informationCollector}) {
    log(LogLevel.Error, message, data, exception, stack, context, informationCollector);
  }

  /// Write a log message for the given level if that level is enabled.
  void log(LogLevel level,
      [String message,
      Map data,
      dynamic exception,
      StackTrace stack,
      DiagnosticsNode context,
      InformationCollector informationCollector]) {
    // filter by log level
    if (!isLevelEnabled(level)) {
      return;
    }

    final LogMessage logMessage = LogMessage();
    logMessage.zone = _zone;
    logMessage.level = level;
    logMessage.timestamp = DateTime.now();
    logMessage.message = message;
    logMessage.data = data;
    logMessage.exception = exception;
    logMessage.stack = stack;
    logMessage.context = context;
    logMessage.informationCollector = informationCollector;

    _core.log(logMessage);
  }
}
