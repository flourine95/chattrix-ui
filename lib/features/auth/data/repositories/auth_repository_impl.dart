import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/datasources/auth_local_datasource.dart';
import '../../domain/datasources/auth_remote_datasource.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      await remoteDataSource.register(
        username: username,
        email: email,
        password: password,
        fullName: fullName,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      await remoteDataSource.verifyEmail(email: email, otp: otp);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resendVerification({
    required String email,
  }) async {
    try {
      await remoteDataSource.resendVerification(email: email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthTokens>> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    try {
      final tokensModel = await remoteDataSource.login(
        usernameOrEmail: usernameOrEmail,
        password: password,
      );

      // Save tokens to secure storage
      await localDataSource.saveTokens(
        accessToken: tokensModel.accessToken,
        refreshToken: tokensModel.refreshToken,
      );

      return Right(tokensModel.toEntity());
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      // Bỏ việc check accessToken ở đây
      // Để AuthHttpClient tự động lấy từ storage và auto-refresh nếu cần
      final userModel = await remoteDataSource.getCurrentUser(
        '',
      ); // Pass empty string
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthTokens>> refreshToken() async {
    try {
      final refreshToken = await localDataSource.getRefreshToken();
      if (refreshToken == null) {
        return const Left(Failure.unauthorized(message: 'No refresh token'));
      }

      final tokensModel = await remoteDataSource.refreshToken(refreshToken);

      // Save new tokens
      await localDataSource.saveTokens(
        accessToken: tokensModel.accessToken,
        refreshToken: tokensModel.refreshToken,
      );

      return Right(tokensModel.toEntity());
    } on ServerException catch (e) {
      // If refresh token is invalid, clear stored tokens
      await localDataSource.deleteTokens();
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // Bỏ check accessToken - để AuthHttpClient tự xử lý
      await remoteDataSource.changePassword(
        accessToken: '', // Pass empty string
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    try {
      await remoteDataSource.forgotPassword(email: email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Bỏ check accessToken - để AuthHttpClient tự xử lý
      await remoteDataSource.logout(''); // Pass empty string

      await localDataSource.deleteTokens();
      return const Right(null);
    } on ServerException catch (e) {
      // Even if server logout fails, clear local tokens
      await localDataSource.deleteTokens();
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      // Even if network fails, clear local tokens
      await localDataSource.deleteTokens();
      return Left(Failure.network(message: e.message));
    } catch (e) {
      await localDataSource.deleteTokens();
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logoutAll() async {
    try {
      // Bỏ check accessToken - để AuthHttpClient tự xử lý
      await remoteDataSource.logoutAll(''); // Pass empty string
      await localDataSource.deleteTokens();

      return const Right(null);
    } on ServerException catch (e) {
      // Even if server logout fails, clear local tokens
      await localDataSource.deleteTokens();
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      await localDataSource.deleteTokens();
      return Left(Failure.network(message: e.message));
    } catch (e) {
      await localDataSource.deleteTokens();
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final accessToken = await localDataSource.getAccessToken();
    return accessToken != null;
  }

  Failure _mapServerExceptionToFailure(ServerException exception) {
    switch (exception.statusCode) {
      case 400:
        return Failure.validation(message: exception.message);
      case 401:
        return Failure.unauthorized(
          message: exception.message,
          errorCode: exception.errorCode,
        );
      case 404:
        return Failure.notFound(
          message: exception.message,
          errorCode: exception.errorCode,
        );
      case 409:
        return Failure.conflict(
          message: exception.message,
          errorCode: exception.errorCode,
        );
      case 429:
        return Failure.rateLimitExceeded(message: exception.message);
      default:
        return Failure.server(
          message: exception.message,
          errorCode: exception.errorCode,
        );
    }
  }
}
