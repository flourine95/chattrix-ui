import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/invite_link_entity.dart';
import 'invite_links_providers.dart';

part 'create_invite_link_provider.g.dart';

/// Provider for creating invite link
@riverpod
class CreateInviteLink extends _$CreateInviteLink {
  @override
  Future<InviteLinkEntity?> build() async {
    return null;
  }

  /// Create invite link
  Future<void> create({required int conversationId, int? expiresIn, int? maxUses}) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(createInviteLinkUseCaseProvider);

    final result = await useCase(conversationId: conversationId, expiresIn: expiresIn, maxUses: maxUses);

    if (ref.mounted) {
      state = result.fold((failure) {
        final f = failure as Failure;
        debugPrint('Failed to create invite link: ${f.userMessage}');
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
