import 'package:dio/dio.dart';
import '../models/poll_dto.dart';
import '../models/create_poll_request_dto.dart';
import '../models/vote_request_dto.dart';
import '../../../../core/network/api_response.dart';

/// Poll API Service
///
/// Handles all HTTP requests related to polls
class PollApiService {
  final Dio _dio;

  PollApiService(this._dio);

  /// Create a new poll in a conversation
  ///
  /// **Endpoint**: `POST /v1/polls/conversation/{conversationId}`
  ///
  /// **Errors:**
  /// - 400: Validation failed
  /// - 401: Unauthorized
  /// - 404: Conversation not found
  Future<ApiResponse<PollDto>> createPoll({required int conversationId, required CreatePollRequestDto request}) async {
    final response = await _dio.post('/v1/polls/conversation/$conversationId', data: request.toJson());

    return ApiResponse<PollDto>.fromJson(response.data, (json) => PollDto.fromJson(json as Map<String, dynamic>));
  }

  /// Vote on a poll
  ///
  /// **Endpoint**: `POST /v1/polls/{pollId}/vote`
  ///
  /// **Errors:**
  /// - 400: Invalid vote (poll inactive, wrong number of options)
  /// - 401: Unauthorized
  /// - 404: Poll not found
  Future<ApiResponse<PollDto>> votePoll({required int pollId, required VoteRequestDto request}) async {
    final response = await _dio.post('/v1/polls/$pollId/vote', data: request.toJson());

    return ApiResponse<PollDto>.fromJson(response.data, (json) => PollDto.fromJson(json as Map<String, dynamic>));
  }

  /// Remove vote from a poll
  ///
  /// **Endpoint**: `DELETE /v1/polls/{pollId}/vote`
  ///
  /// **Errors:**
  /// - 400: Poll is not active
  /// - 401: Unauthorized
  /// - 404: Poll not found
  Future<ApiResponse<PollDto>> removeVote({required int pollId}) async {
    final response = await _dio.delete('/v1/polls/$pollId/vote');

    return ApiResponse<PollDto>.fromJson(response.data, (json) => PollDto.fromJson(json as Map<String, dynamic>));
  }

  /// Get poll by ID
  ///
  /// **Endpoint**: `GET /v1/polls/{pollId}`
  ///
  /// **Errors:**
  /// - 401: Unauthorized
  /// - 404: Poll not found
  Future<ApiResponse<PollDto>> getPollById({required int pollId}) async {
    final response = await _dio.get('/v1/polls/$pollId');

    return ApiResponse<PollDto>.fromJson(response.data, (json) => PollDto.fromJson(json as Map<String, dynamic>));
  }

  /// Get all polls in a conversation
  ///
  /// **Endpoint**: `GET /v1/polls/conversation/{conversationId}`
  ///
  /// **Query Parameters:**
  /// - page: Page number (default: 0)
  /// - size: Items per page (default: 20)
  ///
  /// **Errors:**
  /// - 401: Unauthorized
  /// - 404: Conversation not found
  Future<ApiResponse<List<PollDto>>> getConversationPolls({
    required int conversationId,
    int page = 0,
    int size = 20,
  }) async {
    final response = await _dio.get(
      '/v1/polls/conversation/$conversationId',
      queryParameters: {'page': page, 'size': size},
    );

    // API returns cursor-based paginated response: { success, message, data: { items: [...], meta: {...} } }
    final paginatedData = response.data['data'];
    final pollsData = paginatedData['items'] as List;

    return ApiResponse<List<PollDto>>(
      success: response.data['success'],
      message: response.data['message'],
      data: pollsData.map((json) => PollDto.fromJson(json)).toList(),
    );
  }

  /// Close a poll (creator only)
  ///
  /// **Endpoint**: `POST /v1/polls/{pollId}/close`
  ///
  /// **Errors:**
  /// - 401: Unauthorized
  /// - 403: Only creator can close poll
  /// - 404: Poll not found
  Future<ApiResponse<PollDto>> closePoll({required int pollId}) async {
    final response = await _dio.post('/v1/polls/$pollId/close');

    return ApiResponse<PollDto>.fromJson(response.data, (json) => PollDto.fromJson(json as Map<String, dynamic>));
  }

  /// Delete a poll (creator only)
  ///
  /// **Endpoint**: `DELETE /v1/polls/{pollId}`
  ///
  /// **Errors:**
  /// - 401: Unauthorized
  /// - 403: Only creator can delete poll
  /// - 404: Poll not found
  Future<ApiResponse<String>> deletePoll({required int pollId}) async {
    final response = await _dio.delete('/v1/polls/$pollId');

    return ApiResponse<String>(
      success: response.data['success'],
      message: response.data['message'],
      data: response.data['data'] as String,
    );
  }
}
