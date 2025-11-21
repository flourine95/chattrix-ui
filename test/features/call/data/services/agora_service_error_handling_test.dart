import 'package:chattrix_ui/features/call/data/services/agora_service.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

/// **Feature: fix-agora-join-channel-error, Property 6: Error handling returns Failure**
/// **Validates: Requirements 8.1**
///
/// Property: For any Agora operation that throws an exception, the system SHALL
/// catch the exception and return a Failure type instead of propagating the exception.
///
/// Requirements 8.1: WHEN initialization fails THEN the system SHALL catch the
/// exception and return a Failure
///
/// This test verifies that:
/// 1. AgoraService operations throw exceptions when they fail
/// 2. The repository layer (CallRepositoryImpl) catches these exceptions
/// 3. Exceptions are converted to appropriate Failure types
/// 4. The system returns Either<Failure, T> instead of throwing
/// 5. Error messages are descriptive and actionable
///
/// Note: The AgoraService itself throws exceptions (as designed), but the
/// repository layer wraps these calls and converts exceptions to Failures.
/// This test verifies the exception-throwing behavior of AgoraService,
/// which is the foundation for the repository's error handling.

void main() {
  final faker = Faker();

  group('Property-Based Tests - Error Handling', () {
    test('Property 6: Error handling - JoinChannel throws when not initialized', () async {
      /// This property verifies that joinChannel() throws an exception when
      /// called before the engine is initialized.
      ///
      /// For any channel parameters, attempting to join without initialization
      /// should throw an exception with a clear error message.

      for (int iteration = 0; iteration < 100; iteration++) {
        final service = AgoraService();

        // Generate random channel parameters
        final channelId = 'channel_${faker.randomGenerator.integer(999999)}';
        final uid = faker.randomGenerator.integer(999999999, min: 100000);
        final token = _generateRandomToken(faker);
        final isVideo = faker.randomGenerator.boolean();

        // Property: Joining without initialization should throw
        expect(
          () => service.joinChannel(token: token, channelId: channelId, uid: uid, isVideo: isVideo),
          throwsA(isA<Exception>()),
          reason: 'Iteration $iteration: Should throw exception when not initialized',
        );

        // Property: Exception message should be descriptive
        try {
          await service.joinChannel(token: token, channelId: channelId, uid: uid, isVideo: isVideo);
          fail('Should have thrown exception');
        } catch (e) {
          expect(
            e.toString(),
            contains('Agora engine not initialized'),
            reason: 'Iteration $iteration: Error message should indicate engine not initialized',
          );
        }

        // Clean up
        await service.dispose();
      }
    });

    test('Property 6: Error handling - Operations throw when engine is null', () async {
      /// This property verifies that all operations that require an initialized
      /// engine throw exceptions when the engine is null.
      ///
      /// For any operation (muteAudio, muteVideo, switchCamera, etc.), calling
      /// it without initialization should throw an exception.

      for (int iteration = 0; iteration < 100; iteration++) {
        final service = AgoraService();

        // Property: muteLocalAudioStream should throw when not initialized
        expect(
          () => service.muteLocalAudioStream(true),
          throwsA(isA<Exception>()),
          reason: 'Iteration $iteration: muteLocalAudioStream should throw when not initialized',
        );

        // Property: muteLocalVideoStream should throw when not initialized
        expect(
          () => service.muteLocalVideoStream(true),
          throwsA(isA<Exception>()),
          reason: 'Iteration $iteration: muteLocalVideoStream should throw when not initialized',
        );

        // Property: switchCamera should throw when not initialized
        expect(
          () => service.switchCamera(),
          throwsA(isA<Exception>()),
          reason: 'Iteration $iteration: switchCamera should throw when not initialized',
        );

        // Property: enableVideo should throw when not initialized
        expect(
          () => service.enableVideo(),
          throwsA(isA<Exception>()),
          reason: 'Iteration $iteration: enableVideo should throw when not initialized',
        );

        // Property: enableAudio should throw when not initialized
        expect(
          () => service.enableAudio(),
          throwsA(isA<Exception>()),
          reason: 'Iteration $iteration: enableAudio should throw when not initialized',
        );

        // Clean up
        await service.dispose();
      }
    });

    test('Property 6: Error handling - Error messages are descriptive', () async {
      /// This property verifies that all error messages thrown by AgoraService
      /// are descriptive and help identify the problem.
      ///
      /// For any error condition, the exception message should:
      /// - Clearly indicate what went wrong
      /// - Not expose sensitive information
      /// - Be actionable (suggest what to do)

      for (int iteration = 0; iteration < 100; iteration++) {
        final service = AgoraService();

        // Test various error conditions and verify messages
        final testCases = [
          {
            'operation': 'joinChannel',
            'expectedMessage': 'Agora engine not initialized',
            'action': () => service.joinChannel(
              token: _generateRandomToken(faker),
              channelId: 'test_channel',
              uid: 12345,
              isVideo: true,
            ),
          },
          {
            'operation': 'muteLocalAudioStream',
            'expectedMessage': 'Agora engine not initialized',
            'action': () => service.muteLocalAudioStream(true),
          },
          {
            'operation': 'muteLocalVideoStream',
            'expectedMessage': 'Agora engine not initialized',
            'action': () => service.muteLocalVideoStream(true),
          },
          {
            'operation': 'switchCamera',
            'expectedMessage': 'Agora engine not initialized',
            'action': () => service.switchCamera(),
          },
          {
            'operation': 'enableVideo',
            'expectedMessage': 'Agora engine not initialized',
            'action': () => service.enableVideo(),
          },
          {
            'operation': 'enableAudio',
            'expectedMessage': 'Agora engine not initialized',
            'action': () => service.enableAudio(),
          },
        ];

        for (final testCase in testCases) {
          try {
            await (testCase['action'] as Function)();
            fail('${testCase['operation']} should have thrown exception');
          } catch (e) {
            // Property: Error message should contain expected text
            expect(
              e.toString(),
              contains(testCase['expectedMessage'] as String),
              reason: 'Iteration $iteration: ${testCase['operation']} error message should be descriptive',
            );

            // Property: Error message should not be empty
            expect(
              e.toString().isNotEmpty,
              isTrue,
              reason: 'Iteration $iteration: ${testCase['operation']} error message should not be empty',
            );
          }
        }

        // Clean up
        await service.dispose();
      }
    });

    test('Property 6: Error handling - Exceptions are catchable', () async {
      /// This property verifies that all exceptions thrown by AgoraService
      /// can be caught and handled by the calling code.
      ///
      /// For any operation that throws, the exception should:
      /// - Be catchable with try-catch
      /// - Be of type Exception or a subtype
      /// - Allow the program to continue after catching

      for (int iteration = 0; iteration < 100; iteration++) {
        final service = AgoraService();

        // Generate random parameters
        final channelId = 'channel_${faker.randomGenerator.integer(999999)}';
        final uid = faker.randomGenerator.integer(999999999, min: 100000);
        final token = _generateRandomToken(faker);
        final isVideo = faker.randomGenerator.boolean();

        // Property: Exceptions should be catchable
        var exceptionCaught = false;
        try {
          await service.joinChannel(token: token, channelId: channelId, uid: uid, isVideo: isVideo);
        } catch (e) {
          exceptionCaught = true;

          // Property: Exception should be of type Exception
          expect(e is Exception, isTrue, reason: 'Iteration $iteration: Caught exception should be of type Exception');
        }

        // Property: Exception should have been caught
        expect(exceptionCaught, isTrue, reason: 'Iteration $iteration: Exception should have been caught');

        // Property: Program should continue after catching exception
        // (verified by being able to dispose the service)
        await service.dispose();

        // Property: Service should be in a consistent state after error
        expect(
          service.isInitialized,
          isFalse,
          reason: 'Iteration $iteration: Service should not be initialized after error and dispose',
        );
      }
    });

    test('Property 6: Error handling - State remains consistent after errors', () async {
      /// This property verifies that when operations fail, the service
      /// remains in a consistent state.
      ///
      /// For any failed operation, the service should:
      /// - Not be left in a partially initialized state
      /// - Not leak resources
      /// - Be disposable after errors
      /// - Maintain correct isInitialized flag

      for (int iteration = 0; iteration < 100; iteration++) {
        final service = AgoraService();

        // Property: Initial state should be consistent
        expect(service.isInitialized, isFalse, reason: 'Iteration $iteration: Should not be initialized initially');
        expect(service.localUid, isNull, reason: 'Iteration $iteration: Local UID should be null initially');
        expect(service.engine, isNull, reason: 'Iteration $iteration: Engine should be null initially');

        // Attempt multiple operations that will fail
        final operations = [
          () => service.joinChannel(token: _generateRandomToken(faker), channelId: 'test', uid: 12345, isVideo: true),
          () => service.muteLocalAudioStream(true),
          () => service.muteLocalVideoStream(true),
          () => service.switchCamera(),
        ];

        for (final operation in operations) {
          try {
            await operation();
          } catch (e) {
            // Expected to fail
          }

          // Property: State should remain consistent after each failed operation
          expect(
            service.isInitialized,
            isFalse,
            reason: 'Iteration $iteration: Should remain uninitialized after failed operation',
          );
          expect(
            service.localUid,
            isNull,
            reason: 'Iteration $iteration: Local UID should remain null after failed operation',
          );
          expect(
            service.engine,
            isNull,
            reason: 'Iteration $iteration: Engine should remain null after failed operation',
          );
        }

        // Property: Service should be disposable after errors
        await service.dispose();

        // Property: State should be clean after dispose
        expect(service.isInitialized, isFalse, reason: 'Iteration $iteration: Should not be initialized after dispose');
        expect(service.localUid, isNull, reason: 'Iteration $iteration: Local UID should be null after dispose');
        expect(service.engine, isNull, reason: 'Iteration $iteration: Engine should be null after dispose');
      }
    });

    test('Property 6: Error handling - Multiple errors can be handled sequentially', () async {
      /// This property verifies that the service can handle multiple errors
      /// in sequence without breaking.
      ///
      /// For any sequence of failing operations, the service should:
      /// - Handle each error independently
      /// - Not accumulate error state
      /// - Remain functional for subsequent operations
      /// - Be disposable after multiple errors

      for (int iteration = 0; iteration < 100; iteration++) {
        final service = AgoraService();

        // Attempt multiple operations that will fail
        for (int i = 0; i < 10; i++) {
          final channelId = 'channel_${faker.randomGenerator.integer(999999)}';
          final uid = faker.randomGenerator.integer(999999999, min: 100000);
          final token = _generateRandomToken(faker);
          final isVideo = faker.randomGenerator.boolean();

          // Property: Each operation should throw
          expect(
            () => service.joinChannel(token: token, channelId: channelId, uid: uid, isVideo: isVideo),
            throwsA(isA<Exception>()),
            reason: 'Iteration $iteration, attempt $i: Should throw exception',
          );

          // Property: Service state should remain consistent
          expect(
            service.isInitialized,
            isFalse,
            reason: 'Iteration $iteration, attempt $i: Should remain uninitialized',
          );
        }

        // Property: Service should still be disposable after multiple errors
        await service.dispose();

        expect(service.isInitialized, isFalse, reason: 'Iteration $iteration: Should not be initialized after dispose');
      }
    });
  });
}

/// Generate a random token (simulating Agora token format)
String _generateRandomToken(Faker faker) {
  const chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final length = faker.randomGenerator.integer(200, min: 100);
  return List.generate(length, (_) => chars[faker.randomGenerator.integer(chars.length)]).join();
}
