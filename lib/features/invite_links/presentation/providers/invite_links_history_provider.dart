import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/presentation/providers/invite_links_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invite_links_history_provider.g.dart';

/// Provider for invite links history with cursor-based pagination
@riverpod
class InviteLinksHistory extends _$InviteLinksHistory {
  String? _nextCursor;
  String? _currentStatusFilter;
  static const int _pageSize = 20;

  @override
  Future<InviteLinksHistoryEntity> build(int conversationId) async {
    debugPrint('🔵 [InviteLinksHistory] Building for conversation $conversationId');
    return _loadPage(null, null);
  }

  Future<InviteLinksHistoryEntity> _loadPage(String? cursor, String? status) async {
    debugPrint('🔵 [InviteLinksHistory] Loading page with cursor: $cursor, status: $status');
    final repository = ref.read(inviteLinksRepositoryProvider);
    final result = await repository.getInviteLinksHistory(
      conversationId: conversationId,
      cursor: cursor,
      limit: _pageSize,
      status: status,
    );

    return result.fold(
      (failure) {
        debugPrint('🔴 [InviteLinksHistory] Error: ${failure.message}');
        throw _mapFailureToException(failure);
      },
      (history) {
        debugPrint('🟢 [InviteLinksHistory] Loaded ${history.items.length} items, hasNextPage: ${history.meta.hasNextPage}');
        _nextCursor = history.meta.nextCursor;
        return history;
      },
    );
  }

  /// Load more links (next page using cursor)
  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null || !currentState.meta.hasNextPage || state.isLoading || _nextCursor == null) {
      return;
    }

    state = const AsyncValue.loading();

    try {
      final newHistory = await _loadPage(_nextCursor, _currentStatusFilter);

      // Merge with existing data
      final mergedItems = [
        ...currentState.items,
        ...newHistory.items,
      ];

      state = AsyncValue.data(
        InviteLinksHistoryEntity(
          items: mergedItems,
          meta: newHistory.meta,
        ),
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Filter by status
  Future<void> filterByStatus(String? status) async {
    _currentStatusFilter = status;
    _nextCursor = null;
    state = const AsyncValue.loading();

    try {
      final history = await _loadPage(null, status);
      state = AsyncValue.data(history);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Refresh the list (reload from beginning)
  Future<void> refresh() async {
    _nextCursor = null;
    ref.invalidateSelf();
  }

  /// Add a new link to the top of the list (after creation)
  void addLink(InviteLinkHistoryItemEntity link) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(
      InviteLinksHistoryEntity(
        items: [link, ...currentState.items],
        meta: currentState.meta,
      ),
    );
  }

  /// Update a link in the list (after revoke)
  void updateLink(InviteLinkHistoryItemEntity updatedLink) {
    final currentState = state.value;
    if (currentState == null) return;

    final updatedItems = currentState.items.map((link) {
      if (link.token == updatedLink.token) {
        return updatedLink;
      }
      return link;
    }).toList();

    state = AsyncValue.data(
      InviteLinksHistoryEntity(
        items: updatedItems,
        meta: currentState.meta,
      ),
    );
  }

  Exception _mapFailureToException(Failure failure) {
    if (failure is ValidationFailure) {
      return ValidationException(failure.message, failure.details);
    } else if (failure is AuthFailure) {
      return AuthException(failure.message);
    } else if (failure is NotFoundFailure) {
      return NotFoundException(failure.message);
    } else if (failure is NetworkFailure) {
      return NetworkException(failure.message);
    } else {
      return ServerException(failure.message);
    }
  }
}

/// Custom exceptions for UI
class ValidationException implements Exception {
  final String message;
  final Map<String, String>? details;
  ValidationException(this.message, [this.details]);
  
  @override
  String toString() => message;
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  
  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
  
  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
  
  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  
  @override
  String toString() => message;
}
