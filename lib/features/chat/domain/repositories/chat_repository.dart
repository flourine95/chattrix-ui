import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:fpdart/fpdart.dart';

abstract class ChatRepository {
  Future<Either<Failure, Conversation>> createConversation({
    String? name,
    required String type,
    required List<int> participantIds,
  });

  Future<Either<Failure, List<Conversation>>> getConversations({ConversationFilter filter = ConversationFilter.all});

  Future<Either<Failure, Conversation>> getConversation(int conversationId);

  Future<Either<Failure, List<SearchUser>>> getConversationMembers({
    required int conversationId,
    String? cursor,
    int limit = 20,
  });

  Future<Either<Failure, List<Message>>> getMessages({
    required int conversationId,
    int page = 0,
    int size = 50,
    String sort = 'DESC',
  });

  Future<Either<Failure, Message>> sendMessage(int conversationId, ChatMessageRequest request);

  Future<Either<Failure, List<SearchUser>>> searchUsers({required String query, int limit = 20});

  Future<Either<Failure, List<Conversation>>> searchConversations({required String query});

  Future<Either<Failure, Map<String, dynamic>>> toggleReaction({required int messageId, required String emoji});

  Future<Either<Failure, Map<String, dynamic>>> getReactions(int messageId);

  Future<Either<Failure, Message>> editMessage({
    required int conversationId,
    required int messageId,
    required String content,
  });

  Future<Either<Failure, void>> deleteMessage({required int conversationId, required int messageId});

  Future<Either<Failure, void>> markConversationAsRead({required int conversationId, int? lastMessageId});

  Future<Either<Failure, void>> markConversationAsUnread({required int conversationId});

  Future<Either<Failure, List<Message>>> searchMessages({
    required int conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  });

  Future<Either<Failure, List<Message>>> forwardMessage({
    required int conversationId,
    required int messageId,
    required List<int> targetConversationIds,
  });
}
