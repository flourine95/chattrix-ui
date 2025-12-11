import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/profile/data/models/update_profile_request.dart';
import 'package:chattrix_ui/features/profile/domain/datasources/profile_remote_datasource.dart';
import 'package:chattrix_ui/features/profile/domain/entities/profile.dart';
import 'package:chattrix_ui/features/profile/domain/entities/update_profile_params.dart';
import 'package:chattrix_ui/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    try {
      final profileModel = await remoteDataSource.getProfile();
      return Right(profileModel.toEntity());
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Left(Failure.unauthorized(message: 'Unauthorized'));
      }
      return Left(Failure.server(message: e.response?.data['message'] ?? 'Failed to get profile'));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> updateProfile(UpdateProfileParams params) async {
    try {
      final request = UpdateProfileRequest.fromParams(params);
      final profileModel = await remoteDataSource.updateProfile(request);
      return Right(profileModel.toEntity());
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Left(Failure.unauthorized(message: 'Unauthorized'));
      }
      return Left(Failure.server(message: e.response?.data['message'] ?? 'Failed to update profile'));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }
}

