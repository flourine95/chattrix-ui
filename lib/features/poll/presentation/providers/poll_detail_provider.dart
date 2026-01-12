import 'package:chattrix_ui/features/poll/domain/entities/poll_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'poll_providers.dart';

part 'poll_detail_provider.g.dart';

@riverpod
class PollDetail extends _$PollDetail {
  @override
  Future<PollEntity> build(int conversationId, int pollId) async {
    return _loadPoll(conversationId, pollId);
  }

  Future<PollEntity> _loadPoll(int conversationId, int pollId) async {
    final useCase = ref.read(getPollUseCaseProvider);
    final result = await useCase(conversationId: conversationId, pollId: pollId);

    return result.fold((failure) => throw Exception(failure.toString()), (poll) => poll);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadPoll(conversationId, pollId));
  }

  void updatePoll(PollEntity updatedPoll) {
    if (updatedPoll.id == pollId) {
      state = AsyncValue.data(updatedPoll);
    }
  }
}
