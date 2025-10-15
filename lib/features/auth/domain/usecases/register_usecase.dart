import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

/// UseCase để xử lý đăng ký tài khoản mới
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
