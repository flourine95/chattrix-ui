import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../repositories/event_repository.dart';

/// Use case for deleting an event
class DeleteEventUseCase {
  final EventRepository _repository;

  DeleteEventUseCase(this._repository);

  Future<Either<Failure, void>> call({required int conversationId, required int eventId}) async {
    return await _repository.deleteEvent(conversationId: conversationId, eventId: eventId);
  }
}
