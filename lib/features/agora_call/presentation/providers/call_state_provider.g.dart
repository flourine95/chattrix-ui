// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for tracking network quality metrics
/// Requirement 7.5: Show network quality indicator
/// Requirement 8.4: Log quality metrics for debugging

@ProviderFor(NetworkQuality)
const networkQualityProvider = NetworkQualityProvider._();

/// Provider for tracking network quality metrics
/// Requirement 7.5: Show network quality indicator
/// Requirement 8.4: Log quality metrics for debugging
final class NetworkQualityProvider
    extends $NotifierProvider<NetworkQuality, NetworkQualityState> {
  /// Provider for tracking network quality metrics
  /// Requirement 7.5: Show network quality indicator
  /// Requirement 8.4: Log quality metrics for debugging
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
  NetworkQuality create() => NetworkQuality();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkQualityState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkQualityState>(value),
    );
  }
}

String _$networkQualityHash() => r'eacb5554a4989617a54b97e833ff0db63caa8d01';

/// Provider for tracking network quality metrics
/// Requirement 7.5: Show network quality indicator
/// Requirement 8.4: Log quality metrics for debugging

abstract class _$NetworkQuality extends $Notifier<NetworkQualityState> {
  NetworkQualityState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<NetworkQualityState, NetworkQualityState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NetworkQualityState, NetworkQualityState>,
              NetworkQualityState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider for tracking quality warnings
/// Requirement 8.4: Show quality warnings without terminating call

@ProviderFor(QualityWarning)
const qualityWarningProvider = QualityWarningProvider._();

/// Provider for tracking quality warnings
/// Requirement 8.4: Show quality warnings without terminating call
final class QualityWarningProvider
    extends $NotifierProvider<QualityWarning, String?> {
  /// Provider for tracking quality warnings
  /// Requirement 8.4: Show quality warnings without terminating call
  const QualityWarningProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'qualityWarningProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$qualityWarningHash();

  @$internal
  @override
  QualityWarning create() => QualityWarning();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$qualityWarningHash() => r'cbc3fc4a3dc8b3b2f6bc29027e201555797bf34b';

/// Provider for tracking quality warnings
/// Requirement 8.4: Show quality warnings without terminating call

abstract class _$QualityWarning extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider for tracking WebSocket connection status for calls
/// Requirement 8.3: Handle WebSocket disconnection with reconnection attempt

@ProviderFor(CallWebSocketStatus)
const callWebSocketStatusProvider = CallWebSocketStatusProvider._();

/// Provider for tracking WebSocket connection status for calls
/// Requirement 8.3: Handle WebSocket disconnection with reconnection attempt
final class CallWebSocketStatusProvider
    extends $NotifierProvider<CallWebSocketStatus, bool> {
  /// Provider for tracking WebSocket connection status for calls
  /// Requirement 8.3: Handle WebSocket disconnection with reconnection attempt
  const CallWebSocketStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callWebSocketStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callWebSocketStatusHash();

  @$internal
  @override
  CallWebSocketStatus create() => CallWebSocketStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$callWebSocketStatusHash() =>
    r'0a5870e984967d8f16ec947999f97a2261e0e745';

/// Provider for tracking WebSocket connection status for calls
/// Requirement 8.3: Handle WebSocket disconnection with reconnection attempt

abstract class _$CallWebSocketStatus extends $Notifier<bool> {
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

/// Main call state management provider
///
/// Manages the complete call lifecycle including:
/// - Initiating calls
/// - Accepting/rejecting incoming calls
/// - Ending active calls
/// - Listening to WebSocket call events
/// - Managing Agora channel connections

@ProviderFor(CallState)
const callStateProvider = CallStateProvider._();

/// Main call state management provider
///
/// Manages the complete call lifecycle including:
/// - Initiating calls
/// - Accepting/rejecting incoming calls
/// - Ending active calls
/// - Listening to WebSocket call events
/// - Managing Agora channel connections
final class CallStateProvider
    extends $AsyncNotifierProvider<CallState, CallEntity?> {
  /// Main call state management provider
  ///
  /// Manages the complete call lifecycle including:
  /// - Initiating calls
  /// - Accepting/rejecting incoming calls
  /// - Ending active calls
  /// - Listening to WebSocket call events
  /// - Managing Agora channel connections
  const CallStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callStateHash();

  @$internal
  @override
  CallState create() => CallState();
}

String _$callStateHash() => r'65e047f976e72a2282c6535581b84e4b73b0e229';

/// Main call state management provider
///
/// Manages the complete call lifecycle including:
/// - Initiating calls
/// - Accepting/rejecting incoming calls
/// - Ending active calls
/// - Listening to WebSocket call events
/// - Managing Agora channel connections

abstract class _$CallState extends $AsyncNotifier<CallEntity?> {
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
