import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:chattrix_ui/core/network/dio_client.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_websocket_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/conversation_members_provider.dart';
import 'package:chattrix_ui/features/poll/data/datasources/poll_api_service.dart';
import 'package:chattrix_ui/features/poll/data/models/poll_list_item_dto.dart';
import 'package:chattrix_ui/features/chat/data/datasources/poll_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/data/models/poll_model.dart';
import 'package:chattrix_ui/features/chat/data/repositories/poll_repository_impl.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/poll_datasource.dart';
import 'package:chattrix_ui/features/chat/domain/entities/poll.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/poll_repository.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/poll/close_poll_usecase.dart';

import '../../domain/usecases/poll/create_poll_usecase.dart';
import '../../domain/usecases/poll/delete_poll_usecase.dart';
import '../../domain/usecases/poll/get_all_polls_usecase.dart';
import '../../domain/usecases/poll/vote_poll_usecase.dart';

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

// Data Provider - Fetch polls with filters and pagination using new API
@riverpod
class PollsList extends _$PollsList {
  StreamSubscription<Map<String, dynamic>>? _pollEventSubscription;
  String? _nextCursor;
  bool _hasNextPage = false;

  @override
  Future<List<Poll>> build(int conversationId) async {
    debugPrint('🗳️ PollsList.build() called for conversationId: $conversationId');

    // Listen to WebSocket poll events
    _listenToPollEvents();

    // Fetch initial polls using new list API
    return _fetchPolls(status: 'all');
  }

  /// Fetch polls from new list API
  Future<List<Poll>> _fetchPolls({required String status, String? cursor}) async {
    debugPrint('🗳️ Fetching polls with status: $status, cursor: $cursor');

    final apiService = ref.watch(pollApiServiceProvider);

    try {
      final response = await apiService.listPolls(conversationId: conversationId, status: status, cursor: cursor);

      // Parse response: { items: [...], meta: { nextCursor, hasNextPage, itemsPerPage } }
      final items = response['items'] as List<dynamic>;
      final meta = response['meta'] as Map<String, dynamic>;

      _nextCursor = meta['nextCursor'] as String?;
      _hasNextPage = meta['hasNextPage'] as bool? ?? false;

      debugPrint('🗳️ Fetched ${items.length} polls, hasNextPage: $_hasNextPage');

      // Get members cache to enrich user info
      List<dynamic> members = [];
      try {
        final membersAsync = await ref.read(conversationMembersProvider(conversationId).future);
        members = membersAsync;
      } catch (e) {
        debugPrint('⚠️ Failed to load members cache: $e');
      }
      
      final membersMap = {for (var m in members) m.id: m};
      
      debugPrint('👥 Members cache: ${membersMap.length} members');
      debugPrint('👥 Member IDs: ${membersMap.keys.toList()}');

      // Parse polls using PollListItemDto
      final polls = items.map((item) {
        final itemMap = item as Map<String, dynamic>;
        var dto = PollListItemDto.fromJson(itemMap);
        
        debugPrint('🗳️ Poll creator ID: ${dto.createdBy}, username: ${dto.createdByUsername}');
        debugPrint('🗳️ Before enrich - fullName: ${dto.createdByFullName}, avatarUrl: ${dto.createdByAvatarUrl}');
        
        // Enrich with member info from cache if available
        final creatorId = dto.createdBy;
        final member = membersMap[creatorId];
        if (member != null) {
          debugPrint('✅ Found member in cache: ${member.fullName}, avatar: ${member.avatarUrl}');
          dto = dto.copyWith(
            createdByFullName: member.fullName,
            createdByAvatarUrl: member.avatarUrl,
          );
          debugPrint('✅ After enrich - fullName: ${dto.createdByFullName}, avatarUrl: ${dto.createdByAvatarUrl}');
        } else {
          debugPrint('⚠️ Creator $creatorId not found in members cache');
        }
        
        final pollModel = dto.toPollModel(conversationId);
        debugPrint('🗳️ PollModel creator: ${pollModel.creator.fullName}, avatar: ${pollModel.creator.avatarUrl}');
        
        return pollModel.toEntity();
      }).toList();

      debugPrint('🗳️ Successfully parsed ${polls.length} polls');
      return polls;
    } catch (e, stackTrace) {
      debugPrint('❌ Failed to fetch polls: $e');
      debugPrint('❌ Stack trace: $stackTrace');
      throw Exception('Failed to fetch polls: $e');
    }
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
    state = await AsyncValue.guard(() => _fetchPolls(status: 'all'));
  }

  /// Load more polls (pagination)
  Future<void> loadMore({required String status}) async {
    if (!_hasNextPage || _nextCursor == null) {
      debugPrint('🗳️ No more polls to load');
      return;
    }

    final currentState = state.value;
    if (currentState == null) return;

    try {
      final morePolls = await _fetchPolls(status: status, cursor: _nextCursor);
      state = AsyncValue.data([...currentState, ...morePolls]);
    } catch (e) {
      debugPrint('❌ Failed to load more polls: $e');
      // Keep current state on error
    }
  }

  /// Filter polls by status
  Future<void> filterByStatus(String status) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchPolls(status: status));
  }

  /// Check if more polls can be loaded
  bool get hasNextPage => _hasNextPage;
}

// Provider for PollApiService
@riverpod
PollApiService pollApiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return PollApiService(dio);
}
