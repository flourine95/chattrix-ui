import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../entities/invite_link_entity.dart';
import '../repositories/invite_links_repository.dart';

/// Use case for getting invite links
class GetInviteLinksUseCase {
  final InviteLinksRepository _repository;

  GetInviteLinksUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation
  /// - [cursor]: Cursor for pagination
  /// - [limit]: Number of items per page
  /// - [includeRevoked]: Include revoked links
  ///
  /// **Returns:**
  /// - Right((items, nextCursor, hasNextPage)): Success
  /// - Left(Failure): Error occurred
  Future<Either<Failure, ({List<InviteLinkEntity> items, String? nextCursor, bool hasNextPage})>> call({
    required int conversationId,
    String? cursor,
    int limit = 20,
    bool includeRevoked = false,
  }) async {
    // Validation
    if (conversationId <= 0) {
      return left(
        const Failure.validation(message: 'ID cuộc trò chuyện không hợp lệ', code: 'INVALID_CONVERSATION_ID'),
      );
    }

    if (limit <= 0 || limit > 100) {
      return left(const Failure.validation(message: 'Limit phải từ 1 đến 100', code: 'INVALID_LIMIT'));
    }

    return await _repository.getInviteLinks(
      conversationId: conversationId,
      cursor: cursor,
      limit: limit,
      includeRevoked: includeRevoked,
    );
  }
}
