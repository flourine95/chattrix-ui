// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'auth_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Main auth state notifier using AsyncNotifier
/// Manages authentication state with automatic loading/error handling

@ProviderFor(Auth)
const authProvider = AuthProvider._();

/// Main auth state notifier using AsyncNotifier
/// Manages authentication state with automatic loading/error handling
final class AuthProvider extends $AsyncNotifierProvider<Auth, AuthState> {
  /// Main auth state notifier using AsyncNotifier
  /// Manages authentication state with automatic loading/error handling
  const AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();
}

String _$authHash() => r'8a51e5449a8da60ae43ff8c754f15317c7c9fb91';

/// Main auth state notifier using AsyncNotifier
/// Manages authentication state with automatic loading/error handling

abstract class _$Auth extends $AsyncNotifier<AuthState> {
  FutureOr<AuthState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AuthState>, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthState>, AuthState>,
              AsyncValue<AuthState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Helper providers for common use cases
/// Get current user (null if not logged in)

@ProviderFor(currentUser)
const currentUserProvider = CurrentUserProvider._();

/// Helper providers for common use cases
/// Get current user (null if not logged in)

final class CurrentUserProvider
    extends $FunctionalProvider<entities.User?, entities.User?, entities.User?>
    with $Provider<entities.User?> {
  /// Helper providers for common use cases
  /// Get current user (null if not logged in)
  const CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $ProviderElement<entities.User?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  entities.User? create(Ref ref) {
    return currentUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(entities.User? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<entities.User?>(value),
    );
  }
}

String _$currentUserHash() => r'57119b963d31c0453da05cf27a079825d612a20d';

/// Check if user is authenticated

@ProviderFor(isAuthenticated)
const isAuthenticatedProvider = IsAuthenticatedProvider._();

/// Check if user is authenticated

final class IsAuthenticatedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Check if user is authenticated
  const IsAuthenticatedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAuthenticatedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAuthenticatedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isAuthenticated(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isAuthenticatedHash() => r'7cd3204c51efda797bb06ab15b3b86cd098fc7b9';

/// Check if user is logged in (authenticated + has user data)

@ProviderFor(isLoggedIn)
const isLoggedInProvider = IsLoggedInProvider._();

/// Check if user is logged in (authenticated + has user data)

final class IsLoggedInProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Check if user is logged in (authenticated + has user data)
  const IsLoggedInProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLoggedInProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLoggedInHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isLoggedIn(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLoggedInHash() => r'ac09587a2359f8f0ef403320dcffc87935355ffd';
