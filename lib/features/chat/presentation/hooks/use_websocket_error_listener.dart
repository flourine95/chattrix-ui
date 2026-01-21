import 'package:chattrix_ui/core/network/websocket_providers.dart';
import 'package:chattrix_ui/core/toast/toastification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Hook to listen for WebSocket error messages and display toasts
/// 
/// Handles errors like:
/// - "You are muted in this conversation"
/// - "You are not a member of this conversation"
/// - "Message send failed"
/// - etc.
void useWebSocketErrorListener(BuildContext context, WidgetRef ref) {
  useEffect(() {
    final wsService = ref.read(webSocketServiceProvider);
    
    // Listen for error messages from WebSocket
    // Backend sends errors with type "error" or "chat.error"
    final subscription = wsService.messageRouter
        .getStreamForTypes(['error', 'chat.error', 'message.error'])
        .listen((message) {
      debugPrint('❌ [WS-Error] Received error message: $message');
      
      // Extract error message
      final errorMessage = message['message'] as String? ?? 
                          message['error'] as String? ?? 
                          'An error occurred';
      
      final errorCode = message['code'] as String?;
      
      // Show error toast
      if (context.mounted) {
        AppToast.error(
          context,
          title: 'Error',
          description: errorMessage,
        );
      }
      
      debugPrint('❌ [WS-Error] Code: $errorCode, Message: $errorMessage');
    });
    
    return subscription.cancel;
  }, []);
}
