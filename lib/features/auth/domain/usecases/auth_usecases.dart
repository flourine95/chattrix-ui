import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_tokens.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthTokens>> call({
    required String usernameOrEmail,
    required String password,
  }) async {
    return await repository.login(
      usernameOrEmail: usernameOrEmail,
      password: password,
    );
  }
}

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    return await repository.register(
      username: username,
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}

class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String otp,
  }) async {
    return await repository.verifyEmail(email: email, otp: otp);
  }
}

class ResendVerificationUseCase {
  final AuthRepository repository;

  ResendVerificationUseCase(this.repository);

  Future<Either<Failure, void>> call({required String email}) async {
    return await repository.resendVerification(email: email);
  }
}

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, dynamic>> call() async {
    return await repository.getCurrentUser();
  }
}

class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  Future<Either<Failure, AuthTokens>> call() async {
    return await repository.refreshToken();
  }
}

class ChangePasswordUseCase {
  final AuthRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call({required String email}) async {
    return await repository.forgotPassword(email: email);
  }
}

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    return await repository.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );
  }
}

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}

class LogoutAllUseCase {
  final AuthRepository repository;

  LogoutAllUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.logoutAll();
  }
}

class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase(this.repository);

  Future<bool> call() async {
    return await repository.isLoggedIn();
  }
}
