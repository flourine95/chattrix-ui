import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/poll_repository.dart';

/// Use case for deleting a poll
class DeletePollUseCase {
  final PollRepository _repository;

  DeletePollUseCase(this._repository);

  Future<Either<Failure, void>> call({required int conversationId, required int pollId}) async {
    return await _repository.deletePoll(conversationId: conversationId, pollId: pollId);
  }
}
