// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'incoming_call_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Stream provider for incoming call invitations

@ProviderFor(incomingCallInvitations)
const incomingCallInvitationsProvider = IncomingCallInvitationsProvider._();

/// Stream provider for incoming call invitations

final class IncomingCallInvitationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<CallInvitation>,
          CallInvitation,
          Stream<CallInvitation>
        >
    with $FutureModifier<CallInvitation>, $StreamProvider<CallInvitation> {
  /// Stream provider for incoming call invitations
  const IncomingCallInvitationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingCallInvitationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingCallInvitationsHash();

  @$internal
  @override
  $StreamProviderElement<CallInvitation> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<CallInvitation> create(Ref ref) {
    return incomingCallInvitations(ref);
  }
}

String _$incomingCallInvitationsHash() =>
    r'bc46840f6dc6a124214685ee45bdebdb85c4d8ff';

/// Stream provider for invitation timeouts

@ProviderFor(invitationTimeouts)
const invitationTimeoutsProvider = InvitationTimeoutsProvider._();

/// Stream provider for invitation timeouts

final class InvitationTimeoutsProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  /// Stream provider for invitation timeouts
  const InvitationTimeoutsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'invitationTimeoutsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$invitationTimeoutsHash();

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    return invitationTimeouts(ref);
  }
}

String _$invitationTimeoutsHash() =>
    r'3ac20388922f262e0b97b483768704aa55d32d0d';

/// Notifier for managing the current incoming call invitation

@ProviderFor(CurrentIncomingCall)
const currentIncomingCallProvider = CurrentIncomingCallProvider._();

/// Notifier for managing the current incoming call invitation
final class CurrentIncomingCallProvider
    extends $NotifierProvider<CurrentIncomingCall, CallInvitation?> {
  /// Notifier for managing the current incoming call invitation
  const CurrentIncomingCallProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentIncomingCallProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentIncomingCallHash();

  @$internal
  @override
  CurrentIncomingCall create() => CurrentIncomingCall();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallInvitation? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallInvitation?>(value),
    );
  }
}

String _$currentIncomingCallHash() =>
    r'7d4a794d76773f02992782d16fcb8548db966cc8';

/// Notifier for managing the current incoming call invitation

abstract class _$CurrentIncomingCall extends $Notifier<CallInvitation?> {
  CallInvitation? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CallInvitation?, CallInvitation?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CallInvitation?, CallInvitation?>,
              CallInvitation?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
