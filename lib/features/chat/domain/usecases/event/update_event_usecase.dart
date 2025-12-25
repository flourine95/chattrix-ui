import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/event.dart';
import '../../repositories/event_repository.dart';

/// Use case for updating an event
class UpdateEventUseCase {
  final EventRepository _repository;

  UpdateEventUseCase(this._repository);

  Future<Either<Failure, Event>> call({
    required int conversationId,
    required int eventId,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
  }) async {
    // Validation
    if (title != null && title.trim().isEmpty) {
      return left(const Failure.validation(message: 'Event title cannot be empty', code: 'INVALID_TITLE'));
    }

    if (startTime != null && startTime.isBefore(DateTime.now())) {
      return left(
        const Failure.validation(message: 'Event start time must be in the future', code: 'INVALID_START_TIME'),
      );
    }

    if (startTime != null && endTime != null && endTime.isBefore(startTime)) {
      return left(
        const Failure.validation(message: 'Event end time must be after start time', code: 'INVALID_END_TIME'),
      );
    }

    return await _repository.updateEvent(
      conversationId: conversationId,
      eventId: eventId,
      title: title,
      description: description,
      startTime: startTime,
      endTime: endTime,
      location: location,
    );
  }
}
