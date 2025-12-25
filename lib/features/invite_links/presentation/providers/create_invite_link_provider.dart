import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'invite_links_providers.dart';

part 'create_invite_link_provider.g.dart';

@riverpod
class CreateInviteLink extends _$CreateInviteLink {
  @override
  Future<InviteLinkEntity?> build() async {
    return null;
  }

  Future<void> create({required int conversationId, int? expiresIn, int? maxUses}) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(createInviteLinkUseCaseProvider);

    final result = await useCase(conversationId: conversationId, expiresIn: expiresIn, maxUses: maxUses);

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
