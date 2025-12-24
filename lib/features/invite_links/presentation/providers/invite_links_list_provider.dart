import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/invite_link_entity.dart';
import 'invite_links_providers.dart';

part 'invite_links_list_provider.g.dart';

/// Provider for managing invite links list with pagination
@riverpod
class InviteLinksList extends _$InviteLinksList {
  List<InviteLinkEntity> _allLinks = [];
  String? _nextCursor;
  bool _hasNextPage = false;
  bool _includeRevoked = false;

  @override
  Future<List<InviteLinkEntity>> build(int conversationId) async {
    return _loadLinks(conversationId);
  }

  /// Load initial links
  Future<List<InviteLinkEntity>> _loadLinks(int conversationId) async {
    final useCase = ref.read(getInviteLinksUseCaseProvider);

    final result = await useCase(conversationId: conversationId, limit: 20, includeRevoked: _includeRevoked);

    return result.fold(
      (failure) {
        final f = failure as Failure;
        debugPrint('Failed to load invite links: ${f.userMessage}');
        throw Exception(f.userMessage);
      },
      (data) {
        _allLinks = data.items;
        _nextCursor = data.nextCursor;
        _hasNextPage = data.hasNextPage;
        return _allLinks;
      },
    );
  }

  /// Load more links (pagination)
  Future<void> loadMore(int conversationId) async {
    if (!_hasNextPage || state.isLoading) return;

    final useCase = ref.read(getInviteLinksUseCaseProvider);

    final result = await useCase(
      conversationId: conversationId,
      cursor: _nextCursor,
      limit: 20,
      includeRevoked: _includeRevoked,
    );

    result.fold(
      (failure) {
        final f = failure as Failure;
        debugPrint('Failed to load more invite links: ${f.userMessage}');
      },
      (data) {
        if (ref.mounted) {
          _allLinks.addAll(data.items);
          _nextCursor = data.nextCursor;
          _hasNextPage = data.hasNextPage;
          state = AsyncValue.data(_allLinks);
        }
      },
    );
  }

  /// Toggle include revoked links
  Future<void> toggleIncludeRevoked(int conversationId) async {
    _includeRevoked = !_includeRevoked;
    _allLinks = [];
    _nextCursor = null;
    _hasNextPage = false;
    ref.invalidateSelf();
  }

  /// Refresh the list
  Future<void> refresh(int conversationId) async {
    _allLinks = [];
    _nextCursor = null;
    _hasNextPage = false;
    ref.invalidateSelf();
  }

  /// Add new link to the list
  void addLink(InviteLinkEntity link) {
    if (ref.mounted) {
      _allLinks.insert(0, link);
      state = AsyncValue.data(_allLinks);
    }
  }

  /// Update link in the list
  void updateLink(InviteLinkEntity updatedLink) {
    if (ref.mounted) {
      final index = _allLinks.indexWhere((link) => link.id == updatedLink.id);
      if (index != -1) {
        _allLinks[index] = updatedLink;
        state = AsyncValue.data(_allLinks);
      }
    }
  }

  /// Check if has more pages
  bool get hasNextPage => _hasNextPage;

  /// Check if include revoked
  bool get includeRevoked => _includeRevoked;
}
