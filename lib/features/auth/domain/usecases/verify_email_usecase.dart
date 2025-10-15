import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

/// UseCase để xác thực email bằng OTP
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
