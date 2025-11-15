import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/network/auth_interceptor.dart';
import 'package:chattrix_ui/core/network/dio_client.dart';
import 'package:chattrix_ui/features/auth/data/datasources/auth_local_datasource_impl.dart';
import 'package:chattrix_ui/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:chattrix_ui/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chattrix_ui/features/auth/domain/datasources/auth_local_datasource.dart';
import 'package:chattrix_ui/features/auth/domain/datasources/auth_remote_datasource.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/login_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/logout_all_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/logout_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/register_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/resend_verification_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:chattrix_ui/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers for dependencies
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final dioProvider = Provider<Dio>((ref) {
  final dio = DioClient.createDio();
  final secureStorage = ref.watch(secureStorageProvider);

  // Add auth interceptor
  dio.interceptors.add(AuthInterceptor(dio: dio, secureStorage: secureStorage));

  return dio;
});

// Data source providers
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(dio: ref.watch(dioProvider)) as AuthRemoteDataSource;
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(secureStorage: ref.watch(secureStorageProvider)) as AuthLocalDataSource;
});

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
});

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

final refreshTokenUseCaseProvider = Provider<RefreshTokenUseCase>((ref) {
  return RefreshTokenUseCase(ref.watch(authRepositoryProvider));
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

// Auth state class
class AuthState {
  final User? user;
  final bool isLoading;
  final String? errorMessage;

  AuthState({this.user, this.isLoading = false, this.errorMessage});

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? errorMessage,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

// Auth notifier using AsyncNotifier
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    // Initialize and check if user is logged in
    _checkAuthStatus();
    return AuthState();
  }

  Future<void> _checkAuthStatus() async {
    final isLoggedIn = await ref.read(isLoggedInUseCaseProvider)();
    if (isLoggedIn) {
      await loadCurrentUser();
    }
  }

  String _getFailureMessage(dynamic failure) {
    // Lấy message trực tiếp từ Failure object
    if (failure is Failure) {
      return failure.when(
        server: (message, errorCode) => message,
        network: (message) => 'Không có kết nối mạng. Vui lòng kiểm tra lại.',
        validation: (message, errors) {
          if (errors != null && errors.isNotEmpty) {
            return errors.map((e) => e.message).join(', ');
          }
          return message;
        },
        badRequest: (message, errorCode) => message,
        unauthorized: (message, errorCode) => message,
        forbidden: (message, errorCode) => message,
        notFound: (message, errorCode) => message,
        conflict: (message, errorCode) => message,
        rateLimitExceeded: (message) => 'Quá nhiều yêu cầu. Vui lòng thử lại sau.',
        unknown: (message) => message,
      );
    }

    // Fallback cho trường hợp không phải Failure object
    return 'Có lỗi xảy ra. Vui lòng thử lại.';
  }

  Future<bool> login({required String usernameOrEmail, required String password}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(loginUseCaseProvider)(usernameOrEmail: usernameOrEmail, password: password);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
        return false;
      },
      (tokens) async {
        await loadCurrentUser();
        return true;
      },
    );
  }

  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(registerUseCaseProvider)(
      username: username,
      email: email,
      password: password,
      fullName: fullName,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }

  Future<bool> verifyEmail({required String email, required String otp}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(verifyEmailUseCaseProvider)(email: email, otp: otp);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }

  Future<bool> resendVerification({required String email}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(resendVerificationUseCaseProvider)(email: email);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }

  Future<void> loadCurrentUser() async {
    state = state.copyWith(isLoading: true);

    final result = await ref.read(getCurrentUserUseCaseProvider)();

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
      },
      (user) {
        state = state.copyWith(isLoading: false, user: user);
      },
    );
  }

  Future<bool> forgotPassword({required String email}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(forgotPasswordUseCaseProvider)(email: email);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }

  Future<bool> resetPassword({required String email, required String otp, required String newPassword}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(resetPasswordUseCaseProvider)(email: email, otp: otp, newPassword: newPassword);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }

  Future<bool> changePassword({required String currentPassword, required String newPassword}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(changePasswordUseCaseProvider)(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    await ref.read(logoutUseCaseProvider)();

    // Clear all app state
    await _clearAllState();

    state = AuthState();
  }

  Future<void> logoutAll() async {
    state = state.copyWith(isLoading: true);
    await ref.read(logoutAllUseCaseProvider)();

    // Clear all app state
    await _clearAllState();

    state = AuthState();
  }

  /// Clear all app state when logging out
  Future<void> _clearAllState() async {
    try {
      // Disconnect WebSocket
      final wsNotifier = ref.read(webSocketConnectionProvider.notifier);
      await wsNotifier.disconnect();

      // Invalidate all providers to clear cache
      ref.invalidate(conversationsProvider);
      ref.invalidate(messagesProvider);
      ref.invalidate(onlineUsersProvider);
      ref.invalidate(userStatusProvider);
      ref.invalidate(webSocketConnectionProvider);
    } catch (e) {
      // Silently handle error
    }
  }
}

// Auth notifier provider
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

// Convenience providers
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authNotifierProvider).user;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isLoading;
});

final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authNotifierProvider).errorMessage;
});
