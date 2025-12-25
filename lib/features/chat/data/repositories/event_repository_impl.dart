import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../../domain/datasources/event_datasource.dart';
import '../mappers/event_mapper.dart';
import '../models/event_model.dart';

class EventRepositoryImpl extends BaseRepository implements EventRepository {
  final EventDatasource _datasource;

  EventRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, Event>> createEvent({
    required int conversationId,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  }) async {
    return executeApiCall(() async {
      final request = CreateEventRequest(
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        location: location,
      );
      final model = await _datasource.createEvent(conversationId: conversationId, request: request);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, Event>> updateEvent({
    required int conversationId,
    required int eventId,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
  }) async {
    return executeApiCall(() async {
      final request = UpdateEventRequest(
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        location: location,
      );
      final model = await _datasource.updateEvent(conversationId: conversationId, eventId: eventId, request: request);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, String>> deleteEvent({required int conversationId, required int eventId}) async {
    return executeApiCall(() async {
      return await _datasource.deleteEvent(conversationId: conversationId, eventId: eventId);
    });
  }

  @override
  Future<Either<Failure, Event>> rsvpEvent({
    required int conversationId,
    required int eventId,
    required String status,
  }) async {
    return executeApiCall(() async {
      final request = RsvpEventRequest(status: status);
      final model = await _datasource.rsvpEvent(conversationId: conversationId, eventId: eventId, request: request);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, Event>> getEventDetails({required int conversationId, required int eventId}) async {
    return executeApiCall(() async {
      final model = await _datasource.getEventDetails(conversationId: conversationId, eventId: eventId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<Event>>> getAllEvents({required int conversationId}) async {
    return executeApiCall(() async {
      final models = await _datasource.getAllEvents(conversationId: conversationId);
      return models.map((model) => model.toEntity()).toList();
    });
  }
}
