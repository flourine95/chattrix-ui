// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Call History Notifier - manages call history state

@ProviderFor(CallHistory)
const callHistoryProvider = CallHistoryProvider._();

/// Call History Notifier - manages call history state
final class CallHistoryProvider
    extends $AsyncNotifierProvider<CallHistory, List<CallHistoryEntity>> {
  /// Call History Notifier - manages call history state
  const CallHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callHistoryHash();

  @$internal
  @override
  CallHistory create() => CallHistory();
}

String _$callHistoryHash() => r'cbdd58504219b81407eff2a975e5d746a363e881';

/// Call History Notifier - manages call history state

abstract class _$CallHistory extends $AsyncNotifier<List<CallHistoryEntity>> {
  FutureOr<List<CallHistoryEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<CallHistoryEntity>>,
              List<CallHistoryEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CallHistoryEntity>>,
                List<CallHistoryEntity>
              >,
              AsyncValue<List<CallHistoryEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
