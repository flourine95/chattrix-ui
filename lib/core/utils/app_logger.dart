import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

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

  static const String _debugEmoji = '🔍';
  static const String _infoEmoji = 'ℹ️';
  static const String _warningEmoji = '⚠️';
  static const String _errorEmoji = '❌';
  static const String _successEmoji = '✅';

  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      _logger.d('$_debugEmoji [${tag ?? 'App'}] $message');
    }
  }

  static void info(String message, {String? tag}) {
    _logger.i('$_infoEmoji [${tag ?? 'App'}] $message');
  }

  static void success(String message, {String? tag}) {
    _logger.i('$_successEmoji [${tag ?? 'App'}] $message');
  }

  static void warning(String message, {String? tag}) {
    _logger.w('$_warningEmoji [${tag ?? 'App'}] $message');
  }

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

class _ProductionFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode;
  }
}

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

