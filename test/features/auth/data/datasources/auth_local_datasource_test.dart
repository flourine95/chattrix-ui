import 'package:chattrix_ui/core/services/token_cache_service.dart';
import 'package:chattrix_ui/features/auth/data/datasources/auth_local_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_local_datasource_test.mocks.dart';

@GenerateMocks([TokenCacheService])
void main() {
  late AuthLocalDataSourceImpl dataSource;
  late MockTokenCacheService mockTokenCacheService;

  setUp(() {
    mockTokenCacheService = MockTokenCacheService();
    dataSource = AuthLocalDataSourceImpl(tokenCacheService: mockTokenCacheService);
  });

  group('AuthLocalDataSourceImpl', () {
    const testAccessToken = 'test_access_token';
    const testRefreshToken = 'test_refresh_token';

    test('saveTokens should call tokenCacheService.setTokens', () async {
      // Arrange
      when(mockTokenCacheService.setTokens(any, any)).thenAnswer((_) async => Future.value());

      // Act
      await dataSource.saveTokens(accessToken: testAccessToken, refreshToken: testRefreshToken);

      // Assert
      verify(mockTokenCacheService.setTokens(testAccessToken, testRefreshToken)).called(1);
    });

    test('getAccessToken should call tokenCacheService.getAccessToken', () async {
      // Arrange
      when(mockTokenCacheService.getAccessToken()).thenAnswer((_) async => testAccessToken);

      // Act
      final result = await dataSource.getAccessToken();

      // Assert
      expect(result, testAccessToken);
      verify(mockTokenCacheService.getAccessToken()).called(1);
    });

    test('getRefreshToken should call tokenCacheService.getRefreshToken', () async {
      // Arrange
      when(mockTokenCacheService.getRefreshToken()).thenAnswer((_) async => testRefreshToken);

      // Act
      final result = await dataSource.getRefreshToken();

      // Assert
      expect(result, testRefreshToken);
      verify(mockTokenCacheService.getRefreshToken()).called(1);
    });

    test('deleteTokens should call tokenCacheService.clearTokens', () async {
      // Arrange
      when(mockTokenCacheService.clearTokens()).thenAnswer((_) async => Future.value());

      // Act
      await dataSource.deleteTokens();

      // Assert
      verify(mockTokenCacheService.clearTokens()).called(1);
    });

    test('getAccessToken should return null when token is not available', () async {
      // Arrange
      when(mockTokenCacheService.getAccessToken()).thenAnswer((_) async => null);

      // Act
      final result = await dataSource.getAccessToken();

      // Assert
      expect(result, null);
      verify(mockTokenCacheService.getAccessToken()).called(1);
    });

    test('getRefreshToken should return null when token is not available', () async {
      // Arrange
      when(mockTokenCacheService.getRefreshToken()).thenAnswer((_) async => null);

      // Act
      final result = await dataSource.getRefreshToken();

      // Assert
      expect(result, null);
      verify(mockTokenCacheService.getRefreshToken()).called(1);
    });
  });
}
