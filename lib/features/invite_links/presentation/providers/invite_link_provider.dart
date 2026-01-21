import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'invite_links_providers.dart';

part 'invite_link_provider.g.dart';

/// Provider for managing the current active invite link for a conversation
/// 
/// **API**: GET /v1/conversations/{conversationId}/invite-link
/// Returns null if no active link exists
@riverpod
class InviteLink extends _$InviteLink {
  @override
  Future<InviteLinkEntity?> build(int conversationId) async {
    return _loadLink(conversationId);
  }

  Future<InviteLinkEntity?> _loadLink(int conversationId) async {
    final useCase = ref.read(getInviteLinkUseCaseProvider);

    final result = await useCase(conversationId: conversationId);

    return result.fold(
      (failure) {
        // Don't throw for expected cases
        debugPrint('Failed to load invite link: ${failure.userMessage}');
        return null;
      },
      (link) => link,
    );
  }

  /// Refresh the invite link
  Future<void> refresh(int conversationId) async {
    ref.invalidateSelf();
  }

  /// Set the link after creating
  void setLink(InviteLinkEntity link) {
    if (ref.mounted) {
      state = AsyncValue.data(link);
    }
  }

  /// Clear the link after revoking
  void clearLink() {
    if (ref.mounted) {
      state = const AsyncValue.data(null);
    }
  }

  /// Update the link (e.g., after WebSocket event)
  void updateLink(InviteLinkEntity updatedLink) {
    if (ref.mounted) {
      state = AsyncValue.data(updatedLink);
    }
  }
}
