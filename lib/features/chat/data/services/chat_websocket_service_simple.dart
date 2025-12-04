import 'dart:async';
import 'dart:convert';

import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/network/websocket_manager_simple.dart';
import 'package:chattrix_ui/core/services/json_parsing_service.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation_update.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status_update.dart';

/// Simple Chat WebSocket Service - No interfaces, managed by Riverpod
/// Đơn giản hơn, không cần viết interface abstract class
class ChatWebSocketService {
  final WebSocketManager _wsManager;

  // Stream controllers for different message types
  final _messageController = StreamController<Message>.broadcast();
  final _typingController = StreamController<TypingIndicator>.broadcast();
  final _userStatusController = StreamController<UserStatusUpdate>.broadcast();
  final _conversationUpdateController = StreamController<ConversationUpdate>.broadcast();
  final _rawMessageController = StreamController<Map<String, dynamic>>.broadcast();

  ChatWebSocketService({required WebSocketManager wsManager}) : _wsManager = wsManager {
    // Listen to raw WebSocket messages and route them
    _wsManager.messageStream.listen(_handleMessage);
  }

  // Public streams
  Stream<Message> get messageStream => _messageController.stream;
  Stream<TypingIndicator> get typingStream => _typingController.stream;
  Stream<UserStatusUpdate> get userStatusStream => _userStatusController.stream;
  Stream<ConversationUpdate> get conversationUpdateStream => _conversationUpdateController.stream;
  Stream<bool> get connectionStream => _wsManager.connectionStream;
  Stream<Map<String, dynamic>> get rawMessageStream => _rawMessageController.stream;
  bool get isConnected => _wsManager.isConnected;

  /// Connect to chat WebSocket
  Future<void> connect(String accessToken) async {
    final url = ApiConstants.chatWebSocketWithToken(accessToken);
    await _wsManager.connect(url);
  }

  /// Disconnect
  Future<void> disconnect() async {
    await _wsManager.disconnect();
  }

  /// Send chat message
  void sendMessage({
    required String conversationId,
    required String content,
    int? replyToMessageId,
  }) {
    final payload = {
      'type': 'chat.message',
      'payload': {
        'conversationId': conversationId,
        'content': content,
        if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
      },
    };
    _wsManager.send(jsonEncode(payload));
  }

  /// Send typing start
  void sendTypingStart(String conversationId) {
    final payload = {
      'type': 'typing.start',
      'payload': {'conversationId': conversationId},
    };
    _wsManager.send(jsonEncode(payload));
  }

  /// Send typing stop
  void sendTypingStop(String conversationId) {
    final payload = {
      'type': 'typing.stop',
      'payload': {'conversationId': conversationId},
    };
    _wsManager.send(jsonEncode(payload));
  }

  /// Send generic message (for call signaling, etc.)
  void sendGenericMessage(Map<String, dynamic> payload) {
    _wsManager.send(jsonEncode(payload));
  }

  /// Handle incoming messages and route to appropriate streams
  Future<void> _handleMessage(String messageString) async {
    try {
      final data = jsonDecode(messageString) as Map<String, dynamic>;
      final type = data['type'] as String?;

      print('🔌 [ChatWebSocket] Received: $type');

      if (type == null) {
        // Direct message without wrapper
        final message = await JsonParsingService.parseMessage(messageString);
        _messageController.add(message);
        return;
      }

      // Emit raw message for custom handlers (call signaling)
      _rawMessageController.add(data);

      // Extract payload
      final payload = data['payload'] ?? data['data'];
      if (payload == null) return;

      final payloadString = jsonEncode(payload);

      // Route by message type
      switch (type) {
        case 'chat.message':
          final message = await JsonParsingService.parseMessage(payloadString);
          _messageController.add(message);
          break;

        case 'typing.indicator':
          final indicator = await JsonParsingService.parseTypingIndicator(payloadString);
          _typingController.add(indicator);
          break;

        case 'user.status':
          final status = await JsonParsingService.parseUserStatusUpdate(payloadString);
          _userStatusController.add(status);
          break;

        case 'conversation.update':
          final update = await JsonParsingService.parseConversationUpdate(payloadString);
          _conversationUpdateController.add(update);
          break;

        case 'heartbeat.ack':
          // Acknowledged
          break;

        case 'call.incoming':
        case 'call.accepted':
        case 'call.rejected':
        case 'call.ended':
        case 'call.timeout':
          // Handled by CallWebSocketHandler via rawMessageStream
          break;

        default:
          print('🔌 [ChatWebSocket] Unknown type: $type');
          break;
      }
    } catch (e, stackTrace) {
      print('🔌 [ChatWebSocket] Parse error: $e');
      print(stackTrace);
    }
  }

  /// Dispose (called by Riverpod)
  void dispose() {
    print('🔌 [ChatWebSocket] Disposing...');
    _messageController.close();
    _typingController.close();
    _userStatusController.close();
    _conversationUpdateController.close();
    _rawMessageController.close();
  }
}

