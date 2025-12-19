import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenCacheService {
  final FlutterSecureStorage _secureStorage;

  TokenCacheService(this._secureStorage);

  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read(key: AppConstants.accessTokenKey);
    } catch (e) {
      debugPrint('⚠️ [TokenCache] Failed to read access token: $e');
      return null;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: AppConstants.refreshTokenKey);
    } catch (e) {
      debugPrint('⚠️ [TokenCache] Failed to read refresh token: $e');
      return null;
    }
  }

  Future<void> setTokens(String accessToken, String refreshToken) async {
    try {
      await Future.wait([
        _secureStorage.write(key: AppConstants.accessTokenKey, value: accessToken),
        _secureStorage.write(key: AppConstants.refreshTokenKey, value: refreshToken),
      ]);
    } catch (e) {
      debugPrint('❌ [TokenCache] Failed to write tokens: $e');
      rethrow;
    }
  }

  Future<void> clearTokens() async {
    try {
      await Future.wait([
        _secureStorage.delete(key: AppConstants.accessTokenKey),
        _secureStorage.delete(key: AppConstants.refreshTokenKey),
      ]);
    } catch (e) {
      debugPrint('⚠️ [TokenCache] Failed to clear storage: $e');
    }
  }
}
