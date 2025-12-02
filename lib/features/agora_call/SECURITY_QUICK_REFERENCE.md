# Call Security - Quick Reference

## 🔒 Security Requirements

| Requirement | Status | Implementation |
|------------|--------|----------------|
| JWT in API requests | ✅ | Automatic via `AuthInterceptor` |
| Unique tokens per call | ✅ | `CallSecurityService` |
| Clear tokens on end | ✅ | All call end paths |
| HTTPS/WSS in production | ✅ | `ApiConstants` auto-detection |
| No token logging | ✅ | Code audited |

## 🚀 Quick Start

### Using Security Service

```dart
// Get the service
final securityService = ref.read(callSecurityServiceProvider);

// Store token (done automatically in call flow)
securityService.storeCallToken(callId, token);

// Clear token (done automatically on call end)
securityService.clearCallToken(callId);
```

### Validate Security at Startup (Optional)

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Validate security requirements
  CallSecurityValidator.validateSecurityRequirements();
  
  runApp(MyApp());
}
```

## ✅ Do's

```dart
// ✅ Log token length
debugPrint('Token stored (length: ${token.length})');

// ✅ Use sanitized token for debugging
final sanitized = securityService.sanitizeTokenForLogging(token);
debugPrint('Token: $sanitized'); // "abc1...xyz9"

// ✅ Clear tokens on all exit paths
securityService.clearCallToken(callId);

// ✅ Use authenticated Dio instance
final dio = ref.watch(agoraCallDioProvider);
```

## ❌ Don'ts

```dart
// ❌ Never log full tokens
debugPrint('Token: $token'); // FORBIDDEN

// ❌ Never persist tokens
await storage.write('token', token); // FORBIDDEN

// ❌ Never reuse tokens
final oldToken = securityService.getCallToken(oldCallId);
securityService.storeCallToken(newCallId, oldToken); // FORBIDDEN

// ❌ Never use HTTP/WS in production
const url = 'http://api.example.com'; // FORBIDDEN in production
```

## 🔧 Configuration

### Development
```env
API_HOST=localhost
API_PORT=8080
# HTTP/WS allowed for localhost
```

### Production
```env
API_HOST=api.chattrix.com
API_PORT=443
USE_SECURE_PROTOCOL=true
# HTTPS/WSS enforced
```

## 🧪 Testing

```bash
# Run security tests
flutter test test/features/agora_call/data/services/call_security_service_test.dart

# All tests should pass (15 tests)
```

## 📋 Token Lifecycle

```
1. Call Start → Token received from backend
2. Store → securityService.storeCallToken(callId, token)
3. Use → Join Agora channel with token
4. End → securityService.clearCallToken(callId)
5. Cleanup → Token removed from memory
```

## 🔍 Debugging

### Check if token is stored
```dart
final token = securityService.getCallToken(callId);
if (token != null) {
  debugPrint('Token exists for call $callId');
}
```

### Verify secure protocols
```dart
final isSecure = securityService.isSecureProtocol(url);
debugPrint('URL is secure: $isSecure');
```

### Sanitize for logging
```dart
final sanitized = securityService.sanitizeTokenForLogging(token);
debugPrint('Token: $sanitized'); // Safe to log
```

## 🚨 Common Issues

### "SecurityException: API must use HTTPS"
**Solution:** Update `.env` with `USE_SECURE_PROTOCOL=true` or use HTTPS endpoint

### "Invalid or expired token"
**Solution:** Token expired. End call and start new one with fresh token

### Token not cleared
**Solution:** Verify all call end paths call `clearCallToken()`

## 📚 Full Documentation

See `SECURITY_IMPLEMENTATION.md` for complete details.

## 🔗 Related Files

- `call_security_service.dart` - Core service
- `call_security_validator.dart` - Validation utilities
- `call_state_provider.dart` - Token lifecycle
- `api_constants.dart` - Protocol configuration
