import 'package:chattrix_ui/core/network/api_response.dart';
import 'package:chattrix_ui/features/poll/data/models/create_poll_request_dto.dart';
import 'package:chattrix_ui/features/poll/data/models/poll_dto.dart';
import 'package:chattrix_ui/features/poll/data/models/vote_request_dto.dart';
import 'package:dio/dio.dart';

class PollApiService {
  final Dio _dio;

  PollApiService(this._dio);

  Future<ApiResponse<PollDto>> createPoll({required int conversationId, required CreatePollRequestDto request}) async {
    final response = await _dio.post('/v1/conversations/$conversationId/polls', data: request.toJson());

    return ApiResponse<PollDto>.fromJson(response.data, (json) => PollDto.fromJson(json as Map<String, dynamic>));
  }

  Future<ApiResponse<PollDto>> votePoll({
    required int conversationId,
    required int pollId,
    required VoteRequestDto request,
  }) async {
    final response = await _dio.post('/v1/conversations/$conversationId/polls/$pollId/vote', data: request.toJson());

    return ApiResponse<PollDto>.fromJson(response.data, (json) => PollDto.fromJson(json as Map<String, dynamic>));
  }

  Future<ApiResponse<PollDto>> removeVote({required int conversationId, required int pollId}) async {
    final response = await _dio.delete('/v1/conversations/$conversationId/polls/$pollId/vote');

    return ApiResponse<PollDto>.fromJson(response.data, (json) => PollDto.fromJson(json as Map<String, dynamic>));
  }

  Future<ApiResponse<PollDto>> getPollById({required int conversationId, required int pollId}) async {
    final response = await _dio.get('/v1/conversations/$conversationId/polls/$pollId');

    return ApiResponse<PollDto>.fromJson(response.data, (json) => PollDto.fromJson(json as Map<String, dynamic>));
  }

  Future<ApiResponse<List<PollDto>>> getConversationPolls({
    required int conversationId,
    int page = 0,
    int size = 20,
  }) async {
    final response = await _dio.get(
      '/v1/conversations/$conversationId/polls',
      queryParameters: {'page': page, 'size': size},
    );

    final paginatedData = response.data['data'];
    final pollsData = paginatedData['items'] as List;

    return ApiResponse<List<PollDto>>(
      success: response.data['success'],
      message: response.data['message'],
      data: pollsData.map((json) => PollDto.fromJson(json)).toList(),
    );
  }

  Future<ApiResponse<PollDto>> closePoll({required int conversationId, required int pollId}) async {
    final response = await _dio.post('/v1/conversations/$conversationId/polls/$pollId/close');

    return ApiResponse<PollDto>.fromJson(response.data, (json) => PollDto.fromJson(json as Map<String, dynamic>));
  }

  Future<ApiResponse<String>> deletePoll({required int conversationId, required int pollId}) async {
    final response = await _dio.delete('/v1/conversations/$conversationId/polls/$pollId');

    return ApiResponse<String>(
      success: response.data['success'],
      message: response.data['message'],
      data: response.data['data'] as String,
    );
  }
}
