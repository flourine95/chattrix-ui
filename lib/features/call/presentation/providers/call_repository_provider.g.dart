// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Agora Service provider - singleton

@ProviderFor(agoraService)
const agoraServiceProvider = AgoraServiceProvider._();

/// Agora Service provider - singleton

final class AgoraServiceProvider
    extends $FunctionalProvider<AgoraService, AgoraService, AgoraService>
    with $Provider<AgoraService> {
  /// Agora Service provider - singleton
  const AgoraServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'agoraServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$agoraServiceHash();

  @$internal
  @override
  $ProviderElement<AgoraService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AgoraService create(Ref ref) {
    return agoraService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AgoraService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AgoraService>(value),
    );
  }
}

String _$agoraServiceHash() => r'98985ef6a6658253ba7e3d1c8923fdbd24a4f76a';

/// Token Service provider

@ProviderFor(tokenService)
const tokenServiceProvider = TokenServiceProvider._();

/// Token Service provider

final class TokenServiceProvider
    extends $FunctionalProvider<TokenService, TokenService, TokenService>
    with $Provider<TokenService> {
  /// Token Service provider
  const TokenServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenServiceHash();

  @$internal
  @override
  $ProviderElement<TokenService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TokenService create(Ref ref) {
    return tokenService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenService>(value),
    );
  }
}

String _$tokenServiceHash() => r'aa8d22a0509583aa108437829b082c2fce1d632a';

/// Permission Service provider

@ProviderFor(permissionService)
const permissionServiceProvider = PermissionServiceProvider._();

/// Permission Service provider

final class PermissionServiceProvider
    extends
        $FunctionalProvider<
          PermissionService,
          PermissionService,
          PermissionService
        >
    with $Provider<PermissionService> {
  /// Permission Service provider
  const PermissionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'permissionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$permissionServiceHash();

  @$internal
  @override
  $ProviderElement<PermissionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PermissionService create(Ref ref) {
    return permissionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PermissionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PermissionService>(value),
    );
  }
}

String _$permissionServiceHash() => r'c2d80eefe41d876497606e2f7f35e68b50a5d1d7';

/// Call Local Data Source provider

@ProviderFor(callLocalDataSource)
const callLocalDataSourceProvider = CallLocalDataSourceProvider._();

/// Call Local Data Source provider

final class CallLocalDataSourceProvider
    extends
        $FunctionalProvider<
          CallLocalDataSourceImpl,
          CallLocalDataSourceImpl,
          CallLocalDataSourceImpl
        >
    with $Provider<CallLocalDataSourceImpl> {
  /// Call Local Data Source provider
  const CallLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<CallLocalDataSourceImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallLocalDataSourceImpl create(Ref ref) {
    return callLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallLocalDataSourceImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallLocalDataSourceImpl>(value),
    );
  }
}

String _$callLocalDataSourceHash() =>
    r'3faa21267b6bb2a89f32e10fd14f22bf9706e42d';

/// Call Signaling Service provider

@ProviderFor(callSignalingService)
const callSignalingServiceProvider = CallSignalingServiceProvider._();

/// Call Signaling Service provider

final class CallSignalingServiceProvider
    extends
        $FunctionalProvider<
          CallSignalingService,
          CallSignalingService,
          CallSignalingService
        >
    with $Provider<CallSignalingService> {
  /// Call Signaling Service provider
  const CallSignalingServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callSignalingServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callSignalingServiceHash();

  @$internal
  @override
  $ProviderElement<CallSignalingService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallSignalingService create(Ref ref) {
    return callSignalingService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallSignalingService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallSignalingService>(value),
    );
  }
}

String _$callSignalingServiceHash() =>
    r'79e03f4875740addb530ec5954ce928835a61284';

/// Call Invitation Manager provider

@ProviderFor(callInvitationManager)
const callInvitationManagerProvider = CallInvitationManagerProvider._();

/// Call Invitation Manager provider

final class CallInvitationManagerProvider
    extends
        $FunctionalProvider<
          CallInvitationManager,
          CallInvitationManager,
          CallInvitationManager
        >
    with $Provider<CallInvitationManager> {
  /// Call Invitation Manager provider
  const CallInvitationManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callInvitationManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callInvitationManagerHash();

  @$internal
  @override
  $ProviderElement<CallInvitationManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallInvitationManager create(Ref ref) {
    return callInvitationManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallInvitationManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallInvitationManager>(value),
    );
  }
}

String _$callInvitationManagerHash() =>
    r'1c3300c18a48a062d7fce5c3beef158d4a6f7fd6';

/// Main Call Repository provider

@ProviderFor(callRepository)
const callRepositoryProvider = CallRepositoryProvider._();

/// Main Call Repository provider

final class CallRepositoryProvider
    extends $FunctionalProvider<CallRepository, CallRepository, CallRepository>
    with $Provider<CallRepository> {
  /// Main Call Repository provider
  const CallRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callRepositoryHash();

  @$internal
  @override
  $ProviderElement<CallRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CallRepository create(Ref ref) {
    return callRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallRepository>(value),
    );
  }
}

String _$callRepositoryHash() => r'59472aebf97563af83a9494ac0c1edc5fcb45fa2';
