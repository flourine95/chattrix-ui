import 'package:chattrix_ui/core/services/token_cache_service.dart';
import 'package:chattrix_ui/features/auth/domain/datasources/auth_local_datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final TokenCacheService tokenCacheService;

  AuthLocalDataSourceImpl({required this.tokenCacheService});

  @override
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await tokenCacheService.setTokens(accessToken, refreshToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return await tokenCacheService.getAccessToken();
  }

  @override
  Future<String?> getRefreshToken() async {
    return await tokenCacheService.getRefreshToken();
  }

  @override
  Future<void> deleteTokens() async {
    await tokenCacheService.clearTokens();
  }
}
