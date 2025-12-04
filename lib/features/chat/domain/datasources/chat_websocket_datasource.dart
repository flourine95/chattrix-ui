import 'package:chattrix_ui/features/chat/domain/entities/conversation_update.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status_update.dart';

/// WebSocket datasource interface for chat feature
/// This follows Clean Architecture - domain defines the contract
abstract class ChatWebSocketDataSource {
  /// Connect to chat WebSocket
  Future<void> connect(String accessToken);

  /// Disconnect from chat WebSocket
  Future<void> disconnect();

  /// Send a chat message
  void sendMessage({
    required String conversationId,
    required String content,
    int? replyToMessageId,
  });

  /// Send typing start indicator
  void sendTypingStart(String conversationId);

  /// Send typing stop indicator
  void sendTypingStop(String conversationId);

  /// Send a generic message (for extensibility)
  void sendGenericMessage(Map<String, dynamic> payload);

  /// Stream of incoming messages
  Stream<Message> get messageStream;

  /// Stream of typing indicators
  Stream<TypingIndicator> get typingStream;

  /// Stream of user status updates
  Stream<UserStatusUpdate> get userStatusStream;

  /// Stream of conversation updates
  Stream<ConversationUpdate> get conversationUpdateStream;

  /// Stream of connection state
  Stream<bool> get connectionStream;

  /// Stream of raw messages for custom handlers (e.g., call signaling)
  Stream<Map<String, dynamic>> get rawMessageStream;

  /// Check if connected
  bool get isConnected;

  /// Dispose resources
  void dispose();
}

