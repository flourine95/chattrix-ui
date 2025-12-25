import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/domain/repositories/invite_links_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetInviteLinksUseCase {
  final InviteLinksRepository _repository;

  GetInviteLinksUseCase(this._repository);

  Future<Either<Failure, ({List<InviteLinkEntity> items, String? nextCursor, bool hasNextPage})>> call({
    required int conversationId,
    String? cursor,
    int limit = 20,
    bool includeRevoked = false,
  }) async {
    if (conversationId <= 0) {
      return left(const Failure.validation(message: 'Invalid conversation ID', code: 'INVALID_CONVERSATION_ID'));
    }

    if (limit <= 0 || limit > 100) {
      return left(const Failure.validation(message: 'Limit must be between 1 and 100', code: 'INVALID_LIMIT'));
    }

    return await _repository.getInviteLinks(
      conversationId: conversationId,
      cursor: cursor,
      limit: limit,
      includeRevoked: includeRevoked,
    );
  }
}
