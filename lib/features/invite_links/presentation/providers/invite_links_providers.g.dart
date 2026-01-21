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
final inviteLinksApiServiceProvider = InviteLinksApiServiceProvider._();

final class InviteLinksApiServiceProvider
    extends
        $FunctionalProvider<
          InviteLinksApiService,
          InviteLinksApiService,
          InviteLinksApiService
        >
    with $Provider<InviteLinksApiService> {
  InviteLinksApiServiceProvider._()
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
final inviteLinksRepositoryProvider = InviteLinksRepositoryProvider._();

final class InviteLinksRepositoryProvider
    extends
        $FunctionalProvider<
          InviteLinksRepository,
          InviteLinksRepository,
          InviteLinksRepository
        >
    with $Provider<InviteLinksRepository> {
  InviteLinksRepositoryProvider._()
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
final createInviteLinkUseCaseProvider = CreateInviteLinkUseCaseProvider._();

final class CreateInviteLinkUseCaseProvider
    extends
        $FunctionalProvider<
          CreateInviteLinkUseCase,
          CreateInviteLinkUseCase,
          CreateInviteLinkUseCase
        >
    with $Provider<CreateInviteLinkUseCase> {
  CreateInviteLinkUseCaseProvider._()
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

@ProviderFor(getInviteLinkUseCase)
final getInviteLinkUseCaseProvider = GetInviteLinkUseCaseProvider._();

final class GetInviteLinkUseCaseProvider
    extends
        $FunctionalProvider<
          GetInviteLinkUseCase,
          GetInviteLinkUseCase,
          GetInviteLinkUseCase
        >
    with $Provider<GetInviteLinkUseCase> {
  GetInviteLinkUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getInviteLinkUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getInviteLinkUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetInviteLinkUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetInviteLinkUseCase create(Ref ref) {
    return getInviteLinkUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetInviteLinkUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetInviteLinkUseCase>(value),
    );
  }
}

String _$getInviteLinkUseCaseHash() =>
    r'dfef4889cde01dcc246408cdb70be367a1cd2fc6';

@ProviderFor(revokeInviteLinkUseCase)
final revokeInviteLinkUseCaseProvider = RevokeInviteLinkUseCaseProvider._();

final class RevokeInviteLinkUseCaseProvider
    extends
        $FunctionalProvider<
          RevokeInviteLinkUseCase,
          RevokeInviteLinkUseCase,
          RevokeInviteLinkUseCase
        >
    with $Provider<RevokeInviteLinkUseCase> {
  RevokeInviteLinkUseCaseProvider._()
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

@ProviderFor(getInviteLinkInfoUseCase)
final getInviteLinkInfoUseCaseProvider = GetInviteLinkInfoUseCaseProvider._();

final class GetInviteLinkInfoUseCaseProvider
    extends
        $FunctionalProvider<
          GetInviteLinkInfoUseCase,
          GetInviteLinkInfoUseCase,
          GetInviteLinkInfoUseCase
        >
    with $Provider<GetInviteLinkInfoUseCase> {
  GetInviteLinkInfoUseCaseProvider._()
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

@ProviderFor(joinViaInviteLinkUseCase)
final joinViaInviteLinkUseCaseProvider = JoinViaInviteLinkUseCaseProvider._();

final class JoinViaInviteLinkUseCaseProvider
    extends
        $FunctionalProvider<
          JoinGroupViaLinkUseCase,
          JoinGroupViaLinkUseCase,
          JoinGroupViaLinkUseCase
        >
    with $Provider<JoinGroupViaLinkUseCase> {
  JoinViaInviteLinkUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'joinViaInviteLinkUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$joinViaInviteLinkUseCaseHash();

  @$internal
  @override
  $ProviderElement<JoinGroupViaLinkUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  JoinGroupViaLinkUseCase create(Ref ref) {
    return joinViaInviteLinkUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JoinGroupViaLinkUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JoinGroupViaLinkUseCase>(value),
    );
  }
}

String _$joinViaInviteLinkUseCaseHash() =>
    r'bdb50972f2ef8369ca650251ee9c46d6a2444692';

@ProviderFor(joinGroupViaLinkUseCase)
final joinGroupViaLinkUseCaseProvider = JoinGroupViaLinkUseCaseProvider._();

final class JoinGroupViaLinkUseCaseProvider
    extends
        $FunctionalProvider<
          JoinGroupViaLinkUseCase,
          JoinGroupViaLinkUseCase,
          JoinGroupViaLinkUseCase
        >
    with $Provider<JoinGroupViaLinkUseCase> {
  JoinGroupViaLinkUseCaseProvider._()
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
