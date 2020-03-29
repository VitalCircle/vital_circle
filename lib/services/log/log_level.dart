/// Designates the levels for log messages and configuration.
enum LogLevel {
  /// Lowest level possible.
  All,

  /// Fine-grained events used to track the flow of events.
  Trace,

  /// Fine-grained informal events that are mostly useful to debug an application.
  Debug,

  /// Informal message that highlights the progress of the application at coarse-grained level.
  Info,

  /// Potentially harmful situations.
  Warn,

  /// Error events that might still allow the application to continue running.
  Error,

  /// Highest level possible.
  Off
}
