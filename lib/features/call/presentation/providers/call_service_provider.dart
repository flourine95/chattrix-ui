import 'package:chattrix_ui/features/call/services/agora_service.dart';
import 'package:chattrix_ui/features/call/services/call_websocket_handler_new.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final agoraServiceProvider = Provider<AgoraService>((ref) {
  final service = AgoraService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});

final callWebSocketHandlerProvider = Provider<CallWebSocketHandler>((ref) {
  final webSocketDataSource = ref.watch(chatWebSocketDataSourceProvider);
  final handler = CallWebSocketHandler(webSocketDataSource: webSocketDataSource);
  handler.startListening();

  ref.onDispose(() {
    handler.dispose();
  });

  return handler;
});

