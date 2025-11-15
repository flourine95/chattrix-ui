import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource remoteDatasource;

  ChatRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, Conversation>> createConversation({
    String? name,
    required String type,
    required List<String> participantIds,
  }) async {
    try {
      final model = await remoteDatasource.createConversation(name: name, type: type, participantIds: participantIds);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to create conversation'));
    }
  }

  @override
  Future<Either<Failure, List<Conversation>>> getConversations() async {
    try {
      final models = await remoteDatasource.getConversations();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch conversations'));
    }
  }

  @override
  Future<Either<Failure, Conversation>> getConversation(String conversationId) async {
    try {
      final model = await remoteDatasource.getConversation(conversationId);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch conversation'));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages({
    required String conversationId,
    int page = 0,
    int size = 50,
    String sort = 'DESC',
  }) async {
    try {
      final models = await remoteDatasource.getMessages(
        conversationId: conversationId,
        page: page,
        size: size,
        sort: sort,
      );
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch messages'));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage({
    required String conversationId,
    required String content,
    String? type,
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
    int? fileSize,
    int? duration,
    double? latitude,
    double? longitude,
    String? locationName,
    int? replyToMessageId,
    String? mentions,
  }) async {
    try {
      final model = await remoteDatasource.sendMessage(
        conversationId: conversationId,
        content: content,
        type: type,
        mediaUrl: mediaUrl,
        thumbnailUrl: thumbnailUrl,
        fileName: fileName,
        fileSize: fileSize,
        duration: duration,
        latitude: latitude,
        longitude: longitude,
        locationName: locationName,
        replyToMessageId: replyToMessageId,
        mentions: mentions,
      );
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to send message'));
    }
  }

  @override
  Future<Either<Failure, List<SearchUser>>> searchUsers({required String query, int limit = 20}) async {
    try {
      final models = await remoteDatasource.searchUsers(query: query, limit: limit);
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to search users'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> toggleReaction({
    required String messageId,
    required String emoji,
  }) async {
    try {
      final result = await remoteDatasource.toggleReaction(messageId: messageId, emoji: emoji);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to toggle reaction'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getReactions(String messageId) async {
    try {
      final result = await remoteDatasource.getReactions(messageId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get reactions'));
    }
  }

  @override
  Future<Either<Failure, Message>> editMessage({required String messageId, required String content}) async {
    try {
      final model = await remoteDatasource.editMessage(messageId: messageId, content: content);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to edit message'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(String messageId) async {
    try {
      await remoteDatasource.deleteMessage(messageId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to delete message'));
    }
  }
}
