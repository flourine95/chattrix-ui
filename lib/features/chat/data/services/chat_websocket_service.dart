import 'dart:async';
import 'dart:convert';

import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/services/json_parsing_service.dart';
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
  /// IMPORTANT: WebSocket disconnection does NOT affect Agora RTC connection
  /// Agora media streaming continues independently during WebSocket reconnection
  void _handleDisconnect() {
    _connectionController.add(false);
    _stopHeartbeat();
    _channel = null;

    // Auto-reconnect if not manually disconnected
    // Note: This reconnection is for signaling only
    // Active Agora calls remain connected and media continues streaming
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
  Future<void> _handleMessage(dynamic message) async {
    try {
      final messageString = message as String;

      // First, decode just the wrapper to get the type
      // This is a lightweight operation that won't block the main thread
      final data = jsonDecode(messageString) as Map<String, dynamic>;

      final type = data['type'] as String?;
      if (type == null) {
        // Server might be sending message directly without wrapper
        // Parse in background isolate
        final messageEntity = await JsonParsingService.parseMessage(messageString);
        _messageController.add(messageEntity);
        return;
      }

      // Emit raw message for custom handlers (like call signaling)
      // This must happen BEFORE checking payload to ensure call messages are received
      _rawMessageController.add(data);

      // Backend sends chat messages with 'payload' field
      // Backend sends call messages with 'data' field
      // Try 'payload' first for backward compatibility, then 'data'
      final payload = data['payload'] ?? data['data'];
      if (payload == null) {
        // Message has type but no payload/data - might be a control message
        return;
      }

      // Convert payload to JSON string for background parsing
      final payloadString = jsonEncode(payload);

      switch (type) {
        case ChatWebSocketResponse.chatMessage:
          // Parse message in background isolate
          final messageEntity = await JsonParsingService.parseMessage(payloadString);
          _messageController.add(messageEntity);
          break;

        case ChatWebSocketResponse.typingIndicator:
          // Parse typing indicator in background isolate
          final indicatorEntity = await JsonParsingService.parseTypingIndicator(payloadString);
          _typingController.add(indicatorEntity);
          break;

        case ChatWebSocketResponse.userStatus:
          // Parse user status in background isolate
          final statusEntity = await JsonParsingService.parseUserStatusUpdate(payloadString);
          _userStatusController.add(statusEntity);
          break;

        case ChatWebSocketResponse.conversationUpdate:
          // Parse conversation update in background isolate
          final updateEntity = await JsonParsingService.parseConversationUpdate(payloadString);
          _conversationUpdateController.add(updateEntity);
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
      // Silently handle parsing errors
      // The error could be from jsonDecode (malformed JSON) or from background parsing
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
