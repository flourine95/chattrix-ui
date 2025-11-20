import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:chattrix_ui/core/services/json_parsing_service.dart';

void main() {
  group('JsonParsingService', () {
    group('parseMessage', () {
      test('should parse valid message JSON in background isolate', () async {
        // Arrange
        final messageJson = {
          'id': 1,
          'content': 'Hello World',
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
        expect(result.id, 1);
        expect(result.content, 'Hello World');
        expect(result.type, 'TEXT');
        expect(result.conversationId, '123');
        expect(result.sender.username, 'testuser');
      });

      test('should throw FormatException for malformed JSON', () async {
        // Arrange
        const invalidJson = '{invalid json}';

        // Act & Assert
        expect(() => JsonParsingService.parseMessage(invalidJson), throwsA(isA<FormatException>()));
      });

      test('should handle message with media fields', () async {
        // Arrange
        final messageJson = {
          'id': 2,
          'content': 'Check this image',
          'type': 'IMAGE',
          'createdAt': '2024-01-01T12:00:00Z',
          'conversationId': '123',
          'senderId': 456,
          'senderUsername': 'testuser',
          'senderFullName': 'Test User',
          'mediaUrl': 'https://example.com/image.jpg',
          'thumbnailUrl': 'https://example.com/thumb.jpg',
          'fileName': 'image.jpg',
          'fileSize': 1024,
        };
        final jsonString = jsonEncode(messageJson);

        // Act
        final result = await JsonParsingService.parseMessage(jsonString);

        // Assert
        expect(result.mediaUrl, 'https://example.com/image.jpg');
        expect(result.thumbnailUrl, 'https://example.com/thumb.jpg');
        expect(result.fileName, 'image.jpg');
        expect(result.fileSize, 1024);
      });
    });

    group('parseMessages', () {
      test('should parse multiple messages in background isolate', () async {
        // Arrange
        final messagesJson = [
          {
            'id': 1,
            'content': 'Message 1',
            'type': 'TEXT',
            'createdAt': '2024-01-01T12:00:00Z',
            'conversationId': '123',
            'senderId': 456,
            'senderUsername': 'user1',
            'senderFullName': 'User One',
          },
          {
            'id': 2,
            'content': 'Message 2',
            'type': 'TEXT',
            'createdAt': '2024-01-01T12:01:00Z',
            'conversationId': '123',
            'senderId': 789,
            'senderUsername': 'user2',
            'senderFullName': 'User Two',
          },
        ];
        final jsonString = jsonEncode(messagesJson);

        // Act
        final result = await JsonParsingService.parseMessages(jsonString);

        // Assert
        expect(result.length, 2);
        expect(result[0].content, 'Message 1');
        expect(result[1].content, 'Message 2');
      });

      test('should throw FormatException for malformed JSON array', () async {
        // Arrange
        const invalidJson = '[{invalid}]';

        // Act & Assert
        expect(() => JsonParsingService.parseMessages(invalidJson), throwsA(isA<FormatException>()));
      });
    });

    group('parseConversationUpdate', () {
      test('should parse conversation update in background isolate', () async {
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

      test('should throw FormatException for malformed JSON', () async {
        // Arrange
        const invalidJson = '{invalid}';

        // Act & Assert
        expect(() => JsonParsingService.parseConversationUpdate(invalidJson), throwsA(isA<FormatException>()));
      });
    });

    group('parseTypingIndicator', () {
      test('should parse typing indicator in background isolate', () async {
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
        expect(result.typingUsers[0].username, 'testuser');
      });

      test('should throw FormatException for malformed JSON', () async {
        // Arrange
        const invalidJson = '{invalid}';

        // Act & Assert
        expect(() => JsonParsingService.parseTypingIndicator(invalidJson), throwsA(isA<FormatException>()));
      });
    });

    group('parseUserStatusUpdate', () {
      test('should parse user status update in background isolate', () async {
        // Arrange
        final statusJson = {
          'userId': '123',
          'username': 'testuser',
          'displayName': 'Test User',
          'isOnline': true,
          'lastSeen': '2024-01-01T12:00:00Z',
        };
        final jsonString = jsonEncode(statusJson);

        // Act
        final result = await JsonParsingService.parseUserStatusUpdate(jsonString);

        // Assert
        expect(result.userId, '123');
        expect(result.username, 'testuser');
        expect(result.isOnline, true);
      });

      test('should throw FormatException for malformed JSON', () async {
        // Arrange
        const invalidJson = '{invalid}';

        // Act & Assert
        expect(() => JsonParsingService.parseUserStatusUpdate(invalidJson), throwsA(isA<FormatException>()));
      });
    });
  });
}
