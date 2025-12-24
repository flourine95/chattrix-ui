import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/poll_entity.dart';
import '../../domain/entities/create_poll_params.dart';
import '../../domain/repositories/poll_repository.dart';
import '../datasources/poll_api_service.dart';
import '../mappers/poll_mapper.dart';

/// Poll repository implementation
///
/// Implements PollRepository interface using PollApiService
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
  Future<Either<Failure, PollEntity>> votePoll({required int pollId, required List<int> optionIds}) async {
    return executeApiCall(() async {
      final response = await _apiService.votePoll(pollId: pollId, request: optionIds.toDto());

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }

      throw ApiException(message: response.message, code: 'VOTE_FAILED', statusCode: 500);
    });
  }

  @override
  Future<Either<Failure, PollEntity>> removeVote({required int pollId}) async {
    return executeApiCall(() async {
      final response = await _apiService.removeVote(pollId: pollId);

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }

      throw ApiException(message: response.message, code: 'REMOVE_VOTE_FAILED', statusCode: 500);
    });
  }

  @override
  Future<Either<Failure, PollEntity>> getPollById({required int pollId}) async {
    return executeApiCall(() async {
      final response = await _apiService.getPollById(pollId: pollId);

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
  Future<Either<Failure, PollEntity>> closePoll({required int pollId}) async {
    return executeApiCall(() async {
      final response = await _apiService.closePoll(pollId: pollId);

      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }

      throw ApiException(message: response.message, code: 'CLOSE_POLL_FAILED', statusCode: 500);
    });
  }

  @override
  Future<Either<Failure, String>> deletePoll({required int pollId}) async {
    return executeApiCall(() async {
      final response = await _apiService.deletePoll(pollId: pollId);

      if (response.success && response.data != null) {
        return response.data!;
      }

      throw ApiException(message: response.message, code: 'DELETE_POLL_FAILED', statusCode: 500);
    });
  }
}
