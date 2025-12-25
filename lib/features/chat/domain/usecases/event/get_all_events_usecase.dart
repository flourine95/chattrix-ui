import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/event.dart';
import '../../repositories/event_repository.dart';

/// Use case for getting all events in a conversation
class GetAllEventsUseCase {
  final EventRepository _repository;

  GetAllEventsUseCase(this._repository);

  Future<Either<Failure, List<Event>>> call({required int conversationId}) async {
    return await _repository.getAllEvents(conversationId: conversationId);
  }
}
