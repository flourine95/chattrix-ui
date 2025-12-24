import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/invite_link_entity.dart';
import '../repositories/invite_links_repository.dart';

/// Use case for revoking invite link
class RevokeInviteLinkUseCase {
  final InviteLinksRepository _repository;

  RevokeInviteLinkUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [conversationId]: ID of the conversation
  /// - [linkId]: ID of the link to revoke
  ///
  /// **Returns:**
  /// - Right(InviteLinkEntity): Success
  /// - Left(Failure): Error occurred
  Future<Either<Failure, InviteLinkEntity>> call({required int conversationId, required int linkId}) async {
    // Validation
    if (conversationId <= 0) {
      return left(
        const Failure.validation(message: 'ID cuộc trò chuyện không hợp lệ', code: 'INVALID_CONVERSATION_ID'),
      );
    }

    if (linkId <= 0) {
      return left(const Failure.validation(message: 'ID link không hợp lệ', code: 'INVALID_LINK_ID'));
    }

    return await _repository.revokeInviteLink(conversationId: conversationId, linkId: linkId);
  }
}
