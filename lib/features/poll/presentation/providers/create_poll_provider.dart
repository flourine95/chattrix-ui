import 'package:chattrix_ui/features/poll/domain/entities/create_poll_params.dart';
import 'package:chattrix_ui/features/poll/domain/entities/poll_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'poll_providers.dart';

part 'create_poll_provider.g.dart';

@riverpod
class CreatePoll extends _$CreatePoll {
  @override
  FutureOr<PollEntity?> build() {
    return null;
  }

  Future<void> execute({required CreatePollParams params}) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(createPollUseCaseProvider);
    final result = await useCase(params: params);

    state = result.fold(
      (failure) => AsyncValue.error(_mapFailureToException(failure), StackTrace.current),
      (poll) => AsyncValue.data(poll),
    );
  }

  Exception _mapFailureToException(dynamic failure) {
    return Exception(failure.toString());
  }
}
