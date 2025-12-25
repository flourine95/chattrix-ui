// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'create_invite_link_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateInviteLink)
const createInviteLinkProvider = CreateInviteLinkProvider._();

final class CreateInviteLinkProvider
    extends $AsyncNotifierProvider<CreateInviteLink, InviteLinkEntity?> {
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

String _$createInviteLinkHash() => r'65a2f2d4c33d4280ae439d4243a1cc20475b18e5';

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
