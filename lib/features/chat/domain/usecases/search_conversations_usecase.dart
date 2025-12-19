import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class SearchConversationsUseCase {
  final ChatRepository _repository;

  SearchConversationsUseCase(this._repository);

  Future<Either<Failure, List<Conversation>>> call({required String query}) async {
    if (query.trim().isEmpty) {
      return right([]);
    }

    return await _repository.searchConversations(query: query);
  }
}
