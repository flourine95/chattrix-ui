import 'package:fpdart/fpdart.dart';

import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:chattrix_ui/features/profile/domain/entities/profile.dart';
import 'package:chattrix_ui/features/profile/domain/entities/update_profile_params.dart';
import 'package:chattrix_ui/features/profile/domain/repositories/profile_repository.dart';
import 'package:chattrix_ui/features/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:chattrix_ui/features/profile/data/models/update_profile_request.dart';

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
