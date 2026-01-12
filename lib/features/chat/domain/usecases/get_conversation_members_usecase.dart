import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetConversationMembersUseCase {
  final ChatRepository _repository;

  GetConversationMembersUseCase(this._repository);

  Future<Either<Failure, List<SearchUser>>> call({
    required String conversationId,
    String? cursor,
    int limit = 20,
  }) async {
    return await _repository.getConversationMembers(
      conversationId: conversationId,
      cursor: cursor,
      limit: limit,
    );
  }
}

