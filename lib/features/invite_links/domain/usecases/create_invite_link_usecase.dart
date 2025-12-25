import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/domain/repositories/invite_links_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateInviteLinkUseCase {
  final InviteLinksRepository _repository;

  CreateInviteLinkUseCase(this._repository);

  Future<Either<Failure, InviteLinkEntity>> call({required int conversationId, int? expiresIn, int? maxUses}) async {
    if (conversationId <= 0) {
      return left(const Failure.validation(message: 'Invalid conversation ID', code: 'INVALID_CONVERSATION_ID'));
    }

    if (expiresIn != null && expiresIn <= 0) {
      return left(
        const Failure.validation(message: 'Expiration time must be greater than 0', code: 'INVALID_EXPIRES_IN'),
      );
    }

    if (maxUses != null && maxUses <= 0) {
      return left(const Failure.validation(message: 'Maximum uses must be greater than 0', code: 'INVALID_MAX_USES'));
    }

    return await _repository.createInviteLink(conversationId: conversationId, expiresIn: expiresIn, maxUses: maxUses);
  }
}
