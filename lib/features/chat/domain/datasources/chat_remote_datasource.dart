import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';
import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_member_dto.dart';
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

  /// Get members in a conversation with cursor-based pagination
  Future<List<ConversationMemberDto>> getConversationMembers({
    required String conversationId,
    String? cursor,
    int limit = 20,
  });

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
  Future<MessageModel> editMessage({
    required String conversationId,
    required String messageId,
    required String content,
  });

  /// Delete a message
  Future<void> deleteMessage({required String conversationId, required String messageId});

  /// Mark conversation as read
  ///
  /// **API:** `POST /v1/read-receipts/conversations/{conversationId}`
  Future<void> markConversationAsRead({required int conversationId, int? lastMessageId});

  /// Mark conversation as unread
  ///
  /// Sets unreadCount to 1 if currently 0 (creates unread notification effect)
  ///
  /// **API:** `POST /v1/read-receipts/conversations/{conversationId}/unread`
  Future<void> markConversationAsUnread({required int conversationId});

  /// Update conversation (name, description)
  ///
  /// **API:** `PUT /v1/conversations/{conversationId}`
  /// **Errors:**
  /// - 400: Validation failed
  /// - 401: Unauthorized
  /// - 403: Forbidden (not admin)
  /// - 404: Conversation not found
  Future<ConversationModel> updateConversation({required String conversationId, String? name, String? description});

  /// Delete conversation
  ///
  /// **API:** `DELETE /v1/conversations/{conversationId}`
  /// **Errors:**
  /// - 401: Unauthorized
  /// - 403: Forbidden (not admin)
  /// - 404: Conversation not found
  Future<void> deleteConversation(String conversationId);

  /// Add members to conversation
  ///
  /// **API:** `POST /v1/conversations/{conversationId}/members`
  /// **Errors:**
  /// - 400: Validation failed
  /// - 401: Unauthorized
  /// - 403: Forbidden
  /// - 404: Conversation not found
  Future<Map<String, dynamic>> addMembers({required String conversationId, required List<int> userIds});

  /// Remove member from conversation
  ///
  /// **API:** `DELETE /v1/conversations/{conversationId}/members/{userId}`
  /// **Errors:**
  /// - 401: Unauthorized
  /// - 403: Forbidden (not admin)
  /// - 404: Conversation or member not found
  Future<void> removeMember({required String conversationId, required int userId});

  /// Update member role
  ///
  /// **API:** `PUT /v1/conversations/{conversationId}/members/{userId}/role`
  /// **Errors:**
  /// - 400: Validation failed
  /// - 401: Unauthorized
  /// - 403: Forbidden (not admin)
  /// - 404: Conversation or member not found
  Future<Map<String, dynamic>> updateMemberRole({
    required String conversationId,
    required int userId,
    required String role,
  });

  /// Leave conversation
  ///
  /// **API:** `POST /v1/conversations/{conversationId}/members/leave`
  /// **Errors:**
  /// - 401: Unauthorized
  /// - 404: Conversation not found
  Future<void> leaveConversation(String conversationId);

  /// Update group avatar
  ///
  /// **API:** `PUT /v1/conversations/{conversationId}/avatar`
  /// **Errors:**
  /// - 400: Validation failed
  /// - 401: Unauthorized
  /// - 403: Forbidden (not admin)
  /// - 404: Conversation not found
  Future<ConversationModel> updateGroupAvatar({required String conversationId, required String imagePath});

  /// Delete group avatar
  ///
  /// **API:** `DELETE /v1/conversations/{conversationId}/avatar`
  /// **Errors:**
  /// - 401: Unauthorized
  /// - 403: Forbidden (not admin)
  /// - 404: Conversation not found
  Future<void> deleteGroupAvatar(String conversationId);

  /// Pin message
  ///
  /// **API:** `POST /v1/conversations/{conversationId}/messages/{messageId}/pin`
  Future<MessageModel> pinMessage({required String conversationId, required String messageId});

  /// Unpin message
  ///
  /// **API:** `DELETE /v1/conversations/{conversationId}/messages/{messageId}/pin`
  Future<void> unpinMessage({required String conversationId, required String messageId});

  /// Get pinned messages
  ///
  /// **API:** `GET /v1/conversations/{conversationId}/messages/pinned`
  Future<List<MessageModel>> getPinnedMessages(String conversationId);

  /// Create scheduled message
  ///
  /// **API:** `POST /v1/conversations/{conversationId}/messages/schedule`
  Future<MessageModel> createScheduledMessage({
    required String conversationId,
    required String content,
    required String type,
    required String scheduledTime,
  });

  /// Get scheduled messages
  ///
  /// **API:** `GET /v1/conversations/{conversationId}/messages/scheduled`
  Future<Map<String, dynamic>> getScheduledMessages({required String conversationId, String? cursor, int limit = 20});

  /// Get scheduled message details
  ///
  /// **API:** `GET /v1/conversations/{conversationId}/messages/scheduled/{scheduledMessageId}`
  Future<MessageModel> getScheduledMessage({required String conversationId, required String scheduledMessageId});

  /// Update scheduled message
  ///
  /// **API:** `PUT /v1/conversations/{conversationId}/messages/scheduled/{scheduledMessageId}`
  Future<MessageModel> updateScheduledMessage({
    required String conversationId,
    required String scheduledMessageId,
    String? content,
    String? scheduledTime,
  });

  /// Cancel scheduled message
  ///
  /// **API:** `DELETE /v1/conversations/{conversationId}/messages/scheduled/{scheduledMessageId}`
  Future<void> cancelScheduledMessage({required String conversationId, required String scheduledMessageId});

  /// Cancel scheduled messages in bulk
  ///
  /// **API:** `DELETE /v1/conversations/{conversationId}/messages/scheduled/bulk`
  Future<Map<String, dynamic>> cancelScheduledMessagesBulk({
    required String conversationId,
    required List<int> scheduledMessageIds,
  });

  /// Search messages in conversation
  ///
  /// **API:** `GET /v1/conversations/{conversationId}/search/messages`
  Future<Map<String, dynamic>> searchMessages({
    required String conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  });

  /// Search media in conversation
  ///
  /// **API:** `GET /v1/conversations/{conversationId}/search/media`
  Future<Map<String, dynamic>> searchMedia({
    required String conversationId,
    String? type,
    String? cursor,
    int limit = 20,
  });
}
