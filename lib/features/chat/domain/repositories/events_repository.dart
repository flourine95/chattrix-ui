import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/event_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class EventsRepository {
  Future<Either<Failure, List<EventEntity>>> getEvents({required int conversationId});

  Future<Either<Failure, EventEntity>> createEvent({
    required int conversationId,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  });

  Future<Either<Failure, EventEntity>> updateEvent({
    required int conversationId,
    required int eventId,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
  });

  Future<Either<Failure, EventEntity>> rsvpEvent({
    required int conversationId,
    required int eventId,
    required String status,
  });

  Future<Either<Failure, void>> deleteEvent({required int conversationId, required int eventId});
}
