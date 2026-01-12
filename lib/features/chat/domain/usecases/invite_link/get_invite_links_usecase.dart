import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/invite_link.dart';
import '../../repositories/invite_link_repository.dart';

/// Use case for getting all invite links for a conversation
class GetInviteLinksUseCase {
  final InviteLinkRepository _repository;

  GetInviteLinksUseCase(this._repository);

  Future<Either<Failure, List<InviteLink>>> call({required int conversationId}) async {
    return await _repository.getInviteLinks(conversationId: conversationId);
  }
}
