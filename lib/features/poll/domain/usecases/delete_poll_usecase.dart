import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/poll/domain/repositories/poll_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeletePollUseCase {
  final PollRepository _repository;

  DeletePollUseCase(this._repository);

  Future<Either<Failure, String>> call({required int conversationId, required int pollId}) async {
    return await _repository.deletePoll(conversationId: conversationId, pollId: pollId);
  }
}
