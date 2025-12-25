import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/poll.dart';
import '../../repositories/poll_repository.dart';

/// Use case for voting on a poll
class VotePollUseCase {
  final PollRepository _repository;

  VotePollUseCase(this._repository);

  Future<Either<Failure, Poll>> call({
    required int conversationId,
    required int pollId,
    required List<int> optionIds,
  }) async {
    // Validation
    if (optionIds.isEmpty) {
      return left(const Failure.validation(message: 'Must select at least one option', code: 'NO_OPTION_SELECTED'));
    }

    return await _repository.votePoll(conversationId: conversationId, pollId: pollId, optionIds: optionIds);
  }
}
