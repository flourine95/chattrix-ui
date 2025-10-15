import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

/// UseCase để đổi mật khẩu
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
