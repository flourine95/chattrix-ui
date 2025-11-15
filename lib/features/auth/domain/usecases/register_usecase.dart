import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    return await repository.register(username: username, email: email, password: password, fullName: fullName);
  }
}
