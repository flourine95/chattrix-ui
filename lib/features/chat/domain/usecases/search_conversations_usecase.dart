import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for searching conversations by query
///
/// **Single Responsibility**: Search conversations by name or last message content
class SearchConversationsUseCase {
  final ChatRepository _repository;

  SearchConversationsUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [query]: Search query string
  ///
  /// **Returns:**
  /// - Right(List<Conversation>): Success with filtered conversations
  /// - Left(Failure): Error occurred
  Future<Either<Failure, List<Conversation>>> call({required String query}) async {
    // Business logic validation
    if (query.trim().isEmpty) {
      return right([]); // Return empty list for empty query
    }

    // Call repository
    return await _repository.searchConversations(query: query);
  }
}
