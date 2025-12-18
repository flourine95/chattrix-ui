import 'dart:async';

import 'package:chattrix_ui/core/network/websocket_service.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_update_model.dart';
import 'package:chattrix_ui/features/chat/data/models/typing_indicator_model.dart';
import 'package:chattrix_ui/features/chat/data/models/user_status_update_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_websocket_datasource.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation_update.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status_update.dart';

/// WebSocket event types sent from client to server
class _ChatWebSocketEvent {
  static const String chatMessage = 'chat.message';
  static const String typingStart = 'typing.start';
  static const String typingStop = 'typing.stop';
}

/// WebSocket event types received from server
class _ChatWebSocketResponse {
  static const String chatMessage = 'chat.message';
  static const String typingIndicator = 'typing.indicator';
  static const String userStatus = 'user.status';
  static const String conversationUpdate = 'conversation.update';
}

/// Implementation of ChatWebSocketDataSource
class ChatWebSocketDataSourceImpl implements ChatWebSocketDataSource {
  final WebSocketService _webSocketService;
  StreamSubscription<Map<String, dynamic>>? _subscription;

  // Stream controllers for different message types
  final _messageController = StreamController<Message>.broadcast();
  final _typingController = StreamController<TypingIndicator>.broadcast();
  final _userStatusController = StreamController<UserStatusUpdate>.broadcast();
  final _conversationUpdateController = StreamController<ConversationUpdate>.broadcast();

  ChatWebSocketDataSourceImpl({required WebSocketService webSocketService}) : _webSocketService = webSocketService {
    _startListening();
  }

  void _startListening() {
    // Listen to chat-related messages only
    final chatMessageTypes = [
      _ChatWebSocketResponse.chatMessage,
      _ChatWebSocketResponse.typingIndicator,
      _ChatWebSocketResponse.userStatus,
      _ChatWebSocketResponse.conversationUpdate,
    ];

    _subscription = _webSocketService.messageRouter
        .getStreamForTypes(chatMessageTypes)
        .listen(
          _handleMessage,
          onError: (error, stackTrace) {
            AppLogger.error(
              'WebSocket message stream error',
              error: error,
              stackTrace: stackTrace,
              tag: 'ChatWebSocketDataSource',
            );
          },
        );

    AppLogger.debug('Started listening for chat events', tag: 'ChatWebSocketDataSource');
  }

