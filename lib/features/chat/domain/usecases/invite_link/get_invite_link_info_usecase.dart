import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/invite_link.dart';
import '../../repositories/invite_link_repository.dart';

/// Use case for getting invite link info
class GetInviteLinkInfoUseCase {
  final InviteLinkRepository _repository;

  GetInviteLinkInfoUseCase(this._repository);

  Future<Either<Failure, InviteLinkInfo>> call({required String token}) async {
    // Validation
    if (token.trim().isEmpty) {
      return left(const Failure.validation(message: 'Token cannot be empty', code: 'INVALID_TOKEN'));
    }

    return await _repository.getInviteLinkInfo(token: token);
  }
}
