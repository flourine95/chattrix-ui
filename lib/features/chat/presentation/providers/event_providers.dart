import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../features/auth/presentation/providers/auth_repository_provider.dart';
import '../../data/datasources/event_datasource_impl.dart';
import '../../data/repositories/event_repository_impl.dart';
import '../../domain/datasources/event_datasource.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../../domain/usecases/event/create_event_usecase.dart';
import '../../domain/usecases/event/update_event_usecase.dart';
import '../../domain/usecases/event/rsvp_event_usecase.dart';
import '../../domain/usecases/event/delete_event_usecase.dart';
import '../../domain/usecases/event/get_all_events_usecase.dart';

part 'event_providers.g.dart';

// Datasource Provider
@riverpod
EventDatasource eventDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return EventDatasourceImpl(dio: dio);
}

// Repository Provider
@riverpod
EventRepository eventRepository(Ref ref) {
  final datasource = ref.watch(eventDatasourceProvider);
  return EventRepositoryImpl(datasource);
}

// Use Case Providers
@riverpod
CreateEventUseCase createEventUseCase(Ref ref) {
  final repository = ref.watch(eventRepositoryProvider);
  return CreateEventUseCase(repository);
}

@riverpod
UpdateEventUseCase updateEventUseCase(Ref ref) {
  final repository = ref.watch(eventRepositoryProvider);
  return UpdateEventUseCase(repository);
}

@riverpod
RsvpEventUseCase rsvpEventUseCase(Ref ref) {
  final repository = ref.watch(eventRepositoryProvider);
  return RsvpEventUseCase(repository);
}

@riverpod
DeleteEventUseCase deleteEventUseCase(Ref ref) {
  final repository = ref.watch(eventRepositoryProvider);
  return DeleteEventUseCase(repository);
}

@riverpod
GetAllEventsUseCase getAllEventsUseCase(Ref ref) {
  final repository = ref.watch(eventRepositoryProvider);
  return GetAllEventsUseCase(repository);
}

// Data Provider - Fetch all events for a conversation
@riverpod
Future<List<Event>> allEvents(Ref ref, int conversationId) async {
  final useCase = ref.watch(getAllEventsUseCaseProvider);
  final result = await useCase(conversationId: conversationId);

  return result.fold((failure) => throw Exception(failure.message), (events) => events);
}
