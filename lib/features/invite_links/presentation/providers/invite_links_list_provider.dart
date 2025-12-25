import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'invite_links_providers.dart';

part 'invite_links_list_provider.g.dart';

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

  Future<List<InviteLinkEntity>> _loadLinks(int conversationId) async {
    final useCase = ref.read(getInviteLinksUseCaseProvider);

    final result = await useCase(conversationId: conversationId, limit: 20, includeRevoked: _includeRevoked);

    return result.fold(
      (failure) {
        final f = failure;
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
        final f = failure;
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

  Future<void> toggleIncludeRevoked(int conversationId) async {
    _includeRevoked = !_includeRevoked;
    _allLinks = [];
    _nextCursor = null;
    _hasNextPage = false;
    ref.invalidateSelf();
  }

  Future<void> refresh(int conversationId) async {
    _allLinks = [];
    _nextCursor = null;
    _hasNextPage = false;
    ref.invalidateSelf();
  }

  void addLink(InviteLinkEntity link) {
    if (ref.mounted) {
      _allLinks.insert(0, link);
      state = AsyncValue.data(_allLinks);
    }
  }

  void updateLink(InviteLinkEntity updatedLink) {
    if (ref.mounted) {
      final index = _allLinks.indexWhere((link) => link.id == updatedLink.id);
      if (index != -1) {
        _allLinks[index] = updatedLink;
        state = AsyncValue.data(_allLinks);
      }
    }
  }

  bool get hasNextPage => _hasNextPage;

  bool get includeRevoked => _includeRevoked;
}
