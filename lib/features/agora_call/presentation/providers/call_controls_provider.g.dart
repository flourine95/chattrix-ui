// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_controls_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Call controls state management provider
///
/// Manages the state of call controls (mute, video, speaker, camera)
/// and integrates with AgoraEngineService for actual control actions

@ProviderFor(CallControls)
const callControlsProvider = CallControlsProvider._();

/// Call controls state management provider
///
/// Manages the state of call controls (mute, video, speaker, camera)
/// and integrates with AgoraEngineService for actual control actions
final class CallControlsProvider
    extends $NotifierProvider<CallControls, CallControlsState> {
  /// Call controls state management provider
  ///
  /// Manages the state of call controls (mute, video, speaker, camera)
  /// and integrates with AgoraEngineService for actual control actions
  const CallControlsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callControlsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callControlsHash();

  @$internal
  @override
  CallControls create() => CallControls();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallControlsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallControlsState>(value),
    );
  }
}

String _$callControlsHash() => r'a569a488276567262be74a86bc3ae47e1a5f05f5';

/// Call controls state management provider
///
/// Manages the state of call controls (mute, video, speaker, camera)
/// and integrates with AgoraEngineService for actual control actions

abstract class _$CallControls extends $Notifier<CallControlsState> {
  CallControlsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CallControlsState, CallControlsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CallControlsState, CallControlsState>,
              CallControlsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
