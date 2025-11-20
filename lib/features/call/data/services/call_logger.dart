import 'dart:developer' as developer;

import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';

/// Logger service for call-related events and errors
/// Logs all Failure objects, quality metrics, and call events for debugging
class CallLogger {
  static const String _tag = 'CallLogger';

  /// Log a failure with context
  static void logFailure(Failure failure, {String? context, StackTrace? stackTrace}) {
    final contextStr = context != null ? ' [$context]' : '';
    final message = failure.when(
      server: (msg, code) => 'Server Error$contextStr: $msg${code != null ? ' (Code: $code)' : ''}',
      network: (msg) => 'Network Error$contextStr: $msg',
      validation: (msg, errors) => 'Validation Error$contextStr: $msg',
      badRequest: (msg, code) => 'Bad Request$contextStr: $msg${code != null ? ' (Code: $code)' : ''}',
      unauthorized: (msg, code) => 'Unauthorized$contextStr: $msg${code != null ? ' (Code: $code)' : ''}',
      forbidden: (msg, code) => 'Forbidden$contextStr: $msg${code != null ? ' (Code: $code)' : ''}',
      notFound: (msg, code) => 'Not Found$contextStr: $msg${code != null ? ' (Code: $code)' : ''}',
      conflict: (msg, code) => 'Conflict$contextStr: $msg${code != null ? ' (Code: $code)' : ''}',
      rateLimitExceeded: (msg) => 'Rate Limit Exceeded$contextStr: $msg',
      unknown: (msg) => 'Unknown Error$contextStr: $msg',
      permission: (msg) => 'Permission Error$contextStr: $msg',
      agoraEngine: (msg, code) => 'Agora Engine Error$contextStr: $msg${code != null ? ' (Code: $code)' : ''}',
      tokenExpired: (msg) => 'Token Expired$contextStr: $msg',
      channelJoin: (msg) => 'Channel Join Error$contextStr: $msg',
    );

    developer.log(
      message,
      name: _tag,
      level: 1000, // Error level
      error: failure,
      stackTrace: stackTrace,
    );
  }

  /// Log network quality metrics
  static void logNetworkQuality({
    required String callId,
    required NetworkQuality quality,
    int? txBitrate,
    int? rxBitrate,
    int? txPacketLossRate,
    int? rxPacketLossRate,
  }) {
    final metrics = StringBuffer('Network Quality: ${quality.name}');
    if (txBitrate != null) metrics.write(', TX: ${txBitrate}kbps');
    if (rxBitrate != null) metrics.write(', RX: ${rxBitrate}kbps');
    if (txPacketLossRate != null) metrics.write(', TX Loss: $txPacketLossRate%');
    if (rxPacketLossRate != null) metrics.write(', RX Loss: $rxPacketLossRate%');

    developer.log(
      '[Call: $callId] $metrics',
      name: _tag,
      level: 800, // Info level
    );
  }

  /// Log call events
  static void logCallEvent({required String callId, required String event, Map<String, dynamic>? details}) {
    final detailsStr = details != null ? ' - ${details.entries.map((e) => '${e.key}: ${e.value}').join(', ')}' : '';
    developer.log(
      '[Call: $callId] $event$detailsStr',
      name: _tag,
      level: 800, // Info level
    );
  }

  /// Log call state changes
  static void logCallStateChange({
    required String callId,
    required CallStatus oldStatus,
    required CallStatus newStatus,
  }) {
    developer.log(
      '[Call: $callId] State changed: ${oldStatus.name} -> ${newStatus.name}',
      name: _tag,
      level: 800, // Info level
    );
  }

  /// Log media control changes
  static void logMediaControl({required String callId, required String control, required bool enabled}) {
    developer.log(
      '[Call: $callId] $control: ${enabled ? 'enabled' : 'disabled'}',
      name: _tag,
      level: 800, // Info level
    );
  }

  /// Log permission requests
  static void logPermissionRequest({required String permission, required bool granted}) {
    developer.log(
      'Permission $permission: ${granted ? 'granted' : 'denied'}',
      name: _tag,
      level: granted ? 800 : 900, // Info or Warning level
    );
  }

  /// Log token operations
  static void logTokenOperation({required String operation, required bool success, String? error}) {
    final status = success ? 'succeeded' : 'failed';
    final errorStr = error != null ? ' - $error' : '';
    developer.log(
      'Token $operation $status$errorStr',
      name: _tag,
      level: success ? 800 : 1000, // Info or Error level
    );
  }

  /// Log general debug information
  static void logDebug(String message) {
    developer.log(
      message,
      name: _tag,
      level: 500, // Debug level
    );
  }

  /// Log general info
  static void logInfo(String message) {
    developer.log(
      message,
      name: _tag,
      level: 800, // Info level
    );
  }

  /// Log warnings
  static void logWarning(String message) {
    developer.log(
      message,
      name: _tag,
      level: 900, // Warning level
    );
  }

  /// Log errors
  static void logError(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: _tag,
      level: 1000, // Error level
      error: error,
      stackTrace: stackTrace,
    );
  }
}
