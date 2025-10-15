import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/failures.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth_usecases.dart';

// Providers for dependencies
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// Data source providers
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(client: ref.watch(httpClientProvider));
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(
    secureStorage: ref.watch(secureStorageProvider),
  );
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

final resendVerificationUseCaseProvider = Provider<ResendVerificationUseCase>((
  ref,
) {
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
        unauthorized: (message, errorCode) => message,
        notFound: (message, errorCode) => message,
        conflict: (message, errorCode) => message,
        rateLimitExceeded: (message) =>
            'Quá nhiều yêu cầu. Vui lòng thử lại sau.',
        unknown: (message) => message,
      );
    }

    // Fallback cho trường hợp không phải Failure object
    return 'Có lỗi xảy ra. Vui lòng thử lại.';
  }

  Future<bool> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(loginUseCaseProvider)(
      usernameOrEmail: usernameOrEmail,
      password: password,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getFailureMessage(failure),
        );
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
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getFailureMessage(failure),
        );
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

    final result = await ref.read(verifyEmailUseCaseProvider)(
      email: email,
      otp: otp,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getFailureMessage(failure),
        );
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

    final result = await ref.read(resendVerificationUseCaseProvider)(
      email: email,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getFailureMessage(failure),
        );
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
        state = state.copyWith(isLoading: false, clearUser: true);
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
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getFailureMessage(failure),
        );
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }

  Future<bool> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(resetPasswordUseCaseProvider)(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getFailureMessage(failure),
        );
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(changePasswordUseCaseProvider)(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getFailureMessage(failure),
        );
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
    state = AuthState();
  }

  Future<void> logoutAll() async {
    state = state.copyWith(isLoading: true);
    await ref.read(logoutAllUseCaseProvider)();
    state = AuthState();
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
