import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/poll_entity.dart';
import '../../domain/entities/create_poll_params.dart';
import 'poll_providers.dart';

part 'create_poll_provider.g.dart';

/// Provider for creating a poll
///
/// State: AsyncValue<PollEntity>
@riverpod
class CreatePoll extends _$CreatePoll {
  @override
  FutureOr<PollEntity?> build() {
    return null;
  }

  /// Create a new poll
  Future<void> execute({required CreatePollParams params}) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(createPollUseCaseProvider);
    final result = await useCase(params: params);

    state = result.fold(
      (failure) => AsyncValue.error(_mapFailureToException(failure), StackTrace.current),
      (poll) => AsyncValue.data(poll),
    );
  }

  /// Map Failure to Exception for AsyncValue
  Exception _mapFailureToException(dynamic failure) {
    return Exception(failure.toString());
  }
}
