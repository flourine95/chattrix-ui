import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordUseCase {
  final AuthRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<Either<Failure, void>> call({required String currentPassword, required String newPassword}) async {
    return await repository.changePassword(currentPassword: currentPassword, newPassword: newPassword);
  }
}
