import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/invite_link_entity.dart';
import 'invite_links_providers.dart';

part 'revoke_invite_link_provider.g.dart';

/// Provider for revoking invite link
@riverpod
class RevokeInviteLink extends _$RevokeInviteLink {
  @override
  Future<InviteLinkEntity?> build() async {
    return null;
  }

  /// Revoke invite link
  Future<void> revoke({required int conversationId, required int linkId}) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(revokeInviteLinkUseCaseProvider);

    final result = await useCase(conversationId: conversationId, linkId: linkId);

    if (ref.mounted) {
      state = result.fold((failure) {
        final f = failure as Failure;
        debugPrint('Failed to revoke invite link: ${f.userMessage}');
        return AsyncValue.error(Exception(f.userMessage), StackTrace.current);
      }, (link) => AsyncValue.data(link));
    }
  }

  /// Reset state
  void reset() {
    if (ref.mounted) {
      state = const AsyncValue.data(null);
    }
  }
}
