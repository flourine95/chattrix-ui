import 'package:chattrix_ui/features/auth/data/models/user_model.dart';
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
  Future<List<ConversationModel>> getConversations();

  /// Get a specific conversation by ID
  Future<ConversationModel> getConversation(String conversationId);

  /// Get messages in a conversation with pagination
  Future<List<MessageModel>> getMessages({
    required String conversationId,
    int page = 0,
    int size = 50,
  });

  /// Send a message to a conversation
  Future<MessageModel> sendMessage({
    required String conversationId,
    required String content,
  });

  /// Get list of online users
  Future<List<UserModel>> getOnlineUsers();

  /// Get online users in a specific conversation
  Future<List<UserModel>> getOnlineUsersInConversation(String conversationId);

  /// Get status of a specific user
  Future<UserStatusModel> getUserStatus(String userId);

  /// Search users by query
  Future<List<SearchUserModel>> searchUsers({
    required String query,
    int limit = 20,
  });
}
