import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/network/models/api_response.dart';
import 'package:chattrix_ui/core/network/models/api_response_extensions.dart';
import 'package:chattrix_ui/features/auth/data/models/auth_tokens_dto.dart';
import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';
import 'package:chattrix_ui/features/auth/domain/datasources/auth_remote_datasource.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await dio.post(
      ApiConstants.register,
      data: {'username': username, 'email': email, 'password': password, 'fullName': fullName},
    );
    final apiResponse = ApiResponse<void>.fromJson(response.data, (data) {});
    apiResponse.getDataOrThrow();
  }

  @override
  Future<void> verifyEmail({required String email, required String otp}) async {
    final response = await dio.post(ApiConstants.verifyEmail, data: {'email': email, 'otp': otp});
    final apiResponse = ApiResponse<void>.fromJson(response.data, (data) {});
    apiResponse.getDataOrThrow();
  }

  @override
  Future<void> resendVerification({required String email}) async {
    final response = await dio.post(ApiConstants.resendVerification, data: {'email': email});
    final apiResponse = ApiResponse<void>.fromJson(response.data, (data) {});
    apiResponse.getDataOrThrow();
  }

  @override
  Future<AuthTokensDto> login({required String usernameOrEmail, required String password}) async {
    final response = await dio.post(
      ApiConstants.login,
      data: {'usernameOrEmail': usernameOrEmail, 'password': password},
    );
    final apiResponse = ApiResponse<AuthTokensDto>.fromJson(
      response.data,
      (data) => AuthTokensDto.fromJson(data as Map<String, dynamic>),
    );
    return apiResponse.getDataOrThrow();
  }

  @override
  Future<UserDto> getCurrentUser(String accessToken) async {
    final response = await dio.get(ApiConstants.me);
    final apiResponse = ApiResponse<UserDto>.fromJson(
      response.data,
      (data) => UserDto.fromJson(data as Map<String, dynamic>),
    );
    return apiResponse.getDataOrThrow();
  }

  @override
  Future<AuthTokensDto> refreshToken(String refreshToken) async {
    final response = await dio.post(ApiConstants.refresh, data: {'refreshToken': refreshToken});
    final apiResponse = ApiResponse<AuthTokensDto>.fromJson(
      response.data,
      (data) => AuthTokensDto.fromJson(data as Map<String, dynamic>),
    );
    return apiResponse.getDataOrThrow();
  }

  @override
  Future<void> changePassword({
    required String accessToken,
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await dio.put(
      ApiConstants.changePassword,
      data: {'currentPassword': currentPassword, 'newPassword': newPassword},
    );
    final apiResponse = ApiResponse<void>.fromJson(response.data, (data) {});
    apiResponse.getDataOrThrow();
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    final response = await dio.post(ApiConstants.forgotPassword, data: {'email': email});
    final apiResponse = ApiResponse<void>.fromJson(response.data, (data) {});
    apiResponse.getDataOrThrow();
  }

  @override
  Future<void> resetPassword({required String email, required String otp, required String newPassword}) async {
    final response = await dio.post(
      ApiConstants.resetPassword,
      data: {'email': email, 'otp': otp, 'newPassword': newPassword},
    );
    final apiResponse = ApiResponse<void>.fromJson(response.data, (data) {});
    apiResponse.getDataOrThrow();
  }

  @override
  Future<void> logout(String accessToken) async {
    final response = await dio.post(ApiConstants.logout);
    final apiResponse = ApiResponse<void>.fromJson(response.data, (data) {});
    apiResponse.getDataOrThrow();
  }

  @override
  Future<void> logoutAll(String accessToken) async {
    final response = await dio.post(ApiConstants.logoutAll);
    final apiResponse = ApiResponse<void>.fromJson(response.data, (data) {});
    apiResponse.getDataOrThrow();
  }
}
