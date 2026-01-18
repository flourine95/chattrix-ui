import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/chat/data/models/poll_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/poll_datasource.dart';
import 'package:dio/dio.dart';

class PollDatasourceImpl implements PollDatasource {
  final Dio dio;

  PollDatasourceImpl({required this.dio});

  @override
  Future<PollModel> createPoll({required int conversationId, required CreatePollRequest request}) async {
    try {
      final response = await dio.post(ApiConstants.createPoll(conversationId), data: request.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'] as Map<String, dynamic>;

        final metadata = data['metadata'] as Map<String, dynamic>?;
        if (metadata != null && metadata['poll'] != null) {
          final pollJson = metadata['poll'] as Map<String, dynamic>;
          return PollModel.fromJson(pollJson);
        }

        throw ServerException(message: 'Poll data not found in response');
      }

      throw ServerException(message: 'Failed to create poll');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to create poll');
    }
  }

  @override
  Future<PollModel> votePoll({
    required int conversationId,
    required int pollId,
    required VotePollRequest request,
  }) async {
    try {
      final response = await dio.post(ApiConstants.votePoll(conversationId, pollId), data: request.toJson());

      if (response.statusCode == 200) {
        return PollModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to vote poll');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to vote poll');
    }
  }

  @override
  Future<PollModel> removeVote({
    required int conversationId,
    required int pollId,
    required RemoveVoteRequest request,
  }) async {
    try {
      final response = await dio.delete(
        '${ApiConstants.pollById(conversationId, pollId)}/vote',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return PollModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to remove vote');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to remove vote');
    }
  }

  @override
  Future<PollModel> closePoll({required int conversationId, required int pollId}) async {
    try {
      final response = await dio.post(ApiConstants.closePoll(conversationId, pollId));

      if (response.statusCode == 200) {
        return PollModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to close poll');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to close poll');
    }
  }

  @override
  Future<String> deletePoll({required int conversationId, required int pollId}) async {
    try {
      final response = await dio.delete(ApiConstants.pollById(conversationId, pollId));

      if (response.statusCode == 200) {
        return response.data['data'] as String? ?? 'Poll deleted successfully';
      }

      throw ServerException(message: 'Failed to delete poll');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to delete poll');
    }
  }

  @override
  Future<PollModel> getPollDetails({required int conversationId, required int pollId}) async {
    try {
      final response = await dio.get(ApiConstants.pollById(conversationId, pollId));

      if (response.statusCode == 200) {
        return PollModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to get poll details');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get poll details');
    }
  }

  @override
  Future<List<PollModel>> getAllPolls({required int conversationId}) async {
    try {
      final response = await dio.get(ApiConstants.polls(conversationId));

      if (response.statusCode == 200) {
        final dataWrapper = response.data['data'] as Map<String, dynamic>?;

        if (dataWrapper == null || dataWrapper['items'] == null) {
          return [];
        }

        final List<dynamic> pollsList = dataWrapper['items'] as List<dynamic>;
        return pollsList.map((json) => PollModel.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw ServerException(message: 'Failed to get polls');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get polls');
    }
  }
}
