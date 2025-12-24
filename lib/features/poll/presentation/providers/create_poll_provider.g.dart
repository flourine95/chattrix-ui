// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'create_poll_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for creating a poll
///
/// State: AsyncValue<PollEntity>

@ProviderFor(CreatePoll)
const createPollProvider = CreatePollProvider._();

/// Provider for creating a poll
///
/// State: AsyncValue<PollEntity>
final class CreatePollProvider
    extends $AsyncNotifierProvider<CreatePoll, PollEntity?> {
  /// Provider for creating a poll
  ///
  /// State: AsyncValue<PollEntity>
  const CreatePollProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createPollProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createPollHash();

  @$internal
  @override
  CreatePoll create() => CreatePoll();
}

String _$createPollHash() => r'a6a1729d8c5abda7a3d2e29981693c88cd70721c';

/// Provider for creating a poll
///
/// State: AsyncValue<PollEntity>

abstract class _$CreatePoll extends $AsyncNotifier<PollEntity?> {
  FutureOr<PollEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<PollEntity?>, PollEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PollEntity?>, PollEntity?>,
              AsyncValue<PollEntity?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
