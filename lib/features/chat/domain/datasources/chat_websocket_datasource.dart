import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation_update.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status_update.dart';

abstract class ChatWebSocketDataSource {
  Future<void> connect(String accessToken);

  Future<void> disconnect();

  void sendMessage(int conversationId, ChatMessageRequest request);

  void sendTypingStart(int conversationId);

  void sendTypingStop(int conversationId);

  void sendGenericMessage(Map<String, dynamic> payload);

  Stream<Message> get messageStream;

  Stream<TypingIndicator> get typingStream;

  Stream<UserStatusUpdate> get userStatusStream;

  Stream<ConversationUpdate> get conversationUpdateStream;

  Stream<Map<String, dynamic>> get pollEventStream;

  Stream<Map<String, dynamic>> get messageIdUpdateStream;

  Stream<void> get heartbeatAckStream;

  Stream<bool> get connectionStream;

  Stream<Map<String, dynamic>> get rawMessageStream;

  bool get isConnected;

  void dispose();
}
