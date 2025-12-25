import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/domain/repositories/invite_links_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetInviteLinkInfoUseCase {
  final InviteLinksRepository _repository;

  GetInviteLinkInfoUseCase(this._repository);

  Future<Either<Failure, InviteLinkInfoEntity>> call({required String token}) async {
    if (token.isEmpty) {
      return left(const Failure.validation(message: 'Token cannot be empty', code: 'INVALID_TOKEN'));
    }

    return await _repository.getInviteLinkInfo(token: token);
  }
}
