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

  // Call signaling events
  static const String callInvitation = 'call.invitation';
  static const String callResponse = 'call.response';
  static const String callEnded = 'call.ended';
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
  final _conversationUpdateController = StreamController<ConversationUpdate>.broadcast();
  final _connectionController = StreamController<bool>.broadcast();

  // Stream controller for raw call signaling messages
  final _rawMessageController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Message> get messageStream => _messageController.stream;

  Stream<TypingIndicator> get typingStream => _typingController.stream;

  Stream<UserStatusUpdate> get userStatusStream => _userStatusController.stream;

  Stream<ConversationUpdate> get conversationUpdateStream => _conversationUpdateController.stream;

  Stream<bool> get connectionStream => _connectionController.stream;

  /// Stream of raw messages for call signaling and other custom handlers
  Stream<Map<String, dynamic>> get rawMessageStream => _rawMessageController.stream;

  bool get isConnected => _channel != null;

  /// Connect to WebSocket
  Future<void> connect(String accessToken) async {
    if (_channel != null) {
      return;
    }

    try {
      _lastAccessToken = accessToken;
      _isManualDisconnect = false;

      final wsUrl = ApiConstants.chatWebSocketWithToken(accessToken);

      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      _connectionController.add(true);

      // Start heartbeat timer
      _startHeartbeat();

      // Listen to messages from server
      _channel!.stream.listen(
        (message) {
          _handleMessage(message);
        },
        onError: (error, stackTrace) {
          _handleDisconnect();
        },
        onDone: () {
          _handleDisconnect();
        },
        cancelOnError: false,
      );
    } catch (e) {
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

    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (_lastAccessToken != null && !_isManualDisconnect) {
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
    }
  }

  /// Send a chat message
  void sendMessage(String conversationId, String content, {int? replyToMessageId}) {
    if (_channel == null) {
      return;
    }

    final payload = {
      'type': ChatWebSocketEvent.chatMessage,
      'payload': {
        'conversationId': conversationId,
        'content': content,
        if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
      },
    };

    _channel!.sink.add(jsonEncode(payload));
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
      final data = jsonDecode(message as String) as Map<String, dynamic>;

      final type = data['type'] as String?;
      if (type == null) {
        // Server might be sending message directly without wrapper
        final messageModel = MessageModel.fromApi(data);
        _messageController.add(messageModel.toEntity());
        return;
      }

      final payload = data['payload'] as Map<String, dynamic>?;
      if (payload == null) {
        return;
      }

      // Emit raw message for custom handlers (like call signaling)
      _rawMessageController.add(data);

      switch (type) {
        case ChatWebSocketResponse.chatMessage:
          final messageModel = MessageModel.fromApi(payload);
          _messageController.add(messageModel.toEntity());
          break;

        case ChatWebSocketResponse.typingIndicator:
          final indicatorModel = TypingIndicatorModel.fromJson(payload);
          _typingController.add(indicatorModel.toEntity());
          break;

        case ChatWebSocketResponse.userStatus:
          final statusModel = UserStatusUpdateModel.fromJson(payload);
          _userStatusController.add(statusModel.toEntity());
          break;

        case ChatWebSocketResponse.conversationUpdate:
          final updateModel = ConversationUpdateModel.fromJson(payload);
          _conversationUpdateController.add(updateModel.toEntity());
          break;

        case ChatWebSocketResponse.heartbeatAck:
          break;

        // Call signaling events are handled by CallSignalingService
        case ChatWebSocketResponse.callInvitation:
        case ChatWebSocketResponse.callResponse:
        case ChatWebSocketResponse.callEnded:
          // These are handled through rawMessageStream
          break;

        default:
          break;
      }
    } catch (e) {
      // Silently handle error
    }
  }

  /// Send heartbeat to keep connection alive
  void sendHeartbeat() {
    if (_channel == null) return;

    final payload = {'type': 'heartbeat', 'payload': {}};

    _channel!.sink.add(jsonEncode(payload));
  }

  /// Send a generic message through the WebSocket
  /// This allows other services (like CallSignalingService) to send custom messages
  void sendGenericMessage(Map<String, dynamic> payload) {
    if (_channel == null) return;

    _channel!.sink.add(jsonEncode(payload));
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
    _rawMessageController.close();
  }
}
