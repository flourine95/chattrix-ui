import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_tokens.dart';
import '../repositories/auth_repository.dart';

/// UseCase để làm mới access token
class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  Future<Either<Failure, AuthTokens>> call() async {
    return await repository.refreshToken();
  }
}
