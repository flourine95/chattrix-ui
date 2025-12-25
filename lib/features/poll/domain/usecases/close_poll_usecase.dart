import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/poll/domain/entities/poll_entity.dart';
import 'package:chattrix_ui/features/poll/domain/repositories/poll_repository.dart';
import 'package:fpdart/fpdart.dart';

class ClosePollUseCase {
  final PollRepository _repository;

  ClosePollUseCase(this._repository);

  Future<Either<Failure, PollEntity>> call({required int conversationId, required int pollId}) async {
    return await _repository.closePoll(conversationId: conversationId, pollId: pollId);
  }
}
