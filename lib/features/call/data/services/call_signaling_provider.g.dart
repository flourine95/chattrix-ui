// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_signaling_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for CallSignalingService

@ProviderFor(callSignalingService)
const callSignalingServiceProvider = CallSignalingServiceProvider._();

/// Provider for CallSignalingService

final class CallSignalingServiceProvider
    extends
        $FunctionalProvider<
          CallSignalingService,
          CallSignalingService,
          CallSignalingService
        >
    with $Provider<CallSignalingService> {
  /// Provider for CallSignalingService
  const CallSignalingServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callSignalingServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callSignalingServiceHash();

  @$internal
  @override
  $ProviderElement<CallSignalingService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallSignalingService create(Ref ref) {
    return callSignalingService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallSignalingService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallSignalingService>(value),
    );
  }
}

String _$callSignalingServiceHash() =>
    r'e5e10378fae8cca9fba10fbdf6ea2dd9d5773abb';

/// Provider for CallInvitationManager

@ProviderFor(callInvitationManager)
const callInvitationManagerProvider = CallInvitationManagerProvider._();

/// Provider for CallInvitationManager

final class CallInvitationManagerProvider
    extends
        $FunctionalProvider<
          CallInvitationManager,
          CallInvitationManager,
          CallInvitationManager
        >
    with $Provider<CallInvitationManager> {
  /// Provider for CallInvitationManager
  const CallInvitationManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callInvitationManagerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callInvitationManagerHash();

  @$internal
  @override
  $ProviderElement<CallInvitationManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallInvitationManager create(Ref ref) {
    return callInvitationManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallInvitationManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallInvitationManager>(value),
    );
  }
}

String _$callInvitationManagerHash() =>
    r'b63f7cbd0bcbd0331eead02adeefb61f7ee6c0f4';
