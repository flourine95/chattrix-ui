import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  /// Create a new conversation
  Future<Either<Failure, Conversation>> createConversation({
    String? name,
    required String type,
    required List<String> participantIds,
  });

  /// Get all conversations
  Future<Either<Failure, List<Conversation>>> getConversations();

  /// Get conversation by ID
  Future<Either<Failure, Conversation>> getConversation(String conversationId);

  /// Get messages in a conversation
  Future<Either<Failure, List<Message>>> getMessages({
    required String conversationId,
    int page = 0,
    int size = 50,
  });

  /// Send a message to a conversation
  Future<Either<Failure, Message>> sendMessage({
    required String conversationId,
    required String content,
  });

  /// Search users by query
  Future<Either<Failure, List<SearchUser>>> searchUsers({
    required String query,
    int limit = 20,
  });
}
