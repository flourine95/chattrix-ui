import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';
import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_model.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/data/models/search_user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/user_status_model.dart';

/// Remote data source interface for chat operations
/// Defines contract for fetching data from external sources (API, WebSocket)
abstract class ChatRemoteDatasource {
  /// Create a new conversation
  Future<ConversationModel> createConversation({
    String? name,
    required String type,
    required List<String> participantIds,
  });

  /// Get all conversations for current user
  Future<List<ConversationModel>> getConversations({ConversationFilter filter = ConversationFilter.all});

  /// Get a specific conversation by ID
  Future<ConversationModel> getConversation(String conversationId);

  /// Get messages in a conversation with pagination
  /// [sort] can be 'ASC' (oldest first) or 'DESC' (newest first, default)
  Future<List<MessageModel>> getMessages({
    required String conversationId,
    int page = 0,
    int size = 50,
    String sort = 'DESC',
  });

  /// Send a message to a conversation
  Future<MessageModel> sendMessage(String conversationId, ChatMessageRequest request);

  /// Get list of online users
  Future<List<UserDto>> getOnlineUsers();

  /// Get online users in a specific conversation
  Future<List<UserDto>> getOnlineUsersInConversation(String conversationId);

  /// Get status of a specific user
  Future<UserStatusModel> getUserStatus(String userId);

  /// Search users by query
  Future<List<SearchUserModel>> searchUsers({required String query, int limit = 20});

  /// Search conversations by query (name or last message content)
  Future<List<ConversationModel>> searchConversations({required String query});

  /// Add or toggle reaction to a message
  Future<Map<String, dynamic>> toggleReaction({required String messageId, required String emoji});

  /// Get reactions for a message
  Future<Map<String, dynamic>> getReactions(String messageId);

  /// Edit a message
  Future<MessageModel> editMessage({required String messageId, required String content});

  /// Delete a message
  Future<void> deleteMessage(String messageId);
}
