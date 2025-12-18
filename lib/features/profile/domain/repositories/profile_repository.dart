import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/profile.dart';
import '../entities/update_profile_params.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();

  Future<Either<Failure, Profile>> updateProfile(UpdateProfileParams params);
}
