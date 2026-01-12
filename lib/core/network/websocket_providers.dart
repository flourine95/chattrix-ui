import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:chattrix_ui/core/network/websocket_client.dart';
import 'package:chattrix_ui/core/network/websocket_client_impl.dart';
import 'package:chattrix_ui/core/network/websocket_connection_manager.dart';
import 'package:chattrix_ui/core/network/websocket_message_router.dart';
import 'package:chattrix_ui/core/network/websocket_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'websocket_providers.g.dart';

@Riverpod(keepAlive: true)
WebSocketClient webSocketClient(Ref ref) {
  final client = WebSocketClientImpl();

  ref.onDispose(() => client.dispose());

  return client;
}

@Riverpod(keepAlive: true)
WebSocketMessageRouter webSocketMessageRouter(Ref ref) {
  final router = WebSocketMessageRouter();

  ref.onDispose(() => router.dispose());

  return router;
}

@Riverpod(keepAlive: true)
WebSocketConnectionManager webSocketConnectionManager(Ref ref) {
  final client = ref.watch(webSocketClientProvider);

  final manager = WebSocketConnectionManager(
    client: client,
    reconnectDelay: AppConstants.reconnectDelay,
    heartbeatInterval: AppConstants.heartbeatInterval,
  );

  ref.onDispose(() => manager.dispose());

  return manager;
}

@Riverpod(keepAlive: true)
WebSocketService webSocketService(Ref ref) {
  final connectionManager = ref.watch(webSocketConnectionManagerProvider);
  final messageRouter = ref.watch(webSocketMessageRouterProvider);

  final service = WebSocketService(connectionManager: connectionManager, messageRouter: messageRouter);

  ref.onDispose(() => service.dispose());

  return service;
}
