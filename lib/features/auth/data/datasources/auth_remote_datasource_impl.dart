import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/auth/data/models/auth_tokens_model.dart';
import 'package:chattrix_ui/features/auth/data/models/user_model.dart';
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
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.register}',
        data: {
          'username': username,
          'email': email,
          'password': password,
          'fullName': fullName,
        },
      );

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> verifyEmail({required String email, required String otp}) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.verifyEmail}',
        data: {'email': email, 'otp': otp},
      );

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> resendVerification({required String email}) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.resendVerification}',
        data: {'email': email},
      );

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthTokensModel> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.login}',
        data: {'usernameOrEmail': usernameOrEmail, 'password': password},
      );

      final data = _handleResponse(response);
      return AuthTokensModel.fromJson(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> getCurrentUser(String accessToken) async {
    try {
      // Không cần truyền accessToken vào header thủ công
      // AuthDioClient sẽ tự động thêm từ secure storage
      final response = await dio.get(
        '${ApiConstants.baseUrl}/${ApiConstants.me}',
      );

      final data = _handleResponse(response);
      return UserModel.fromJson(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthTokensModel> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.refresh}',
        data: {'refreshToken': refreshToken},
      );

      final data = _handleResponse(response);
      return AuthTokensModel.fromJson(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> changePassword({
    required String accessToken,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // Bỏ Authorization header - để AuthDioClient tự động thêm
      final response = await dio.put(
        '${ApiConstants.baseUrl}/${ApiConstants.changePassword}',
        data: {'currentPassword': currentPassword, 'newPassword': newPassword},
      );

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.forgotPassword}',
        data: {'email': email},
      );

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.resetPassword}',
        data: {'email': email, 'otp': otp, 'newPassword': newPassword},
      );

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> logout(String accessToken) async {
    try {
      // Bỏ Authorization header - để AuthDioClient tự động thêm
      final response = await dio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.logout}',
      );

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> logoutAll(String accessToken) async {
    try {
      // Bỏ Authorization header - để AuthDioClient tự động thêm
      final response = await dio.post(
        '${ApiConstants.baseUrl}/${ApiConstants.logoutAll}',
      );

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data['data'];
    } else {
      final message = response.data['message'] ?? 'An error occurred';
      final errors = response.data['errors'] as List?;
      final errorCode = errors?.isNotEmpty == true
          ? errors!.first['errorCode'] as String?
          : null;

      throw ServerException(
        message: message,
        errorCode: errorCode,
        statusCode: response.statusCode,
      );
    }
  }

  Exception _handleError(dynamic error) {
    if (error is ServerException) {
      return error;
    } else if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        return NetworkException();
      }

      // Handle response errors
      if (error.response != null) {
        final message = error.response?.data['message'] ?? 'An error occurred';
        final errors = error.response?.data['errors'] as List?;
        final errorCode = errors?.isNotEmpty == true
            ? errors!.first['errorCode'] as String?
            : null;

        return ServerException(
          message: message,
          errorCode: errorCode,
          statusCode: error.response?.statusCode,
        );
      }

      return NetworkException();
    } else {
      return ServerException(message: error.toString());
    }
  }
}
