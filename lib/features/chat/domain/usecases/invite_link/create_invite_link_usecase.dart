import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/invite_link.dart';
import '../../repositories/invite_link_repository.dart';

/// Use case for creating an invite link
class CreateInviteLinkUseCase {
  final InviteLinkRepository _repository;

  CreateInviteLinkUseCase(this._repository);

  Future<Either<Failure, InviteLink>> call({required int conversationId, int? expiresInDays, int? maxUses}) async {
    // Validation
    if (expiresInDays != null && expiresInDays <= 0) {
      return left(const Failure.validation(message: 'Expiration days must be positive', code: 'INVALID_EXPIRATION'));
    }

    if (maxUses != null && maxUses <= 0) {
      return left(const Failure.validation(message: 'Max uses must be positive', code: 'INVALID_MAX_USES'));
    }

    return await _repository.createInviteLink(
      conversationId: conversationId,
      expiresInDays: expiresInDays,
      maxUses: maxUses,
    );
  }
}
