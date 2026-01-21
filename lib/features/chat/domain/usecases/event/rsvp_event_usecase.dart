import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/event.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/event_repository.dart';

class RsvpEventUseCase {
  final EventRepository _repository;

  RsvpEventUseCase(this._repository);

  Future<Either<Failure, Event>> call({
    required int conversationId,
    required int eventId,
    required String response,
  }) async {
    // Validation
    const validResponses = ['GOING', 'NOT_GOING', 'MAYBE'];
    if (!validResponses.contains(response.toUpperCase())) {
      return left(
        Failure.validation(
          message: 'Invalid RSVP response. Must be one of: ${validResponses.join(", ")}',
          code: 'INVALID_RESPONSE',
        ),
      );
    }

    return await _repository.rsvpEvent(conversationId: conversationId, eventId: eventId, status: response);
  }
}
