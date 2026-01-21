// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'revoke_invite_link_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for revoking the current active invite link
///
/// **API**: DELETE /v1/conversations/{conversationId}/invite-link

@ProviderFor(RevokeInviteLink)
final revokeInviteLinkProvider = RevokeInviteLinkProvider._();

/// Provider for revoking the current active invite link
///
/// **API**: DELETE /v1/conversations/{conversationId}/invite-link
final class RevokeInviteLinkProvider
    extends $AsyncNotifierProvider<RevokeInviteLink, InviteLinkEntity?> {
  /// Provider for revoking the current active invite link
  ///
  /// **API**: DELETE /v1/conversations/{conversationId}/invite-link
  RevokeInviteLinkProvider._()
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

String _$revokeInviteLinkHash() => r'c09a5a0de2671c5061b33f202c4c4a433673c5c0';

/// Provider for revoking the current active invite link
///
/// **API**: DELETE /v1/conversations/{conversationId}/invite-link

abstract class _$RevokeInviteLink extends $AsyncNotifier<InviteLinkEntity?> {
  FutureOr<InviteLinkEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
  }
}
