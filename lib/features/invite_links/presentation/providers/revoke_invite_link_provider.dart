import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'invite_links_providers.dart';

part 'revoke_invite_link_provider.g.dart';

@riverpod
class RevokeInviteLink extends _$RevokeInviteLink {
  @override
  Future<InviteLinkEntity?> build() async {
    return null;
  }

  Future<void> revoke({required int conversationId, required int linkId}) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(revokeInviteLinkUseCaseProvider);

    final result = await useCase(conversationId: conversationId, linkId: linkId);

    if (ref.mounted) {
      state = result.fold((failure) {
        final f = failure;
        return AsyncValue.error(Exception(f.userMessage), StackTrace.current);
      }, (link) => AsyncValue.data(link));
    }
  }

  void reset() {
    if (ref.mounted) {
      state = const AsyncValue.data(null);
    }
  }
}
