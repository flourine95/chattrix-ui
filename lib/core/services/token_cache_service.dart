import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:chattrix_ui/core/services/performance_monitor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenCacheService {
  String? _accessToken;
  String? _refreshToken;

  // Khóa để tránh việc nhiều luồng cùng đọc Token một lúc
  Future<String?>? _accessTokenFuture;

  final FlutterSecureStorage _secureStorage;

  TokenCacheService(this._secureStorage);

  Future<String?> getAccessToken() async {
    // 1. Ưu tiên lấy từ RAM (Nhanh nhất)
    if (_accessToken != null && _accessToken!.isNotEmpty) {
      return _accessToken;
    }

    // 2. Nếu đang có luồng khác đi lấy, thì chờ ké
    if (_accessTokenFuture != null) {
      return _accessTokenFuture;
    }

    // 3. Bắt đầu đi lấy an toàn
    _accessTokenFuture = _readAccessTokenSafe();
    return _accessTokenFuture;
  }

  // 🔥 HÀM QUAN TRỌNG: Đọc an toàn, bất chấp lỗi
  Future<String?> _readAccessTokenSafe() async {
    try {
      final token = await PerformanceMonitor.measureAsync(
        'getAccessToken',
            () => _secureStorage.read(key: AppConstants.accessTokenKey),
      );

      if (token != null && token.isNotEmpty) {
        _accessToken = token;
      }
      return token;
    } catch (e) {
      // ⚠️ ĐÂY LÀ CHỖ CỨU APP CỦA BẠN KHỎI MÀN HÌNH TRẮNG
      // Nếu gặp lỗi (OperationError), coi như dữ liệu hỏng -> Xóa sạch để reset
      debugPrint('⚠️ [TokenCache] Storage corrupted. Resetting... Error: $e');
      await clearTokens();
      return null; // Trả về null để App hiểu là chưa đăng nhập -> Về màn hình Login
    } finally {
      _accessTokenFuture = null;
    }
  }

  Future<String?> getRefreshToken() async {
    if (_refreshToken != null && _refreshToken!.isNotEmpty) {
      return _refreshToken;
    }

    try {
      final token = await PerformanceMonitor.measureAsync(
        'getRefreshToken',
            () => _secureStorage.read(key: AppConstants.refreshTokenKey),
      );

      if (token != null && token.isNotEmpty) {
        _refreshToken = token;
      }
      return token;
    } catch (e) {
      debugPrint('⚠️ [TokenCache] Refresh token corrupted: $e');
      return null;
    }
  }

  Future<void> setTokens(String accessToken, String refreshToken) async {
    debugPrint('🔄 [TokenCache] Updating tokens...');
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    try {
      await PerformanceMonitor.measureAsync(
        'setTokens',
            () => Future.wait([
          _secureStorage.write(key: AppConstants.accessTokenKey, value: accessToken),
          _secureStorage.write(key: AppConstants.refreshTokenKey, value: refreshToken),
        ]),
      );
    } catch (e) {
      debugPrint('❌ [TokenCache] Failed to write tokens: $e');
    }
  }

  Future<void> clearTokens() async {
    debugPrint('🧹 [TokenCache] Clearing tokens...');
    _accessToken = null;
    _refreshToken = null;
    _accessTokenFuture = null;

    try {
      await Future.wait([
        _secureStorage.delete(key: AppConstants.accessTokenKey),
        _secureStorage.delete(key: AppConstants.refreshTokenKey),
      ]);
    } catch (e) {
      debugPrint('⚠️ [TokenCache] Failed to clear storage (might be already empty): $e');
    }
  }

  bool hasTokensInCache() => _accessToken != null && _refreshToken != null;
}