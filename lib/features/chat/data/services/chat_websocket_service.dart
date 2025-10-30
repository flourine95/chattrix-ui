import 'dart:async';
import 'dart:convert';

import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_update_model.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/data/models/typing_indicator_model.dart';
import 'package:chattrix_ui/features/chat/data/models/user_status_update_model.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation_update.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status_update.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// WebSocket events from client to server
class ChatWebSocketEvent {
  static const String chatMessage = 'chat.message';
  static const String typingStart = 'typing.start';
  static const String typingStop = 'typing.stop';
}

/// WebSocket events from server to client
class ChatWebSocketResponse {
  static const String chatMessage = 'chat.message';
  static const String typingIndicator = 'typing.indicator';
  static const String userStatus = 'user.status';
  static const String conversationUpdate = 'conversation.update';
  static const String heartbeatAck = 'heartbeat.ack';
}

class ChatWebSocketService {
  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  String? _lastAccessToken;
  bool _isManualDisconnect = false;

  // Stream controllers now emit entities instead of models
  final _messageController = StreamController<Message>.broadcast();
  final _typingController = StreamController<TypingIndicator>.broadcast();
  final _userStatusController = StreamController<UserStatusUpdate>.broadcast();
  final _conversationUpdateController =
      StreamController<ConversationUpdate>.broadcast();
  final _connectionController = StreamController<bool>.broadcast();

  Stream<Message> get messageStream => _messageController.stream;

  Stream<TypingIndicator> get typingStream => _typingController.stream;

  Stream<UserStatusUpdate> get userStatusStream => _userStatusController.stream;

  Stream<ConversationUpdate> get conversationUpdateStream =>
      _conversationUpdateController.stream;

  Stream<bool> get connectionStream => _connectionController.stream;

  bool get isConnected => _channel != null;

  /// Connect to WebSocket
  Future<void> connect(String accessToken) async {
    if (_channel != null) {
      debugPrint('⚠️ WebSocket already connected');
      return;
    }

    try {
      _lastAccessToken = accessToken;
      _isManualDisconnect = false;

      final wsUrl =
          '${ApiConstants.wsBaseUrl}/${ApiConstants.chatWebSocket}?token=$accessToken';
      debugPrint('🔌 Connecting to WebSocket: $wsUrl');

      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      _connectionController.add(true);
      debugPrint('✅ WebSocket connected');
      debugPrint('   Ready state: ${_channel!.closeCode == null ? "OPEN" : "CLOSED"}');

      // Start heartbeat timer
      _startHeartbeat();

      // Listen to messages from server
      _channel!.stream.listen(
        (message) {
          debugPrint('📨 [WebSocket] Message received from server');
          _handleMessage(message);
        },
        onError: (error, stackTrace) {
          debugPrint('❌ [WebSocket] Stream error: $error');
          debugPrint('   Error type: ${error.runtimeType}');
          debugPrint('Stack trace: $stackTrace');
          _handleDisconnect();
        },
        onDone: () {
          debugPrint('🔌 [WebSocket] Stream closed (onDone called)');
          debugPrint('   Manual disconnect: $_isManualDisconnect');
          debugPrint('   Channel null: ${_channel == null}');
          debugPrint('   Close code: ${_channel?.closeCode}');
          debugPrint('   Close reason: ${_channel?.closeReason}');
          _handleDisconnect();
        },
        cancelOnError: false,
      );
    } catch (e) {
      debugPrint('❌ Failed to connect WebSocket: $e');
      _connectionController.add(false);
      _channel = null;
      _scheduleReconnect();
    }
  }

  /// Handle disconnect and attempt reconnect
  void _handleDisconnect() {
    _connectionController.add(false);
    _stopHeartbeat();
    _channel = null;

    // Auto-reconnect if not manually disconnected
    if (!_isManualDisconnect && _lastAccessToken != null) {
      _scheduleReconnect();
    }
  }

