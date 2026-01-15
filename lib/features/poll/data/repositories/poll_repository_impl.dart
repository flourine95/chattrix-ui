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
      final response = await _apiService.createPoll(
        conversationId: params.conversationId,
        request: params.toDto(),
      );

      if (response.success && response.data != null) {
        final message = response.data!.toEntity();
        
        // Extract poll data from message metadata
        if (message.pollData != null) {
          return message.pollData!;
        }

        throw ApiException(
          message: 'Poll data not found in message metadata',
          code: 'INVALID_RESPONSE',
          statusCode: 500,
        );
      }

      throw ApiException(
        message: response.message,
        code: 'CREATE_POLL_FAILED',
        statusCode: 500,
      );
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
        messageId: pollId, // pollId is now messageId
        request: optionIds.toDto(),
      );

      if (response.success && response.data != null) {
        final message = response.data!.toEntity();
        
        // Extract poll data from message metadata
        if (message.pollData != null) {
          return message.pollData!;
        }

        throw ApiException(
          message: 'Poll data not found in message metadata',
          code: 'INVALID_RESPONSE',
          statusCode: 500,
        );
      }

      throw ApiException(
        message: response.message,
        code: 'VOTE_FAILED',
        statusCode: 500,
      );
    });
  }

  @override
  Future<Either<Failure, PollEntity>> removeVote({
    required int conversationId,
    required int pollId,
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.removeVote(
        conversationId: conversationId,
        messageId: pollId, // pollId is now messageId
      );

      if (response.success && response.data != null) {
        final message = response.data!.toEntity();
        
        // Extract poll data from message metadata
        if (message.pollData != null) {
          return message.pollData!;
        }

        throw ApiException(
          message: 'Poll data not found in message metadata',
          code: 'INVALID_RESPONSE',
          statusCode: 500,
        );
      }

      throw ApiException(
        message: response.message,
        code: 'REMOVE_VOTE_FAILED',
        statusCode: 500,
      );
    });
  }

  @override
  Future<Either<Failure, PollEntity>> getPollById({
    required int conversationId,
    required int pollId,
  }) async {
    // This method is no longer supported in new API
    // Polls are fetched as part of messages
    return left(ServerFailure(
      message: 'getPollById is deprecated. Use getMessages with type=POLL filter',
      code: 'DEPRECATED',
    ));
  }

  @override
  Future<Either<Failure, List<PollEntity>>> getConversationPolls({
    required int conversationId,
    int page = 0,
    int size = 20,
  }) async {
    // This method is no longer supported in new API
    // Polls are fetched as part of messages
    return left(ServerFailure(
      message: 'getConversationPolls is deprecated. Use getMessages with type=POLL filter',
      code: 'DEPRECATED',
    ));
  }

  @override
  Future<Either<Failure, PollEntity>> closePoll({
    required int conversationId,
    required int pollId,
  }) async {
    // This method is no longer supported in new API
    return left(ServerFailure(
      message: 'closePoll is not supported in new API',
      code: 'NOT_SUPPORTED',
    ));
  }

  @override
  Future<Either<Failure, String>> deletePoll({
    required int conversationId,
    required int pollId,
  }) async {
    // This method is no longer supported in new API
    // Delete message instead
    return left(ServerFailure(
      message: 'deletePoll is deprecated. Use deleteMessage instead',
      code: 'DEPRECATED',
    ));
  }
}
