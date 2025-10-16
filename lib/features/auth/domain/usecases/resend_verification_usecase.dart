import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ResendVerificationUseCase {
  final AuthRepository repository;

  ResendVerificationUseCase(this.repository);

  Future<Either<Failure, void>> call({required String email}) async {
    return await repository.resendVerification(email: email);
  }
}
