import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import '../../domain/entities/poll.dart';
import '../../domain/repositories/poll_repository.dart';
import '../../domain/datasources/poll_datasource.dart';
import '../mappers/poll_mapper.dart';
import '../models/poll_model.dart';

class PollRepositoryImpl extends BaseRepository implements PollRepository {
  final PollDatasource _datasource;

  PollRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, Poll>> createPoll({
    required int conversationId,
    required String question,
    required List<String> options,
    required bool allowMultipleVotes,
    DateTime? expiresAt,
  }) async {
    return executeApiCall(() async {
      final request = CreatePollRequest(
        question: question,
        options: options,
        allowMultipleVotes: allowMultipleVotes,
        expiresAt: expiresAt,
      );
      final model = await _datasource.createPoll(conversationId: conversationId, request: request);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, Poll>> votePoll({
    required int conversationId,
    required int pollId,
    required List<int> optionIds,
  }) async {
    return executeApiCall(() async {
      final request = VotePollRequest(optionIds: optionIds);
      final model = await _datasource.votePoll(conversationId: conversationId, pollId: pollId, request: request);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, Poll>> removeVote({
    required int conversationId,
    required int pollId,
    required List<int> optionIds,
  }) async {
    return executeApiCall(() async {
      final request = RemoveVoteRequest(optionIds: optionIds);
      final model = await _datasource.removeVote(conversationId: conversationId, pollId: pollId, request: request);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, Poll>> closePoll({required int conversationId, required int pollId}) async {
    return executeApiCall(() async {
      final model = await _datasource.closePoll(conversationId: conversationId, pollId: pollId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, String>> deletePoll({required int conversationId, required int pollId}) async {
    return executeApiCall(() async {
      return await _datasource.deletePoll(conversationId: conversationId, pollId: pollId);
    });
  }

  @override
  Future<Either<Failure, Poll>> getPollDetails({required int conversationId, required int pollId}) async {
    return executeApiCall(() async {
      final model = await _datasource.getPollDetails(conversationId: conversationId, pollId: pollId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<Poll>>> getAllPolls({required int conversationId}) async {
    return executeApiCall(() async {
      final models = await _datasource.getAllPolls(conversationId: conversationId);
      return models.map((model) => model.toEntity()).toList();
    });
  }
}
