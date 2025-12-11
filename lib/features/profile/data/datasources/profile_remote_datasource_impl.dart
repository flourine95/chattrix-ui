import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/profile/data/models/profile_model.dart';
import 'package:chattrix_ui/features/profile/data/models/update_profile_request.dart';
import 'package:chattrix_ui/features/profile/domain/datasources/profile_remote_datasource.dart';
import 'package:dio/dio.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl({required this.dio});

  @override
  Future<ProfileModel> getProfile() async {
    final response = await dio.get(ApiConstants.getProfile);
    return ProfileModel.fromJson(response.data['data']);
  }

  @override
  Future<ProfileModel> updateProfile(UpdateProfileRequest request) async {
    final response = await dio.put(ApiConstants.updateProfile, data: request.toJson());
    return ProfileModel.fromJson(response.data['data']);
  }
}
