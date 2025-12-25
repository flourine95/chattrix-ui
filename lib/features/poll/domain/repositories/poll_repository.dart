import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/poll/domain/entities/create_poll_params.dart';
import 'package:chattrix_ui/features/poll/domain/entities/poll_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class PollRepository {
  Future<Either<Failure, PollEntity>> createPoll({required CreatePollParams params});

  Future<Either<Failure, PollEntity>> votePoll({
    required int conversationId,
    required int pollId,
    required List<int> optionIds,
  });

  Future<Either<Failure, PollEntity>> removeVote({required int conversationId, required int pollId});

  Future<Either<Failure, PollEntity>> getPollById({required int conversationId, required int pollId});

  Future<Either<Failure, List<PollEntity>>> getConversationPolls({
    required int conversationId,
    int page = 0,
    int size = 20,
  });

  Future<Either<Failure, PollEntity>> closePoll({required int conversationId, required int pollId});

  Future<Either<Failure, String>> deletePoll({required int conversationId, required int pollId});
}
