import 'package:chattrix_ui/features/agora_call/domain/failures/call_failure.dart';
import 'package:flutter/material.dart';

/// Utility class for handling call errors and providing user-friendly messages
/// Requirement 8.1: Handle API errors with user-friendly messages
class CallErrorHandler {
  /// Converts a CallFailure to a user-friendly error message
  static String getErrorMessage(CallFailure failure) {
    return failure.when(
      serverError: (message) {
        // Parse common server error messages
        if (message.toLowerCase().contains('timeout')) {
          return 'The request timed out. Please check your connection and try again.';
        }
        if (message.toLowerCase().contains('maintenance')) {
          return 'The service is currently under maintenance. Please try again later.';
        }
        return 'Unable to complete the call. Please try again.';
      },
      networkError: () => 'No internet connection. Please check your network and try again.',
      userBusy: () => 'The user is currently on another call. Please try again later.',
      callNotFound: () => 'This call is no longer available.',
      permissionDenied: (permission) {
        if (permission.toLowerCase().contains('camera')) {
          return 'Camera permission is required for video calls. Please enable it in settings.';
        }
        if (permission.toLowerCase().contains('microphone')) {
          return 'Microphone permission is required for calls. Please enable it in settings.';
        }
        return 'Permission denied: $permission';
      },
      agoraError: (message) {
        // Parse common Agora error messages
        if (message.toLowerCase().contains('token')) {
          return 'Call authentication failed. Please try again.';
        }
        if (message.toLowerCase().contains('network')) {
          return 'Network connection issue. Please check your internet and try again.';
        }
        if (message.toLowerCase().contains('channel')) {
          return 'Unable to connect to the call. Please try again.';
        }
        return 'Call connection error. Please try again.';
      },
      unauthorized: () => 'Your session has expired. Please log in again.',
    );
  }

  /// Shows an error dialog with a user-friendly message
  /// Requirement 8.1: Display user-friendly error messages
  static void showErrorDialog(BuildContext context, CallFailure failure, {VoidCallback? onDismiss}) {
    final message = getErrorMessage(failure);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Call Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onDismiss?.call();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Shows an error snackbar with a user-friendly message
  /// Requirement 8.1: Display user-friendly error messages
  static void showErrorSnackBar(BuildContext context, CallFailure failure, {VoidCallback? onRetry}) {
    final message = getErrorMessage(failure);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        action: onRetry != null ? SnackBarAction(label: 'Retry', textColor: Colors.white, onPressed: onRetry) : null,
      ),
    );
  }

  /// Shows a quality warning banner without terminating the call
  /// Requirement 8.4: Show quality warnings without terminating call
  static void showQualityWarning(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning_amber, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Shows a network quality degradation warning
  /// Requirement 8.4: Show quality warnings without terminating call
  static void showNetworkQualityWarning(BuildContext context) {
    showQualityWarning(context, 'Poor network quality detected. Call quality may be affected.');
  }

  /// Shows a WebSocket disconnection warning
  /// Requirement 8.3: Handle WebSocket disconnection with notification
  static void showWebSocketDisconnectionWarning(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.cloud_off, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text('Connection lost. Reconnecting...')),
          ],
        ),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 3),
      ),
    );
  }

  /// Shows a WebSocket reconnection success message
  /// Requirement 8.3: Handle WebSocket disconnection with reconnection attempt
  static void showWebSocketReconnectedMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.cloud_done, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text('Connection restored')),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Shows an Agora SDK error dialog with cleanup option
  /// Requirement 8.2: Handle Agora SDK errors with notification and cleanup
  static void showAgoraErrorDialog(BuildContext context, String errorMessage, {required VoidCallback onEndCall}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Connection Error'),
        content: Text('Unable to maintain call connection: $errorMessage\n\nThe call will be ended.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onEndCall();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Shows a permission denied dialog with settings option
  /// Requirement 8.2: Handle permission denied errors
  static void showPermissionDeniedDialog(
    BuildContext context,
    String permission, {
    required VoidCallback onOpenSettings,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Permission Required'),
        content: Text('This call requires $permission permission. Please enable it in app settings to continue.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onOpenSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  /// Shows a user busy notification
  /// Requirement 8.5: Auto-reject incoming calls when user is busy
  static void showUserBusyNotification(BuildContext context, String callerName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Missed call from $callerName (you were busy)'),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(label: 'Dismiss', textColor: Colors.white, onPressed: () {}),
      ),
    );
  }
}
