import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/login_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/logout_all_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/logout_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/register_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/resend_verification_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:chattrix_ui/features/auth/presentation/state/auth_state.dart';
import 'package:chattrix_ui/features/birthday/presentation/providers/birthday_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Export providers from auth_repository_provider for backward compatibility
export 'auth_repository_provider.dart' show dioProvider, secureStorageProvider, tokenCacheServiceProvider;
// Export AuthState and its extension for backward compatibility
export 'package:chattrix_ui/features/auth/presentation/state/auth_state.dart';

part 'auth_notifier.g.dart';

// Use case providers
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(ref.watch(authRepositoryProvider));
});

final verifyEmailUseCaseProvider = Provider<VerifyEmailUseCase>((ref) {
  return VerifyEmailUseCase(ref.watch(authRepositoryProvider));
});

final resendVerificationUseCaseProvider = Provider<ResendVerificationUseCase>((ref) {
  return ResendVerificationUseCase(ref.watch(authRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return GetCurrentUserUseCase(ref.watch(authRepositoryProvider));
});

final changePasswordUseCaseProvider = Provider<ChangePasswordUseCase>((ref) {
  return ChangePasswordUseCase(ref.watch(authRepositoryProvider));
});

final forgotPasswordUseCaseProvider = Provider<ForgotPasswordUseCase>((ref) {
  return ForgotPasswordUseCase(ref.watch(authRepositoryProvider));
});

final resetPasswordUseCaseProvider = Provider<ResetPasswordUseCase>((ref) {
  return ResetPasswordUseCase(ref.watch(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
});

final logoutAllUseCaseProvider = Provider<LogoutAllUseCase>((ref) {
  return LogoutAllUseCase(ref.watch(authRepositoryProvider));
});

final isLoggedInUseCaseProvider = Provider<IsLoggedInUseCase>((ref) {
  return IsLoggedInUseCase(ref.watch(authRepositoryProvider));
});

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    // Check auth status on initialization
    _checkAuthStatus();
    return const AuthState.initial();
  }

  Future<void> _checkAuthStatus() async {
    final isLoggedIn = await ref.read(isLoggedInUseCaseProvider)();
    if (isLoggedIn) {
      await loadCurrentUser();
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  /// Map Failure to user-friendly error message
  /// 
  /// Note: This is correct for the presentation layer. The repository already
  /// uses BaseRepository for error handling and returns Either<Failure, T>.
  /// Here we just convert Failure to user-friendly messages for the UI.
  String _getFailureMessage(Failure failure) {
    return failure.when(
      server: (message, code, requestId) => message,
      network: (message, code) => 'No internet connection. Please check your network.',
      validation: (message, code, details, requestId) {
        if (details != null && details.isNotEmpty) {
          return details.values.join(', ');
        }
        return message;
      },
      auth: (message, code, requestId) {
        if (message.contains('Invalid or expired token') || 
            message.contains('Token expired')) {
          _handleTokenExpired();
        }
        return message;
      },
      notFound: (message, code, requestId) => message,
      conflict: (message, code, requestId) => message,
      rateLimit: (message, code, requestId) => 
        'Too many requests. Please try again later.',
    );
  }

  Future<void> _handleTokenExpired() async {
    try {
      final tokenCache = ref.read(tokenCacheServiceProvider);
      await tokenCache.clearTokens();
      await _clearAllState();
      state = const AuthState.unauthenticated(
        message: 'Session expired. Please login again.',
      );
    } catch (e) {
      // Silently handle error
    }
  }

  Future<bool> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    state = const AuthState.loading();

    final result = await ref.read(loginUseCaseProvider)(
      usernameOrEmail: usernameOrEmail,
      password: password,
    );

    return result.fold(
      (failure) {
        final errorMessage = _getFailureMessage(failure);
        state = AuthState.error(message: errorMessage);
        return false;
      },
      (tokens) async {
        await loadCurrentUser();
        
        if (state.isAuthenticated) {
          ref.invalidate(webSocketConnectionProvider);
          return true;
        } else {
          state = const AuthState.error(
            message: 'Login successful but failed to load user profile',
          );
          return false;
        }
      },
    );
  }

  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    state = const AuthState.loading();

    final result = await ref.read(registerUseCaseProvider)(
      username: username,
      email: email,
      password: password,
      fullName: fullName,
    );

    return result.fold(
      (failure) {
        state = AuthState.error(message: _getFailureMessage(failure));
        return false;
      },
      (_) {
        state = const AuthState.unauthenticated();
        return true;
      },
    );
  }

  Future<bool> verifyEmail({
    required String email,
    required String otp,
  }) async {
    state = const AuthState.loading();

    final result = await ref.read(verifyEmailUseCaseProvider)(
      email: email,
      otp: otp,
    );

    return result.fold(
      (failure) {
        state = AuthState.error(message: _getFailureMessage(failure));
        return false;
      },
      (_) {
        state = const AuthState.unauthenticated();
        return true;
      },
    );
  }

  Future<bool> resendVerification({required String email}) async {
    // Don't change state to loading for resend
    final currentState = state;
    
    final result = await ref.read(resendVerificationUseCaseProvider)(
      email: email,
    );

    return result.fold(
      (failure) {
        state = AuthState.error(message: _getFailureMessage(failure));
        return false;
      },
      (_) {
        // Restore previous state
        state = currentState;
        return true;
      },
    );
  }

  Future<void> loadCurrentUser() async {
    state = const AuthState.loading();

    final result = await ref.read(getCurrentUserUseCaseProvider)();

    result.fold(
      (failure) {
        final errorMessage = _getFailureMessage(failure);
        state = AuthState.error(message: errorMessage);
      },
      (user) {
        state = AuthState.authenticated(user: user);
      },
    );
  }

  Future<bool> forgotPassword({required String email}) async {
    final currentState = state;
    state = const AuthState.loading();

    final result = await ref.read(forgotPasswordUseCaseProvider)(
      email: email,
    );

    return result.fold(
      (failure) {
        state = AuthState.error(message: _getFailureMessage(failure));
        return false;
      },
      (_) {
        // Restore previous state
        state = currentState;
        return true;
      },
    );
  }

  Future<bool> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    state = const AuthState.loading();

    final result = await ref.read(resetPasswordUseCaseProvider)(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );

    return result.fold(
      (failure) {
        state = AuthState.error(message: _getFailureMessage(failure));
        return false;
      },
      (_) {
        state = const AuthState.unauthenticated();
        return true;
      },
    );
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final currentState = state;
    state = const AuthState.loading();

    final result = await ref.read(changePasswordUseCaseProvider)(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    return result.fold(
      (failure) {
        state = AuthState.error(message: _getFailureMessage(failure));
        return false;
      },
      (_) {
        // Restore previous state
        state = currentState;
        return true;
      },
    );
  }

  Future<void> logout() async {
    state = const AuthState.unauthenticated();
    await ref.read(logoutUseCaseProvider)();
    await _clearAllState();
  }

  Future<void> logoutAll() async {
    state = const AuthState.unauthenticated();
    await ref.read(logoutAllUseCaseProvider)();
    await _clearAllState();
  }

  Future<void> _clearAllState() async {
    try {
      final wsNotifier = ref.read(webSocketConnectionProvider.notifier);
      await wsNotifier.disconnect();

      ref.invalidate(conversationsProvider);
      ref.invalidate(messagesProvider);
      ref.invalidate(onlineUsersProvider);
      ref.invalidate(userStatusProvider);
      ref.invalidate(webSocketConnectionProvider);
      ref.invalidate(todayBirthdaysProvider);
      ref.invalidate(upcomingBirthdaysProvider);
    } catch (e) {
      // Silently handle error
    }
  }
}

/// Convenience providers for backward compatibility
@riverpod
User? currentUser(Ref ref) {
  return ref.watch(authProvider).user;
}

@riverpod
bool isLoading(Ref ref) {
  return ref.watch(authProvider).isLoading;
}

@riverpod
String? authError(Ref ref) {
  return ref.watch(authProvider).errorMessage;
}

