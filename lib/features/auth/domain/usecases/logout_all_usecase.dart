import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

/// UseCase để đăng xuất tất cả thiết bị
class LogoutAllUseCase {
  final AuthRepository repository;

  LogoutAllUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.logoutAll();
  }
}
