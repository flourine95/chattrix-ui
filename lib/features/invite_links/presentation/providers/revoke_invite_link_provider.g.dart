// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'revoke_invite_link_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for revoking invite link

@ProviderFor(RevokeInviteLink)
const revokeInviteLinkProvider = RevokeInviteLinkProvider._();

/// Provider for revoking invite link
final class RevokeInviteLinkProvider
    extends $AsyncNotifierProvider<RevokeInviteLink, InviteLinkEntity?> {
  /// Provider for revoking invite link
  const RevokeInviteLinkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'revokeInviteLinkProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$revokeInviteLinkHash();

  @$internal
  @override
  RevokeInviteLink create() => RevokeInviteLink();
}

String _$revokeInviteLinkHash() => r'8ef22c3d1f1e1923143b69187dd9c10b5f736cca';

/// Provider for revoking invite link

abstract class _$RevokeInviteLink extends $AsyncNotifier<InviteLinkEntity?> {
  FutureOr<InviteLinkEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<InviteLinkEntity?>, InviteLinkEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<InviteLinkEntity?>, InviteLinkEntity?>,
              AsyncValue<InviteLinkEntity?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
