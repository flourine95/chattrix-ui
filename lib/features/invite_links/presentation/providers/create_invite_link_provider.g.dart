// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'create_invite_link_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for creating invite link

@ProviderFor(CreateInviteLink)
const createInviteLinkProvider = CreateInviteLinkProvider._();

/// Provider for creating invite link
final class CreateInviteLinkProvider
    extends $AsyncNotifierProvider<CreateInviteLink, InviteLinkEntity?> {
  /// Provider for creating invite link
  const CreateInviteLinkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createInviteLinkProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createInviteLinkHash();

  @$internal
  @override
  CreateInviteLink create() => CreateInviteLink();
}

String _$createInviteLinkHash() => r'f7185a21992a569b501ed92e438555c7a32330df';

/// Provider for creating invite link

abstract class _$CreateInviteLink extends $AsyncNotifier<InviteLinkEntity?> {
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
