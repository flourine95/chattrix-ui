import 'dart:convert';

import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/auth/data/models/auth_tokens_model.dart';
import 'package:chattrix_ui/features/auth/data/models/user_model.dart';
import 'package:chattrix_ui/features/auth/domain/datasources/auth_remote_datasource.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.register}'),
        headers: {'Content-Type': ApiConstants.contentTypeJson},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'fullName': fullName,
        }),
      );

      await _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> verifyEmail({required String email, required String otp}) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.verifyEmail}'),
        headers: {'Content-Type': ApiConstants.contentTypeJson},
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      await _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> resendVerification({required String email}) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.resendVerification}'),
        headers: {'Content-Type': ApiConstants.contentTypeJson},
        body: jsonEncode({'email': email}),
      );

      await _handleResponse(response);
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
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.login}'),
        headers: {'Content-Type': ApiConstants.contentTypeJson},
        body: jsonEncode({
          'usernameOrEmail': usernameOrEmail,
          'password': password,
        }),
      );

      final data = await _handleResponse(response);
      return AuthTokensModel.fromJson(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> getCurrentUser(String accessToken) async {
    try {
      // Không cần truyền accessToken vào header thủ công
      // AuthHttpClient sẽ tự động thêm từ secure storage
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.me}'),
        // Bỏ header Authorization - để AuthHttpClient tự động thêm
      );

      final data = await _handleResponse(response);
      return UserModel.fromJson(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthTokensModel> refreshToken(String refreshToken) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.refresh}'),
        headers: {'Content-Type': ApiConstants.contentTypeJson},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      final data = await _handleResponse(response);
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
      // Bỏ Authorization header - để AuthHttpClient tự động thêm
      final response = await client.put(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.changePassword}'),
        headers: {'Content-Type': ApiConstants.contentTypeJson},
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        }),
      );

      await _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.forgotPassword}'),
        headers: {'Content-Type': ApiConstants.contentTypeJson},
        body: jsonEncode({'email': email}),
      );

      await _handleResponse(response);
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
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.resetPassword}'),
        headers: {'Content-Type': ApiConstants.contentTypeJson},
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'newPassword': newPassword,
        }),
      );

      await _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> logout(String accessToken) async {
    try {
      // Bỏ Authorization header - để AuthHttpClient tự động thêm
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.logout}'),
      );

      await _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> logoutAll(String accessToken) async {
    try {
      // Bỏ Authorization header - để AuthHttpClient tự động thêm
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.logoutAll}'),
      );

      await _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> _handleResponse(http.Response response) async {
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonResponse['data'];
    } else {
      final message = jsonResponse['message'] ?? 'An error occurred';
      final errors = jsonResponse['errors'] as List?;
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
    } else if (error is http.ClientException) {
      return NetworkException();
    } else {
      return ServerException(message: error.toString());
    }
  }
}
