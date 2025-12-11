import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/profile/domain/entities/profile.dart';
import 'package:chattrix_ui/features/profile/domain/entities/update_profile_params.dart';
import 'package:chattrix_ui/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, Profile>> call(UpdateProfileParams params) async {
    return await repository.updateProfile(params);
  }
}
