// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'incoming_call_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for managing the current incoming call invitation
/// This provider watches CallSignalingService and subscribes to callInvitationStream

@ProviderFor(IncomingCall)
const incomingCallProvider = IncomingCallProvider._();

/// Notifier for managing the current incoming call invitation
/// This provider watches CallSignalingService and subscribes to callInvitationStream
final class IncomingCallProvider
    extends $NotifierProvider<IncomingCall, CallInvitationData?> {
  /// Notifier for managing the current incoming call invitation
  /// This provider watches CallSignalingService and subscribes to callInvitationStream
  const IncomingCallProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingCallProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingCallHash();

  @$internal
  @override
  IncomingCall create() => IncomingCall();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallInvitationData? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallInvitationData?>(value),
    );
  }
}

String _$incomingCallHash() => r'1953919fbea7fbd659b811ad2ccd6ad567c1dc3d';

/// Notifier for managing the current incoming call invitation
/// This provider watches CallSignalingService and subscribes to callInvitationStream

abstract class _$IncomingCall extends $Notifier<CallInvitationData?> {
  CallInvitationData? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CallInvitationData?, CallInvitationData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CallInvitationData?, CallInvitationData?>,
              CallInvitationData?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider to access the current incoming call invitation

@ProviderFor(currentIncomingCall)
const currentIncomingCallProvider = CurrentIncomingCallProvider._();

/// Provider to access the current incoming call invitation

final class CurrentIncomingCallProvider
    extends
        $FunctionalProvider<
          CallInvitationData?,
          CallInvitationData?,
          CallInvitationData?
        >
    with $Provider<CallInvitationData?> {
  /// Provider to access the current incoming call invitation
  const CurrentIncomingCallProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentIncomingCallProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentIncomingCallHash();

  @$internal
  @override
  $ProviderElement<CallInvitationData?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallInvitationData? create(Ref ref) {
    return currentIncomingCall(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallInvitationData? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallInvitationData?>(value),
    );
  }
}

String _$currentIncomingCallHash() =>
    r'de49239c04c9916ef371d4054de9ab87ef10ee79';
