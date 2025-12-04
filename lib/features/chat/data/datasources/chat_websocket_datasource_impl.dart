import 'dart:async';
import 'dart:convert';

import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/network/websocket_connection_manager.dart';
import 'package:chattrix_ui/core/services/json_parsing_service.dart';
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
  static const String heartbeatAck = 'heartbeat.ack';
  static const String callInvitation = 'call.invitation';
  static const String callResponse = 'call.response';
  static const String callEnded = 'call.ended';
}

/// Implementation of ChatWebSocketDataSource
/// This class handles WebSocket communication for chat feature
class ChatWebSocketDataSourceImpl implements ChatWebSocketDataSource {
  final WebSocketConnectionManager _connectionManager;

  String? _currentToken;

  // Stream controllers for different message types
  final _messageController = StreamController<Message>.broadcast();
  final _typingController = StreamController<TypingIndicator>.broadcast();
  final _userStatusController = StreamController<UserStatusUpdate>.broadcast();
  final _conversationUpdateController = StreamController<ConversationUpdate>.broadcast();
  final _rawMessageController = StreamController<Map<String, dynamic>>.broadcast();

  ChatWebSocketDataSourceImpl({
    required WebSocketConnectionManager connectionManager,
  }) : _connectionManager = connectionManager {
    // Listen to incoming messages and route them
    _connectionManager.client.messageStream.listen(_handleMessage);
  }

  @override
  Future<void> connect(String accessToken) async {
    _currentToken = accessToken;
    final url = ApiConstants.chatWebSocketWithToken(accessToken);
    await _connectionManager.connect(url);
  }

  @override
  Future<void> disconnect() async {
    _currentToken = null;
    await _connectionManager.disconnect();
  }

  @override
  void sendMessage({
    required String conversationId,
    required String content,
    int? replyToMessageId,
  }) {
    final payload = {
      'type': _ChatWebSocketEvent.chatMessage,
      'payload': {
        'conversationId': conversationId,
        'content': content,
        if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
      },
    };

    _connectionManager.client.send(jsonEncode(payload));
  }

  @override
  void sendTypingStart(String conversationId) {
    final payload = {
      'type': _ChatWebSocketEvent.typingStart,
      'payload': {'conversationId': conversationId},
    };

    _connectionManager.client.send(jsonEncode(payload));
  }

  @override
  void sendTypingStop(String conversationId) {
    final payload = {
      'type': _ChatWebSocketEvent.typingStop,
      'payload': {'conversationId': conversationId},
    };

    _connectionManager.client.send(jsonEncode(payload));
  }

  @override
  void sendGenericMessage(Map<String, dynamic> payload) {
    _connectionManager.client.send(jsonEncode(payload));
  }

  /// Handle incoming WebSocket messages
  Future<void> _handleMessage(String messageString) async {
    try {
      // Decode the wrapper to get the type
      final data = jsonDecode(messageString) as Map<String, dynamic>;
      final type = data['type'] as String?;

      print('🔌 [WebSocketDataSource] Received message type: $type');

      if (type == null) {
        // Server might send message directly without wrapper
        final messageEntity = await JsonParsingService.parseMessage(messageString);
        _messageController.add(messageEntity);
        return;
      }

      // Emit raw message for custom handlers (like call signaling)
      _rawMessageController.add(data);

      // Extract payload - try 'payload' first, then 'data' for backward compatibility
      final payload = data['payload'] ?? data['data'];
      if (payload == null) {
        print('🔌 [WebSocketDataSource] Message has no payload/data');
        return;
      }

      // Convert payload to JSON string for background parsing
      final payloadString = jsonEncode(payload);

      // Route message based on type
      switch (type) {
        case _ChatWebSocketResponse.chatMessage:
          final messageEntity = await JsonParsingService.parseMessage(payloadString);
          _messageController.add(messageEntity);
          break;

        case _ChatWebSocketResponse.typingIndicator:
          final indicatorEntity = await JsonParsingService.parseTypingIndicator(payloadString);
          _typingController.add(indicatorEntity);
          break;

        case _ChatWebSocketResponse.userStatus:
          final statusEntity = await JsonParsingService.parseUserStatusUpdate(payloadString);
          _userStatusController.add(statusEntity);
          break;

        case _ChatWebSocketResponse.conversationUpdate:
          final updateEntity = await JsonParsingService.parseConversationUpdate(payloadString);
          _conversationUpdateController.add(updateEntity);
          break;

        case _ChatWebSocketResponse.heartbeatAck:
          // Heartbeat acknowledged - no action needed
          break;

        case _ChatWebSocketResponse.callInvitation:
        case _ChatWebSocketResponse.callResponse:
        case _ChatWebSocketResponse.callEnded:
          // These are handled through rawMessageStream by CallSignalingService
          break;

        default:
          print('🔌 [WebSocketDataSource] Unknown message type: $type');
          break;
      }
    } catch (e, stackTrace) {
      print('🔌 [WebSocketDataSource] Error parsing message: $e');
      print('🔌 [WebSocketDataSource] Stack trace: $stackTrace');
    }
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
  Stream<bool> get connectionStream => _connectionManager.client.connectionStream;

  @override
  Stream<Map<String, dynamic>> get rawMessageStream => _rawMessageController.stream;

  @override
  bool get isConnected => _connectionManager.client.isConnected;

  @override
  void dispose() {
    _messageController.close();
    _typingController.close();
    _userStatusController.close();
    _conversationUpdateController.close();
    _rawMessageController.close();
    _connectionManager.dispose();
  }
}

