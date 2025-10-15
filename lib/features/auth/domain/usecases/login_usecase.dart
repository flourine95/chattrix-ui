import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_tokens.dart';
import '../repositories/auth_repository.dart';

/// UseCase để xử lý đăng nhập
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
