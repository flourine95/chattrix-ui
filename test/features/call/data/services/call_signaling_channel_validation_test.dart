import 'package:chattrix_ui/features/call/data/models/websocket/call_invitation_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CallInvitationData Channel ID Validation', () {
    test('should parse CallInvitationData with valid channel ID format', () {
      // Arrange
      final json = {
        'callId': 'call_123',
        'channelId': 'channel_1234567890_user1_user2',
        'callerId': 'user1',
        'callerName': 'John Doe',
        'callerAvatar': 'https://example.com/avatar.jpg',
        'callType': 'VIDEO',
      };

      // Act
      final invitation = CallInvitationData.fromJson(json);

      // Assert
      expect(invitation.callId, 'call_123');
      expect(invitation.channelId, 'channel_1234567890_user1_user2');
      expect(invitation.callerId, 'user1');
      expect(invitation.callerName, 'John Doe');
      expect(invitation.callType, 'VIDEO');
    });

    test('should parse CallInvitationData with invalid channel ID format (logs warning)', () {
      // Arrange
      final json = {
        'callId': 'call_123',
        'channelId': 'invalid_channel_format',
        'callerId': 'user1',
        'callerName': 'John Doe',
        'callType': 'AUDIO',
      };

      // Act
      final invitation = CallInvitationData.fromJson(json);

      // Assert - should still parse but log warning
      expect(invitation.callId, 'call_123');
      expect(invitation.channelId, 'invalid_channel_format');
      expect(invitation.callType, 'AUDIO');
    });

    test('should parse CallInvitationData with channel ID containing conversation prefix', () {
      // Arrange
      final json = {
        'callId': 'call_123',
        'channelId': 'channel_conv_abc123',
        'callerId': 'user1',
        'callerName': 'John Doe',
        'callType': 'VIDEO',
      };

      // Act
      final invitation = CallInvitationData.fromJson(json);

      // Assert - should parse even though format doesn't match standard pattern
      expect(invitation.callId, 'call_123');
      expect(invitation.channelId, 'channel_conv_abc123');
    });

    test('should parse CallInvitationData with backend-generated channel ID', () {
      // Arrange - simulating backend response
      final json = {
        'callId': 'call_1705318200000_abc123',
        'channelId': 'channel_1705318200000_user123_user456',
        'callerId': 'user123',
        'callerName': 'Alice',
        'callerAvatar': null,
        'callType': 'VIDEO',
      };

      // Act
      final invitation = CallInvitationData.fromJson(json);

      // Assert
      expect(invitation.callId, 'call_1705318200000_abc123');
      expect(invitation.channelId, 'channel_1705318200000_user123_user456');
      expect(invitation.callerId, 'user123');
      expect(invitation.callerName, 'Alice');
      expect(invitation.callerAvatar, isNull);
      expect(invitation.callType, 'VIDEO');
    });
  });
}
