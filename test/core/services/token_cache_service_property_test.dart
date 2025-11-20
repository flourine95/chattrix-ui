import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:chattrix_ui/core/services/token_cache_service.dart';
import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'token_cache_service_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late MockFlutterSecureStorage mockSecureStorage;
  final faker = Faker();

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
  });

  group('Property-Based Tests - Token Cache Consistency', () {
    /// **Feature: flutter-main-thread-optimization, Property 5: Token cache avoids repeated storage access**
    /// **Validates: Requirements 2.1**
    test('Property 5: Token cache avoids repeated storage access', () async {
      // Run 100+ iterations with random token values and read counts
      for (int i = 0; i < 100; i++) {
        // Generate random tokens
        final accessToken = faker.jwt.valid();
        final refreshToken = faker.jwt.valid();

        // Generate random number of subsequent reads (2-10)
        final numberOfReads = faker.randomGenerator.integer(10, min: 2);

        // Create a fresh service instance for each iteration
        final tokenCacheService = TokenCacheService(mockSecureStorage);

        // Mock storage operations - storage should only be accessed once
        when(mockSecureStorage.read(key: AppConstants.accessTokenKey)).thenAnswer((_) async => accessToken);
        when(mockSecureStorage.read(key: AppConstants.refreshTokenKey)).thenAnswer((_) async => refreshToken);

        // Act: Perform multiple reads
        final accessTokenResults = <String?>[];
        final refreshTokenResults = <String?>[];

        for (int readIndex = 0; readIndex < numberOfReads; readIndex++) {
          accessTokenResults.add(await tokenCacheService.getAccessToken());
          refreshTokenResults.add(await tokenCacheService.getRefreshToken());
        }

        // Assert: All reads should return the same token values
        for (int readIndex = 0; readIndex < numberOfReads; readIndex++) {
          expect(
            accessTokenResults[readIndex],
            accessToken,
            reason: 'Iteration $i, Read $readIndex: Access token should match',
          );
          expect(
            refreshTokenResults[readIndex],
            refreshToken,
            reason: 'Iteration $i, Read $readIndex: Refresh token should match',
          );
        }

        // Assert: Storage should only be accessed ONCE for each token (on first read)
        verify(mockSecureStorage.read(key: AppConstants.accessTokenKey)).called(1);
        verify(mockSecureStorage.read(key: AppConstants.refreshTokenKey)).called(1);

        // Reset mocks for next iteration
        reset(mockSecureStorage);
      }
    });

    /// **Feature: flutter-main-thread-optimization, Property 8: Token refresh updates both cache and storage**
    /// **Validates: Requirements 2.4**
    test('Property 8: Token refresh updates both cache and storage', () async {
      // Run 100+ iterations with random token values
      for (int i = 0; i < 100; i++) {
        // Generate random tokens
        final accessToken = faker.jwt.valid();
        final refreshToken = faker.jwt.valid();

        // Create a fresh service instance for each iteration
        final tokenCacheService = TokenCacheService(mockSecureStorage);

        // Mock storage operations
        when(mockSecureStorage.write(key: AppConstants.accessTokenKey, value: accessToken)).thenAnswer((_) async => {});
        when(
          mockSecureStorage.write(key: AppConstants.refreshTokenKey, value: refreshToken),
        ).thenAnswer((_) async => {});
        when(mockSecureStorage.read(key: AppConstants.accessTokenKey)).thenAnswer((_) async => accessToken);
        when(mockSecureStorage.read(key: AppConstants.refreshTokenKey)).thenAnswer((_) async => refreshToken);

        // Act: Set tokens (simulating token refresh)
        await tokenCacheService.setTokens(accessToken, refreshToken);

        // Assert: Verify tokens are written to storage
        verify(mockSecureStorage.write(key: AppConstants.accessTokenKey, value: accessToken)).called(1);
        verify(mockSecureStorage.write(key: AppConstants.refreshTokenKey, value: refreshToken)).called(1);

        // Assert: Verify tokens are in cache (can be retrieved without storage access)
        final cachedAccessToken = await tokenCacheService.getAccessToken();
        final cachedRefreshToken = await tokenCacheService.getRefreshToken();

        expect(cachedAccessToken, accessToken, reason: 'Iteration $i: Access token should be in cache');
        expect(cachedRefreshToken, refreshToken, reason: 'Iteration $i: Refresh token should be in cache');

        // Verify storage was not accessed again (tokens came from cache)
        verifyNever(mockSecureStorage.read(key: AppConstants.accessTokenKey));
        verifyNever(mockSecureStorage.read(key: AppConstants.refreshTokenKey));

        // Reset mocks for next iteration
        reset(mockSecureStorage);
      }
    });

    /// **Feature: flutter-main-thread-optimization, Property 9: Token clear removes from both locations**
    /// **Validates: Requirements 2.5**
    test('Property 9: Token clear removes from both locations', () async {
      // Run 100+ iterations with random token values
      for (int i = 0; i < 100; i++) {
        // Generate random tokens
        final accessToken = faker.jwt.valid();
        final refreshToken = faker.jwt.valid();

        // Create a fresh service instance for each iteration
        final tokenCacheService = TokenCacheService(mockSecureStorage);

        // Mock storage operations for setting tokens
        when(mockSecureStorage.write(key: AppConstants.accessTokenKey, value: accessToken)).thenAnswer((_) async => {});
        when(
          mockSecureStorage.write(key: AppConstants.refreshTokenKey, value: refreshToken),
        ).thenAnswer((_) async => {});

        // Mock storage operations for clearing tokens
        when(mockSecureStorage.delete(key: AppConstants.accessTokenKey)).thenAnswer((_) async => {});
        when(mockSecureStorage.delete(key: AppConstants.refreshTokenKey)).thenAnswer((_) async => {});

        // Mock storage operations for reading after clear (should return null)
        when(mockSecureStorage.read(key: AppConstants.accessTokenKey)).thenAnswer((_) async => null);
        when(mockSecureStorage.read(key: AppConstants.refreshTokenKey)).thenAnswer((_) async => null);

        // Arrange: Set tokens first
        await tokenCacheService.setTokens(accessToken, refreshToken);

        // Verify tokens are in cache
        expect(
          tokenCacheService.hasTokensInCache(),
          true,
          reason: 'Iteration $i: Tokens should be in cache before clear',
        );

        // Act: Clear tokens
        await tokenCacheService.clearTokens();

        // Assert: Verify tokens are deleted from storage
        verify(mockSecureStorage.delete(key: AppConstants.accessTokenKey)).called(1);
        verify(mockSecureStorage.delete(key: AppConstants.refreshTokenKey)).called(1);

        // Assert: Verify tokens are cleared from cache
        expect(
          tokenCacheService.hasTokensInCache(),
          false,
          reason: 'Iteration $i: Tokens should not be in cache after clear',
        );

        // Assert: Verify tokens cannot be retrieved (both cache and storage are empty)
        final clearedAccessToken = await tokenCacheService.getAccessToken();
        final clearedRefreshToken = await tokenCacheService.getRefreshToken();

        expect(clearedAccessToken, isNull, reason: 'Iteration $i: Access token should be null after clear');
        expect(clearedRefreshToken, isNull, reason: 'Iteration $i: Refresh token should be null after clear');

        // Reset mocks for next iteration
        reset(mockSecureStorage);
      }
    });
  });
}
