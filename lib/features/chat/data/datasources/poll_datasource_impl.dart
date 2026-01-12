import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/chat/data/models/poll_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/poll_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PollDatasourceImpl implements PollDatasource {
  final Dio dio;

  PollDatasourceImpl({required this.dio});

  @override
  Future<PollModel> createPoll({required int conversationId, required CreatePollRequest request}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/polls', data: request.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return PollModel.fromJson(response.data['data'] as Map<String, dynamic>);
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
      final response = await dio.post('/v1/conversations/$conversationId/polls/$pollId/vote', data: request.toJson());

      if (response.statusCode == 200) {
        return PollModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to vote poll');
    } on DioException catch (e) {
      debugPrint('❌ Vote error: ${e.response?.statusCode} - ${e.response?.data}');
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
      final response = await dio.delete('/v1/conversations/$conversationId/polls/$pollId/vote', data: request.toJson());

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
      final response = await dio.post('/v1/conversations/$conversationId/polls/$pollId/close');

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
      final response = await dio.delete('/v1/conversations/$conversationId/polls/$pollId');

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
      final response = await dio.get('/v1/conversations/$conversationId/polls/$pollId');

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
      final response = await dio.get('/v1/conversations/$conversationId/polls');

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
      debugPrint('🗳️ [PollDatasource] Error: ${e.response?.statusCode} - ${e.response?.data}');
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get polls');
    }
  }
}
