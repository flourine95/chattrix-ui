import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/event_entity.dart';

/// Repository interface for events operations
abstract class EventsRepository {
  /// Get all events in a conversation
  ///
  /// **API:** `GET /v1/conversations/{conversationId}/events`
  Future<Either<Failure, List<EventEntity>>> getEvents({required String conversationId});

  /// Create a new event
  ///
  /// **API:** `POST /v1/conversations/{conversationId}/events`
  Future<Either<Failure, EventEntity>> createEvent({
    required String conversationId,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  });

  /// Update an existing event
  ///
  /// **API:** `PUT /v1/conversations/{conversationId}/events/{eventId}`
  Future<Either<Failure, EventEntity>> updateEvent({
    required String conversationId,
    required int eventId,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
  });

  /// RSVP to an event
  ///
  /// **API:** `POST /v1/conversations/{conversationId}/events/{eventId}/rsvp`
  Future<Either<Failure, EventEntity>> rsvpEvent({
    required String conversationId,
    required int eventId,
    required String status,
  });

  /// Delete an event
  ///
  /// **API:** `DELETE /v1/conversations/{conversationId}/events/{eventId}`
  Future<Either<Failure, void>> deleteEvent({required String conversationId, required int eventId});
}
