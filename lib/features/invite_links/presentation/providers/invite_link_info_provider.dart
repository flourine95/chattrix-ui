import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/invite_link_entity.dart';
import 'invite_links_providers.dart';

part 'invite_link_info_provider.g.dart';

/// Provider for getting public invite link info (no auth required)
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
      debugPrint('Failed to load invite link info: ${failure.userMessage}');
      throw Exception(failure.userMessage);
    }, (info) => info);
  }

  /// Refresh link info
  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
