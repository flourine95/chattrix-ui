// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'invite_link_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(inviteLinkDatasource)
const inviteLinkDatasourceProvider = InviteLinkDatasourceProvider._();

final class InviteLinkDatasourceProvider
    extends
        $FunctionalProvider<
          InviteLinkDatasource,
          InviteLinkDatasource,
          InviteLinkDatasource
        >
    with $Provider<InviteLinkDatasource> {
  const InviteLinkDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteLinkDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteLinkDatasourceHash();

  @$internal
  @override
  $ProviderElement<InviteLinkDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InviteLinkDatasource create(Ref ref) {
    return inviteLinkDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InviteLinkDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InviteLinkDatasource>(value),
    );
  }
}

String _$inviteLinkDatasourceHash() =>
    r'cd6985cf58c7acd63e6c5caa03b998357a77b633';

@ProviderFor(inviteLinkRepository)
const inviteLinkRepositoryProvider = InviteLinkRepositoryProvider._();

final class InviteLinkRepositoryProvider
    extends
        $FunctionalProvider<
          InviteLinkRepository,
          InviteLinkRepository,
          InviteLinkRepository
        >
    with $Provider<InviteLinkRepository> {
  const InviteLinkRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteLinkRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteLinkRepositoryHash();

  @$internal
  @override
  $ProviderElement<InviteLinkRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InviteLinkRepository create(Ref ref) {
    return inviteLinkRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InviteLinkRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InviteLinkRepository>(value),
    );
  }
}

String _$inviteLinkRepositoryHash() =>
    r'375d07cc0b79ec1e689c4d5c37ef84d59641fcd1';

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
    r'4cfb7cbf6d7033c3098cc5f8785464184ffc80b4';

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
    r'61c00e29832230b7527f41a4d8b5d649a44e6d6e';

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
    r'f94a455fb3fe3332a4572ba19f827466ec06daca';

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
    r'2054833d7d7ed90649a86d7682f121beb1732373';

@ProviderFor(joinViaInviteLinkUseCase)
const joinViaInviteLinkUseCaseProvider = JoinViaInviteLinkUseCaseProvider._();

final class JoinViaInviteLinkUseCaseProvider
    extends
        $FunctionalProvider<
          JoinViaInviteLinkUseCase,
          JoinViaInviteLinkUseCase,
          JoinViaInviteLinkUseCase
        >
    with $Provider<JoinViaInviteLinkUseCase> {
  const JoinViaInviteLinkUseCaseProvider._()
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
  $ProviderElement<JoinViaInviteLinkUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  JoinViaInviteLinkUseCase create(Ref ref) {
    return joinViaInviteLinkUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JoinViaInviteLinkUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JoinViaInviteLinkUseCase>(value),
    );
  }
}

String _$joinViaInviteLinkUseCaseHash() =>
    r'86b22620548b94a10c8c61bf88abdb7f529a4412';

@ProviderFor(getQrCodeUseCase)
const getQrCodeUseCaseProvider = GetQrCodeUseCaseProvider._();

final class GetQrCodeUseCaseProvider
    extends
        $FunctionalProvider<
          GetQrCodeUseCase,
          GetQrCodeUseCase,
          GetQrCodeUseCase
        >
    with $Provider<GetQrCodeUseCase> {
  const GetQrCodeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getQrCodeUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getQrCodeUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetQrCodeUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetQrCodeUseCase create(Ref ref) {
    return getQrCodeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetQrCodeUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetQrCodeUseCase>(value),
    );
  }
}

String _$getQrCodeUseCaseHash() => r'718eb2046f8722c27fa086051e93607335cb0baa';
