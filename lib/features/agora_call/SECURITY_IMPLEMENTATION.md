# Call Security Implementation

This document describes the security measures implemented for the Agora call integration feature.

## Requirements Coverage

### Requirement 10.1: JWT Token in API Requests ✅

**Implementation:**
- JWT tokens are automatically included in all API requests via `AuthInterceptor`
- The interceptor adds the `Authorization: Bearer <token>` header to every request
- Token refresh is handled automatically on 401 responses

**Location:**
- `lib/core/network/auth_interceptor.dart`
- `lib/features/agora_call/presentation/providers/agora_call_providers.dart` (uses authenticated Dio instance)

**Verification:**
```dart
// All call API requests use the authenticated Dio instance
@Riverpod(keepAlive: true)
Dio agoraCallDio(Ref ref) {
  return ref.watch(dioProvider); // Uses AuthInterceptor
}
```

### Requirement 10.2: Unique Agora Token per Call Session ✅

**Implementation:**
- Each call initiation/acceptance receives a unique Agora token from the backend
- Tokens are stored in memory only via `CallSecurityService`
- Each call ID maps to exactly one Agora token
- Tokens are never reused across different calls

**Location:**
- `lib/features/agora_call/data/services/call_security_service.dart`
- `lib/features/agora_call/presentation/providers/call_state_provider.dart`

**Usage:**
```dart
// Store token when call is initiated/accepted
final securityService = ref.read(callSecurityServiceProvider);
securityService.storeCallToken(connection.callEntity.id, connection.token);

// Retrieve token if needed
final token = securityService.getCallToken(callId);
```

### Requirement 10.3: Clear Tokens on Call End ✅

**Implementation:**
- Tokens are cleared from memory when calls end via any path:
  - User ends call (`endCall()`)
  - Call is rejected (`_handleCallRejected()`)
  - Call ends remotely (`_handleCallEnded()`)
  - Call times out (`_handleCallTimeout()`)
- All tokens are cleared on service disposal
- Tokens are never persisted to disk

**Location:**
- `lib/features/agora_call/data/services/call_security_service.dart`
- `lib/features/agora_call/presentation/providers/call_state_provider.dart`

**Cleanup Points:**
```dart
// Individual call cleanup
securityService.clearCallToken(callId);

// Full cleanup on logout/disposal
securityService.clearAllTokens();
```

### Requirement 10.5: Secure Protocols (HTTPS/WSS) ✅

**Implementation:**
- API constants automatically use HTTPS/WSS in production (release mode)
- HTTP/WS allowed only for localhost in debug mode
- Environment variable `USE_SECURE_PROTOCOL` can force secure protocols
- Security validation at app startup via `CallSecurityValidator`

**Location:**
- `lib/core/constants/api_constants.dart`
- `lib/features/agora_call/data/services/call_security_service.dart`
- `lib/features/agora_call/presentation/utils/call_security_validator.dart`

**Configuration:**
```dart
// Automatic protocol selection
static bool get _useSecureProtocol {
  // Release mode: always secure
  if (!kDebugMode) return true;
  
  // Debug mode: secure for non-localhost
  return !isLocalhost;
}
```

**Validation:**
```dart
// Call at app startup
CallSecurityValidator.validateSecurityRequirements();
```

## Security Service API

### CallSecurityService

The `CallSecurityService` provides centralized security management:

```dart
class CallSecurityService {
  // Token Management
  void storeCallToken(String callId, String agoraToken);
  String? getCallToken(String callId);
  void clearCallToken(String callId);
  void clearAllTokens();
  
  // Protocol Validation
  bool isSecureProtocol(String url);
  void validateSecureProtocols({
    required String apiBaseUrl,
    required String wsBaseUrl,
  });
  
  // Logging Safety
  String sanitizeTokenForLogging(String token);
  
  // Cleanup
  void dispose();
}
```

### Provider Integration

```dart
@Riverpod(keepAlive: true)
CallSecurityService callSecurityService(Ref ref) {
  final service = CallSecurityService();
  ref.onDispose(() => service.dispose());
  return service;
}
```

## Token Lifecycle

```
1. Call Initiated/Accepted
   ↓
2. Backend returns unique Agora token
   ↓
3. Token stored in CallSecurityService (memory only)
   ↓
4. Token used to join Agora channel
   ↓
5. Call ends (any reason)
   ↓
6. Token cleared from memory
   ↓
7. Token cannot be reused
```

## Logging Safety

### Safe Logging Practices

