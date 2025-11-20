import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:chattrix_ui/core/services/performance_monitor.dart';

/// Service for caching JWT tokens in memory to avoid repeated secure storage access.
/// Implements a cache-first read strategy with fallback to secure storage.
class TokenCacheService {
  String? _accessToken;
  String? _refreshToken;
  final FlutterSecureStorage _secureStorage;

  TokenCacheService(this._secureStorage);

  /// Get access token from cache or storage.
  /// Uses cache-first strategy: returns cached token if available,
  /// otherwise reads from secure storage and caches the result.
  Future<String?> getAccessToken() async {
    if (_accessToken != null) {
      if (kDebugMode) {
        print('🔑 [TokenCache] Access token retrieved from cache');
      }
      return _accessToken;
    }

    if (kDebugMode) {
      print('🔑 [TokenCache] Access token not in cache, reading from storage');
    }

    _accessToken = await PerformanceMonitor.measureAsync(
      'getAccessToken (storage read)',
      () => _secureStorage.read(key: AppConstants.accessTokenKey),
    );
    return _accessToken;
  }

  /// Get refresh token from cache or storage.
  /// Uses cache-first strategy: returns cached token if available,
  /// otherwise reads from secure storage and caches the result.
  Future<String?> getRefreshToken() async {
    if (_refreshToken != null) {
      if (kDebugMode) {
        print('🔑 [TokenCache] Refresh token retrieved from cache');
      }
      return _refreshToken;
    }

    if (kDebugMode) {
      print('🔑 [TokenCache] Refresh token not in cache, reading from storage');
    }

    _refreshToken = await PerformanceMonitor.measureAsync(
      'getRefreshToken (storage read)',
      () => _secureStorage.read(key: AppConstants.refreshTokenKey),
    );
    return _refreshToken;
  }

  /// Set both tokens in cache and storage.
  /// Updates the in-memory cache immediately and writes to secure storage asynchronously.
  Future<void> setTokens(String accessToken, String refreshToken) async {
    if (kDebugMode) {
      print('🔑 [TokenCache] Setting tokens in cache and storage');
    }

    // Update cache immediately
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    // Write to storage asynchronously
    await PerformanceMonitor.measureAsync(
      'setTokens (storage write)',
      () => Future.wait([
        _secureStorage.write(key: AppConstants.accessTokenKey, value: accessToken),
        _secureStorage.write(key: AppConstants.refreshTokenKey, value: refreshToken),
      ]),
    );

    if (kDebugMode) {
      print('✅ [TokenCache] Tokens saved to cache and storage');
    }
  }

  /// Clear all tokens from cache and storage.
  /// Removes tokens from both in-memory cache and secure storage.
  Future<void> clearTokens() async {
    if (kDebugMode) {
      print('🗑️  [TokenCache] Clearing tokens from cache and storage');
    }

    // Clear cache immediately
    _accessToken = null;
    _refreshToken = null;

    // Clear storage asynchronously
    await Future.wait([
      _secureStorage.delete(key: AppConstants.accessTokenKey),
      _secureStorage.delete(key: AppConstants.refreshTokenKey),
    ]);

    if (kDebugMode) {
      print('✅ [TokenCache] Tokens cleared from cache and storage');
    }
  }

  /// Check if tokens are cached in memory.
  /// Returns true if both access and refresh tokens are present in cache.
  bool hasTokensInCache() {
    return _accessToken != null && _refreshToken != null;
  }
}
