import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/invite_link.dart';
import '../../repositories/invite_link_repository.dart';

/// Use case for revoking an invite link
class RevokeInviteLinkUseCase {
  final InviteLinkRepository _repository;

  RevokeInviteLinkUseCase(this._repository);

  Future<Either<Failure, InviteLink>> call({required int conversationId, required int linkId}) async {
    return await _repository.revokeInviteLink(conversationId: conversationId, linkId: linkId);
  }
}
