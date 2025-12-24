// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'poll_actions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for poll actions (vote, close, delete)
///
/// Handles voting, closing, and deleting polls

@ProviderFor(PollActions)
const pollActionsProvider = PollActionsProvider._();

/// Provider for poll actions (vote, close, delete)
///
/// Handles voting, closing, and deleting polls
final class PollActionsProvider
    extends $AsyncNotifierProvider<PollActions, PollEntity?> {
  /// Provider for poll actions (vote, close, delete)
  ///
  /// Handles voting, closing, and deleting polls
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

String _$pollActionsHash() => r'def26f7b52b62ee8de99b2ff5bce1ced2121c5b1';

/// Provider for poll actions (vote, close, delete)
///
/// Handles voting, closing, and deleting polls

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
