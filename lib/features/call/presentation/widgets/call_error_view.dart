import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:flutter/material.dart';

/// Widget that displays error states during calls
/// Provides user-friendly error messages and retry options
class CallErrorView extends StatelessWidget {
  const CallErrorView({super.key, required this.error, this.onRetry, this.onDismiss});

  final Object error;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final errorInfo = _getErrorInfo(error);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(errorInfo.icon, color: errorInfo.color, size: 64),
                const SizedBox(height: 24),
                Text(
                  errorInfo.title,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  errorInfo.message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 32),
                if (errorInfo.canRetry && onRetry != null)
                  ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
                  ),
                if (errorInfo.canRetry && onRetry != null) const SizedBox(height: 16),
                TextButton(
                  onPressed: onDismiss,
                  child: Text(onDismiss != null ? 'Go Back' : 'Dismiss', style: const TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _ErrorInfo _getErrorInfo(Object error) {
    if (error is Failure) {
      // Use the userMessage extension for user-friendly error messages
      final userFriendlyMessage = error.userMessage;

      return error.when(
        server: (message, errorCode) => _ErrorInfo(
          icon: Icons.cloud_off,
          color: Colors.red,
          title: 'Server Error',
          message: userFriendlyMessage,
          canRetry: true,
        ),
        network: (message) => _ErrorInfo(
          icon: Icons.wifi_off,
          color: Colors.orange,
          title: 'Connection Error',
          message: userFriendlyMessage,
          canRetry: true,
        ),
        validation: (message, errors) => _ErrorInfo(
          icon: Icons.error_outline,
          color: Colors.red,
          title: 'Invalid Request',
          message: userFriendlyMessage,
          canRetry: false,
        ),
        badRequest: (message, errorCode) => _ErrorInfo(
          icon: Icons.error_outline,
          color: Colors.red,
          title: 'Bad Request',
          message: userFriendlyMessage,
          canRetry: false,
        ),
        unauthorized: (message, errorCode) => _ErrorInfo(
          icon: Icons.lock_outline,
          color: Colors.red,
          title: 'Unauthorized',
          message: userFriendlyMessage,
          canRetry: false,
        ),
        forbidden: (message, errorCode) => _ErrorInfo(
          icon: Icons.block,
          color: Colors.red,
          title: 'Access Denied',
          message: userFriendlyMessage,
          canRetry: false,
        ),
        notFound: (message, errorCode) => _ErrorInfo(
          icon: Icons.search_off,
          color: Colors.orange,
          title: 'Not Found',
          message: userFriendlyMessage,
          canRetry: false,
        ),
        conflict: (message, errorCode) => _ErrorInfo(
          icon: Icons.warning_amber,
          color: Colors.orange,
          title: 'Conflict',
          message: userFriendlyMessage,
          canRetry: false,
        ),
        rateLimitExceeded: (message) => _ErrorInfo(
          icon: Icons.timer_off,
          color: Colors.orange,
          title: 'Too Many Requests',
          message: userFriendlyMessage,
          canRetry: true,
        ),
        unknown: (message) => _ErrorInfo(
          icon: Icons.error_outline,
          color: Colors.red,
          title: 'Unknown Error',
          message: userFriendlyMessage,
          canRetry: true,
        ),
        permission: (message) => _ErrorInfo(
          icon: Icons.block,
          color: Colors.orange,
          title: 'Permission Required',
          message: userFriendlyMessage,
          canRetry: false,
        ),
        agoraEngine: (message, code) => _ErrorInfo(
          icon: Icons.videocam_off,
          color: Colors.red,
          title: 'Call Engine Error',
          message: userFriendlyMessage,
          canRetry: true,
        ),
        tokenExpired: (message) => _ErrorInfo(
          icon: Icons.lock_clock,
          color: Colors.orange,
          title: 'Session Expired',
          message: userFriendlyMessage,
          canRetry: true,
        ),
        channelJoin: (message) => _ErrorInfo(
          icon: Icons.phone_disabled,
          color: Colors.red,
          title: 'Failed to Join Call',
          message: userFriendlyMessage,
          canRetry: true,
        ),
      );
    }

    // Generic error
    return _ErrorInfo(
      icon: Icons.error_outline,
      color: Colors.red,
      title: 'Error',
      message: error.toString(),
      canRetry: true,
    );
  }
}

class _ErrorInfo {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final bool canRetry;

  _ErrorInfo({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.canRetry,
  });
}
