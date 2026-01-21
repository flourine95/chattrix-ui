import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/domain/repositories/invite_links_repository.dart';
import 'package:fpdart/fpdart.dart';

class JoinGroupViaLinkUseCase {
  final InviteLinksRepository _repository;

  JoinGroupViaLinkUseCase(this._repository);

  Future<Either<Failure, JoinGroupResultEntity>> call({required String token}) async {
    return await _repository.joinGroupViaLink(token: token);
  }
}
