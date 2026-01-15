import 'package:chattrix_ui/core/network/api_response.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/poll/data/models/create_poll_request_dto.dart';
import 'package:chattrix_ui/features/poll/data/models/vote_request_dto.dart';
import 'package:dio/dio.dart';

class PollApiService {
  final Dio _dio;

  PollApiService(this._dio);

  /// Create poll - NEW API returns Message with metadata.poll
  Future<ApiResponse<MessageModel>> createPoll({
    required int conversationId,
    required CreatePollRequestDto request,
  }) async {
    final response = await _dio.post(
      '/v1/conversations/$conversationId/messages/poll',
      data: request.toJson(),
    );

    return ApiResponse<MessageModel>.fromJson(
      response.data,
      (json) => MessageModel.fromApi(json as Map<String, dynamic>),
    );
  }

  /// Vote poll - NEW API returns Message with updated metadata.poll
  Future<ApiResponse<MessageModel>> votePoll({
    required int conversationId,
    required int messageId,
    required VoteRequestDto request,
  }) async {
    final response = await _dio.post(
      '/v1/conversations/$conversationId/messages/$messageId/poll/vote',
      data: request.toJson(),
    );

    return ApiResponse<MessageModel>.fromJson(
      response.data,
      (json) => MessageModel.fromApi(json as Map<String, dynamic>),
    );
  }

  /// List polls with filters and pagination
  /// 
  /// **Endpoint**: GET /v1/conversations/{id}/polls
  /// 
  /// **Query Parameters:**
  /// - status: 'all' | 'active' | 'closed' (default: 'all')
  /// - cursor: pagination cursor (optional)
  /// - limit: items per page (default: 20)
  /// 
  /// **Response includes calculated fields:**
  /// - voteCount: number of votes per option
  /// - percentage: percentage of votes per option
  /// - hasVoted: whether current user has voted
  /// - isClosed: whether poll is closed
  /// - totalVotes: total number of votes
  Future<Map<String, dynamic>> listPolls({
    required int conversationId,
    String status = 'all',
    String? cursor,
    int limit = 20,
  }) async {
    final response = await _dio.get(
      '/v1/conversations/$conversationId/polls',
      queryParameters: {
        'status': status,
        if (cursor != null) 'cursor': cursor,
        'limit': limit,
      },
    );

    return response.data['data'] as Map<String, dynamic>;
  }

  /// Get poll detail
  Future<ApiResponse<MessageModel>> getPollDetail({
    required int conversationId,
    required int messageId,
  }) async {
    final response = await _dio.get(
      '/v1/conversations/$conversationId/polls/$messageId',
    );

    return ApiResponse<MessageModel>.fromJson(
      response.data,
      (json) => MessageModel.fromApi(json as Map<String, dynamic>),
    );
  }

  /// Close poll manually
  Future<ApiResponse<MessageModel>> closePoll({
    required int conversationId,
    required int messageId,
  }) async {
    final response = await _dio.post(
      '/v1/conversations/$conversationId/polls/$messageId/close',
    );

    return ApiResponse<MessageModel>.fromJson(
      response.data,
      (json) => MessageModel.fromApi(json as Map<String, dynamic>),
    );
  }

  /// Delete poll
  Future<void> deletePoll({
    required int conversationId,
    required int messageId,
  }) async {
    await _dio.delete(
      '/v1/conversations/$conversationId/polls/$messageId',
    );
  }

  // Legacy methods kept for backward compatibility (if needed)
  Future<ApiResponse<MessageModel>> removeVote({
    required int conversationId,
    required int messageId,
  }) async {
    final response = await _dio.delete(
      '/v1/conversations/$conversationId/messages/$messageId/poll/vote',
    );

    return ApiResponse<MessageModel>.fromJson(
      response.data,
      (json) => MessageModel.fromApi(json as Map<String, dynamic>),
    );
  }
}
