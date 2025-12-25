import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/chat/data/models/event_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/event_datasource.dart';
import 'package:dio/dio.dart';

class EventDatasourceImpl implements EventDatasource {
  final Dio dio;

  EventDatasourceImpl({required this.dio});

  @override
  Future<EventModel> createEvent({required int conversationId, required CreateEventRequest request}) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/events', data: request.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return EventModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to create event');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to create event');
    }
  }

  @override
  Future<EventModel> updateEvent({
    required int conversationId,
    required int eventId,
    required UpdateEventRequest request,
  }) async {
    try {
      final response = await dio.put('/v1/conversations/$conversationId/events/$eventId', data: request.toJson());

      if (response.statusCode == 200) {
        return EventModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to update event');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to update event');
    }
  }

  @override
  Future<String> deleteEvent({required int conversationId, required int eventId}) async {
    try {
      final response = await dio.delete('/v1/conversations/$conversationId/events/$eventId');

      if (response.statusCode == 200) {
        return response.data['data'] as String? ?? 'Event deleted successfully';
      }

      throw ServerException(message: 'Failed to delete event');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to delete event');
    }
  }

  @override
  Future<EventModel> rsvpEvent({
    required int conversationId,
    required int eventId,
    required RsvpEventRequest request,
  }) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/events/$eventId/rsvp', data: request.toJson());

      if (response.statusCode == 200) {
        return EventModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to RSVP event');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to RSVP event');
    }
  }

  @override
  Future<EventModel> getEventDetails({required int conversationId, required int eventId}) async {
    try {
      final response = await dio.get('/v1/conversations/$conversationId/events/$eventId');

      if (response.statusCode == 200) {
        return EventModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to get event details');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get event details');
    }
  }

  @override
  Future<List<EventModel>> getAllEvents({required int conversationId}) async {
    try {
      final response = await dio.get('/v1/conversations/$conversationId/events');

      if (response.statusCode == 200) {
        // Handle case when there are no events (data might be null or empty)
        final data = response.data['data'];
        if (data == null) {
          return [];
        }

        final List<dynamic> eventsList = data as List<dynamic>;
        return eventsList.map((json) => EventModel.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw ServerException(message: 'Failed to get events');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get events');
    }
  }
}
