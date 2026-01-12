import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/event.dart';
import '../../repositories/event_repository.dart';

/// Use case for creating an event
class CreateEventUseCase {
  final EventRepository _repository;

  CreateEventUseCase(this._repository);

  Future<Either<Failure, Event>> call({
    required int conversationId,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  }) async {
    // Validation
    if (title.trim().isEmpty) {
      return left(const Failure.validation(message: 'Event title cannot be empty', code: 'INVALID_TITLE'));
    }

    if (startTime.isBefore(DateTime.now())) {
      return left(
        const Failure.validation(message: 'Event start time must be in the future', code: 'INVALID_START_TIME'),
      );
    }

    if (endTime.isBefore(startTime)) {
      return left(
        const Failure.validation(message: 'Event end time must be after start time', code: 'INVALID_END_TIME'),
      );
    }

    return await _repository.createEvent(
      conversationId: conversationId,
      title: title,
      description: description,
      startTime: startTime,
      endTime: endTime,
      location: location,
    );
  }
}
