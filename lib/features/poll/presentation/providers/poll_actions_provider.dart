import 'package:chattrix_ui/features/poll/domain/entities/poll_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'poll_providers.dart';

part 'poll_actions_provider.g.dart';

@riverpod
class PollActions extends _$PollActions {
  @override
  FutureOr<PollEntity?> build() {
    return null;
  }

  Future<PollEntity?> vote({required int conversationId, required int pollId, required List<int> optionIds}) async {
    if (!ref.mounted) return null;

    state = const AsyncValue.loading();

    final useCase = ref.read(votePollUseCaseProvider);
    final result = await useCase(conversationId: conversationId, pollId: pollId, optionIds: optionIds);

    return result.fold(
      (failure) {
        if (ref.mounted) {
          state = AsyncValue.error(Exception(failure.toString()), StackTrace.current);
        }
        return null;
      },
      (poll) {
        if (ref.mounted) {
          state = AsyncValue.data(poll);
        }
        return poll;
      },
    );
  }

  Future<PollEntity?> close({required int conversationId, required int pollId}) async {
    if (!ref.mounted) return null;

    state = const AsyncValue.loading();

    final useCase = ref.read(closePollUseCaseProvider);
    final result = await useCase(conversationId: conversationId, pollId: pollId);

    return result.fold(
      (failure) {
        if (ref.mounted) {
          state = AsyncValue.error(Exception(failure.toString()), StackTrace.current);
        }
        return null;
      },
      (poll) {
        if (ref.mounted) {
          state = AsyncValue.data(poll);
        }
        return poll;
      },
    );
  }

  Future<bool> delete({required int conversationId, required int pollId}) async {
    if (!ref.mounted) return false;

    state = const AsyncValue.loading();

    final useCase = ref.read(deletePollUseCaseProvider);
    final result = await useCase(conversationId: conversationId, pollId: pollId);

    return result.fold(
      (failure) {
        if (ref.mounted) {
          state = AsyncValue.error(Exception(failure.toString()), StackTrace.current);
        }
        return false;
      },
      (message) {
        if (ref.mounted) {
          state = const AsyncValue.data(null);
        }
        return true;
      },
    );
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
