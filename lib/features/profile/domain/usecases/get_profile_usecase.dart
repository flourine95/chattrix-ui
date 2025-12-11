import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/profile/domain/entities/profile.dart';
import 'package:chattrix_ui/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, Profile>> call() async {
    return await repository.getProfile();
  }
}
