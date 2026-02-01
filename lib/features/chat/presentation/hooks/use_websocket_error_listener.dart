import 'package:chattrix_ui/core/network/websocket_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Hook to listen for WebSocket error messages and display toasts
///
/// Handles errors like:
/// - "You don't have permission to send messages in this group"
/// - "You are muted in this conversation"
/// - "You are not a member of this conversation"
/// - etc.
void useWebSocketErrorListener(BuildContext context, WidgetRef ref) {
  useEffect(() {
    final wsService = ref.read(webSocketServiceProvider);

    // Listen for error messages from WebSocket
    // Backend sends errors with type "error" or "chat.error"
    final subscription = wsService.messageRouter.getStreamForTypes(['error', 'chat.error', 'message.error']).listen((
      message,
    ) {
      debugPrint('❌ [WS-Error] Received error message: $message');

      // Extract error from payload first, then fallback to root level
      final payload = message['payload'] as Map<String, dynamic>?;
      final errorMessage =
          payload?['error'] as String? ??
          message['message'] as String? ??
          message['error'] as String? ??
          'An error occurred';

      final errorCode = payload?['code'] as String? ?? message['code'] as String?;
      final originalType = payload?['originalType'] as String?;

      // Map error codes to user-friendly messages
      String displayMessage = errorMessage;
      IconData icon = Icons.error_outline;

      if (errorCode == 'FORBIDDEN') {
        if (originalType == 'chat.message') {
          displayMessage = 'You don\'t have permission to send messages';
          icon = Icons.block;
        } else {
          displayMessage = 'You don\'t have permission to perform this action';
          icon = Icons.block;
        }
      } else if (errorCode == 'MUTED') {
        displayMessage = 'You are muted in this conversation';
        icon = Icons.volume_off;
      } else if (errorCode == 'NOT_MEMBER') {
        displayMessage = 'You are not a member of this conversation';
        icon = Icons.person_off;
      } else if (errorCode == 'NOT_FOUND') {
        displayMessage = 'Conversation not found';
        icon = Icons.search_off;
      }

      // Show error toast with icon
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(displayMessage, style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            duration: const Duration(seconds: 3),
          ),
        );
      }

      debugPrint('❌ [WS-Error] Code: $errorCode, Type: $originalType, Message: $displayMessage');
    });

    return subscription.cancel;
  }, []);
}
