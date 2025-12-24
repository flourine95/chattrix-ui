import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/invite_link_entity.dart';
import 'invite_links_providers.dart';

part 'join_group_provider.g.dart';

/// Provider for joining group via invite link
@riverpod
class JoinGroup extends _$JoinGroup {
  @override
  Future<JoinGroupResultEntity?> build() async {
    return null;
  }

  /// Join group via invite link
  Future<void> join(String token) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(joinGroupViaLinkUseCaseProvider);

    final result = await useCase(token: token);

    if (ref.mounted) {
      state = result.fold((failure) {
        debugPrint('Failed to join group: ${failure.userMessage}');
        return AsyncValue.error(Exception(failure.userMessage), StackTrace.current);
      }, (result) => AsyncValue.data(result));
    }
  }

  /// Reset state
  void reset() {
    if (ref.mounted) {
      state = const AsyncValue.data(null);
    }
  }
}
