// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'revoke_invite_link_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RevokeInviteLink)
const revokeInviteLinkProvider = RevokeInviteLinkProvider._();

final class RevokeInviteLinkProvider
    extends $AsyncNotifierProvider<RevokeInviteLink, InviteLinkEntity?> {
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

String _$revokeInviteLinkHash() => r'd54072066a4112e0330bda523ffcd5a80e4dad24';

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
