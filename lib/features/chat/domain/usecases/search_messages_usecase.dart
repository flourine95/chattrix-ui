import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class SearchMessagesUseCase {
  final ChatRepository _repository;

  SearchMessagesUseCase(this._repository);

  Future<Either<Failure, List<Message>>> call({
    required int conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  }) async {
    if (query.trim().isEmpty) {
      return left(const Failure.validation(message: 'Search query cannot be empty', code: 'INVALID_INPUT'));
    }

    return await _repository.searchMessages(conversationId: conversationId, query: query, cursor: cursor, limit: limit);
  }
}
