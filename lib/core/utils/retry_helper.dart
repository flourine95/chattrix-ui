import 'dart:async';
import 'package:flutter/foundation.dart';

/// Helper class for implementing exponential backoff retry logic
///
/// Used for handling transient failures like network timeouts
class RetryHelper {
  /// Execute an operation with exponential backoff retry
  ///
  /// **Parameters:**
  /// - [operation]: The async operation to retry
  /// - [maxAttempts]: Maximum number of retry attempts (default: 3)
  /// - [initialDelay]: Initial delay before first retry (default: 1 second)
  /// - [maxDelay]: Maximum delay between retries (default: 10 seconds)
  /// - [shouldRetry]: Optional function to determine if error should be retried
  ///
  /// **Returns:** Result of the operation
  ///
  /// **Throws:** Last error if all retries fail
  static Future<T> retry<T>({
    required Future<T> Function() operation,
    int maxAttempts = 3,
    Duration initialDelay = const Duration(seconds: 1),
    Duration maxDelay = const Duration(seconds: 10),
    bool Function(Object error)? shouldRetry,
  }) async {
    int attempt = 0;
    Duration delay = initialDelay;

    while (true) {
      try {
        attempt++;
        debugPrint('🔄 Retry attempt $attempt/$maxAttempts');
        return await operation();
      } catch (error) {
        // Check if we should retry this error
        if (shouldRetry != null && !shouldRetry(error)) {
          debugPrint('❌ Error not retryable: $error');
          rethrow;
        }

        // Check if we've exhausted all attempts
        if (attempt >= maxAttempts) {
          debugPrint('❌ All retry attempts exhausted ($maxAttempts)');
          rethrow;
        }

        // Calculate next delay with exponential backoff
        debugPrint('⏳ Waiting ${delay.inSeconds}s before retry...');
        await Future.delayed(delay);

        // Exponential backoff: double the delay, but cap at maxDelay
        delay = Duration(
          milliseconds: (delay.inMilliseconds * 2).clamp(initialDelay.inMilliseconds, maxDelay.inMilliseconds),
        );
      }
    }
  }

  /// Check if an error is a network-related error that should be retried
  static bool isNetworkError(Object error) {
    final errorString = error.toString().toLowerCase();
    return errorString.contains('timeout') ||
        errorString.contains('connection') ||
        errorString.contains('network') ||
        errorString.contains('no_connection');
  }
}
