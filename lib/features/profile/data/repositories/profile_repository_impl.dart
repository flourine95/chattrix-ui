import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/repositories/base_repository.dart';
import '../../../auth/data/mappers/user_mapper.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/update_profile_params.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource_impl.dart';
import '../models/update_profile_request.dart';

class ProfileRepositoryImpl extends BaseRepository implements ProfileRepository {
  final ProfileRemoteDataSourceImpl _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    return executeApiCall(() async {
      final userDto = await _remoteDataSource.getProfile();
      return userDto.toEntity();
    });
  }

  @override
  Future<Either<Failure, Profile>> updateProfile(UpdateProfileParams params) async {
    return executeApiCall(() async {
      final request = UpdateProfileRequest.fromParams(params);
      final userDto = await _remoteDataSource.updateProfile(request);
      return userDto.toEntity();
    });
  }
}
