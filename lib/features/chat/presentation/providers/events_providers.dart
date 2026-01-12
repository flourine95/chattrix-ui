import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/event_entity.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/events_repository.dart';
import 'package:chattrix_ui/features/chat/data/repositories/events_repository_impl.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_websocket_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:chattrix_ui/features/chat/data/models/event_dto.dart';
import 'package:chattrix_ui/features/chat/data/mappers/event_mapper.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

part 'events_providers.g.dart';

// ============================================================================
// REPOSITORY PROVIDER
// ============================================================================

@riverpod
EventsRepository eventsRepository(Ref ref) {
  final datasource = ref.watch(chatRemoteDatasourceProvider);
  return EventsRepositoryImpl(datasource);
}

// ============================================================================
// EVENTS LIST PROVIDER
// ============================================================================

@riverpod
class EventsList extends _$EventsList {
  StreamSubscription<Map<String, dynamic>>? _eventEventSubscription;

  @override
  Future<List<EventEntity>> build(String conversationId) async {
    debugPrint('📅 EventsList.build() called for conversationId: $conversationId');

    // Listen to WebSocket event events
    _listenToEventEvents();

    final repository = ref.watch(eventsRepositoryProvider);
    debugPrint('📅 Fetching events from API...');
    final result = await repository.getEvents(conversationId: conversationId);

    return result.fold(
      (failure) {
        debugPrint('❌ Failed to fetch events: ${failure.message}');
        throw Exception(failure.message);
      },
      (events) {
        debugPrint('✅ Successfully fetched ${events.length} events');
        return events;
      },
    );
  }

  void _listenToEventEvents() {
    final webSocketDataSource = ref.watch(chatWebSocketDataSourceProvider) as ChatWebSocketDataSourceImpl;

    _eventEventSubscription = webSocketDataSource.eventEventStream.listen((event) {
      try {
        final eventType = event['type'] as String?;
        final eventData = event['event'] as Map<String, dynamic>?;

        if (eventData == null) return;

        final eventEntity = EventDto.fromJson(eventData).toEntity();

        // Only update if this event belongs to our conversation
        if (eventEntity.conversationId.toString() != conversationId) return;

        final currentState = state.value;
        if (currentState == null) return;

        switch (eventType) {
          case 'EVENT_CREATED':
            // Add new event to the list
            state = AsyncValue.data([eventEntity, ...currentState]);
            debugPrint('📅 Event created: ${eventEntity.title}');
            break;

          case 'EVENT_UPDATED':
          case 'EVENT_RSVP_UPDATED':
            // Update existing event
            final updatedEvents = currentState.map((e) => e.id == eventEntity.id ? eventEntity : e).toList();
            state = AsyncValue.data(updatedEvents);
            debugPrint('📅 Event updated: ${eventEntity.title}');
            break;

          case 'EVENT_DELETED':
            // Remove event from list
            final filteredEvents = currentState.where((e) => e.id != eventEntity.id).toList();
            state = AsyncValue.data(filteredEvents);
            debugPrint('📅 Event deleted: ${eventEntity.title}');
            break;
        }
      } catch (e) {
        // Log error but don't break the stream
        debugPrint('Error handling event event: $e');
      }
    });

    // Cancel subscription when provider is disposed
    ref.onDispose(() {
      _eventEventSubscription?.cancel();
    });
  }

  /// Refresh events list
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build(conversationId));
  }

  /// Create a new event
  Future<void> createEvent({
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  }) async {
    final repository = ref.read(eventsRepositoryProvider);

    final result = await repository.createEvent(
      conversationId: conversationId,
      title: title,
      description: description,
      startTime: startTime,
      endTime: endTime,
      location: location,
    );

    result.fold((failure) => throw Exception(failure.message), (event) {
      // Don't add to list here - WebSocket will handle it
      // This prevents duplicate events
      debugPrint('✅ Event created successfully: ${event.title}');
    });
  }

  /// Update an event
  Future<void> updateEvent({
    required int eventId,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
  }) async {
    final repository = ref.read(eventsRepositoryProvider);

    final result = await repository.updateEvent(
      conversationId: conversationId,
      eventId: eventId,
      title: title,
      description: description,
      startTime: startTime,
      endTime: endTime,
      location: location,
    );

    result.fold((failure) => throw Exception(failure.message), (updatedEvent) {
      // Don't update list here - WebSocket will handle it
      debugPrint('✅ Event updated successfully: ${updatedEvent.title}');
    });
  }

  /// RSVP to an event
  Future<void> rsvpEvent({required int eventId, required String status}) async {
    final repository = ref.read(eventsRepositoryProvider);

    final result = await repository.rsvpEvent(conversationId: conversationId, eventId: eventId, status: status);

    result.fold((failure) => throw Exception(failure.message), (updatedEvent) {
      // Don't update list here - WebSocket will handle it
      debugPrint('✅ RSVP updated successfully for event: ${updatedEvent.title}');
    });
  }

  /// Delete an event
  Future<void> deleteEvent(int eventId) async {
    final repository = ref.read(eventsRepositoryProvider);

    final result = await repository.deleteEvent(conversationId: conversationId, eventId: eventId);

    result.fold((failure) => throw Exception(failure.message), (_) {
      // Don't remove from list here - WebSocket will handle it
      debugPrint('✅ Event deleted successfully');
    });
  }
}
