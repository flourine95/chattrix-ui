import 'package:flutter_test/flutter_test.dart';
import 'package:chattrix_ui/core/services/json_parsing_service.dart';
import 'package:chattrix_ui/core/services/token_cache_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

/// **Feature: flutter-main-thread-optimization, Property 17: Consistent 60 FPS during typical usage**
///
/// Integration test for overall performance validation
/// Validates: Requirements 5.5
void main() {
  group('Integration Tests - Overall Performance', () {
    late TokenCacheService tokenCacheService;
    late FlutterSecureStorage secureStorage;

    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
      secureStorage = const FlutterSecureStorage();
      tokenCacheService = TokenCacheService(secureStorage);
    });

    test('Property 17: Consistent 60 FPS during typical usage - JSON parsing performance', () async {
      // Test JSON parsing performance with multiple messages
      final messageJson = jsonEncode({
        'id': 1,
        'conversationId': 1,
        'senderId': 1,
        'content': 'Test message content',
        'messageType': 'TEXT',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
        'isRead': false,
        'sender': {
          'id': 1,
          'username': 'testuser',
          'email': 'test@example.com',
          'fullName': 'Test User',
          'avatarUrl': null,
          'status': 'ONLINE',
          'createdAt': DateTime.now().toIso8601String(),
        },
      });

      final stopwatch = Stopwatch()..start();

      // Simulate receiving 10 rapid messages (typical usage)
      for (int i = 0; i < 10; i++) {
        await JsonParsingService.parseMessage(messageJson);
      }

      stopwatch.stop();

      // Each message should be parsed well under 16ms
      // With 10 messages, total time should be under 160ms (10 * 16ms)
      // In practice, with isolates, this should be much faster
      expect(
        stopwatch.elapsedMilliseconds,
        lessThan(160),
        reason: 'Parsing 10 messages should complete within frame budget',
      );

      // Average time per message should be reasonable
      final avgTimePerMessage = stopwatch.elapsedMilliseconds / 10;
      expect(avgTimePerMessage, lessThan(50), reason: 'Average parsing time per message should be under 50ms');
    });

    test('Property 17: Consistent 60 FPS during typical usage - Token cache performance', () async {
      // Test token cache performance
      const accessToken = 'test_access_token_12345';
      const refreshToken = 'test_refresh_token_67890';

      // Set tokens
      await tokenCacheService.setTokens(accessToken, refreshToken);

      final stopwatch = Stopwatch()..start();

      // Simulate 50 token reads (typical during multiple API calls)
      for (int i = 0; i < 50; i++) {
        final token = await tokenCacheService.getAccessToken();
        expect(token, equals(accessToken));
      }

      stopwatch.stop();

      // 50 cached reads should be extremely fast (< 10ms total)
      expect(stopwatch.elapsedMilliseconds, lessThan(10), reason: 'Cached token reads should be nearly instant');

      // Average time per read should be under 1ms
      final avgTimePerRead = stopwatch.elapsedMilliseconds / 50;
      expect(avgTimePerRead, lessThan(1), reason: 'Average cached token read should be under 1ms');
    });

    test('Property 17: Consistent 60 FPS during typical usage - Combined scenario', () async {
      // Test a combined scenario: token reads + JSON parsing
      const accessToken = 'test_access_token';
      const refreshToken = 'test_refresh_token';

      await tokenCacheService.setTokens(accessToken, refreshToken);

      final messageJson = jsonEncode({
        'id': 1,
        'conversationId': 1,
        'senderId': 1,
        'content': 'Test message',
        'messageType': 'TEXT',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
        'isRead': false,
        'sender': {
          'id': 1,
          'username': 'testuser',
          'email': 'test@example.com',
          'fullName': 'Test User',
          'avatarUrl': null,
          'status': 'ONLINE',
          'createdAt': DateTime.now().toIso8601String(),
        },
      });

      final stopwatch = Stopwatch()..start();

      // Simulate typical usage: 5 messages with token checks
      for (int i = 0; i < 5; i++) {
        // Check token (simulating API call auth)
        final token = await tokenCacheService.getAccessToken();
        expect(token, equals(accessToken));

        // Parse message
        await JsonParsingService.parseMessage(messageJson);
      }

      stopwatch.stop();

      // Combined operations should maintain 60 FPS
      // 5 iterations should complete well under 5 * 16ms = 80ms
      expect(stopwatch.elapsedMilliseconds, lessThan(100), reason: 'Combined typical usage should maintain 60 FPS');
    });

    test('Property 17: Consistent 60 FPS during typical usage - Conversation update parsing', () async {
      final conversationUpdateJson = jsonEncode({
        'conversationId': 1,
        'updatedAt': DateTime.now().toIso8601String(),
        'lastMessage': {
          'id': 1,
          'content': 'Last message',
          'senderId': 1,
          'senderUsername': 'testuser',
          'sentAt': DateTime.now().toIso8601String(),
          'type': 'TEXT',
        },
      });

      final stopwatch = Stopwatch()..start();

      // Parse 10 conversation updates
      for (int i = 0; i < 10; i++) {
        await JsonParsingService.parseConversationUpdate(conversationUpdateJson);
      }

      stopwatch.stop();

      // Should complete within frame budget
      expect(
        stopwatch.elapsedMilliseconds,
        lessThan(160),
        reason: 'Parsing 10 conversation updates should maintain 60 FPS',
      );
    });

    test('Property 17: Consistent 60 FPS during typical usage - Storage write performance', () async {
      // Test that storage writes don't block
      final stopwatch = Stopwatch()..start();

      // Perform 5 token updates (simulating token refresh scenarios)
      for (int i = 0; i < 5; i++) {
        await tokenCacheService.setTokens('access_token_$i', 'refresh_token_$i');
      }

      stopwatch.stop();

      // Storage writes should be reasonably fast
      // 5 writes should complete in under 100ms
      expect(
        stopwatch.elapsedMilliseconds,
        lessThan(100),
        reason: 'Token storage writes should not cause significant delays',
      );
    });

    test('Property 17: Consistent 60 FPS during typical usage - Large message batch', () async {
      // Test parsing a larger batch of messages
      final messagesJson = jsonEncode(
        List.generate(
          20,
          (i) => {
            'id': i,
            'conversationId': 1,
            'senderId': 1,
            'content': 'Message $i',
            'messageType': 'TEXT',
            'createdAt': DateTime.now().toIso8601String(),
            'updatedAt': DateTime.now().toIso8601String(),
            'isRead': false,
            'sender': {
              'id': 1,
              'username': 'testuser',
              'email': 'test@example.com',
              'fullName': 'Test User',
              'avatarUrl': null,
              'status': 'ONLINE',
              'createdAt': DateTime.now().toIso8601String(),
            },
          },
        ),
      );

      final stopwatch = Stopwatch()..start();

      // Parse batch of 20 messages
      await JsonParsingService.parseMessages(messagesJson);

      stopwatch.stop();

      // Batch parsing should be efficient
      // 20 messages should parse in under 200ms
      expect(stopwatch.elapsedMilliseconds, lessThan(200), reason: 'Batch parsing of 20 messages should be efficient');
    });
  });
}
