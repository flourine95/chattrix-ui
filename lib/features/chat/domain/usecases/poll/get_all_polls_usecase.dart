import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/poll.dart';
import '../../repositories/poll_repository.dart';

/// Use case for getting all polls in a conversation
class GetAllPollsUseCase {
  final PollRepository _repository;

  GetAllPollsUseCase(this._repository);

  Future<Either<Failure, List<Poll>>> call({required int conversationId}) async {
    return await _repository.getAllPolls(conversationId: conversationId);
  }
}
