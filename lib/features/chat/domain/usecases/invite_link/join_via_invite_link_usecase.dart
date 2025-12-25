import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/invite_link.dart';
import '../../repositories/invite_link_repository.dart';

/// Use case for joining a conversation via invite link
class JoinViaInviteLinkUseCase {
  final InviteLinkRepository _repository;

  JoinViaInviteLinkUseCase(this._repository);

  Future<Either<Failure, JoinViaInviteLink>> call({required String token}) async {
    // Validation
    if (token.trim().isEmpty) {
      return left(const Failure.validation(message: 'Token cannot be empty', code: 'INVALID_TOKEN'));
    }

    return await _repository.joinViaInviteLink(token: token);
  }
}