✅ **SAFE:**
```dart
debugPrint('Stored token for call $callId (length: ${token.length})');
debugPrint('Joined Agora channel ${connection.callEntity.channelId}');
debugPrint('Invalid or expired token'); // Generic message
```

❌ **UNSAFE (Never do this):**
```dart
debugPrint('Token: $token'); // Exposes full token
debugPrint('Connection: $connection'); // May contain token
debugPrint('Response: ${response.data}'); // May contain token
```

### Token Sanitization

Use `sanitizeTokenForLogging()` if you must log token-related info:

```dart
final sanitized = securityService.sanitizeTokenForLogging(token);
debugPrint('Token: $sanitized'); // Output: "abc1...xyz9"
```

## Environment Configuration

### Development (.env)
```env
API_HOST=localhost
API_PORT=8080
USE_SECURE_PROTOCOL=false  # Optional: allows HTTP/WS for localhost
```

### Production (.env.production)
```env
API_HOST=api.chattrix.com
API_PORT=443
USE_SECURE_PROTOCOL=true  # Enforces HTTPS/WSS
```

## Security Checklist

- [x] JWT tokens included in all API requests (AuthInterceptor)
- [x] Unique Agora token per call session (CallSecurityService)
- [x] Tokens cleared on call end (all exit paths)
- [x] Tokens never persisted to disk
- [x] HTTPS enforced in production
- [x] WSS enforced in production
- [x] No token logging (audited)
- [x] Token sanitization utility available
- [x] Security validation at startup
- [x] Secure protocol verification

## Testing Security

### Manual Testing

1. **Token Uniqueness:**
   - Initiate multiple calls
   - Verify each receives different token
   - Verify tokens are not reused

2. **Token Cleanup:**
   - Start a call
   - End the call
   - Verify token is cleared from memory

3. **Protocol Security:**
   - Build in release mode
   - Verify all URLs use HTTPS/WSS
   - Attempt HTTP/WS connection (should fail)

4. **Token Logging:**
   - Review all logs during call flow
   - Verify no full tokens appear in logs

### Automated Testing

```dart
test('Token is cleared after call ends', () async {
  final service = CallSecurityService();
  
  // Store token
  service.storeCallToken('call-123', 'token-abc');
  expect(service.getCallToken('call-123'), 'token-abc');
  
  // Clear token
  service.clearCallToken('call-123');
  expect(service.getCallToken('call-123'), null);
});

test('Secure protocols enforced in production', () {
  // Mock release mode
  expect(
    CallSecurityService().isSecureProtocol('https://api.example.com'),
    true,
  );
  expect(
    CallSecurityService().isSecureProtocol('http://api.example.com'),
    false,
  );
});
```

## Security Best Practices

1. **Never log sensitive data:**
   - No full tokens in logs
   - Use sanitization for debugging
   - Log only metadata (length, call ID)

2. **Clear tokens promptly:**
   - Clear on every call end path
   - Clear on logout
   - Clear on service disposal

3. **Use secure protocols:**
   - HTTPS for all API calls
   - WSS for WebSocket connections
   - No exceptions in production

4. **Validate at startup:**
   - Check protocol configuration
   - Verify security requirements
   - Fail fast on misconfiguration

5. **Memory-only storage:**
   - Never persist tokens to disk
   - Never cache tokens
   - Clear on app termination

## Troubleshooting

### Issue: "SecurityException: API must use HTTPS in production"

**Cause:** App is in release mode but API_HOST is configured for HTTP

**Solution:**
1. Update `.env` file: `USE_SECURE_PROTOCOL=true`
2. Or update API_HOST to use HTTPS endpoint
3. Rebuild the app

### Issue: "Invalid or expired token"

**Cause:** Agora token has expired or is invalid

**Solution:**
1. Tokens are time-limited by backend
2. End the call and initiate a new one
3. Backend should provide fresh token

### Issue: Token not cleared after call

**Cause:** Call ended through unexpected path

**Solution:**
1. Verify all call end paths call `clearCallToken()`
2. Check `_handleCallEnded()`, `_handleCallRejected()`, `_handleCallTimeout()`
3. Add cleanup to any new call end paths

## Related Files

- `lib/features/agora_call/data/services/call_security_service.dart` - Core security service
- `lib/features/agora_call/presentation/utils/call_security_validator.dart` - Validation utilities
- `lib/features/agora_call/presentation/providers/call_state_provider.dart` - Token lifecycle management
- `lib/core/network/auth_interceptor.dart` - JWT token injection
- `lib/core/constants/api_constants.dart` - Secure protocol configuration
