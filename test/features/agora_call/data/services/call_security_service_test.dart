import 'package:chattrix_ui/features/agora_call/data/services/call_security_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CallSecurityService', () {
    late CallSecurityService service;

    setUp(() {
      service = CallSecurityService();
    });

    tearDown(() {
      service.dispose();
    });

    group('Token Management', () {
      test('should store and retrieve call token', () {
        // Arrange
        const callId = 'call-123';
        const token = 'agora-token-abc123';

        // Act
        service.storeCallToken(callId, token);
        final retrieved = service.getCallToken(callId);

        // Assert
        expect(retrieved, token);
      });

      test('should return null for non-existent call token', () {
        // Act
        final retrieved = service.getCallToken('non-existent');

        // Assert
        expect(retrieved, null);
      });

      test('should clear specific call token', () {
        // Arrange
        const callId = 'call-123';
        const token = 'agora-token-abc123';
        service.storeCallToken(callId, token);

        // Act
        service.clearCallToken(callId);
        final retrieved = service.getCallToken(callId);

        // Assert
        expect(retrieved, null);
      });

      test('should clear all call tokens', () {
        // Arrange
        service.storeCallToken('call-1', 'token-1');
        service.storeCallToken('call-2', 'token-2');
        service.storeCallToken('call-3', 'token-3');

        // Act
        service.clearAllTokens();

        // Assert
        expect(service.getCallToken('call-1'), null);
        expect(service.getCallToken('call-2'), null);
        expect(service.getCallToken('call-3'), null);
      });

      test('should store unique tokens for different calls', () {
        // Arrange
        const callId1 = 'call-1';
        const callId2 = 'call-2';
        const token1 = 'token-1';
        const token2 = 'token-2';

        // Act
        service.storeCallToken(callId1, token1);
        service.storeCallToken(callId2, token2);

        // Assert
        expect(service.getCallToken(callId1), token1);
        expect(service.getCallToken(callId2), token2);
        expect(token1, isNot(equals(token2)));
      });
    });

    group('Protocol Security', () {
      test('should identify HTTPS as secure', () {
        // Act & Assert
        expect(service.isSecureProtocol('https://api.example.com'), true);
      });

      test('should identify WSS as secure', () {
        // Act & Assert
        expect(service.isSecureProtocol('wss://ws.example.com'), true);
      });

      test('should identify HTTP as insecure (non-localhost)', () {
        // Act & Assert
        expect(service.isSecureProtocol('http://api.example.com'), false);
      });

      test('should identify WS as insecure (non-localhost)', () {
        // Act & Assert
        expect(service.isSecureProtocol('ws://ws.example.com'), false);
      });

      test('should allow localhost HTTP in debug mode', () {
        // Act & Assert
        expect(service.isSecureProtocol('http://localhost:8080'), true);
        expect(service.isSecureProtocol('http://127.0.0.1:8080'), true);
        expect(service.isSecureProtocol('http://10.0.2.2:8080'), true);
      });

      test('should allow localhost WS in debug mode', () {
        // Act & Assert
        expect(service.isSecureProtocol('ws://localhost:8080'), true);
        expect(service.isSecureProtocol('ws://127.0.0.1:8080'), true);
        expect(service.isSecureProtocol('ws://10.0.2.2:8080'), true);
      });
    });

    group('Token Sanitization', () {
      test('should sanitize long tokens for logging', () {
        // Arrange
        const token = 'abcdefghijklmnopqrstuvwxyz123456';

        // Act
        final sanitized = service.sanitizeTokenForLogging(token);

        // Assert
        expect(sanitized, 'abcd...3456');
        expect(sanitized, isNot(contains(token)));
      });

      test('should sanitize short tokens', () {
        // Arrange
        const token = 'short';

        // Act
        final sanitized = service.sanitizeTokenForLogging(token);

        // Assert
        expect(sanitized, '***');
      });

      test('should not expose full token in sanitized output', () {
        // Arrange
        const token = 'secret-token-12345678';

        // Act
        final sanitized = service.sanitizeTokenForLogging(token);

        // Assert
        expect(sanitized, isNot(equals(token)));
        expect(sanitized.length, lessThan(token.length));
      });
    });

    group('Disposal', () {
      test('should clear all tokens on dispose', () {
        // Arrange
        service.storeCallToken('call-1', 'token-1');
        service.storeCallToken('call-2', 'token-2');

        // Act
        service.dispose();

        // Assert
        expect(service.getCallToken('call-1'), null);
        expect(service.getCallToken('call-2'), null);
      });
    });
  });
}
