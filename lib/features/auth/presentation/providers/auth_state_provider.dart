import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart' as entities;
import 'package:chattrix_ui/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:chattrix_ui/features/auth/presentation/state/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

/// Main auth state notifier using AsyncNotifier
/// Manages authentication state with automatic loading/error handling
@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  Future<AuthState> build() async {
    // Check if user is already logged in on app start
    final isLoggedIn = await ref.read(authRepositoryProvider).isLoggedIn();

    if (isLoggedIn) {
      // Try to load current user
      final result = await ref.read(authRepositoryProvider).getCurrentUser();

      return result.fold(
        (failure) => const AuthState(isAuthenticated: false),
        (user) => AuthState(user: user, isAuthenticated: true),
      );
    }

    return const AuthState(isAuthenticated: false);
  }

  /// Login user with username/email and password
  Future<void> login({required String usernameOrEmail, required String password}) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);

      // Perform login
      final loginResult = await repository.login(usernameOrEmail: usernameOrEmail, password: password);

      // Handle login result
      loginResult.fold((failure) => throw _mapFailureToException(failure), (_) => null);

      // Get current user after successful login
      final userResult = await repository.getCurrentUser();

      final user = userResult.fold((failure) => throw _mapFailureToException(failure), (user) => user);

      return AuthState(user: user, isAuthenticated: true);
    });
  }

  /// Register new user
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);

      final result = await repository.register(
        username: username,
        email: email,
        password: password,
        fullName: fullName,
      );

      result.fold((failure) => throw _mapFailureToException(failure), (_) => null);

      // Keep state as unauthenticated, user needs to verify email
      return const AuthState(isAuthenticated: false);
    });
  }

  /// Verify email with OTP
  Future<void> verifyEmail({required String email, required String otp}) async {
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.verifyEmail(email: email, otp: otp);

    result.fold((failure) => throw _mapFailureToException(failure), (_) => null);
  }

  /// Resend verification email
  Future<void> resendVerification({required String email}) async {
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.resendVerification(email: email);

    result.fold((failure) => throw _mapFailureToException(failure), (_) => null);
  }

  /// Change password for logged in user
  Future<void> changePassword({required String currentPassword, required String newPassword}) async {
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.changePassword(currentPassword: currentPassword, newPassword: newPassword);

    result.fold((failure) => throw _mapFailureToException(failure), (_) => null);
  }

  /// Initiate forgot password flow
  Future<void> forgotPassword({required String email}) async {
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.forgotPassword(email: email);

    result.fold((failure) => throw _mapFailureToException(failure), (_) => null);
  }

  /// Reset password with OTP
  Future<void> resetPassword({required String email, required String otp, required String newPassword}) async {
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.resetPassword(email: email, otp: otp, newPassword: newPassword);

    result.fold((failure) => throw _mapFailureToException(failure), (_) => null);
  }

  /// Logout current user
  Future<void> logout() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);

      final result = await repository.logout();

      result.fold((failure) => throw _mapFailureToException(failure), (_) => null);

      return const AuthState(isAuthenticated: false);
    });
  }

  /// Logout from all devices
  Future<void> logoutAll() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);

      final result = await repository.logoutAll();

      result.fold((failure) => throw _mapFailureToException(failure), (_) => null);

      return const AuthState(isAuthenticated: false);
    });
  }

  /// Refresh current user data
  Future<void> refreshUser() async {
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.getCurrentUser();

    state = await AsyncValue.guard(() async {
      final user = result.fold((failure) => throw _mapFailureToException(failure), (user) => user);

      return AuthState(user: user, isAuthenticated: true);
    });
  }

  /// Map Failure to Exception for AsyncValue.guard
  Exception _mapFailureToException(Failure failure) {
    return failure.when(
      server: (message, errorCode) => ServerException(message, errorCode),
      network: (message) => NetworkException(message),
      validation: (message, errors) => ValidationException(message, errors),
      badRequest: (message, errorCode) => BadRequestException(message, errorCode),
      unauthorized: (message, errorCode) => UnauthorizedException(message, errorCode),
      forbidden: (message, errorCode) => ForbiddenException(message, errorCode),
      notFound: (message, errorCode) => NotFoundException(message, errorCode),
      conflict: (message, errorCode) => ConflictException(message, errorCode),
      rateLimitExceeded: (message) => RateLimitException(message),
      unknown: (message) => UnknownException(message),
      permission: (message) => UnknownException(message),
      agoraEngine: (message, code) => UnknownException(message),
      tokenExpired: (message) => UnknownException(message),
      channelJoin: (message) => UnknownException(message),
      webSocketNotConnected: (message) => UnknownException(message),
      webSocketSendFailed: (message) => UnknownException(message),
      callNotFound: (message) => UnknownException(message),
      callAlreadyActive: (message) => UnknownException(message),
    );
  }
}

/// Custom exceptions matching Failure types
class ServerException implements Exception {
  final String message;
  final String? errorCode;
  ServerException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;
  final List<ValidationError>? errors;
  ValidationException(this.message, [this.errors]);

  @override
  String toString() {
    if (errors != null && errors!.isNotEmpty) {
      return errors!.map((e) => e.message).join(', ');
    }
    return message;
  }
}

class BadRequestException implements Exception {
  final String message;
  final String? errorCode;
  BadRequestException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;
  final String? errorCode;
  UnauthorizedException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class ForbiddenException implements Exception {
  final String message;
  final String? errorCode;
  ForbiddenException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  final String? errorCode;
  NotFoundException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class ConflictException implements Exception {
  final String message;
  final String? errorCode;
  ConflictException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class RateLimitException implements Exception {
  final String message;
  RateLimitException(this.message);

  @override
  String toString() => message;
}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);

  @override
  String toString() => message;
}

/// Helper providers for common use cases

/// Get current user (null if not logged in)
@riverpod
entities.User? currentUser(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.whenData((state) => state.user).value;
}

/// Check if user is authenticated
@riverpod
bool isAuthenticated(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.whenData((state) => state.isAuthenticated).value ?? false;
}

/// Check if user is logged in (authenticated + has user data)
@riverpod
bool isLoggedIn(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.whenData((state) => state.isAuthenticated && state.user != null).value ?? false;
}
