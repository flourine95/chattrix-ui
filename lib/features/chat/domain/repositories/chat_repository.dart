import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:fpdart/fpdart.dart';

abstract class ChatRepository {
  /// Create a new conversation
  Future<Either<Failure, Conversation>> createConversation({
    String? name,
    required String type,
    required List<String> participantIds,
  });

  /// Get all conversations
  Future<Either<Failure, List<Conversation>>> getConversations({ConversationFilter filter = ConversationFilter.all});

  /// Get conversation by ID
  Future<Either<Failure, Conversation>> getConversation(String conversationId);

  /// Get messages in a conversation
  /// [sort] can be 'ASC' (oldest first) or 'DESC' (newest first, default)
  Future<Either<Failure, List<Message>>> getMessages({
    required String conversationId,
    int page = 0,
    int size = 50,
    String sort = 'DESC',
  });

  /// Send a message to a conversation
  Future<Either<Failure, Message>> sendMessage(String conversationId, ChatMessageRequest request);

  /// Search users by query
  Future<Either<Failure, List<SearchUser>>> searchUsers({required String query, int limit = 20});

  /// Search conversations by query (name or last message content)
  Future<Either<Failure, List<Conversation>>> searchConversations({required String query});

  /// Toggle reaction on a message
  Future<Either<Failure, Map<String, dynamic>>> toggleReaction({required String messageId, required String emoji});

  /// Get reactions for a message
  Future<Either<Failure, Map<String, dynamic>>> getReactions(String messageId);

  /// Edit a message
  Future<Either<Failure, Message>> editMessage({required String messageId, required String content});

  /// Delete a message
  Future<Either<Failure, void>> deleteMessage(String messageId);

  /// Mark conversation as read
  ///
  /// Marks all unread messages in a conversation as read.
  /// Creates read receipts and resets unread count.
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation
  /// - [lastMessageId]: Optional - ID of last message to mark as read
  ///
  /// **API:** `POST /v1/read-receipts/conversations/{conversationId}`
  Future<Either<Failure, void>> markConversationAsRead({required int conversationId, int? lastMessageId});
}