  void _handleMessage(Map<String, dynamic> message) {
    try {
      final type = message['type'] as String?;
      if (type == null) {
        AppLogger.warning('Received message without type field', tag: 'ChatWebSocketDataSource');
        return;
      }

      final payload = message['payload'] ?? message['data'];
      if (payload == null) {
        AppLogger.warning(
          'Received message without payload/data field for type: $type',
          tag: 'ChatWebSocketDataSource',
        );
        return;
      }

      AppLogger.debug('Processing WebSocket message: $type', tag: 'ChatWebSocketDataSource');

      switch (type) {
        case _ChatWebSocketResponse.chatMessage:
          try {
            final messageEntity = MessageModel.fromApi(payload as Map<String, dynamic>).toEntity();
            _messageController.add(messageEntity);
            AppLogger.debug('Successfully processed chat message', tag: 'ChatWebSocketDataSource');
          } catch (e, st) {
            AppLogger.error('Failed to parse chat message', error: e, stackTrace: st, tag: 'ChatWebSocketDataSource');
          }
          break;

        case _ChatWebSocketResponse.typingIndicator:
          try {
            final indicatorEntity = TypingIndicatorModel.fromJson(payload as Map<String, dynamic>).toEntity();
            _typingController.add(indicatorEntity);
            AppLogger.debug(
              'Typing indicator: conversationId=${indicatorEntity.conversationId}, users=${indicatorEntity.typingUsers.length}',
              tag: 'ChatWebSocketDataSource',
            );
          } catch (e, st) {
            AppLogger.error(
              'Failed to parse typing indicator',
              error: e,
              stackTrace: st,
              tag: 'ChatWebSocketDataSource',
            );
          }
          break;

        case _ChatWebSocketResponse.userStatus:
          try {
            final statusEntity = UserStatusUpdateModel.fromJson(payload as Map<String, dynamic>).toEntity();
            _userStatusController.add(statusEntity);
            AppLogger.debug('User status update: userId=${statusEntity.userId}', tag: 'ChatWebSocketDataSource');
          } catch (e, st) {
            AppLogger.error(
              'Failed to parse user status update',
              error: e,
              stackTrace: st,
              tag: 'ChatWebSocketDataSource',
            );
          }
          break;

        case _ChatWebSocketResponse.conversationUpdate:
          try {
            final updateEntity = ConversationUpdateModel.fromJson(payload as Map<String, dynamic>).toEntity();
            _conversationUpdateController.add(updateEntity);
            AppLogger.debug(
              'Conversation update: conversationId=${updateEntity.conversationId}',
              tag: 'ChatWebSocketDataSource',
            );
          } catch (e, st) {
            AppLogger.error(
              'Failed to parse conversation update',
              error: e,
              stackTrace: st,
              tag: 'ChatWebSocketDataSource',
            );
          }
          break;

        default:
          AppLogger.warning('Unknown message type: $type', tag: 'ChatWebSocketDataSource');
      }
    } catch (e, stackTrace) {
      // Catch-all for any unexpected errors
      AppLogger.error(
        'Unexpected error handling WebSocket message',
        error: e,
        stackTrace: stackTrace,
        tag: 'ChatWebSocketDataSource',
      );
    }
  }

  @override
  Future<void> connect(String accessToken) async {
    // Connection is managed by WebSocketService
    // This method is kept for interface compatibility but does nothing
    AppLogger.debug('Connect called (handled by WebSocketService)', tag: 'ChatWebSocketDataSource');
  }

  @override
  Future<void> disconnect() async {
    // Disconnection is managed by WebSocketService
    AppLogger.debug('Disconnect called (handled by WebSocketService)', tag: 'ChatWebSocketDataSource');
  }

  @override
  void sendMessage(String conversationId, ChatMessageRequest request) {
    final messageData = request.toJson();

    messageData['conversationId'] = conversationId;

    final wsPayload = {
      'type': _ChatWebSocketEvent.chatMessage,
      'payload': messageData,
    };

    _webSocketService.send(wsPayload);
  }

  @override
  void sendTypingStart(String conversationId) {
    final payload = {
      'type': _ChatWebSocketEvent.typingStart,
      'payload': {'conversationId': conversationId},
    };

    _webSocketService.send(payload);
  }

  @override
  void sendTypingStop(String conversationId) {
    final payload = {
      'type': _ChatWebSocketEvent.typingStop,
      'payload': {'conversationId': conversationId},
    };

    _webSocketService.send(payload);
  }

  @override
  void sendGenericMessage(Map<String, dynamic> payload) {
    _webSocketService.send(payload);
  }

  @override
  Stream<Message> get messageStream => _messageController.stream;

  @override
  Stream<TypingIndicator> get typingStream => _typingController.stream;

  @override
  Stream<UserStatusUpdate> get userStatusStream => _userStatusController.stream;

  @override
  Stream<ConversationUpdate> get conversationUpdateStream => _conversationUpdateController.stream;

  @override
  Stream<bool> get connectionStream => _webSocketService.connectionStream;

  @override
  Stream<Map<String, dynamic>> get rawMessageStream => _webSocketService.messageRouter.rawMessageStream;

  @override
  bool get isConnected => _webSocketService.isConnected;

  @override
  void dispose() {
    _subscription?.cancel();
    _messageController.close();
    _typingController.close();
    _userStatusController.close();
    _conversationUpdateController.close();
  }
}
