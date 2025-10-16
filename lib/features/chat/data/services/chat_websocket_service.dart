import 'dart:async';
import 'dart:convert';

import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
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
}

class ChatWebSocketService {
  WebSocketChannel? _channel;
  final _messageController = StreamController<MessageModel>.broadcast();
  final _typingController = StreamController<TypingIndicator>.broadcast();
  final _userStatusController = StreamController<UserStatusUpdate>.broadcast();
  final _connectionController = StreamController<bool>.broadcast();

  Stream<MessageModel> get messageStream => _messageController.stream;

  Stream<TypingIndicator> get typingStream => _typingController.stream;

  Stream<UserStatusUpdate> get userStatusStream => _userStatusController.stream;

  Stream<bool> get connectionStream => _connectionController.stream;

  bool get isConnected => _channel != null;

  /// Connect to WebSocket
  Future<void> connect(String accessToken) async {
    if (_channel != null) {
      debugPrint('⚠️ WebSocket already connected');
      return;
    }

    try {
      final wsUrl =
          '${ApiConstants.wsBaseUrl}/${ApiConstants.chatWebSocket}?token=$accessToken';
      debugPrint('🔌 Connecting to WebSocket: $wsUrl');

      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      _connectionController.add(true);
      debugPrint('✅ WebSocket connected');

      // Listen to messages from server
      _channel!.stream.listen(
        (message) {
          _handleMessage(message);
        },
        onError: (error) {
          debugPrint('❌ WebSocket error: $error');
          _connectionController.add(false);
        },
        onDone: () {
          debugPrint('🔌 WebSocket connection closed');
          _connectionController.add(false);
          _channel = null;
        },
      );
    } catch (e) {
      debugPrint('❌ Failed to connect WebSocket: $e');
      _connectionController.add(false);
      _channel = null;
      rethrow;
    }
  }

  /// Disconnect from WebSocket
  Future<void> disconnect() async {
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
      final data = jsonDecode(message as String) as Map<String, dynamic>;
      final type = data['type'] as String;
      final payload = data['payload'] as Map<String, dynamic>;

      switch (type) {
        case ChatWebSocketResponse.chatMessage:
          final messageModel = MessageModel.fromJson(payload);
          _messageController.add(messageModel);
          debugPrint('📨 Received message: ${messageModel.id}');
          break;

        case ChatWebSocketResponse.typingIndicator:
          final indicator = TypingIndicator.fromJson(payload);
          _typingController.add(indicator);
          debugPrint('⌨️ Typing indicator: ${indicator.conversationId}');
          break;

        case ChatWebSocketResponse.userStatus:
          final status = UserStatusUpdate.fromJson(payload);
          _userStatusController.add(status);
          debugPrint('👤 User status: ${status.userId} - ${status.isOnline}');
          break;

        default:
          debugPrint('⚠️ Unknown WebSocket event type: $type');
      }
    } catch (e) {
      debugPrint('❌ Error handling WebSocket message: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    disconnect();
    _messageController.close();
    _typingController.close();
    _userStatusController.close();
    _connectionController.close();
  }
}

/// Typing indicator model
class TypingIndicator {
  final String conversationId;
  final List<TypingUser> typingUsers;

  TypingIndicator({required this.conversationId, required this.typingUsers});

  factory TypingIndicator.fromJson(Map<String, dynamic> json) {
    return TypingIndicator(
      conversationId: json['conversationId'] as String,
      typingUsers: (json['typingUsers'] as List)
          .map((user) => TypingUser.fromJson(user as Map<String, dynamic>))
          .toList(),
    );
  }
}

class TypingUser {
  final String id;
  final String username;
  final String fullName;

  TypingUser({
    required this.id,
    required this.username,
    required this.fullName,
  });

  factory TypingUser.fromJson(Map<String, dynamic> json) {
    return TypingUser(
      id: json['id'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
    );
  }
}

/// User status update model
class UserStatusUpdate {
  final String userId;
  final String username;
  final String displayName;
  final bool isOnline;
  final String? lastSeen;

  UserStatusUpdate({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.isOnline,
    this.lastSeen,
  });

  factory UserStatusUpdate.fromJson(Map<String, dynamic> json) {
    return UserStatusUpdate(
      userId: json['userId'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String,
      isOnline: json['isOnline'] as bool,
      lastSeen: json['lastSeen'] as String?,
    );
  }
}
