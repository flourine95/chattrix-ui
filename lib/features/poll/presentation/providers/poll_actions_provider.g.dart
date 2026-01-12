// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'poll_actions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PollActions)
const pollActionsProvider = PollActionsProvider._();

final class PollActionsProvider
    extends $AsyncNotifierProvider<PollActions, PollEntity?> {
  const PollActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pollActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pollActionsHash();

  @$internal
  @override
  PollActions create() => PollActions();
}

String _$pollActionsHash() => r'aeeadc0764ab79f3d244f023c41555f80282a187';

abstract class _$PollActions extends $AsyncNotifier<PollEntity?> {
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
