import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/domain/repositories/invite_links_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Revoke the current active invite link
class RevokeInviteLinkUseCase {
  final InviteLinksRepository _repository;

  RevokeInviteLinkUseCase(this._repository);

  /// Revoke the current invite link
  /// 
  /// Returns the revoked link
  Future<Either<Failure, InviteLinkEntity>> call({
    required int conversationId,
  }) async {
    if (conversationId <= 0) {
      return left(const Failure.validation(
        message: 'Invalid conversation ID',
        code: 'INVALID_CONVERSATION_ID',
      ));
    }

    return await _repository.revokeInviteLink(
      conversationId: conversationId,
    );
  }
}
