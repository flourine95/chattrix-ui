import 'package:chattrix_ui/features/call/data/services/call_signaling_service.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'call_signaling_provider.g.dart';

/// Provider for CallSignalingService
@riverpod
CallSignalingService callSignalingService(Ref ref) {
  // Get the WebSocket service from the chat feature
  final webSocketService = ref.watch(chatWebSocketServiceProvider);

  final service = CallSignalingService(webSocketService: webSocketService);

  // Dispose when provider is disposed
  ref.onDispose(() {
    service.dispose();
  });

  return service;
}
