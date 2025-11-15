import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/entities/auth_tokens.dart';
import 'package:chattrix_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthTokens>> call({required String usernameOrEmail, required String password}) async {
    return await repository.login(usernameOrEmail: usernameOrEmail, password: password);
  }
}
