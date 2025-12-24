import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/poll_entity.dart';
import 'poll_providers.dart';

part 'poll_actions_provider.g.dart';

/// Provider for poll actions (vote, close, delete)
///
/// Handles voting, closing, and deleting polls
@riverpod
class PollActions extends _$PollActions {
  @override
  FutureOr<PollEntity?> build() {
    return null;
  }

  /// Vote on a poll
  Future<PollEntity?> vote({required int pollId, required List<int> optionIds}) async {
    // Check if ref is still mounted before setting state
    if (!ref.mounted) return null;

    state = const AsyncValue.loading();

    final useCase = ref.read(votePollUseCaseProvider);
    final result = await useCase(pollId: pollId, optionIds: optionIds);

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

  /// Close a poll (creator only)
  Future<PollEntity?> close({required int pollId}) async {
    if (!ref.mounted) return null;

    state = const AsyncValue.loading();

    final useCase = ref.read(closePollUseCaseProvider);
    final result = await useCase(pollId: pollId);

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

  /// Delete a poll (creator only)
  Future<bool> delete({required int pollId}) async {
    if (!ref.mounted) return false;

    state = const AsyncValue.loading();

    final useCase = ref.read(deletePollUseCaseProvider);
    final result = await useCase(pollId: pollId);

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

  /// Reset state
  void reset() {
    state = const AsyncValue.data(null);
  }
}
