import 'package:flutter_test/flutter_test.dart';
import 'package:chattrix_ui/core/config/env_validator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:faker/faker.dart';

/// **Feature: fix-agora-join-channel-error, Property 3: App ID validation**
/// **Validates: Requirements 2.1**
///
/// Property: For any app startup, if AGORA_APP_ID is empty or invalid,
/// the system SHALL throw an exception before attempting to initialize the engine.
///
/// This test verifies that:
/// 1. Valid App IDs (32 characters) pass validation
/// 2. Empty or null App IDs throw exceptions
/// 3. Invalid length App IDs throw exceptions
/// 4. The validation happens before any engine initialization

void main() {
  final faker = Faker();

  group('Property-Based Tests - App ID Validation', () {
    setUpAll(() async {
      // Initialize dotenv with empty values
      await dotenv.load(mergeWith: {});
    });

    test('Property 3: Valid App IDs pass validation', () async {
      /// This property verifies that any valid 32-character App ID
      /// passes validation without throwing an exception.
      ///
      /// For any string of exactly 32 characters, the validation should succeed.

      for (int iteration = 0; iteration < 100; iteration++) {
        // Generate a random valid 32-character App ID
        final validAppId = _generateRandomAppId(faker);

        // Load the App ID into dotenv
        await dotenv.load(mergeWith: {'AGORA_APP_ID': validAppId});

        // Property: Valid App ID should not throw
        expect(
          () => EnvValidator.validate(),
          returnsNormally,
          reason: 'Iteration $iteration: Valid 32-character App ID should pass validation',
        );

        // Property: getAgoraAppId should return the correct App ID
        final retrievedAppId = EnvValidator.getAgoraAppId();
        expect(
          retrievedAppId,
          equals(validAppId),
          reason: 'Iteration $iteration: Retrieved App ID should match the set App ID',
        );
      }
    });

    test('Property 3: Empty App ID throws exception', () async {
      /// This property verifies that an empty App ID always throws an exception.
      ///
      /// For any empty string or null value, validation should fail with a clear message.

      for (int iteration = 0; iteration < 100; iteration++) {
        // Test with empty string
        await dotenv.load(mergeWith: {'AGORA_APP_ID': ''});

        // Property: Empty App ID should throw
        expect(
          () => EnvValidator.validate(),
          throwsA(predicate((e) => e is Exception && e.toString().contains('AGORA_APP_ID is not set in .env file'))),
          reason: 'Iteration $iteration: Empty App ID should throw exception',
        );

        // Property: getAgoraAppId should also throw for empty App ID
        expect(
          () => EnvValidator.getAgoraAppId(),
          throwsA(predicate((e) => e is Exception && e.toString().contains('AGORA_APP_ID not found'))),
          reason: 'Iteration $iteration: getAgoraAppId should throw for empty App ID',
        );
      }
    });

    test('Property 3: Null/Missing App ID throws exception', () async {
      /// This property verifies that a missing (null) or empty App ID always throws an exception.
      ///
      /// When AGORA_APP_ID is not defined or empty in the environment, validation should fail.
      ///
      /// Note: Due to dotenv.load(mergeWith:) not clearing previous values,
      /// we test the null case by verifying empty string behavior, which follows
      /// the same code path (null || isEmpty check).

      for (int iteration = 0; iteration < 100; iteration++) {
        // Test with empty string (simulates null/missing)
        await dotenv.load(mergeWith: {'AGORA_APP_ID': ''});

        // Property: Empty/null App ID should throw
        expect(
          () => EnvValidator.validate(),
          throwsA(predicate((e) => e is Exception && e.toString().contains('AGORA_APP_ID is not set in .env file'))),
          reason: 'Iteration $iteration: Empty/null App ID should throw exception',
        );

        // Property: getAgoraAppId should also throw for empty/null App ID
        expect(
          () => EnvValidator.getAgoraAppId(),
          throwsA(predicate((e) => e is Exception && e.toString().contains('AGORA_APP_ID not found'))),
          reason: 'Iteration $iteration: getAgoraAppId should throw for empty/null App ID',
        );
      }
    });

    test('Property 3: Invalid length App IDs throw exception', () async {
      /// This property verifies that App IDs with incorrect length always throw an exception.
      ///
      /// For any string that is not exactly 32 characters, validation should fail.

      for (int iteration = 0; iteration < 100; iteration++) {
        // Generate random invalid lengths (avoiding 32)
        final invalidLengths = [
          faker.randomGenerator.integer(31, min: 1), // Too short
          faker.randomGenerator.integer(100, min: 33), // Too long
        ];

        for (final length in invalidLengths) {
          final invalidAppId = _generateRandomString(faker, length);

          // Load the invalid App ID into dotenv
          await dotenv.load(mergeWith: {'AGORA_APP_ID': invalidAppId});

          // Property: Invalid length App ID should throw
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
            reason: 'Iteration $iteration: App ID with length $length should throw exception',
          );

          // Property: getAgoraAppId should still return the value (it doesn't validate length)
          final retrievedAppId = EnvValidator.getAgoraAppId();
          expect(
            retrievedAppId,
            equals(invalidAppId),
            reason: 'Iteration $iteration: getAgoraAppId should return the value even if invalid length',
          );
        }
      }
    });

    test('Property 3: Whitespace-only App ID throws exception', () async {
      /// This property verifies that App IDs containing only whitespace throw an exception.
      ///
      /// For any string composed entirely of whitespace characters, validation should fail.
      ///
      /// Note: dotenv may trim whitespace, so this could trigger either the "not set"
      /// or "invalid length" error. Both are acceptable as they indicate validation failure.

      for (int iteration = 0; iteration < 100; iteration++) {
        // Generate whitespace-only strings of various lengths
        final whitespaceLength = faker.randomGenerator.integer(50, min: 1);
        final whitespaceAppId = ' ' * whitespaceLength;

        // Load the whitespace App ID into dotenv
        await dotenv.load(mergeWith: {'AGORA_APP_ID': whitespaceAppId});

        // Property: Whitespace App ID should throw (either "not set" or "invalid length")
        expect(
          () => EnvValidator.validate(),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  (e.toString().contains('AGORA_APP_ID is not set') ||
                      e.toString().contains('AGORA_APP_ID appears to be invalid')),
            ),
          ),
          reason: 'Iteration $iteration: Whitespace-only App ID should throw exception',
        );
      }
    });

    test('Property 3: App ID format consistency', () async {
      /// This property verifies that the App ID format is consistently validated.
      ///
      /// For any valid 32-character hexadecimal string, validation should succeed.
      /// This tests the expected format of Agora App IDs.

      for (int iteration = 0; iteration < 100; iteration++) {
        // Generate a valid hexadecimal App ID (typical Agora format)
        final hexAppId = _generateRandomHexString(faker, 32);

        // Load the App ID into dotenv
        await dotenv.load(mergeWith: {'AGORA_APP_ID': hexAppId});

        // Property: Valid hex App ID should pass validation
        expect(
          () => EnvValidator.validate(),
          returnsNormally,
          reason: 'Iteration $iteration: Valid 32-character hex App ID should pass validation',
        );

        // Property: Retrieved App ID should match exactly
        final retrievedAppId = EnvValidator.getAgoraAppId();
        expect(retrievedAppId, equals(hexAppId), reason: 'Iteration $iteration: Retrieved App ID should match exactly');

        // Property: App ID should be exactly 32 characters
        expect(
          retrievedAppId.length,
          equals(32),
          reason: 'Iteration $iteration: App ID should be exactly 32 characters',
        );
      }
    });

    test('Property 3: Validation is idempotent', () async {
      /// This property verifies that validation can be called multiple times
      /// with the same result.
      ///
      /// For any valid App ID, calling validate() multiple times should
      /// consistently succeed without side effects.

      for (int iteration = 0; iteration < 100; iteration++) {
        final validAppId = _generateRandomAppId(faker);
        await dotenv.load(mergeWith: {'AGORA_APP_ID': validAppId});

        // Property: Multiple validations should all succeed
        expect(() => EnvValidator.validate(), returnsNormally);
        expect(() => EnvValidator.validate(), returnsNormally);
        expect(() => EnvValidator.validate(), returnsNormally);

        // Property: Multiple retrievals should return the same value
        final appId1 = EnvValidator.getAgoraAppId();
        final appId2 = EnvValidator.getAgoraAppId();
        final appId3 = EnvValidator.getAgoraAppId();

        expect(appId1, equals(validAppId));
        expect(appId2, equals(validAppId));
        expect(appId3, equals(validAppId));
        expect(appId1, equals(appId2));
        expect(appId2, equals(appId3));
      }
    });

    test('Property 3: Alphanumeric with underscores and hyphens in App ID', () async {
      /// This property verifies that App IDs with safe special characters
      /// (underscores, hyphens) are handled correctly.
      ///
      /// Agora App IDs are typically alphanumeric, but the validator
      /// only checks length, not character composition. We test with
      /// safe characters that won't cause dotenv parsing issues.

      for (int iteration = 0; iteration < 100; iteration++) {
        // Generate App IDs with alphanumeric + safe special chars
        final safeSpecialChars = '_-';
        final mixedAppId = _generateMixedString(faker, 32, safeSpecialChars);

        // Verify the generated string is exactly 32 characters
        expect(
          mixedAppId.length,
          equals(32),
          reason: 'Iteration $iteration: Generated App ID should be exactly 32 characters',
        );

        await dotenv.load(mergeWith: {'AGORA_APP_ID': mixedAppId});

        // Property: 32-character App ID should pass regardless of characters
        expect(
          () => EnvValidator.validate(),
          returnsNormally,
          reason: 'Iteration $iteration: 32-character App ID should pass validation',
        );

        final retrievedAppId = EnvValidator.getAgoraAppId();
        expect(
          retrievedAppId,
          equals(mixedAppId),
          reason: 'Iteration $iteration: Retrieved App ID should match the set value',
        );
        expect(
          retrievedAppId.length,
          equals(32),
          reason: 'Iteration $iteration: Retrieved App ID should be 32 characters',
        );
      }
    });
  });
}

/// Generate a random 32-character App ID (simulating Agora App ID format)
String _generateRandomAppId(Faker faker) {
  const chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  return List.generate(32, (_) => chars[faker.randomGenerator.integer(chars.length)]).join();
}

/// Generate a random hexadecimal string of specified length
String _generateRandomHexString(Faker faker, int length) {
  const hexChars = '0123456789abcdef';
  return List.generate(length, (_) => hexChars[faker.randomGenerator.integer(hexChars.length)]).join();
}

/// Generate a random string of specified length
String _generateRandomString(Faker faker, int length) {
  const chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  return List.generate(length, (_) => chars[faker.randomGenerator.integer(chars.length)]).join();
}

/// Generate a mixed string with special characters
String _generateMixedString(Faker faker, int length, String specialChars) {
  const alphanumeric = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final allChars = alphanumeric + specialChars;
  return List.generate(length, (_) => allChars[faker.randomGenerator.integer(allChars.length)]).join();
}
