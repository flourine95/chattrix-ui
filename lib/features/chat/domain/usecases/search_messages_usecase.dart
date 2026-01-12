import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for searching messages in a conversation
///
/// **API:** `GET /v1/conversations/{conversationId}/search/messages`
class SearchMessagesUseCase {
  final ChatRepository _repository;

  SearchMessagesUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation to search in
  /// - [query]: Search query string
  /// - [cursor]: Optional cursor for pagination
  /// - [limit]: Number of results per page (default 20)
  ///
  /// **Returns:**
  /// - Right(List<Message>): List of messages matching the query
  /// - Left(Failure): Error occurred
  Future<Either<Failure, List<Message>>> call({
    required String conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  }) async {
    // Validate input
    if (query.trim().isEmpty) {
      return left(const Failure.validation(message: 'Search query cannot be empty', code: 'INVALID_INPUT'));
    }

    // Call repository
    return await _repository.searchMessages(conversationId: conversationId, query: query, cursor: cursor, limit: limit);
  }
}
