import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/auth_tokens_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> verifyEmail({required String email, required String otp});

  Future<void> resendVerification({required String email});

  Future<AuthTokensModel> login({
    required String usernameOrEmail,
    required String password,
  });

  Future<UserModel> getCurrentUser(String accessToken);

  Future<AuthTokensModel> refreshToken(String refreshToken);

  Future<void> changePassword({
    required String accessToken,
    required String currentPassword,
    required String newPassword,
  });

  Future<void> forgotPassword({required String email});

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });

  Future<void> logout(String accessToken);

  Future<void> logoutAll(String accessToken);
}

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
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.me}'),
        headers: {'Authorization': '${ApiConstants.bearer} $accessToken'},
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
      final response = await client.put(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.changePassword}'),
        headers: {
          'Authorization': '${ApiConstants.bearer} $accessToken',
          'Content-Type': ApiConstants.contentTypeJson,
        },
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
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.logout}'),
        headers: {'Authorization': '${ApiConstants.bearer} $accessToken'},
      );

      await _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> logoutAll(String accessToken) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.logoutAll}'),
        headers: {'Authorization': '${ApiConstants.bearer} $accessToken'},
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
