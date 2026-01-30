import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/poll/domain/entities/poll_entity.dart';
import 'package:chattrix_ui/features/poll/domain/repositories/poll_repository.dart';
import 'package:fpdart/fpdart.dart';

class VotePollUseCase {
  final PollRepository _repository;

  VotePollUseCase(this._repository);

  Future<Either<Failure, PollEntity>> call({
    required int conversationId,
    required int pollId,
    required List<int> optionIds,
  }) async {
    // ✅ Allow empty array to unvote (remove all votes)
    // Backend will handle empty array as unvote
    // No validation needed - let backend decide
    
    return await _repository.votePoll(conversationId: conversationId, pollId: pollId, optionIds: optionIds);
  }
}
