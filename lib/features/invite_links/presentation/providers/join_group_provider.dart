import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'invite_links_providers.dart';

part 'join_group_provider.g.dart';

@riverpod
class JoinGroup extends _$JoinGroup {
  @override
  Future<JoinGroupResultEntity?> build() async {
    return null;
  }

  Future<void> join(String token) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(joinGroupViaLinkUseCaseProvider);

    final result = await useCase(token: token);

    if (ref.mounted) {
      state = result.fold((failure) {
        return AsyncValue.error(Exception(failure.userMessage), StackTrace.current);
      }, (result) => AsyncValue.data(result));
    }
  }

  void reset() {
    if (ref.mounted) {
      state = const AsyncValue.data(null);
    }
  }
}
