import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/poll_entity.dart';
import 'poll_providers.dart';

part 'poll_detail_provider.g.dart';

/// Provider for poll details
///
/// State: AsyncValue<PollEntity>
@riverpod
class PollDetail extends _$PollDetail {
  @override
  Future<PollEntity> build(int pollId) async {
    return _loadPoll(pollId);
  }

  /// Load poll details
  Future<PollEntity> _loadPoll(int pollId) async {
    final useCase = ref.read(getPollUseCaseProvider);
    final result = await useCase(pollId: pollId);

    return result.fold((failure) => throw Exception(failure.toString()), (poll) => poll);
  }

  /// Refresh poll data
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadPoll(pollId));
  }

  /// Update poll data (called from WebSocket events)
  void updatePoll(PollEntity updatedPoll) {
    if (updatedPoll.id == pollId) {
      state = AsyncValue.data(updatedPoll);
    }
  }
}
