import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/network/api_response.dart';
import 'package:chattrix_ui/features/chat/data/models/event_model.dart';
import 'package:dio/dio.dart';

abstract class EventRemoteDataSource {
  Future<ApiResponse<List<EventModel>>> getEvents(String conversationId);

  Future<ApiResponse<EventModel>> createEvent(String conversationId, CreateEventRequest request);

  Future<ApiResponse<EventModel>> updateEvent(String conversationId, String eventId, UpdateEventRequest request);

  Future<ApiResponse<void>> deleteEvent(String conversationId, String eventId);

  Future<ApiResponse<EventModel>> rsvpEvent(String conversationId, String eventId, RsvpEventRequest request);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final Dio _dio;

  EventRemoteDataSourceImpl(this._dio);

  @override
  Future<ApiResponse<List<EventModel>>> getEvents(String conversationId) async {
    try {
      final response = await _dio.get(ApiConstants.events(conversationId));

      final apiResponse = ApiResponse<List<EventModel>>.fromJson(
        response.data,
        (json) => (json as List).map((item) => EventModel.fromJson(item as Map<String, dynamic>)).toList(),
      );

      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<EventModel>> createEvent(String conversationId, CreateEventRequest request) async {
    try {
      final response = await _dio.post(ApiConstants.events(conversationId), data: request.toJson());

      final apiResponse = ApiResponse<EventModel>.fromJson(
        response.data,
        (json) => EventModel.fromJson(json as Map<String, dynamic>),
      );

      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<EventModel>> updateEvent(String conversationId, String eventId, UpdateEventRequest request) async {
    try {
      final response = await _dio.put(ApiConstants.eventById(conversationId, eventId), data: request.toJson());

      final apiResponse = ApiResponse<EventModel>.fromJson(
        response.data,
        (json) => EventModel.fromJson(json as Map<String, dynamic>),
      );

      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<void>> deleteEvent(String conversationId, String eventId) async {
    try {
      final response = await _dio.delete(ApiConstants.eventById(conversationId, eventId));

      final apiResponse = ApiResponse<void>.fromJson(response.data, (json) => null);

      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<EventModel>> rsvpEvent(String conversationId, String eventId, RsvpEventRequest request) async {
    try {
      final response = await _dio.post(ApiConstants.rsvpEvent(conversationId, eventId), data: request.toJson());

      final apiResponse = ApiResponse<EventModel>.fromJson(
        response.data,
        (json) => EventModel.fromJson(json as Map<String, dynamic>),
      );

      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }
}
