import 'dart:async';

import 'package:chattrix_ui/core/domain/enums/profile_visibility.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_websocket_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/data/models/event_dto.dart';
import 'package:chattrix_ui/features/chat/data/models/event_list_item_dto.dart';
import 'package:chattrix_ui/features/chat/data/repositories/events_repository_impl.dart';
import 'package:chattrix_ui/features/chat/domain/entities/event_entity.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/events_repository.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/conversation_members_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  String? _nextCursor;
  bool _hasNextPage = false;

  @override
  Future<List<EventEntity>> build(int conversationId) async {
    // Listen to WebSocket event events
    _listenToEventEvents();

    // Fetch initial events using new list API
    return _fetchEvents(status: 'all');
  }

  /// Fetch events from new list API
  Future<List<EventEntity>> _fetchEvents({required String status, String? cursor}) async {
    // Use the implementation provider to access listEvents method
    final datasource = ref.watch(chatRemoteDatasourceImplProvider);

    try {
      // Call listEvents on the implementation
      final response = await datasource.listEvents(conversationId: conversationId, status: status, cursor: cursor);

      // Check if provider is still mounted after async operation
      if (!ref.mounted) {
        return [];
      }

      // Parse response: { items: [...], meta: { nextCursor, hasNextPage, itemsPerPage } }
      final items = response['items'] as List<dynamic>;
      final meta = response['meta'] as Map<String, dynamic>;

      _nextCursor = meta['nextCursor'] as String?;
      _hasNextPage = meta['hasNextPage'] as bool? ?? false;

      // Get conversation members for user info enrichment
      final membersAsync = await ref.read(conversationMembersProvider(conversationId).future);

      // Check again after async operation
      if (!ref.mounted) {
        return [];
      }

      final membersMap = {for (var m in membersAsync) m.id: m};

      // Parse events from list items
      final events = <EventEntity>[];
      for (var item in items) {
        try {
          final eventDto = EventListItemDto.fromJson(item as Map<String, dynamic>);

          // Get SearchUser from cache and convert to User (only use available fields)
          final searchUser = membersMap[eventDto.createdBy];
          final creator = searchUser != null
              ? User(
                  id: searchUser.id,
                  username: searchUser.username,
                  email: searchUser.email,
                  emailVerified: false,
                  fullName: searchUser.fullName,
                  avatarUrl: searchUser.avatarUrl,
                  bio: null,
                  gender: null,
                  dateOfBirth: null,
                  location: null,
                  profileVisibility: ProfileVisibility.public,
                  lastSeen: searchUser.lastSeen,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                )
              : null;

          // Convert to entity with creator from cache
          final enrichedEvent = eventDto.toEntity(creatorFromCache: creator);

          // Set conversationId
          events.add(enrichedEvent.copyWith(conversationId: conversationId));
        } catch (e) {
          // Ignore parse errors
        }
      }

      return events;
    } catch (e) {
      throw Exception('Failed to fetch events: $e');
    }
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
        if (eventEntity.conversationId != conversationId) return;

        final currentState = state.value;
        if (currentState == null) return;

        switch (eventType) {
          case 'EVENT_CREATED':
            // Add new event to the list
            state = AsyncValue.data([eventEntity, ...currentState]);
            break;

          case 'EVENT_UPDATED':
          case 'EVENT_RSVP_UPDATED':
            // Update existing event
            final updatedEvents = currentState.map((e) => e.id == eventEntity.id ? eventEntity : e).toList();
            state = AsyncValue.data(updatedEvents);
            break;

          case 'EVENT_DELETED':
            // Remove event from list
            final filteredEvents = currentState.where((e) => e.id != eventEntity.id).toList();
            state = AsyncValue.data(filteredEvents);
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
    state = await AsyncValue.guard(() => _fetchEvents(status: 'all'));
  }

  /// Load more events (pagination)
  Future<void> loadMore({required String status}) async {
    if (!_hasNextPage || _nextCursor == null) {
      return;
    }

    final currentState = state.value;
    if (currentState == null) return;

    try {
      final moreEvents = await _fetchEvents(status: status, cursor: _nextCursor);
      state = AsyncValue.data([...currentState, ...moreEvents]);
    } catch (e) {
      // Keep current state on error
    }
  }

  /// Filter events by status
  Future<void> filterByStatus(String status) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchEvents(status: status));
  }

  /// Check if more events can be loaded
  bool get hasNextPage => _hasNextPage;

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
    });
  }

  /// RSVP to an event
  Future<void> rsvpEvent({required int eventId, required String status}) async {
    final repository = ref.read(eventsRepositoryProvider);

    final result = await repository.rsvpEvent(conversationId: conversationId, eventId: eventId, status: status);

    result.fold((failure) => throw Exception(failure.message), (updatedEvent) {
      // Don't update list here - WebSocket will handle it
    });
  }

  /// Delete an event
  Future<void> deleteEvent(int eventId) async {
    final repository = ref.read(eventsRepositoryProvider);

    final result = await repository.deleteEvent(conversationId: conversationId, eventId: eventId);

    result.fold((failure) => throw Exception(failure.message), (_) {
      // Don't remove from list here - WebSocket will handle it
    });
  }
}
