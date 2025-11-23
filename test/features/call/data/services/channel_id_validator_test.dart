import 'package:chattrix_ui/features/call/data/services/channel_id_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChannelIdValidator', () {
    group('validate', () {
      test('should return true for valid channel ID with standard format', () {
        // Arrange
        const channelId = 'channel_1234567890_user1_user2';

        // Act
        final result = ChannelIdValidator.validate(channelId);

        // Assert
        expect(result, true);
      });

      test('should return true for valid channel ID with UUID-like user IDs', () {
        // Arrange
        const channelId = 'channel_1234567890_abc-123-def_xyz-456-ghi';

        // Act
        final result = ChannelIdValidator.validate(channelId);

        // Assert
        expect(result, true);
      });

      test('should return true for valid channel ID with numeric user IDs', () {
        // Arrange
        const channelId = 'channel_1234567890_12345_67890';

        // Act
        final result = ChannelIdValidator.validate(channelId);

        // Assert
        expect(result, true);
      });

      test('should return false for channel ID missing prefix', () {
        // Arrange
        const channelId = '1234567890_user1_user2';

        // Act
        final result = ChannelIdValidator.validate(channelId);

        // Assert
        expect(result, false);
      });

      test('should return false for channel ID with non-numeric timestamp', () {
        // Arrange
        const channelId = 'channel_abc_user1_user2';

        // Act
        final result = ChannelIdValidator.validate(channelId);

        // Assert
        expect(result, false);
      });

      test('should return false for channel ID with missing user IDs', () {
        // Arrange
        const channelId = 'channel_1234567890';

        // Act
        final result = ChannelIdValidator.validate(channelId);

        // Assert
        expect(result, false);
      });

      test('should return false for channel ID with only one user ID', () {
        // Arrange
        const channelId = 'channel_1234567890_user1';

        // Act
        final result = ChannelIdValidator.validate(channelId);

        // Assert
        expect(result, false);
      });

      test('should return false for empty channel ID', () {
        // Arrange
        const channelId = '';

        // Act
        final result = ChannelIdValidator.validate(channelId);

        // Assert
        expect(result, false);
      });

      test('should return false for channel ID with special characters in user IDs', () {
        // Arrange
        const channelId = 'channel_1234567890_user@1_user#2';

        // Act
        final result = ChannelIdValidator.validate(channelId);

        // Assert
        expect(result, false);
      });
    });

    group('extractComponents', () {
      test('should extract components from valid channel ID', () {
        // Arrange
        const channelId = 'channel_1234567890_user1_user2';

        // Act
        final result = ChannelIdValidator.extractComponents(channelId);

        // Assert
        expect(result, isNotNull);
        expect(result!['timestamp'], '1234567890');
        expect(result['userId1'], 'user1');
        expect(result['userId2'], 'user2');
      });

      test('should return null for invalid channel ID', () {
        // Arrange
        const channelId = 'invalid_channel_id';

        // Act
        final result = ChannelIdValidator.extractComponents(channelId);

        // Assert
        expect(result, isNull);
      });

      test('should extract components from channel ID with extra underscores in user IDs', () {
        // Arrange
        const channelId = 'channel_1234567890_user_1_user_2';

        // Act
        final result = ChannelIdValidator.extractComponents(channelId);

        // Assert
        expect(result, isNotNull);
        expect(result!['timestamp'], '1234567890');
        expect(result['userId1'], 'user');
        expect(result['userId2'], '1');
      });
    });

    group('validateAndLog', () {
      test('should return the same channel ID', () {
        // Arrange
        const channelId = 'channel_1234567890_user1_user2';

        // Act
        final result = ChannelIdValidator.validateAndLog(channelId);

        // Assert
        expect(result, channelId);
      });

      test('should return the channel ID even if invalid', () {
        // Arrange
        const channelId = 'invalid_channel_id';

        // Act
        final result = ChannelIdValidator.validateAndLog(channelId);

        // Assert
        expect(result, channelId);
      });
    });
  });
}
