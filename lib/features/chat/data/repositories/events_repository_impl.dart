import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/event_entity.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/events_repository.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:chattrix_ui/features/chat/data/models/event_dto.dart';
import 'package:chattrix_ui/features/chat/data/mappers/event_mapper.dart';

class EventsRepositoryImpl extends BaseRepository implements EventsRepository {
  final ChatRemoteDatasource _remoteDatasource;

  EventsRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents({required String conversationId}) async {
    return executeApiCall(() async {
      final response = await _remoteDatasource.getEvents(conversationId: conversationId);

      final events = response.map((json) => EventDto.fromJson(json as Map<String, dynamic>).toEntity()).toList();

      return events;
    });
  }

  @override
  Future<Either<Failure, EventEntity>> createEvent({
    required String conversationId,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  }) async {
    return executeApiCall(() async {
      final response = await _remoteDatasource.createEvent(
        conversationId: conversationId,
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        location: location,
      );

      return EventDto.fromJson(response as Map<String, dynamic>).toEntity();
    });
  }

  @override
  Future<Either<Failure, EventEntity>> updateEvent({
    required String conversationId,
    required int eventId,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
  }) async {
    return executeApiCall(() async {
      final response = await _remoteDatasource.updateEvent(
        conversationId: conversationId,
        eventId: eventId,
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        location: location,
      );

      return EventDto.fromJson(response as Map<String, dynamic>).toEntity();
    });
  }

  @override
  Future<Either<Failure, EventEntity>> rsvpEvent({
    required String conversationId,
    required int eventId,
    required String status,
  }) async {
    return executeApiCall(() async {
      final response = await _remoteDatasource.rsvpEvent(
        conversationId: conversationId,
        eventId: eventId,
        status: status,
      );

      return EventDto.fromJson(response as Map<String, dynamic>).toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> deleteEvent({required String conversationId, required int eventId}) async {
    return executeApiCall(() async {
      await _remoteDatasource.deleteEvent(conversationId: conversationId, eventId: eventId);
    });
  }
}
