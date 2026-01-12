import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChatRepositoryImpl extends BaseRepository implements ChatRepository {
  final ChatRemoteDatasource remoteDatasource;

  ChatRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, Conversation>> createConversation({
    String? name,
    required String type,
    required List<String> participantIds,
  }) async {
    return executeApiCall(() async {
      final model = await remoteDatasource.createConversation(name: name, type: type, participantIds: participantIds);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<Conversation>>> getConversations({
    ConversationFilter filter = ConversationFilter.all,
  }) async {
    return executeApiCall(() async {
      final models = await remoteDatasource.getConversations(filter: filter);
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Conversation>> getConversation(String conversationId) async {
    return executeApiCall(() async {
      final model = await remoteDatasource.getConversation(conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<SearchUser>>> getConversationMembers({
    required String conversationId,
    String? cursor,
    int limit = 20,
  }) async {
    return executeApiCall(() async {
      final memberDtos = await remoteDatasource.getConversationMembers(
        conversationId: conversationId,
        cursor: cursor,
        limit: limit,
      );
      return memberDtos
          .map<SearchUser>(
            (dto) => SearchUser(
              id: dto.id,
              username: dto.username,
              email: dto.email,
              fullName: dto.fullName,
              avatarUrl: dto.avatarUrl,
              isOnline: dto.online,
              lastSeen: DateTime.now(),
              isContact: false,
              hasConversation: true,
              conversationId: int.tryParse(conversationId),
            ),
          )
          .toList();
    });
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages({
    required String conversationId,
    int page = 0,
    int size = 50,
    String sort = 'DESC',
  }) async {
    return executeApiCall(() async {
      final models = await remoteDatasource.getMessages(
        conversationId: conversationId,
        page: page,
        size: size,
        sort: sort,
      );
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Message>> sendMessage(String conversationId, ChatMessageRequest request) async {
    final messageModel = await remoteDatasource.sendMessage(conversationId, request);
    return Right(messageModel.toEntity());
  }

  @override
  Future<Either<Failure, List<SearchUser>>> searchUsers({required String query, int limit = 20}) async {
    return executeApiCall(() async {
      final models = await remoteDatasource.searchUsers(query: query, limit: limit);
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<Conversation>>> searchConversations({required String query}) async {
    return executeApiCall(() async {
      final models = await remoteDatasource.searchConversations(query: query);
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> toggleReaction({
    required String messageId,
    required String emoji,
  }) async {
    return executeApiCall(() async {
      return await remoteDatasource.toggleReaction(messageId: messageId, emoji: emoji);
    });
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getReactions(String messageId) async {
    return executeApiCall(() async {
      return await remoteDatasource.getReactions(messageId);
    });
  }

  @override
  Future<Either<Failure, Message>> editMessage({
    required String conversationId,
    required String messageId,
    required String content,
  }) async {
    return executeApiCall(() async {
      final model = await remoteDatasource.editMessage(
        conversationId: conversationId,
        messageId: messageId,
        content: content,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> deleteMessage({required String conversationId, required String messageId}) async {
    return executeApiCall(() async {
      await remoteDatasource.deleteMessage(conversationId: conversationId, messageId: messageId);
    });
  }

  @override
  Future<Either<Failure, void>> markConversationAsRead({required int conversationId, int? lastMessageId}) async {
    return executeApiCall(() async {
      await remoteDatasource.markConversationAsRead(conversationId: conversationId, lastMessageId: lastMessageId);
    });
  }

  @override
  Future<Either<Failure, void>> markConversationAsUnread({required int conversationId}) async {
    return executeApiCall(() async {
      await remoteDatasource.markConversationAsUnread(conversationId: conversationId);
    });
  }

  @override
  Future<Either<Failure, List<Message>>> searchMessages({
    required String conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  }) async {
    return executeApiCall(() async {
      final response = await remoteDatasource.searchMessages(
        conversationId: conversationId,
        query: query,
        cursor: cursor,
        limit: limit,
      );

      // Parse the paginated response
      final items = response['items'] as List;
      final models = items.whereType<Map<String, dynamic>>().map((json) => MessageModel.fromApi(json)).toList();
      return models.map((model) => model.toEntity()).toList();
    });
  }
}
