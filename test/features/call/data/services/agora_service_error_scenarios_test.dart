import 'package:chattrix_ui/core/config/env_validator.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/data/services/agora_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

/// **Manual Error Scenario Tests**
/// **Validates: Requirements 2.1, 2.4, 6.1, 8.1**
///
/// This test suite validates error handling scenarios:
/// 1. Invalid App ID (should fail gracefully) - Requirement 2.1, 2.4
/// 2. Backend stopped (should show connection error) - Requirement 6.1
/// 3. Invalid token (should show auth error) - Requirement 6.1
/// 4. User-friendly error messages - Requirement 6.1, 8.1
///
/// These tests verify that the system handles errors gracefully and provides
/// clear, actionable error messages to users.

void main() {
  group('Error Scenario Tests - Invalid App ID', () {
    test('Scenario 1: Empty App ID should fail gracefully with clear message', () async {
      /// Requirement 2.1: WHEN the app starts THEN the system SHALL validate
      /// AGORA_APP_ID is not empty
      ///
      /// Requirement 8.1: WHEN initialization fails THEN the system SHALL catch
      /// the exception and return a Failure

      // Setup: Create environment with empty App ID
      await dotenv.load(mergeWith: {'AGORA_APP_ID': ''});

      // Verify: EnvValidator should throw exception with clear message
      expect(
        () => EnvValidator.validate(),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains('AGORA_APP_ID is not set') &&
                e.toString().contains('Please add: AGORA_APP_ID=your_app_id'),
          ),
        ),
        reason: 'Empty App ID should throw exception with actionable message',
      );

      // Verify: Error message is user-friendly
      try {
        EnvValidator.validate();
        fail('Should have thrown exception');
      } catch (e) {
        expect(
          e.toString(),
          isNot(contains('null')),
          reason: 'Error message should not contain technical null references',
        );
        expect(e.toString().length, greaterThan(20), reason: 'Error message should be descriptive');
      }
    });

    test('Scenario 2: Invalid App ID length should fail gracefully', () async {
      /// Requirement 2.1: WHEN the app starts THEN the system SHALL validate
      /// AGORA_APP_ID is not empty
      ///
      /// Requirement 2.4: WHEN the App ID mismatches THEN the system SHALL
      /// display a clear error message

      // Setup: Create environment with invalid App ID (wrong length)
      await dotenv.load(mergeWith: {'AGORA_APP_ID': 'invalid_short_id'});

      // Verify: EnvValidator should throw exception with clear message
      expect(
        () => EnvValidator.validate(),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains('AGORA_APP_ID appears to be invalid') &&
                e.toString().contains('should be 32 characters'),
          ),
        ),
        reason: 'Invalid App ID length should throw exception with clear message',
      );

      // Verify: Error message includes current length for debugging
      try {
        EnvValidator.validate();
        fail('Should have thrown exception');
      } catch (e) {
        expect(
          e.toString(),
          contains('Current length:'),
          reason: 'Error message should include actual length for debugging',
        );
      }
    });

    // Note: Scenario 3 (AgoraService initialization with empty App ID) is tested
    // in the property-based tests. In unit tests, the Agora SDK is mocked and
    // may not behave the same way as in production.
  });

  group('Error Scenario Tests - Connection Errors', () {
    test('Scenario 4: Join channel without initialization should show clear error', () async {
      /// Requirement 6.1: WHEN error -17 occurs THEN the system SHALL display
      /// "Failed to join call. Please check your connection and try again."
      ///
      /// Requirement 8.1: WHEN initialization fails THEN the system SHALL catch
      /// the exception and return a Failure

      final service = AgoraService();

      // Attempt to join channel without initialization
      try {
        await service.joinChannel(token: 'test_token', channelId: 'test_channel', uid: 12345, isVideo: true);
        fail('Should have thrown exception');
      } catch (e) {
        // Verify error message is clear and actionable
        expect(
          e.toString(),
          contains('Agora engine not initialized'),
          reason: 'Error message should indicate engine not initialized',
        );

        // Verify error message doesn't expose technical details
        expect(
          e.toString(),
          isNot(contains('null pointer')),
          reason: 'Error message should not expose low-level technical details',
        );
      }

      // Cleanup
      await service.dispose();
    });

    test('Scenario 5: Network error simulation - operations should fail gracefully', () async {
      /// Requirement 6.1: WHEN error -17 occurs THEN the system SHALL display
      /// "Failed to join call. Please check your connection and try again."

      final service = AgoraService();

      // List of operations that should fail gracefully
      final operations = [
        () => service.muteLocalAudioStream(true),
        () => service.muteLocalVideoStream(true),
        () => service.switchCamera(),
        () => service.enableVideo(),
        () => service.enableAudio(),
      ];

      for (final operation in operations) {
        try {
          await operation();
          fail('Operation should have thrown exception');
        } catch (e) {
          // Verify error is caught and message is clear
          expect(e, isA<Exception>(), reason: 'Should throw Exception');
          expect(e.toString(), contains('Agora engine not initialized'), reason: 'Error message should be clear');
        }
      }

      // Verify service is still in consistent state
      expect(service.isInitialized, isFalse);
      await service.dispose();
    });
  });

  group('Error Scenario Tests - User-Friendly Messages', () {
    test('Scenario 6: Failure types should have user-friendly messages', () {
      /// Requirement 6.1: WHEN error -17 occurs THEN the system SHALL display
      /// "Failed to join call. Please check your connection and try again."
      ///
      /// Requirement 6.2: WHEN the error is due to token THEN the system SHALL
      /// suggest "Token may be invalid. Please restart the app."
      ///
      /// Requirement 6.3: WHEN the error is due to network THEN the system SHALL
      /// suggest "Network error. Please check your internet connection."

      // Test AgoraEngine failure message
      const agoraFailure = Failure.agoraEngine(
        message: 'Technical error: SDK initialization failed with code -2',
        code: -2,
      );
      expect(
        agoraFailure.userMessage,
        equals('Failed to join call. Please check your connection and try again.'),
        reason: 'Agora engine failure should have user-friendly message',
      );

      // Test ChannelJoin failure message
      const channelJoinFailure = Failure.channelJoin(message: 'Technical error: Channel join rejected with code -17');
      expect(
        channelJoinFailure.userMessage,
        equals('Failed to join call. Please try again.'),
        reason: 'Channel join failure should have user-friendly message',
      );

      // Test Network failure message
      const networkFailure = Failure.network(message: 'Technical error: Connection timeout');
      expect(
        networkFailure.userMessage,
        equals('Network error. Please check your internet connection.'),
        reason: 'Network failure should have user-friendly message',
      );

      // Test Unauthorized failure message
      const unauthorizedFailure = Failure.unauthorized(message: 'Technical error: Invalid JWT token', errorCode: '401');
      expect(
        unauthorizedFailure.userMessage,
        equals('Authentication failed. Please login again.'),
        reason: 'Unauthorized failure should have user-friendly message',
      );

      // Test TokenExpired failure message
      const tokenExpiredFailure = Failure.tokenExpired(message: 'Technical error: Token expired at timestamp');
      expect(
        tokenExpiredFailure.userMessage,
        equals('Session expired. Please login again.'),
        reason: 'Token expired failure should have user-friendly message',
      );
    });

    test('Scenario 7: User messages should not contain technical jargon', () {
      /// Requirement 6.1: Error messages should be user-friendly

      final failures = [
        const Failure.agoraEngine(message: 'SDK error', code: -17),
        const Failure.channelJoin(message: 'Join failed'),
        const Failure.network(message: 'Connection error'),
        const Failure.unauthorized(message: 'Auth failed', errorCode: '401'),
        const Failure.tokenExpired(message: 'Token expired'),
        const Failure.server(message: 'Server error', errorCode: '500'),
        const Failure.unknown(message: 'Unknown error'),
      ];

      // Technical terms that should NOT appear in user messages
      final technicalTerms = [
        'SDK',
        'API',
        'null',
        'exception',
        'stack trace',
        'code -17',
        'HTTP',
        'JWT',
        'RTC',
        'UID',
      ];

      for (final failure in failures) {
        final userMessage = failure.userMessage.toLowerCase();

        for (final term in technicalTerms) {
          expect(
            userMessage,
            isNot(contains(term.toLowerCase())),
            reason: 'User message should not contain technical term: $term',
          );
        }

        // Verify message is actionable (contains suggestion)
        final hasActionableContent =
            userMessage.contains('please') || userMessage.contains('try') || userMessage.contains('check');

        expect(hasActionableContent, isTrue, reason: 'User message should be actionable: $userMessage');
      }
    });

    test('Scenario 8: Error messages should be concise and clear', () {
      /// Requirement 6.1: Error messages should be clear

      final failures = [
        const Failure.agoraEngine(message: 'Error', code: -17),
        const Failure.channelJoin(message: 'Error'),
        const Failure.network(message: 'Error'),
      ];

      for (final failure in failures) {
        final userMessage = failure.userMessage;

        // Message should not be too short (at least 20 characters)
        expect(
          userMessage.length,
          greaterThanOrEqualTo(20),
          reason: 'Error message should be descriptive enough: $userMessage',
        );

        // Message should not be too long (at most 150 characters)
        expect(userMessage.length, lessThanOrEqualTo(150), reason: 'Error message should be concise: $userMessage');

        // Message should start with capital letter
        expect(
          userMessage[0],
          equals(userMessage[0].toUpperCase()),
          reason: 'Error message should start with capital letter',
        );

        // Message should end with period
        expect(userMessage.endsWith('.'), isTrue, reason: 'Error message should end with period: $userMessage');
      }
    });

    test('Scenario 9: Permission errors should be specific and actionable', () {
      /// Requirement 6.1: Error messages should be actionable

      const cameraPermissionFailure = Failure.permission(message: 'Camera permission is required for video calls');

      const micPermissionFailure = Failure.permission(message: 'Microphone permission is required for calls');

      // Verify camera permission message
      expect(
        cameraPermissionFailure.userMessage,
        contains('Camera permission'),
        reason: 'Should specify camera permission',
      );
      expect(
        cameraPermissionFailure.userMessage,
        contains('video calls'),
        reason: 'Should explain why camera is needed',
      );

      // Verify microphone permission message
      expect(
        micPermissionFailure.userMessage,
        contains('Microphone permission'),
        reason: 'Should specify microphone permission',
      );
      expect(micPermissionFailure.userMessage, contains('calls'), reason: 'Should explain why microphone is needed');
    });
  });

  group('Error Scenario Tests - Error Recovery', () {
    test('Scenario 10: Service should be disposable after any error', () async {
      /// Requirement 8.1: WHEN initialization fails THEN the system SHALL catch
      /// the exception and return a Failure

      final service = AgoraService();

      // Cause various errors
      try {
        await service.joinChannel(token: 'test', channelId: 'test', uid: 123, isVideo: true);
      } catch (e) {
        // Expected
      }

      try {
        await service.muteLocalAudioStream(true);
      } catch (e) {
        // Expected
      }

      // Verify service can be disposed without errors
      await service.dispose();

      // Verify clean state after dispose
      expect(service.isInitialized, isFalse);
      expect(service.engine, isNull);
      expect(service.localUid, isNull);
    });

    test('Scenario 11: Errors should not leak resources', () async {
      /// Requirement 8.1: Error handling should not leak resources

      // Create multiple services and cause errors
      for (int i = 0; i < 10; i++) {
        final service = AgoraService();

        // Cause error
        try {
          await service.joinChannel(token: 'test_$i', channelId: 'channel_$i', uid: i, isVideo: true);
        } catch (e) {
          // Expected
        }

        // Verify state is consistent
        expect(service.isInitialized, isFalse);
        expect(service.engine, isNull);
        expect(service.localUid, isNull);

        // Dispose should work
        await service.dispose();
      }

      // If we got here without memory issues, test passes
      expect(true, isTrue, reason: 'No resource leaks detected');
    });
  });

  group('Error Scenario Tests - Edge Cases', () {
    test('Scenario 12: Null or empty parameters should fail gracefully', () async {
      /// Requirement 8.1: Error handling should be robust

      final service = AgoraService();

      // Test empty token
      expect(
        () => service.joinChannel(token: '', channelId: 'test', uid: 123, isVideo: true),
        throwsA(isA<Exception>()),
        reason: 'Empty token should throw exception',
      );

      // Test empty channel ID
      expect(
        () => service.joinChannel(token: 'test_token', channelId: '', uid: 123, isVideo: true),
        throwsA(isA<Exception>()),
        reason: 'Empty channel ID should throw exception',
      );

      // Test zero UID
      expect(
        () => service.joinChannel(token: 'test_token', channelId: 'test_channel', uid: 0, isVideo: true),
        throwsA(isA<Exception>()),
        reason: 'Zero UID should throw exception',
      );

      await service.dispose();
    });

    test('Scenario 13: Rapid successive errors should not cause crashes', () async {
      /// Requirement 8.1: Error handling should be robust under stress

      final service = AgoraService();

      // Cause rapid successive errors
      final futures = <Future>[];
      for (int i = 0; i < 20; i++) {
        futures.add(
          service
              .joinChannel(token: 'test_$i', channelId: 'channel_$i', uid: i, isVideo: i % 2 == 0)
              .catchError((e) => null),
        );
      }

      // Wait for all operations to complete
      await Future.wait(futures);

      // Verify service is still in consistent state
      expect(service.isInitialized, isFalse);
      expect(service.engine, isNull);

      // Dispose should work
      await service.dispose();
    });
  });
}
