import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../entities/event.dart';

/// Repository interface for events
/// Implementation: Data Layer
abstract class EventRepository {
  /// Create an event
  /// Returns [Right] with [Event] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Event>> createEvent({
    required int conversationId,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  });

  /// Update an event
  Future<Either<Failure, Event>> updateEvent({
    required int conversationId,
    required int eventId,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
  });

  /// Delete an event
  Future<Either<Failure, String>> deleteEvent({required int conversationId, required int eventId});

  /// RSVP to an event
  Future<Either<Failure, Event>> rsvpEvent({required int conversationId, required int eventId, required String status});

  /// Get event details
  Future<Either<Failure, Event>> getEventDetails({required int conversationId, required int eventId});

  /// Get all events in a conversation
  Future<Either<Failure, List<Event>>> getAllEvents({required int conversationId});
}
