import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String otp,
  }) async {
    return await repository.verifyEmail(email: email, otp: otp);
  }
}
