import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';
import '../../../../features/auth/presentation/providers/auth_repository_provider.dart';
import '../../data/datasources/poll_datasource_impl.dart';
import '../../data/repositories/poll_repository_impl.dart';
import '../../data/models/poll_model.dart';
import '../../data/mappers/poll_mapper.dart';
import '../../domain/datasources/poll_datasource.dart';
import '../../domain/entities/poll.dart';
import '../../domain/repositories/poll_repository.dart';
import '../../domain/usecases/poll/create_poll_usecase.dart';
import '../../domain/usecases/poll/vote_poll_usecase.dart';
import '../../domain/usecases/poll/close_poll_usecase.dart';
import '../../domain/usecases/poll/delete_poll_usecase.dart';
import '../../domain/usecases/poll/get_all_polls_usecase.dart';
import '../../../chat/data/datasources/chat_websocket_datasource_impl.dart';
import '../../../chat/presentation/providers/chat_websocket_provider_new.dart';
import 'dart:async';

part 'poll_providers.g.dart';

// Datasource Provider
@riverpod
PollDatasource pollDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return PollDatasourceImpl(dio: dio);
}

// Repository Provider
@riverpod
PollRepository pollRepository(Ref ref) {
  final datasource = ref.watch(pollDatasourceProvider);
  return PollRepositoryImpl(datasource);
}

// Use Case Providers
@riverpod
CreatePollUseCase createPollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return CreatePollUseCase(repository);
}

@riverpod
VotePollUseCase votePollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return VotePollUseCase(repository);
}

@riverpod
ClosePollUseCase closePollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return ClosePollUseCase(repository);
}

@riverpod
DeletePollUseCase deletePollUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return DeletePollUseCase(repository);
}

@riverpod
GetAllPollsUseCase getAllPollsUseCase(Ref ref) {
  final repository = ref.watch(pollRepositoryProvider);
  return GetAllPollsUseCase(repository);
}

// Data Provider - Fetch all polls for a conversation with WebSocket updates
@riverpod
class PollsList extends _$PollsList {
  StreamSubscription<Map<String, dynamic>>? _pollEventSubscription;

  @override
  Future<List<Poll>> build(int conversationId) async {
    debugPrint('🗳️ PollsList.build() called for conversationId: $conversationId');

    // Listen to WebSocket poll events
    _listenToPollEvents();

    // Fetch initial polls
    final useCase = ref.watch(getAllPollsUseCaseProvider);
    debugPrint('🗳️ Fetching polls from API...');
    final result = await useCase(conversationId: conversationId);

    return result.fold(
      (failure) {
        debugPrint('❌ Failed to fetch polls: ${failure.message}');
        throw Exception(failure.message);
      },
      (polls) {
        debugPrint('✅ Successfully fetched ${polls.length} polls');
        return polls;
      },
    );
  }

  void _listenToPollEvents() {
    final webSocketDataSource = ref.watch(chatWebSocketDataSourceProvider) as ChatWebSocketDataSourceImpl;

    _pollEventSubscription = webSocketDataSource.pollEventStream.listen((event) {
      try {
        final eventType = event['type'] as String?;
        final pollData = event['poll'] as Map<String, dynamic>?;

        if (pollData == null) return;

        final poll = PollModel.fromJson(pollData).toEntity();

        // Only update if this poll belongs to our conversation
        if (poll.conversationId != conversationId) return;

        final currentState = state.value;
        if (currentState == null) return;

        switch (eventType) {
          case 'POLL_CREATED':
            // Add new poll to the list
            state = AsyncValue.data([poll, ...currentState]);
            break;

          case 'POLL_VOTED':
          case 'POLL_CLOSED':
            // Update existing poll
            final updatedPolls = currentState.map((p) => p.id == poll.id ? poll : p).toList();
            state = AsyncValue.data(updatedPolls);
            break;

          case 'POLL_DELETED':
            // Remove poll from list
            final filteredPolls = currentState.where((p) => p.id != poll.id).toList();
            state = AsyncValue.data(filteredPolls);
            break;
        }
      } catch (e) {
        // Log error but don't break the stream
        debugPrint('Error handling poll event: $e');
      }
    });

    // Cancel subscription when provider is disposed
    ref.onDispose(() {
      _pollEventSubscription?.cancel();
    });
  }

  /// Manually refresh polls
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getAllPollsUseCaseProvider);
      final result = await useCase(conversationId: conversationId);
      return result.fold((failure) => throw Exception(failure.message), (polls) => polls);
    });
  }
}
