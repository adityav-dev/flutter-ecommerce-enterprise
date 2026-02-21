import 'package:flutter/foundation.dart';

/// Logging abstraction for the app.
/// In production, wire to Crashlytics, Sentry, or a custom backend.
abstract class AppLogger {
  void debug(String message, [Object? error, StackTrace? stackTrace]);
  void info(String message, [Object? error, StackTrace? stackTrace]);
  void warning(String message, [Object? error, StackTrace? stackTrace]);
  void error(String message, [Object? error, StackTrace? stackTrace]);
}

class AppLoggerImpl implements AppLogger {
  static const _tag = '[Ecommerce]';

  @override
  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      // ignore: avoid_print
      print('$_tag DEBUG: $message');
      if (error != null) print(error);
      if (stackTrace != null) print(stackTrace);
    }
  }

  @override
  void info(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      // ignore: avoid_print
      print('$_tag INFO: $message');
      if (error != null) print(error);
    }
  }

  @override
  void warning(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      // ignore: avoid_print
      print('$_tag WARN: $message');
      if (error != null) print(error);
    }
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    // ignore: avoid_print
    print('$_tag ERROR: $message');
    if (error != null) print(error);
    if (stackTrace != null) print(stackTrace);
  }
}
