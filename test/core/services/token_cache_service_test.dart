import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:chattrix_ui/core/services/token_cache_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'token_cache_service_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late TokenCacheService tokenCacheService;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    tokenCacheService = TokenCacheService(mockSecureStorage);
  });

  group('TokenCacheService', () {
    const testAccessToken = 'test_access_token';
    const testRefreshToken = 'test_refresh_token';

    test('should return null when no tokens are cached or stored', () async {
      // Arrange
      when(mockSecureStorage.read(key: AppConstants.accessTokenKey)).thenAnswer((_) async => null);

      // Act
      final result = await tokenCacheService.getAccessToken();

      // Assert
      expect(result, isNull);
      verify(mockSecureStorage.read(key: AppConstants.accessTokenKey)).called(1);
    });

    test('should read access token from storage on first call', () async {
      // Arrange
      when(mockSecureStorage.read(key: AppConstants.accessTokenKey)).thenAnswer((_) async => testAccessToken);

      // Act
      final result = await tokenCacheService.getAccessToken();

      // Assert
      expect(result, testAccessToken);
      verify(mockSecureStorage.read(key: AppConstants.accessTokenKey)).called(1);
    });

    test('should return cached access token on subsequent calls without storage access', () async {
      // Arrange
      when(mockSecureStorage.read(key: AppConstants.accessTokenKey)).thenAnswer((_) async => testAccessToken);

      // Act - First call reads from storage
      await tokenCacheService.getAccessToken();
      // Second call should use cache
      final result = await tokenCacheService.getAccessToken();

      // Assert
      expect(result, testAccessToken);
      // Storage should only be accessed once
      verify(mockSecureStorage.read(key: AppConstants.accessTokenKey)).called(1);
    });

    test('should read refresh token from storage on first call', () async {
      // Arrange
      when(mockSecureStorage.read(key: AppConstants.refreshTokenKey)).thenAnswer((_) async => testRefreshToken);

      // Act
      final result = await tokenCacheService.getRefreshToken();

      // Assert
      expect(result, testRefreshToken);
      verify(mockSecureStorage.read(key: AppConstants.refreshTokenKey)).called(1);
    });

    test('should return cached refresh token on subsequent calls without storage access', () async {
      // Arrange
      when(mockSecureStorage.read(key: AppConstants.refreshTokenKey)).thenAnswer((_) async => testRefreshToken);

      // Act - First call reads from storage
      await tokenCacheService.getRefreshToken();
      // Second call should use cache
      final result = await tokenCacheService.getRefreshToken();

      // Assert
      expect(result, testRefreshToken);
      // Storage should only be accessed once
      verify(mockSecureStorage.read(key: AppConstants.refreshTokenKey)).called(1);
    });

    test('should set tokens in both cache and storage', () async {
      // Arrange
      when(
        mockSecureStorage.write(key: AppConstants.accessTokenKey, value: testAccessToken),
      ).thenAnswer((_) async => {});
      when(
        mockSecureStorage.write(key: AppConstants.refreshTokenKey, value: testRefreshToken),
      ).thenAnswer((_) async => {});

      // Act
      await tokenCacheService.setTokens(testAccessToken, testRefreshToken);

      // Assert
      verify(mockSecureStorage.write(key: AppConstants.accessTokenKey, value: testAccessToken)).called(1);
      verify(mockSecureStorage.write(key: AppConstants.refreshTokenKey, value: testRefreshToken)).called(1);

      // Verify tokens are cached by checking they can be retrieved without storage access
      final accessToken = await tokenCacheService.getAccessToken();
      final refreshToken = await tokenCacheService.getRefreshToken();

      expect(accessToken, testAccessToken);
      expect(refreshToken, testRefreshToken);
      // Storage read should not be called since tokens are in cache
      verifyNever(mockSecureStorage.read(key: AppConstants.accessTokenKey));
      verifyNever(mockSecureStorage.read(key: AppConstants.refreshTokenKey));
    });

    test('should clear tokens from both cache and storage', () async {
      // Arrange
      when(
        mockSecureStorage.write(key: AppConstants.accessTokenKey, value: testAccessToken),
      ).thenAnswer((_) async => {});
      when(
        mockSecureStorage.write(key: AppConstants.refreshTokenKey, value: testRefreshToken),
      ).thenAnswer((_) async => {});
      when(mockSecureStorage.delete(key: AppConstants.accessTokenKey)).thenAnswer((_) async => {});
      when(mockSecureStorage.delete(key: AppConstants.refreshTokenKey)).thenAnswer((_) async => {});
      when(mockSecureStorage.read(key: AppConstants.accessTokenKey)).thenAnswer((_) async => null);
      when(mockSecureStorage.read(key: AppConstants.refreshTokenKey)).thenAnswer((_) async => null);

      // Set tokens first
      await tokenCacheService.setTokens(testAccessToken, testRefreshToken);

      // Act
      await tokenCacheService.clearTokens();

      // Assert
      verify(mockSecureStorage.delete(key: AppConstants.accessTokenKey)).called(1);
      verify(mockSecureStorage.delete(key: AppConstants.refreshTokenKey)).called(1);

      // Verify tokens are cleared from cache
      final accessToken = await tokenCacheService.getAccessToken();
      final refreshToken = await tokenCacheService.getRefreshToken();

      expect(accessToken, isNull);
      expect(refreshToken, isNull);
    });

    test('hasTokensInCache should return false when no tokens are cached', () {
      // Act
      final result = tokenCacheService.hasTokensInCache();

      // Assert
      expect(result, false);
    });

    test('hasTokensInCache should return true when tokens are cached', () async {
      // Arrange
      when(
        mockSecureStorage.write(key: AppConstants.accessTokenKey, value: testAccessToken),
      ).thenAnswer((_) async => {});
      when(
        mockSecureStorage.write(key: AppConstants.refreshTokenKey, value: testRefreshToken),
      ).thenAnswer((_) async => {});

      await tokenCacheService.setTokens(testAccessToken, testRefreshToken);

      // Act
      final result = tokenCacheService.hasTokensInCache();

      // Assert
      expect(result, true);
    });

    test('hasTokensInCache should return false after clearing tokens', () async {
      // Arrange
      when(
        mockSecureStorage.write(key: AppConstants.accessTokenKey, value: testAccessToken),
      ).thenAnswer((_) async => {});
      when(
        mockSecureStorage.write(key: AppConstants.refreshTokenKey, value: testRefreshToken),
      ).thenAnswer((_) async => {});
      when(mockSecureStorage.delete(key: AppConstants.accessTokenKey)).thenAnswer((_) async => {});
      when(mockSecureStorage.delete(key: AppConstants.refreshTokenKey)).thenAnswer((_) async => {});

      await tokenCacheService.setTokens(testAccessToken, testRefreshToken);

      // Act
      await tokenCacheService.clearTokens();
      final result = tokenCacheService.hasTokensInCache();

      // Assert
      expect(result, false);
    });
  });
}
