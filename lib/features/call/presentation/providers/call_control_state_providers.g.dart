// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_control_state_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Separate state providers for call controls
/// Each provider manages its own state independently to prevent unnecessary rebuilds

@ProviderFor(IsMutedState)
const isMutedStateProvider = IsMutedStateProvider._();

/// Separate state providers for call controls
/// Each provider manages its own state independently to prevent unnecessary rebuilds
final class IsMutedStateProvider extends $NotifierProvider<IsMutedState, bool> {
  /// Separate state providers for call controls
  /// Each provider manages its own state independently to prevent unnecessary rebuilds
  const IsMutedStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isMutedStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isMutedStateHash();

  @$internal
  @override
  IsMutedState create() => IsMutedState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isMutedStateHash() => r'cf6e742f33b1793bc126a60d0cb282fcb6d74b2b';

/// Separate state providers for call controls
/// Each provider manages its own state independently to prevent unnecessary rebuilds

abstract class _$IsMutedState extends $Notifier<bool> {
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

@ProviderFor(IsVideoEnabledState)
const isVideoEnabledStateProvider = IsVideoEnabledStateProvider._();

final class IsVideoEnabledStateProvider
    extends $NotifierProvider<IsVideoEnabledState, bool> {
  const IsVideoEnabledStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isVideoEnabledStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isVideoEnabledStateHash();

  @$internal
  @override
  IsVideoEnabledState create() => IsVideoEnabledState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isVideoEnabledStateHash() =>
    r'b97e300a0f77bd3eb3e4044660226fd828b21383';

abstract class _$IsVideoEnabledState extends $Notifier<bool> {
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

@ProviderFor(IsSpeakerEnabledState)
const isSpeakerEnabledStateProvider = IsSpeakerEnabledStateProvider._();

final class IsSpeakerEnabledStateProvider
    extends $NotifierProvider<IsSpeakerEnabledState, bool> {
  const IsSpeakerEnabledStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isSpeakerEnabledStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isSpeakerEnabledStateHash();

  @$internal
  @override
  IsSpeakerEnabledState create() => IsSpeakerEnabledState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isSpeakerEnabledStateHash() =>
    r'8d87dcdd2019e630cdd903b1834444d8cbcd7ed4';

abstract class _$IsSpeakerEnabledState extends $Notifier<bool> {
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

@ProviderFor(IsFrontCameraState)
const isFrontCameraStateProvider = IsFrontCameraStateProvider._();

final class IsFrontCameraStateProvider
    extends $NotifierProvider<IsFrontCameraState, bool> {
  const IsFrontCameraStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isFrontCameraStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isFrontCameraStateHash();

  @$internal
  @override
  IsFrontCameraState create() => IsFrontCameraState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isFrontCameraStateHash() =>
    r'97374f4c03ca39fd27a8f3fe5bdbc218c54b87d1';

abstract class _$IsFrontCameraState extends $Notifier<bool> {
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

@ProviderFor(RemoteIsMutedState)
const remoteIsMutedStateProvider = RemoteIsMutedStateProvider._();

final class RemoteIsMutedStateProvider
    extends $NotifierProvider<RemoteIsMutedState, bool> {
  const RemoteIsMutedStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteIsMutedStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteIsMutedStateHash();

  @$internal
  @override
  RemoteIsMutedState create() => RemoteIsMutedState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$remoteIsMutedStateHash() =>
    r'2470233666ee55867ba58ab4c63fdfbad335a578';

abstract class _$RemoteIsMutedState extends $Notifier<bool> {
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

@ProviderFor(RemoteIsVideoEnabledState)
const remoteIsVideoEnabledStateProvider = RemoteIsVideoEnabledStateProvider._();

final class RemoteIsVideoEnabledStateProvider
    extends $NotifierProvider<RemoteIsVideoEnabledState, bool> {
  const RemoteIsVideoEnabledStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteIsVideoEnabledStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteIsVideoEnabledStateHash();

  @$internal
  @override
  RemoteIsVideoEnabledState create() => RemoteIsVideoEnabledState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$remoteIsVideoEnabledStateHash() =>
    r'248dbc1ddf090495f82549d4f76c230301443015';

abstract class _$RemoteIsVideoEnabledState extends $Notifier<bool> {
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

@ProviderFor(RemoteUidState)
const remoteUidStateProvider = RemoteUidStateProvider._();

final class RemoteUidStateProvider
    extends $NotifierProvider<RemoteUidState, int?> {
  const RemoteUidStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteUidStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteUidStateHash();

  @$internal
  @override
  RemoteUidState create() => RemoteUidState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$remoteUidStateHash() => r'01e446ee1879ab213246faedf5562a75f0725725';

abstract class _$RemoteUidState extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
