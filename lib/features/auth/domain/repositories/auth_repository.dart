import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/entities/auth_tokens.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  });

  Future<Either<Failure, void>> verifyEmail({required String email, required String otp});

  Future<Either<Failure, void>> resendVerification({required String email});

  Future<Either<Failure, AuthTokens>> login({required String usernameOrEmail, required String password});

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, AuthTokens>> refreshToken();

  Future<Either<Failure, void>> changePassword({required String currentPassword, required String newPassword});

  Future<Either<Failure, void>> forgotPassword({required String email});

  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> logoutAll();

  Future<bool> isLoggedIn();
}
