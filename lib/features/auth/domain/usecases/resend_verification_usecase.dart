import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

/// UseCase để gửi lại mã OTP xác thực
class ResendVerificationUseCase {
  final AuthRepository repository;

  ResendVerificationUseCase(this.repository);

  Future<Either<Failure, void>> call({required String email}) async {
    return await repository.resendVerification(email: email);
  }
}
