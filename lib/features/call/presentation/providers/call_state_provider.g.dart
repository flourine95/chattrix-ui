// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Network quality stream provider
/// Watches the repository's network quality stream

@ProviderFor(networkQuality)
const networkQualityProvider = NetworkQualityProvider._();

/// Network quality stream provider
/// Watches the repository's network quality stream

final class NetworkQualityProvider
    extends
        $FunctionalProvider<
          AsyncValue<NetworkQuality>,
          NetworkQuality,
          Stream<NetworkQuality>
        >
    with $FutureModifier<NetworkQuality>, $StreamProvider<NetworkQuality> {
  /// Network quality stream provider
  /// Watches the repository's network quality stream
  const NetworkQualityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkQualityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkQualityHash();

  @$internal
  @override
  $StreamProviderElement<NetworkQuality> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<NetworkQuality> create(Ref ref) {
    return networkQuality(ref);
  }
}

String _$networkQualityHash() => r'20c056c3e7f7d8c14a6d65e5f14e228218289c42';

/// Call history notifier using AsyncNotifier
/// Manages call history state with fetch and refresh capabilities

@ProviderFor(CallHistory)
const callHistoryProvider = CallHistoryProvider._();

/// Call history notifier using AsyncNotifier
/// Manages call history state with fetch and refresh capabilities
final class CallHistoryProvider
    extends $AsyncNotifierProvider<CallHistory, List<CallHistoryEntity>> {
  /// Call history notifier using AsyncNotifier
  /// Manages call history state with fetch and refresh capabilities
  const CallHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callHistoryHash();

  @$internal
  @override
  CallHistory create() => CallHistory();
}

String _$callHistoryHash() => r'718a562e4b88a13896c73ebc624d4f95627e657d';

/// Call history notifier using AsyncNotifier
/// Manages call history state with fetch and refresh capabilities

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

/// Main call state notifier using AsyncNotifier
/// Manages call state with automatic loading/error handling

@ProviderFor(Call)
const callProvider = CallProvider._();

/// Main call state notifier using AsyncNotifier
/// Manages call state with automatic loading/error handling
final class CallProvider extends $AsyncNotifierProvider<Call, CallEntity?> {
  /// Main call state notifier using AsyncNotifier
  /// Manages call state with automatic loading/error handling
  const CallProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callHash();

  @$internal
  @override
  Call create() => Call();
}

String _$callHash() => r'6066aaeaa9dd333ab328f276cb29de7f0ba0e262';

/// Main call state notifier using AsyncNotifier
/// Manages call state with automatic loading/error handling

abstract class _$Call extends $AsyncNotifier<CallEntity?> {
  FutureOr<CallEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<CallEntity?>, CallEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CallEntity?>, CallEntity?>,
              AsyncValue<CallEntity?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
