import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'invite_links_providers.dart';

part 'invite_link_info_provider.g.dart';

@riverpod
class InviteLinkInfo extends _$InviteLinkInfo {
  @override
  Future<InviteLinkInfoEntity?> build(String token) async {
    return _loadLinkInfo(token);
  }

  Future<InviteLinkInfoEntity?> _loadLinkInfo(String token) async {
    final useCase = ref.read(getInviteLinkInfoUseCaseProvider);

    final result = await useCase(token: token);

    return result.fold((failure) {
      throw Exception(failure.userMessage);
    }, (info) => info);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
