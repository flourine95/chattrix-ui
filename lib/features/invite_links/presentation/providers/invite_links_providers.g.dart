// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'invite_links_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(inviteLinksApiService)
const inviteLinksApiServiceProvider = InviteLinksApiServiceProvider._();

final class InviteLinksApiServiceProvider
    extends
        $FunctionalProvider<
          InviteLinksApiService,
          InviteLinksApiService,
          InviteLinksApiService
        >
    with $Provider<InviteLinksApiService> {
  const InviteLinksApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteLinksApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteLinksApiServiceHash();

  @$internal
  @override
  $ProviderElement<InviteLinksApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InviteLinksApiService create(Ref ref) {
    return inviteLinksApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InviteLinksApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InviteLinksApiService>(value),
    );
  }
}

String _$inviteLinksApiServiceHash() =>
    r'b8a6482d166b24d333468a352e1fe298f3e40388';

@ProviderFor(inviteLinksRepository)
const inviteLinksRepositoryProvider = InviteLinksRepositoryProvider._();

final class InviteLinksRepositoryProvider
    extends
        $FunctionalProvider<
          InviteLinksRepository,
          InviteLinksRepository,
          InviteLinksRepository
        >
    with $Provider<InviteLinksRepository> {
  const InviteLinksRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteLinksRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteLinksRepositoryHash();

  @$internal
  @override
  $ProviderElement<InviteLinksRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InviteLinksRepository create(Ref ref) {
    return inviteLinksRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InviteLinksRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InviteLinksRepository>(value),
    );
  }
}

String _$inviteLinksRepositoryHash() =>
    r'6bcd01dac30a56525b3c9b5e12ecf5360b6536f0';

@ProviderFor(createInviteLinkUseCase)
const createInviteLinkUseCaseProvider = CreateInviteLinkUseCaseProvider._();

final class CreateInviteLinkUseCaseProvider
    extends
        $FunctionalProvider<
          CreateInviteLinkUseCase,
          CreateInviteLinkUseCase,
          CreateInviteLinkUseCase
        >
    with $Provider<CreateInviteLinkUseCase> {
  const CreateInviteLinkUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createInviteLinkUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createInviteLinkUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateInviteLinkUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateInviteLinkUseCase create(Ref ref) {
    return createInviteLinkUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateInviteLinkUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateInviteLinkUseCase>(value),
    );
  }
}

String _$createInviteLinkUseCaseHash() =>
    r'778b17e9e331c1daa3e980a8cb4f66ab1e1d3729';

@ProviderFor(getInviteLinksUseCase)
const getInviteLinksUseCaseProvider = GetInviteLinksUseCaseProvider._();

final class GetInviteLinksUseCaseProvider
    extends
        $FunctionalProvider<
          GetInviteLinksUseCase,
          GetInviteLinksUseCase,
          GetInviteLinksUseCase
        >
    with $Provider<GetInviteLinksUseCase> {
  const GetInviteLinksUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getInviteLinksUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getInviteLinksUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetInviteLinksUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetInviteLinksUseCase create(Ref ref) {
    return getInviteLinksUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetInviteLinksUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetInviteLinksUseCase>(value),
    );
  }
}

String _$getInviteLinksUseCaseHash() =>
    r'fabb393e4c7390db5502af8161ce600fc4840817';

@ProviderFor(revokeInviteLinkUseCase)
const revokeInviteLinkUseCaseProvider = RevokeInviteLinkUseCaseProvider._();

final class RevokeInviteLinkUseCaseProvider
    extends
        $FunctionalProvider<
          RevokeInviteLinkUseCase,
          RevokeInviteLinkUseCase,
          RevokeInviteLinkUseCase
        >
    with $Provider<RevokeInviteLinkUseCase> {
  const RevokeInviteLinkUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'revokeInviteLinkUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$revokeInviteLinkUseCaseHash();

  @$internal
  @override
  $ProviderElement<RevokeInviteLinkUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RevokeInviteLinkUseCase create(Ref ref) {
    return revokeInviteLinkUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RevokeInviteLinkUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RevokeInviteLinkUseCase>(value),
    );
  }
}

String _$revokeInviteLinkUseCaseHash() =>
    r'84118726b90b552a8726c462e9c6b8e2a4b6f59e';

@ProviderFor(getQRCodeUseCase)
const getQRCodeUseCaseProvider = GetQRCodeUseCaseProvider._();

final class GetQRCodeUseCaseProvider
    extends
        $FunctionalProvider<
          GetQRCodeUseCase,
          GetQRCodeUseCase,
          GetQRCodeUseCase
        >
    with $Provider<GetQRCodeUseCase> {
  const GetQRCodeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getQRCodeUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getQRCodeUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetQRCodeUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetQRCodeUseCase create(Ref ref) {
    return getQRCodeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetQRCodeUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetQRCodeUseCase>(value),
    );
  }
}

String _$getQRCodeUseCaseHash() => r'6acca188df345d8c85d034a258948392e215ecef';

@ProviderFor(getInviteLinkInfoUseCase)
const getInviteLinkInfoUseCaseProvider = GetInviteLinkInfoUseCaseProvider._();

final class GetInviteLinkInfoUseCaseProvider
    extends
        $FunctionalProvider<
          GetInviteLinkInfoUseCase,
          GetInviteLinkInfoUseCase,
          GetInviteLinkInfoUseCase
        >
    with $Provider<GetInviteLinkInfoUseCase> {
  const GetInviteLinkInfoUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getInviteLinkInfoUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getInviteLinkInfoUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetInviteLinkInfoUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetInviteLinkInfoUseCase create(Ref ref) {
    return getInviteLinkInfoUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetInviteLinkInfoUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetInviteLinkInfoUseCase>(value),
    );
  }
}

String _$getInviteLinkInfoUseCaseHash() =>
    r'1c24478e84c56718e9472bcc896110d758e3b0a0';

@ProviderFor(joinGroupViaLinkUseCase)
const joinGroupViaLinkUseCaseProvider = JoinGroupViaLinkUseCaseProvider._();

final class JoinGroupViaLinkUseCaseProvider
    extends
        $FunctionalProvider<
          JoinGroupViaLinkUseCase,
          JoinGroupViaLinkUseCase,
          JoinGroupViaLinkUseCase
        >
    with $Provider<JoinGroupViaLinkUseCase> {
  const JoinGroupViaLinkUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'joinGroupViaLinkUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$joinGroupViaLinkUseCaseHash();

  @$internal
  @override
  $ProviderElement<JoinGroupViaLinkUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  JoinGroupViaLinkUseCase create(Ref ref) {
    return joinGroupViaLinkUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JoinGroupViaLinkUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JoinGroupViaLinkUseCase>(value),
    );
  }
}

String _$joinGroupViaLinkUseCaseHash() =>
    r'aefbd0837ba7d69f3f3b9277e3b3ba584acd1b12';
