import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:chattrix_ui/features/auth/domain/datasources/auth_local_datasource.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await secureStorage.write(key: AppConstants.accessTokenKey, value: accessToken);
    await secureStorage.write(key: AppConstants.refreshTokenKey, value: refreshToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: AppConstants.accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: AppConstants.refreshTokenKey);
  }

  @override
  Future<void> deleteTokens() async {
    await secureStorage.delete(key: AppConstants.accessTokenKey);
    await secureStorage.delete(key: AppConstants.refreshTokenKey);
  }
}
