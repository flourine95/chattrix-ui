import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/auth/domain/datasources/auth_local_datasource.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await secureStorage.write(
      key: ApiConstants.accessTokenKey,
      value: accessToken,
    );
    await secureStorage.write(
      key: ApiConstants.refreshTokenKey,
      value: refreshToken,
    );
  }

  @override
  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: ApiConstants.accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: ApiConstants.refreshTokenKey);
  }

  @override
  Future<void> deleteTokens() async {
    await secureStorage.delete(key: ApiConstants.accessTokenKey);
    await secureStorage.delete(key: ApiConstants.refreshTokenKey);
  }
}
