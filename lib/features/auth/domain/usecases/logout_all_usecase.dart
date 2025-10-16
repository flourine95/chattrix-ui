import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutAllUseCase {
  final AuthRepository repository;

  LogoutAllUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.logoutAll();
  }
}
