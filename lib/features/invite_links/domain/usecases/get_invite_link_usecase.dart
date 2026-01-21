import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/domain/repositories/invite_links_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Get current active invite link for a conversation
class GetInviteLinkUseCase {
  final InviteLinksRepository _repository;

  GetInviteLinkUseCase(this._repository);

  /// Get the current active invite link
  /// 
  /// Returns null if no active link exists
  Future<Either<Failure, InviteLinkEntity?>> call({
    required int conversationId,
  }) async {
    if (conversationId <= 0) {
      return left(const Failure.validation(
        message: 'Invalid conversation ID',
        code: 'INVALID_CONVERSATION_ID',
      ));
    }

    return await _repository.getInviteLink(
      conversationId: conversationId,
    );
  }
}
