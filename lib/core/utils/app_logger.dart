import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Centralized logging utility for the entire application
///
/// Usage:
/// - AppLogger.debug('Debug message', tag: 'MyClass');
/// - AppLogger.info('Info message', tag: 'MyClass');
/// - AppLogger.warning('Warning message', tag: 'MyClass');
/// - AppLogger.error('Error message', error: e, stackTrace: st, tag: 'MyClass');
class AppLogger {
  static final _logger = Logger(
    filter: _ProductionFilter(),
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  // Emoji prefixes for better visual distinction
  static const String _debugEmoji = '🔍';
  static const String _infoEmoji = 'ℹ️';
  static const String _warningEmoji = '⚠️';
  static const String _errorEmoji = '❌';
  static const String _successEmoji = '✅';

  /// Log debug messages (only in debug mode)
  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      _logger.d('$_debugEmoji [${tag ?? 'App'}] $message');
    }
  }

  /// Log info messages
  static void info(String message, {String? tag}) {
    _logger.i('$_infoEmoji [${tag ?? 'App'}] $message');
  }

  /// Log success messages
  static void success(String message, {String? tag}) {
    _logger.i('$_successEmoji [${tag ?? 'App'}] $message');
  }

  /// Log warning messages
  static void warning(String message, {String? tag}) {
    _logger.w('$_warningEmoji [${tag ?? 'App'}] $message');
  }

  /// Log error messages with optional error object and stack trace
  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    _logger.e(
      '$_errorEmoji [${tag ?? 'App'}] $message',
      error: error,
      stackTrace: stackTrace,
    );
  }

  // Module-specific loggers for consistent tagging
  static void websocket(String message, {bool isError = false}) {
    if (isError) {
      error(message, tag: 'WebSocket');
    } else {
      debug(message, tag: 'WebSocket');
    }
  }

  static void call(String message, {bool isError = false}) {
    if (isError) {
      error(message, tag: 'Call');
    } else {
      debug(message, tag: 'Call');
    }
  }

  static void chat(String message, {bool isError = false}) {
    if (isError) {
      error(message, tag: 'Chat');
    } else {
      debug(message, tag: 'Chat');
    }
  }

  static void auth(String message, {bool isError = false}) {
    if (isError) {
      error(message, tag: 'Auth');
    } else {
      debug(message, tag: 'Auth');
    }
  }

  static void media(String message, {bool isError = false}) {
    if (isError) {
      error(message, tag: 'Media');
    } else {
      debug(message, tag: 'Media');
    }
  }
}

/// Custom filter to only show logs in debug mode
class _ProductionFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode;
  }
}

// Legacy support - deprecated, use AppLogger instead
@Deprecated('Use AppLogger instead')
final appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);