  /// Schedule reconnect attempt
  /// Note: This will use the SAME token that was used before
  /// If you need to reconnect with a NEW token (e.g., after refresh),
  /// call disconnect() then connect(newToken) instead
  void _scheduleReconnect() {
    _reconnectTimer?.cancel();

    debugPrint('🔄 Scheduling reconnect in 5 seconds...');
    debugPrint('   Will reconnect with token: ${_lastAccessToken?.substring(0, 20)}...');
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (_lastAccessToken != null && !_isManualDisconnect) {
        debugPrint('🔄 Attempting to reconnect...');
        debugPrint('⚠️ WARNING: Reconnecting with OLD token. If token was refreshed, this will fail!');
        connect(_lastAccessToken!);
      }
    });
  }

  /// Start heartbeat timer
  void _startHeartbeat() {
    _stopHeartbeat();

    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      sendHeartbeat();
    });

    debugPrint('💓 Heartbeat timer started (30s interval)');
  }

  /// Stop heartbeat timer
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  /// Disconnect from WebSocket
  Future<void> disconnect() async {
    _isManualDisconnect = true;
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    _lastAccessToken = null;

    if (_channel != null) {
      await _channel!.sink.close();
      _channel = null;
      _connectionController.add(false);
      debugPrint('🔌 WebSocket disconnected');
    }
  }

  /// Send a chat message
  void sendMessage(String conversationId, String content) {
    if (_channel == null) {
      debugPrint('⚠️ Cannot send message: WebSocket not connected');
      return;
    }

    final payload = {
      'type': ChatWebSocketEvent.chatMessage,
      'payload': {'conversationId': conversationId, 'content': content},
    };

    _channel!.sink.add(jsonEncode(payload));
    debugPrint('📤 Sent message to conversation: $conversationId');
  }

  /// Send typing start indicator
  void sendTypingStart(String conversationId) {
    if (_channel == null) return;

    final payload = {
      'type': ChatWebSocketEvent.typingStart,
      'payload': {'conversationId': conversationId},
    };

    _channel!.sink.add(jsonEncode(payload));
  }

  /// Send typing stop indicator
  void sendTypingStop(String conversationId) {
    if (_channel == null) return;

    final payload = {
      'type': ChatWebSocketEvent.typingStop,
      'payload': {'conversationId': conversationId},
    };

    _channel!.sink.add(jsonEncode(payload));
  }

  /// Handle incoming WebSocket messages
  void _handleMessage(dynamic message) {
    try {
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      debugPrint('📥 [WebSocket] Raw message received: $message');

      final data = jsonDecode(message as String) as Map<String, dynamic>;
      debugPrint('📦 [WebSocket] Parsed data: $data');

      final type = data['type'] as String?;
      if (type == null) {
        debugPrint('⚠️ [WebSocket] Message has no type field, treating as direct message');
        // Server might be sending message directly without wrapper
        final messageModel = MessageModel.fromApi(data);
        debugPrint('📨 [WebSocket] Broadcasting direct message to stream...');
        debugPrint('   Message ID: ${messageModel.id}');
        debugPrint('   ConversationId: ${messageModel.conversationId}');
        debugPrint('   Content: "${messageModel.content}"');
        debugPrint('   Stream has listeners: ${_messageController.hasListener}');
        _messageController.add(messageModel.toEntity());
        debugPrint('✅ [WebSocket] Message broadcasted to ${_messageController.hasListener ? "active" : "NO"} listeners');
        debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        return;
      }

      final payload = data['payload'] as Map<String, dynamic>?;
      if (payload == null) {
        debugPrint('⚠️ [WebSocket] Message has no payload field');
        debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        return;
      }

      debugPrint('🔍 [WebSocket] Message type: $type');

      switch (type) {
        case ChatWebSocketResponse.chatMessage:
          final messageModel = MessageModel.fromApi(payload);
          debugPrint('📨 [WebSocket] Broadcasting chat message to stream...');
          debugPrint('   Message ID: ${messageModel.id}');
          debugPrint('   ConversationId: ${messageModel.conversationId}');
          debugPrint('   Type: ${messageModel.type}');
          debugPrint('   Content: "${messageModel.content}"');
          debugPrint('   MediaUrl: ${messageModel.mediaUrl}');
          debugPrint('   Sender: ${messageModel.sender.username}');
          debugPrint('   Stream has listeners: ${_messageController.hasListener}');
          _messageController.add(messageModel.toEntity());
          debugPrint('✅ [WebSocket] Message broadcasted to ${_messageController.hasListener ? "active" : "NO"} listeners');
          break;

        case ChatWebSocketResponse.typingIndicator:
          final indicatorModel = TypingIndicatorModel.fromJson(payload);
          _typingController.add(indicatorModel.toEntity());
          debugPrint('⌨️ [WebSocket] Typing indicator: ${indicatorModel.conversationId}');
          break;

        case ChatWebSocketResponse.userStatus:
          final statusModel = UserStatusUpdateModel.fromJson(payload);
          _userStatusController.add(statusModel.toEntity());
          debugPrint(
            '👤 [WebSocket] User status: ${statusModel.userId} - ${statusModel.isOnline}',
          );
          break;

        case ChatWebSocketResponse.conversationUpdate:
          final updateModel = ConversationUpdateModel.fromJson(payload);
          _conversationUpdateController.add(updateModel.toEntity());
          debugPrint('💬 [WebSocket] Conversation update: ${updateModel.conversationId}');
          break;

        case ChatWebSocketResponse.heartbeatAck:
          debugPrint('💓 [WebSocket] Heartbeat acknowledged');
          break;

        default:
          debugPrint('⚠️ [WebSocket] Unknown event type: $type');
      }
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    } catch (e, stackTrace) {
      debugPrint('❌ [WebSocket] Error handling message: $e');
      debugPrint('Stack trace: $stackTrace');
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    }
  }

  /// Send heartbeat to keep connection alive
  void sendHeartbeat() {
    if (_channel == null) return;

    final payload = {'type': 'heartbeat', 'payload': {}};

    _channel!.sink.add(jsonEncode(payload));
    debugPrint('💓 Sent heartbeat');
  }

  /// Dispose resources
  void dispose() {
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    disconnect();
    _messageController.close();
    _typingController.close();
    _userStatusController.close();
    _conversationUpdateController.close();
    _connectionController.close();
  }
}
