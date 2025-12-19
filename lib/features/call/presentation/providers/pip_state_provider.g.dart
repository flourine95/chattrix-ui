// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'pip_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider to manage Picture-in-Picture state

@ProviderFor(PipState)
const pipStateProvider = PipStateProvider._();

/// Provider to manage Picture-in-Picture state
final class PipStateProvider extends $NotifierProvider<PipState, bool> {
  /// Provider to manage Picture-in-Picture state
  const PipStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pipStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pipStateHash();

  @$internal
  @override
  PipState create() => PipState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$pipStateHash() => r'd4b4bf4e3300305541d620da9795b5ed07faba64';

/// Provider to manage Picture-in-Picture state

abstract class _$PipState extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider to manage PiP position

@ProviderFor(PipPosition)
const pipPositionProvider = PipPositionProvider._();

/// Provider to manage PiP position
final class PipPositionProvider
    extends $NotifierProvider<PipPosition, ({double x, double y})> {
  /// Provider to manage PiP position
  const PipPositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pipPositionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pipPositionHash();

  @$internal
  @override
  PipPosition create() => PipPosition();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({double x, double y}) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<({double x, double y})>(value),
    );
  }
}

String _$pipPositionHash() => r'61d3cbf5fc33d8897180d0631e5035b81bc43d71';

/// Provider to manage PiP position

abstract class _$PipPosition extends $Notifier<({double x, double y})> {
  ({double x, double y}) build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<({double x, double y}), ({double x, double y})>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<({double x, double y}), ({double x, double y})>,
              ({double x, double y}),
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
