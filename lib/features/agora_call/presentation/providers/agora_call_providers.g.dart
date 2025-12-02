// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'agora_call_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Dio client provider for Agora call API communication
///
/// Reuses the authenticated Dio instance from auth providers

@ProviderFor(agoraCallDio)
const agoraCallDioProvider = AgoraCallDioProvider._();

/// Dio client provider for Agora call API communication
///
/// Reuses the authenticated Dio instance from auth providers

final class AgoraCallDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Dio client provider for Agora call API communication
  ///
  /// Reuses the authenticated Dio instance from auth providers
  const AgoraCallDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'agoraCallDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$agoraCallDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return agoraCallDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$agoraCallDioHash() => r'8afdad5a2cf988b626dce4fc9eb06d43ec5160db';

/// Remote data source provider for Agora call API
///
/// Handles all HTTP communication with the backend call API

@ProviderFor(agoraCallRemoteDataSource)
const agoraCallRemoteDataSourceProvider = AgoraCallRemoteDataSourceProvider._();

/// Remote data source provider for Agora call API
///
/// Handles all HTTP communication with the backend call API

final class AgoraCallRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          AgoraCallRemoteDataSource,
          AgoraCallRemoteDataSource,
          AgoraCallRemoteDataSource
        >
    with $Provider<AgoraCallRemoteDataSource> {
  /// Remote data source provider for Agora call API
  ///
  /// Handles all HTTP communication with the backend call API
  const AgoraCallRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'agoraCallRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$agoraCallRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<AgoraCallRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AgoraCallRemoteDataSource create(Ref ref) {
    return agoraCallRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AgoraCallRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AgoraCallRemoteDataSource>(value),
    );
  }
}

String _$agoraCallRemoteDataSourceHash() =>
    r'a35ea65a894185163786050d23c7825241772860';

/// Repository provider for Agora call operations
///
/// Implements the domain repository interface and handles error mapping

@ProviderFor(agoraCallRepository)
const agoraCallRepositoryProvider = AgoraCallRepositoryProvider._();

/// Repository provider for Agora call operations
///
/// Implements the domain repository interface and handles error mapping

final class AgoraCallRepositoryProvider
    extends
        $FunctionalProvider<
          AgoraCallRepository,
          AgoraCallRepository,
          AgoraCallRepository
        >
    with $Provider<AgoraCallRepository> {
  /// Repository provider for Agora call operations
  ///
  /// Implements the domain repository interface and handles error mapping
  const AgoraCallRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'agoraCallRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$agoraCallRepositoryHash();

  @$internal
  @override
  $ProviderElement<AgoraCallRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AgoraCallRepository create(Ref ref) {
    return agoraCallRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AgoraCallRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AgoraCallRepository>(value),
    );
  }
}

String _$agoraCallRepositoryHash() =>
    r'0d69c0229cf1b4c28ccedf93cbc4ac7cc52a0f00';

/// Agora RTC Engine service provider
///
/// Manages the Agora SDK instance for real-time audio/video communication
/// Automatically initializes with the App ID from environment variables
/// Disposes the engine when the provider is disposed

@ProviderFor(agoraEngineService)
const agoraEngineServiceProvider = AgoraEngineServiceProvider._();

/// Agora RTC Engine service provider
///
/// Manages the Agora SDK instance for real-time audio/video communication
/// Automatically initializes with the App ID from environment variables
/// Disposes the engine when the provider is disposed

final class AgoraEngineServiceProvider
    extends
        $FunctionalProvider<
          AgoraEngineService,
          AgoraEngineService,
          AgoraEngineService
        >
    with $Provider<AgoraEngineService> {
  /// Agora RTC Engine service provider
  ///
  /// Manages the Agora SDK instance for real-time audio/video communication
  /// Automatically initializes with the App ID from environment variables
  /// Disposes the engine when the provider is disposed
  const AgoraEngineServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'agoraEngineServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$agoraEngineServiceHash();

  @$internal
  @override
  $ProviderElement<AgoraEngineService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AgoraEngineService create(Ref ref) {
    return agoraEngineService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AgoraEngineService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AgoraEngineService>(value),
    );
  }
}

String _$agoraEngineServiceHash() =>
    r'd430792ab83e6feeef535ceb5b205e076ae43098';

/// Ringtone service provider
///
/// Manages ringtone playback for incoming calls
/// Automatically disposes the audio player when the provider is disposed

@ProviderFor(ringtoneService)
const ringtoneServiceProvider = RingtoneServiceProvider._();

/// Ringtone service provider
///
/// Manages ringtone playback for incoming calls
/// Automatically disposes the audio player when the provider is disposed

final class RingtoneServiceProvider
    extends
        $FunctionalProvider<RingtoneService, RingtoneService, RingtoneService>
    with $Provider<RingtoneService> {
  /// Ringtone service provider
  ///
  /// Manages ringtone playback for incoming calls
  /// Automatically disposes the audio player when the provider is disposed
  const RingtoneServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ringtoneServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ringtoneServiceHash();

  @$internal
  @override
  $ProviderElement<RingtoneService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RingtoneService create(Ref ref) {
    return ringtoneService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RingtoneService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RingtoneService>(value),
    );
  }
}

String _$ringtoneServiceHash() => r'5ca6e299aa1b01378795f22f4b5595c3c9d71717';

/// Permission service provider
///
/// Manages camera and microphone permissions for calls
/// Handles permission requests and checks based on call type

@ProviderFor(permissionService)
const permissionServiceProvider = PermissionServiceProvider._();

/// Permission service provider
///
/// Manages camera and microphone permissions for calls
/// Handles permission requests and checks based on call type

final class PermissionServiceProvider
    extends
        $FunctionalProvider<
          PermissionService,
          PermissionService,
          PermissionService
        >
    with $Provider<PermissionService> {
  /// Permission service provider
  ///
  /// Manages camera and microphone permissions for calls
  /// Handles permission requests and checks based on call type
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

/// Call security service provider
///
/// Manages security measures for calls including:
/// - Token lifecycle management
/// - Secure protocol verification
/// - Sensitive data cleanup
///
/// Requirements: 10.1, 10.2, 10.3, 10.5

@ProviderFor(callSecurityService)
const callSecurityServiceProvider = CallSecurityServiceProvider._();

/// Call security service provider
///
/// Manages security measures for calls including:
/// - Token lifecycle management
/// - Secure protocol verification
/// - Sensitive data cleanup
///
/// Requirements: 10.1, 10.2, 10.3, 10.5

final class CallSecurityServiceProvider
    extends
        $FunctionalProvider<
          CallSecurityService,
          CallSecurityService,
          CallSecurityService
        >
    with $Provider<CallSecurityService> {
  /// Call security service provider
  ///
  /// Manages security measures for calls including:
  /// - Token lifecycle management
  /// - Secure protocol verification
  /// - Sensitive data cleanup
  ///
  /// Requirements: 10.1, 10.2, 10.3, 10.5
  const CallSecurityServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callSecurityServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callSecurityServiceHash();

  @$internal
  @override
  $ProviderElement<CallSecurityService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallSecurityService create(Ref ref) {
    return callSecurityService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallSecurityService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallSecurityService>(value),
    );
  }
}

String _$callSecurityServiceHash() =>
    r'669caace564757159e02b567c2af91ff62495c4c';
