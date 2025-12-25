import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/poll.dart';
import '../../repositories/poll_repository.dart';

/// Use case for closing a poll
class ClosePollUseCase {
  final PollRepository _repository;

  ClosePollUseCase(this._repository);

  Future<Either<Failure, Poll>> call({required int conversationId, required int pollId}) async {
    return await _repository.closePoll(conversationId: conversationId, pollId: pollId);
  }
}
