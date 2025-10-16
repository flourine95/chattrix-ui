import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, User>> call() async {
    return await repository.getCurrentUser();
  }
}
