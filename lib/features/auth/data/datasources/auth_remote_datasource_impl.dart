import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/network/models/api_response.dart';
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
        ApiConstants.register,
        data: {'username': username, 'email': email, 'password': password, 'fullName': fullName},
      );

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> verifyEmail({required String email, required String otp}) async {
    try {
      final response = await dio.post(ApiConstants.verifyEmail, data: {'email': email, 'otp': otp});

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> resendVerification({required String email}) async {
    try {
      final response = await dio.post(ApiConstants.resendVerification, data: {'email': email});

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthTokensModel> login({required String usernameOrEmail, required String password}) async {
    try {
      final response = await dio.post(
        ApiConstants.login,
        data: {'usernameOrEmail': usernameOrEmail, 'password': password},
      );

      // Parse as ApiResponse
      final apiResponse = ApiResponse<AuthTokensModel>.fromJson(
        response.data,
        (data) => AuthTokensModel.fromJson(data as Map<String, dynamic>),
      );

      // Check if successful
      if (apiResponse.isSuccess) {
        return apiResponse.data!;
      } else {
        // Convert error to exception
        throw _apiResponseToException(apiResponse);
      }
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> getCurrentUser(String accessToken) async {
    try {
      final response = await dio.get(ApiConstants.me);

      final data = _handleResponse(response);
      return UserModel.fromJson(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthTokensModel> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(ApiConstants.refresh, data: {'refreshToken': refreshToken});

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
      final response = await dio.put(
        ApiConstants.changePassword,
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
      final response = await dio.post(ApiConstants.forgotPassword, data: {'email': email});

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> resetPassword({required String email, required String otp, required String newPassword}) async {
    try {
      final response = await dio.post(
        ApiConstants.resetPassword,
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
      final response = await dio.post(ApiConstants.logout);

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> logoutAll(String accessToken) async {
    try {
      final response = await dio.post(ApiConstants.logoutAll);

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data['data'];
    } else {
      final errorData = response.data['error'];
      final message = errorData?['message'] ?? response.data['message'] ?? 'An error occurred';
      final errorCode = errorData?['code'] as String?;

      throw ServerException(message: message, errorCode: errorCode, statusCode: response.statusCode);
    }
  }

  /// Convert ApiResponse error to ServerException
  ServerException _apiResponseToException(ApiResponse apiResponse) {
    return ServerException(
      message: apiResponse.message ?? 'An error occurred',
      errorCode: apiResponse.code,
      statusCode: null, // We don't have HTTP status code from parsed response
    );
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

      if (error.response != null) {
        final errorData = error.response?.data['error'];
        final message = errorData?['message'] ?? error.response?.data['message'] ?? 'An error occurred';
        final errorCode = errorData?['code'] as String?;

        return ServerException(message: message, errorCode: errorCode, statusCode: error.response?.statusCode);
      }

      return NetworkException();
    } else {
      return ServerException(message: error.toString());
    }
  }
}
