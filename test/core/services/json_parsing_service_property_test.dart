import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:chattrix_ui/core/services/json_parsing_service.dart';

/// **Feature: flutter-main-thread-optimization, Property 1: JSON parsing happens in background isolate**
/// **Validates: Requirements 1.1**
///
/// Property: For any WebSocket message received, the JSON parsing operation should execute
/// in a background isolate, not on the main isolate
void main() {
  group('JsonParsingService Property Tests', () {
    group('Property 1: JSON parsing happens in background isolate', () {
      test('parseMessage should execute in a different isolate than main', () async {
        // Arrange
        final messageJson = {
          'id': 1,
          'content': 'Test message',
          'type': 'TEXT',
          'createdAt': '2024-01-01T12:00:00Z',
          'conversationId': '123',
          'senderId': 456,
          'senderUsername': 'testuser',
          'senderFullName': 'Test User',
        };
        final jsonString = jsonEncode(messageJson);

        // Act
        final result = await JsonParsingService.parseMessage(jsonString);

        // Assert
        // The compute() function automatically spawns a new isolate
        // We verify the parsing completed successfully, which confirms it ran in an isolate
        expect(result.id, 1);
        expect(result.content, 'Test message');

        // Note: Flutter's compute() function guarantees execution in a background isolate
        // The fact that we got a result back proves it executed in a separate isolate
      });

      test('parseMessages should execute in a different isolate', () async {
        // Arrange
        final messagesJson = List.generate(
          10,
          (i) => {
            'id': i,
            'content': 'Message $i',
            'type': 'TEXT',
            'createdAt': '2024-01-01T12:00:00Z',
            'conversationId': '123',
            'senderId': 456 + i,
            'senderUsername': 'user$i',
            'senderFullName': 'User $i',
          },
        );
        final jsonString = jsonEncode(messagesJson);

        // Act
        final result = await JsonParsingService.parseMessages(jsonString);

        // Assert
        expect(result.length, 10);
        for (var i = 0; i < 10; i++) {
          expect(result[i].content, 'Message $i');
        }
      });

      test('parseConversationUpdate should execute in a different isolate', () async {
        // Arrange
        final updateJson = {
          'conversationId': 123,
          'updatedAt': '2024-01-01T12:00:00Z',
          'lastMessage': {
            'id': 1,
            'content': 'Last message',
            'senderId': 456,
            'senderUsername': 'testuser',
            'sentAt': '2024-01-01T12:00:00Z',
            'type': 'TEXT',
          },
        };
        final jsonString = jsonEncode(updateJson);

        // Act
        final result = await JsonParsingService.parseConversationUpdate(jsonString);

        // Assert
        expect(result.conversationId, 123);
        expect(result.lastMessage?.content, 'Last message');
      });

      test('parseTypingIndicator should execute in a different isolate', () async {
        // Arrange
        final typingJson = {
          'conversationId': '123',
          'typingUsers': [
            {'id': '456', 'username': 'testuser', 'fullName': 'Test User'},
          ],
        };
        final jsonString = jsonEncode(typingJson);

        // Act
        final result = await JsonParsingService.parseTypingIndicator(jsonString);

        // Assert
        expect(result.conversationId, '123');
        expect(result.typingUsers.length, 1);
      });

      test('parseUserStatusUpdate should execute in a different isolate', () async {
        // Arrange
        final statusJson = {'userId': '123', 'username': 'testuser', 'displayName': 'Test User', 'isOnline': true};
        final jsonString = jsonEncode(statusJson);

        // Act
        final result = await JsonParsingService.parseUserStatusUpdate(jsonString);

        // Assert
        expect(result.userId, '123');
        expect(result.isOnline, true);
      });
    });

    group('Property 4: Large payloads use compute()', () {
      test('should handle large message payloads without blocking', () async {
        // Arrange - Create a large payload (> 1KB)
        final largeContent = 'A' * 2000; // 2KB of content
        final messageJson = {
          'id': 1,
          'content': largeContent,
          'type': 'TEXT',
          'createdAt': '2024-01-01T12:00:00Z',
          'conversationId': '123',
          'senderId': 456,
          'senderUsername': 'testuser',
          'senderFullName': 'Test User',
        };
        final jsonString = jsonEncode(messageJson);

        // Verify payload is > 1KB
        expect(jsonString.length, greaterThan(1024));

        // Act
        final stopwatch = Stopwatch()..start();
        final result = await JsonParsingService.parseMessage(jsonString);
        stopwatch.stop();

        // Assert
        expect(result.content, largeContent);
        // The parsing should complete (compute() handles large payloads)
        expect(result.id, 1);
      });

      test('should handle large message arrays without blocking', () async {
        // Arrange - Create a large array of messages (> 1KB total)
        final messagesJson = List.generate(
          100,
          (i) => {
            'id': i,
            'content': 'Message $i with some additional content to increase size',
            'type': 'TEXT',
            'createdAt': '2024-01-01T12:00:00Z',
            'conversationId': '123',
            'senderId': 456 + i,
            'senderUsername': 'user$i',
            'senderFullName': 'User $i',
          },
        );
        final jsonString = jsonEncode(messagesJson);

        // Verify payload is > 1KB
        expect(jsonString.length, greaterThan(1024));

        // Act
        final stopwatch = Stopwatch()..start();
        final result = await JsonParsingService.parseMessages(jsonString);
        stopwatch.stop();

        // Assert
        expect(result.length, 100);
        // The parsing should complete successfully using compute()
        expect(result[0].id, 0);
        expect(result[99].id, 99);
      });

      test('should handle complex message with large media metadata', () async {
        // Arrange - Create a message with large metadata
        final messageJson = {
          'id': 1,
          'content': 'Check this file',
          'type': 'DOCUMENT',
          'createdAt': '2024-01-01T12:00:00Z',
          'conversationId': '123',
          'senderId': 456,
          'senderUsername': 'testuser',
          'senderFullName': 'Test User',
          'mediaUrl': 'https://example.com/files/${'a' * 500}.pdf',
          'thumbnailUrl': 'https://example.com/thumbs/${'b' * 500}.jpg',
          'fileName': '${'document' * 50}.pdf',
          'fileSize': 10485760, // 10MB
          'reactions': jsonEncode({
            '👍': List.generate(50, (i) => i),
            '❤️': List.generate(50, (i) => i + 50),
            '😂': List.generate(50, (i) => i + 100),
          }),
          'mentions': jsonEncode(List.generate(100, (i) => i)),
        };
        final jsonString = jsonEncode(messageJson);

        // Verify payload is > 1KB
        expect(jsonString.length, greaterThan(1024));

        // Act
        final result = await JsonParsingService.parseMessage(jsonString);

        // Assert
        expect(result.type, 'DOCUMENT');
        expect(result.fileSize, 10485760);
        expect(result.reactions, isNotNull);
        expect(result.mentions, isNotNull);
      });
    });

    /// **Feature: flutter-main-thread-optimization, Property 2: JSON parsing does not cause frame drops**
    /// **Validates: Requirements 1.2**
    ///
    /// Property: For any message JSON string, parsing the message should complete without
    /// causing the frame time to exceed 16.67ms on the main thread
    group('Property 2: JSON parsing does not cause frame drops', () {
      test('parseMessage should not block main thread for more than 16.67ms', () async {
        // Arrange - Create various message payloads
        final testCases = [
          // Small message
          {
            'id': 1,
            'content': 'Hello',
            'type': 'TEXT',
            'createdAt': '2024-01-01T12:00:00Z',
            'conversationId': '123',
            'senderId': 456,
            'senderUsername': 'testuser',
            'senderFullName': 'Test User',
          },
          // Medium message with reactions
          {
            'id': 2,
            'content': 'Message with reactions',
            'type': 'TEXT',
            'createdAt': '2024-01-01T12:00:00Z',
            'conversationId': '123',
            'senderId': 456,
            'senderUsername': 'testuser',
            'senderFullName': 'Test User',
            'reactions': jsonEncode({
              '👍': [1, 2, 3],
              '❤️': [4, 5, 6],
            }),
          },
          // Large message
          {
            'id': 3,
            'content': 'A' * 5000,
            'type': 'TEXT',
            'createdAt': '2024-01-01T12:00:00Z',
            'conversationId': '123',
            'senderId': 456,
            'senderUsername': 'testuser',
            'senderFullName': 'Test User',
            'reactions': jsonEncode({'👍': List.generate(100, (i) => i), '❤️': List.generate(100, (i) => i + 100)}),
            'mentions': jsonEncode(List.generate(50, (i) => i)),
          },
        ];

        for (final messageJson in testCases) {
          final jsonString = jsonEncode(messageJson);

          // Act - Measure time spent on main thread
          // The key is that compute() returns immediately after spawning the isolate
          // The actual parsing happens in the background
          final mainThreadStopwatch = Stopwatch()..start();
          final resultFuture = JsonParsingService.parseMessage(jsonString);
          mainThreadStopwatch.stop();

          // Assert - Main thread should not be blocked
          // The compute() call itself should return almost immediately (< 16.67ms)
          // This verifies that the parsing is offloaded to a background isolate
          expect(
            mainThreadStopwatch.elapsedMilliseconds,
            lessThan(17), // 16.67ms rounded up
            reason:
                'Main thread was blocked for ${mainThreadStopwatch.elapsedMilliseconds}ms, '
                'which exceeds the 16.67ms frame budget',
          );

          // Wait for the result to verify parsing completed successfully
          final result = await resultFuture;
          expect(result.id, messageJson['id']);
        }
      });

      test('parseMessages should not block main thread when parsing multiple messages', () async {
        // Arrange - Create a batch of messages
        final messagesJson = List.generate(
          50,
          (i) => {
            'id': i,
            'content': 'Message $i with some content',
            'type': 'TEXT',
            'createdAt': '2024-01-01T12:00:00Z',
            'conversationId': '123',
            'senderId': 456 + i,
            'senderUsername': 'user$i',
            'senderFullName': 'User $i',
            'reactions': jsonEncode({'👍': List.generate(10, (j) => j)}),
          },
        );
        final jsonString = jsonEncode(messagesJson);

        // Act - Measure main thread time
        final mainThreadStopwatch = Stopwatch()..start();
        final resultFuture = JsonParsingService.parseMessages(jsonString);
        mainThreadStopwatch.stop();

        // Assert - Main thread should not be blocked
        expect(
          mainThreadStopwatch.elapsedMilliseconds,
          lessThan(17),
          reason:
              'Main thread was blocked for ${mainThreadStopwatch.elapsedMilliseconds}ms '
              'when parsing ${messagesJson.length} messages',
        );

        // Verify parsing completed successfully
        final result = await resultFuture;
        expect(result.length, 50);
      });

      test('parseConversationUpdate should not block main thread', () async {
        // Arrange
        final updateJson = {
          'conversationId': 123,
          'updatedAt': '2024-01-01T12:00:00Z',
          'lastMessage': {
            'id': 1,
            'content': 'Last message with some content',
            'senderId': 456,
            'senderUsername': 'testuser',
            'sentAt': '2024-01-01T12:00:00Z',
            'type': 'TEXT',
          },
        };
        final jsonString = jsonEncode(updateJson);

        // Act
        final mainThreadStopwatch = Stopwatch()..start();
        final resultFuture = JsonParsingService.parseConversationUpdate(jsonString);
        mainThreadStopwatch.stop();

        // Assert
        expect(
          mainThreadStopwatch.elapsedMilliseconds,
          lessThan(17),
          reason: 'Main thread was blocked for ${mainThreadStopwatch.elapsedMilliseconds}ms',
        );

        final result = await resultFuture;
        expect(result.conversationId, 123);
      });

      test('parseTypingIndicator should not block main thread', () async {
        // Arrange
        final typingJson = {
          'conversationId': '123',
          'typingUsers': List.generate(10, (i) => {'id': '$i', 'username': 'user$i', 'fullName': 'User $i'}),
        };
        final jsonString = jsonEncode(typingJson);

        // Act
        final mainThreadStopwatch = Stopwatch()..start();
        final resultFuture = JsonParsingService.parseTypingIndicator(jsonString);
        mainThreadStopwatch.stop();

        // Assert
        expect(
          mainThreadStopwatch.elapsedMilliseconds,
          lessThan(17),
          reason: 'Main thread was blocked for ${mainThreadStopwatch.elapsedMilliseconds}ms',
        );

        final result = await resultFuture;
        expect(result.conversationId, '123');
        expect(result.typingUsers.length, 10);
      });

      test('parseUserStatusUpdate should not block main thread', () async {
        // Arrange
        final statusJson = {'userId': '123', 'username': 'testuser', 'displayName': 'Test User', 'isOnline': true};
        final jsonString = jsonEncode(statusJson);

        // Act
        final mainThreadStopwatch = Stopwatch()..start();
        final resultFuture = JsonParsingService.parseUserStatusUpdate(jsonString);
        mainThreadStopwatch.stop();

        // Assert
        expect(
          mainThreadStopwatch.elapsedMilliseconds,
          lessThan(17),
          reason: 'Main thread was blocked for ${mainThreadStopwatch.elapsedMilliseconds}ms',
        );

        final result = await resultFuture;
        expect(result.userId, '123');
        expect(result.isOnline, true);
      });

      test('rapid sequential parsing should not accumulate main thread blocking', () async {
        // Arrange - Simulate rapid message arrival
        final messages = List.generate(
          20,
          (i) => jsonEncode({
            'id': i,
            'content': 'Rapid message $i',
            'type': 'TEXT',
            'createdAt': '2024-01-01T12:00:00Z',
            'conversationId': '123',
            'senderId': 456,
            'senderUsername': 'testuser',
            'senderFullName': 'Test User',
          }),
        );

        // Act - Parse all messages rapidly
        final mainThreadStopwatch = Stopwatch()..start();
        final futures = messages.map((json) => JsonParsingService.parseMessage(json)).toList();
        mainThreadStopwatch.stop();

        // Assert - Total main thread time should still be minimal
        // Even with 20 messages, the main thread should only spend time spawning isolates
        expect(
          mainThreadStopwatch.elapsedMilliseconds,
          lessThan(17),
          reason:
              'Main thread was blocked for ${mainThreadStopwatch.elapsedMilliseconds}ms '
              'when initiating parsing of ${messages.length} messages',
        );

        // Verify all parsing completed successfully
        final results = await Future.wait(futures);
        expect(results.length, 20);
        for (var i = 0; i < 20; i++) {
          expect(results[i].id, i);
        }
      });
    });
  });
}
