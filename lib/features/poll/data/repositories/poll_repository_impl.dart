import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:chattrix_ui/features/poll/data/datasources/poll_api_service.dart';
import 'package:chattrix_ui/features/poll/data/mappers/poll_mapper.dart';
import 'package:chattrix_ui/features/poll/domain/entities/create_poll_params.dart';
import 'package:chattrix_ui/features/poll/domain/entities/poll_entity.dart';
import 'package:chattrix_ui/features/poll/domain/repositories/poll_repository.dart';
import 'package:fpdart/fpdart.dart';

class PollRepositoryImpl extends BaseRepository implements PollRepository {
  final PollApiService _apiService;

  PollRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, PollEntity>> createPoll({required CreatePollParams params}) async {
    return executeApiCall(() async {
      final response = await _apiService.createPoll(conversationId: params.conversationId, request: params.toDto());

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }

      throw ApiException(message: response.message, code: 'CREATE_POLL_FAILED', statusCode: 500);
    });
  }

  @override
  Future<Either<Failure, PollEntity>> votePoll({
    required int conversationId,
    required int pollId,
    required List<int> optionIds,
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.votePoll(
        conversationId: conversationId,
        pollId: pollId,
        request: optionIds.toDto(),
      );

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }

      throw ApiException(message: response.message, code: 'VOTE_FAILED', statusCode: 500);
    });
  }

  @override
  Future<Either<Failure, PollEntity>> removeVote({required int conversationId, required int pollId}) async {
    return executeApiCall(() async {
      final response = await _apiService.removeVote(conversationId: conversationId, pollId: pollId);

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }

      throw ApiException(message: response.message, code: 'REMOVE_VOTE_FAILED', statusCode: 500);
    });
  }

  @override
  Future<Either<Failure, PollEntity>> getPollById({required int conversationId, required int pollId}) async {
    return executeApiCall(() async {
      final response = await _apiService.getPollById(conversationId: conversationId, pollId: pollId);

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }

      throw ApiException(message: response.message, code: 'GET_POLL_FAILED', statusCode: 500);
    });
  }

  @override
  Future<Either<Failure, List<PollEntity>>> getConversationPolls({
    required int conversationId,
    int page = 0,
    int size = 20,
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.getConversationPolls(conversationId: conversationId, page: page, size: size);

      if (response.success && response.data != null) {
        return response.data!.map((dto) => dto.toEntity()).toList();
      }

      throw ApiException(message: response.message, code: 'GET_POLLS_FAILED', statusCode: 500);
    });
  }

  @override
  Future<Either<Failure, PollEntity>> closePoll({required int conversationId, required int pollId}) async {
    return executeApiCall(() async {
      final response = await _apiService.closePoll(conversationId: conversationId, pollId: pollId);

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }

      throw ApiException(message: response.message, code: 'CLOSE_POLL_FAILED', statusCode: 500);
    });
  }

  @override
  Future<Either<Failure, String>> deletePoll({required int conversationId, required int pollId}) async {
    return executeApiCall(() async {
      final response = await _apiService.deletePoll(conversationId: conversationId, pollId: pollId);

      if (response.success && response.data != null) {
        return response.data!;
      }

      throw ApiException(message: response.message, code: 'DELETE_POLL_FAILED', statusCode: 500);
    });
  }
}
