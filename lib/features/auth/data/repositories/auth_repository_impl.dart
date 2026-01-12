import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:chattrix_ui/features/auth/domain/datasources/auth_local_datasource.dart';
import 'package:chattrix_ui/features/auth/domain/datasources/auth_remote_datasource.dart';
import 'package:chattrix_ui/features/auth/domain/entities/auth_tokens.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../mappers/auth_tokens_mapper.dart';
import '../mappers/user_mapper.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, void>> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    return executeApiCall(() async {
      await remoteDataSource.register(username: username, email: email, password: password, fullName: fullName);
    });
  }

  @override
  Future<Either<Failure, void>> verifyEmail({required String email, required String otp}) async {
    return executeApiCall(() async {
      await remoteDataSource.verifyEmail(email: email, otp: otp);
    });
  }

  @override
  Future<Either<Failure, void>> resendVerification({required String email}) async {
    return executeApiCall(() async {
      await remoteDataSource.resendVerification(email: email);
    });
  }

  @override
  Future<Either<Failure, AuthTokens>> login({required String usernameOrEmail, required String password}) async {
    return executeApiCall(() async {
      final tokensDto = await remoteDataSource.login(usernameOrEmail: usernameOrEmail, password: password);

      // Save tokens to secure storage
      await localDataSource.saveTokens(accessToken: tokensDto.accessToken, refreshToken: tokensDto.refreshToken);

      return tokensDto.toEntity();
    });
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    return executeApiCall(() async {
      final userDto = await remoteDataSource.getCurrentUser('');
      return userDto.toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthTokens>> refreshToken() async {
    return executeApiCall(() async {
      final refreshToken = await localDataSource.getRefreshToken();
      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final tokensDto = await remoteDataSource.refreshToken(refreshToken);

      // Save new tokens
      await localDataSource.saveTokens(accessToken: tokensDto.accessToken, refreshToken: tokensDto.refreshToken);

      return tokensDto.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> changePassword({required String currentPassword, required String newPassword}) async {
    return executeApiCall(() async {
      await remoteDataSource.changePassword(
        accessToken: '',
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    });
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    return executeApiCall(() async {
      await remoteDataSource.forgotPassword(email: email);
    });
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    return executeApiCall(() async {
      await remoteDataSource.resetPassword(email: email, otp: otp, newPassword: newPassword);
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return executeApiCall(() async {
      try {
        await remoteDataSource.logout('');
      } finally {
        // Always clear local tokens, even if server logout fails
        await localDataSource.deleteTokens();
      }
    });
  }

  @override
  Future<Either<Failure, void>> logoutAll() async {
    return executeApiCall(() async {
      try {
        await remoteDataSource.logoutAll('');
      } finally {
        // Always clear local tokens, even if server logout fails
        await localDataSource.deleteTokens();
      }
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    final accessToken = await localDataSource.getAccessToken();
    return accessToken != null;
  }
}
