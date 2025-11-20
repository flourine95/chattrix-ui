# Design Document: Flutter Main Thread Optimization

## Overview

This design addresses critical performance issues in the Chattrix Flutter application where heavy operations on the main thread cause frame drops and UI jank. The solution involves offloading JSON parsing to background isolates, implementing in-memory token caching, replacing polling with event-driven updates, and optimizing widget rendering.

## Architecture

The optimization follows Flutter's performance best practices:

1. **Isolate-based JSON Parsing**: Use `compute()` to parse JSON in background isolates
2. **In-Memory Token Cache**: Implement a token cache layer between Dio and FlutterSecureStorage
3. **Event-Driven Updates**: Replace polling with WebSocket-driven state updates
4. **Widget Optimization**: Use const constructors, selective rebuilds, and proper list view configuration

### Component Interaction Flow

```
WebSocket Message → Background Isolate (JSON Parse) → Main Thread (State Update) → UI Render
HTTP Request → Memory Cache (Token) → Dio Request → Response
WebSocket Event → State Notifier → UI Update (no polling)
```

## Components and Interfaces

### 1. JSON Parsing Service

**Purpose**: Offload JSON parsing from the main thread to background isolates

**Location**: `lib/core/services/json_parsing_service.dart`

**Interface**:
```dart
class JsonParsingService {
  /// Parse a single message in a background isolate
  static Future<Message> parseMessage(String jsonString);
  
  /// Parse multiple messages in a background isolate
  static Future<List<Message>> parseMessages(String jsonString);
  
  /// Parse conversation update in a background isolate
  static Future<ConversationUpdate> parseConversationUpdate(String jsonString);
  
  /// Parse typing indicator in a background isolate
  static Future<TypingIndicator> parseTypingIndicator(String jsonString);
  
  /// Parse user status update in a background isolate
  static Future<UserStatusUpdate> parseUserStatusUpdate(String jsonString);
}

// Top-level functions for isolate execution
Message _parseMessageIsolate(String jsonString);
List<Message> _parseMessagesIsolate(String jsonString);
ConversationUpdate _parseConversationUpdateIsolate(String jsonString);
TypingIndicator _parseTypingIndicatorIsolate(String jsonString);
UserStatusUpdate _parseUserStatusUpdateIsolate(String jsonString);
```

### 2. Token Cache Service

**Purpose**: Cache JWT tokens in memory to avoid repeated secure storage access

**Location**: `lib/core/services/token_cache_service.dart`

**Interface**:
```dart
class TokenCacheService {
  String? _accessToken;
  String? _refreshToken;
  final FlutterSecureStorage _secureStorage;
  
  TokenCacheService(this._secureStorage);
  
  /// Get access token (from cache or storage)
  Future<String?> getAccessToken();
  
  /// Get refresh token (from cache or storage)
  Future<String?> getRefreshToken();
  
  /// Set both tokens (updates cache and storage)
  Future<void> setTokens(String accessToken, String refreshToken);
  
  /// Clear all tokens (cache and storage)
  Future<void> clearTokens();
  
  /// Check if tokens are cached
  bool hasTokensInCache();
}
```

### 3. Optimized WebSocket Service

**Purpose**: Use background isolates for message parsing

**Location**: `lib/features/chat/data/services/chat_websocket_service.dart` (modified)

**Changes**:
- Replace synchronous `jsonDecode()` with `JsonParsingService.parseMessage()`
- Use `compute()` for all model parsing operations
- Emit entities directly after background parsing

### 4. Optimized Auth Interceptor

**Purpose**: Use token cache instead of direct secure storage access

**Location**: `lib/core/network/auth_interceptor.dart` (modified)

**Changes**:
- Inject `TokenCacheService` instead of `FlutterSecureStorage`
- Read tokens from cache synchronously in `onRequest`
- Update cache when refreshing tokens
- Clear cache on logout

### 5. Event-Driven Messages Notifier

**Purpose**: Replace polling with WebSocket event-driven updates

**Location**: `lib/features/chat/presentation/state/messages_notifier.dart` (modified)

**Changes**:
- Remove `Timer` for periodic polling
- Only refresh on WebSocket message events
- Add fallback polling when WebSocket is disconnected
- Listen to connection state to toggle between modes

## Data Models

No changes to existing data models. All models remain the same:
- `Message` / `MessageModel`
- `Conversation` / `ConversationModel`
- `TypingIndicator` / `TypingIndicatorModel`
- `UserStatusUpdate` / `UserStatusUpdateModel`
- `ConversationUpdate` / `ConversationUpdateModel`

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: JSON parsing happens in background isolate

*For any* WebSocket message received, the JSON parsing operation should execute in a background isolate, not on the main isolate
**Validates: Requirements 1.1**

### Property 2: JSON parsing does not cause frame drops

*For any* message JSON string, parsing the message should complete without causing the frame time to exceed 16.67ms on the main thread
**Validates: Requirements 1.2**

### Property 3: Rapid messages maintain 60 FPS

*For any* sequence of rapid WebSocket messages (10+ messages within 1 second), the system should maintain frame rendering times under 16.67ms
**Validates: Requirements 1.3**

### Property 4: Large payloads use compute()

*For any* JSON payload larger than 1KB, the system should use compute() to offload parsing to a background isolate
**Validates: Requirements 1.4**

### Property 5: Token cache avoids repeated storage access

*For any* sequence of token read operations, after the first read from secure storage, all subsequent reads should come from the in-memory cache without accessing storage
**Validates: Requirements 2.1**

### Property 6: Token writes are asynchronous

*For any* token write operation, the write should return immediately without blocking the main thread for more than 1ms
**Validates: Requirements 2.2**

### Property 7: Header addition uses cache

*For any* HTTP request requiring authorization, adding the authorization header should retrieve the token from cache without accessing secure storage
**Validates: Requirements 2.3**

### Property 8: Token refresh updates both cache and storage

*For any* token refresh operation, both the in-memory cache and secure storage should contain the new tokens after the operation completes
**Validates: Requirements 2.4**

### Property 9: Token clear removes from both locations

*For any* token clear operation, both the in-memory cache and secure storage should be empty after the operation completes
**Validates: Requirements 2.5**

### Property 10: WebSocket connection disables polling

*For any* WebSocket connected state, the polling timer should be null or cancelled, and updates should only come from WebSocket events
**Validates: Requirements 3.1, 3.3**

### Property 11: Disconnection enables polling

*For any* WebSocket disconnection event, the polling timer should be active and triggering periodic refreshes
**Validates: Requirements 3.2**

### Property 12: Reconnection disables polling

*For any* WebSocket reconnection event, the polling timer should be cancelled and updates should resume from WebSocket events
**Validates: Requirements 3.4**

### Property 13: WebSocket messages trigger targeted updates

*For any* message received via WebSocket, only the affected conversation's state should be updated, not all conversations
**Validates: Requirements 3.5**

### Property 14: Selective widget rebuilds

*For any* message state update, the number of widget rebuilds should be proportional to the number of changed messages, not the total message count
**Validates: Requirements 4.3**

### Property 15: Lazy loading for media

*For any* message with media attachments outside the viewport, the media should not be loaded until the message scrolls into view
**Validates: Requirements 4.4**

### Property 16: Replied message lookup caching

*For any* replied message, looking up the same replied message multiple times should only perform the search once, with subsequent lookups using cached results
**Validates: Requirements 4.5**

### Property 17: Consistent 60 FPS during typical usage

*For any* typical usage scenario (scrolling through 100 messages, receiving 10 messages, sending 5 messages), the system should maintain frame times under 16.67ms for 95% of frames
**Validates: Requirements 5.5**

## Error Handling

### JSON Parsing Errors
- **Scenario**: Invalid JSON received from WebSocket
- **Handling**: Catch exceptions in isolate, log error, skip message
- **User Impact**: Message not displayed, no app crash

### Token Cache Errors
- **Scenario**: Secure storage read/write fails
- **Handling**: Fall back to direct storage access, log warning
- **User Impact**: Slight performance degradation, no functionality loss

### WebSocket Disconnection
- **Scenario**: Network interruption or server restart
- **Handling**: Automatic reconnection with exponential backoff, enable polling fallback
- **User Impact**: Temporary delay in message delivery, automatic recovery

### Isolate Spawn Failures
- **Scenario**: System unable to create background isolate
- **Handling**: Fall back to main thread parsing, log error
- **User Impact**: Performance degradation, no functionality loss

## Testing Strategy

### Unit Tests

1. **Token Cache Service Tests**
   - Test token storage and retrieval
   - Test cache invalidation
   - Test concurrent access patterns
   - Test fallback to secure storage

2. **JSON Parsing Service Tests**
   - Test parsing valid JSON strings
   - Test handling malformed JSON
   - Test parsing different message types
   - Test isolate error handling

3. **WebSocket Service Tests**
   - Test message handling with background parsing
   - Test connection state management
   - Test error recovery

### Property-Based Tests

Property-based testing will use the **fast_check** equivalent for Dart, which is the **test** package with custom generators.

1. **Property 1: JSON Parsing Round-Trip**
   - Generate random Message entities
   - Convert to JSON, parse in isolate
   - Verify result matches original
   - Run 100+ iterations

2. **Property 2: Token Cache Consistency**
   - Generate random token operation sequences
   - Execute operations
   - Verify cache matches storage
   - Run 100+ iterations

3. **Property 3: Polling Disabled When Connected**
   - Generate random WebSocket connection states
   - Verify polling timer is null when connected
   - Verify polling timer exists when disconnected
   - Run 100+ iterations

### Integration Tests

1. **End-to-End Message Flow**
   - Send message via WebSocket
   - Verify background parsing
   - Verify UI update
   - Measure frame timing

2. **Token Refresh Flow**
   - Trigger 401 error
   - Verify token refresh uses cache
   - Verify cache updated with new tokens
   - Verify retry succeeds

3. **WebSocket Reconnection**
   - Disconnect WebSocket
   - Verify polling starts
   - Reconnect WebSocket
   - Verify polling stops

### Performance Tests

1. **Frame Timing Analysis**
   - Use Flutter DevTools Timeline
   - Record frame rendering during message receipt
   - Verify all frames < 16.67ms
   - Test with 10, 50, 100 rapid messages

2. **Memory Profiling**
   - Monitor isolate memory usage
   - Verify no memory leaks in token cache
   - Test with extended usage (1000+ messages)

3. **Network Request Timing**
   - Measure time to add auth headers
   - Compare with/without token cache
   - Verify < 1ms overhead

## Implementation Notes

### Using compute() for JSON Parsing

```dart
// Example usage
Future<Message> parseMessage(String jsonString) async {
  return await compute(_parseMessageIsolate, jsonString);
}

// Top-level function (required for compute)
Message _parseMessageIsolate(String jsonString) {
  final json = jsonDecode(jsonString);
  final model = MessageModel.fromApi(json);
  return model.toEntity();
}
```

### Token Cache Implementation

```dart
class TokenCacheService {
  String? _accessToken;
  String? _refreshToken;
  final FlutterSecureStorage _secureStorage;
  
  Future<String?> getAccessToken() async {
    if (_accessToken != null) return _accessToken;
    _accessToken = await _secureStorage.read(key: 'accessToken');
    return _accessToken;
  }
  
  Future<void> setTokens(String accessToken, String refreshToken) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    await Future.wait([
      _secureStorage.write(key: 'accessToken', value: accessToken),
      _secureStorage.write(key: 'refreshToken', value: refreshToken),
    ]);
  }
}
```

### Event-Driven Notifier Pattern

```dart
@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  Timer? _pollingTimer;
  
  @override
  FutureOr<List<Message>> build(String conversationId) async {
    final wsConnection = ref.watch(webSocketConnectionProvider);
    
    // Only poll if disconnected
    if (!wsConnection.isConnected) {
      _startPolling();
    } else {
      _stopPolling();
    }
    
    // Listen to WebSocket messages
    final wsService = ref.watch(chatWebSocketServiceProvider);
    final subscription = wsService.messageStream.listen((message) {
      if (message.conversationId.toString() == conversationId) {
        refresh();
      }
    });
    
    ref.onDispose(() {
      subscription.cancel();
      _stopPolling();
    });
    
    return _fetchMessages(conversationId);
  }
}
```

## Performance Targets

| Metric | Current | Target | Measurement |
|--------|---------|--------|-------------|
| Frame time (message receipt) | 30-50ms | < 16.67ms | Flutter DevTools |
| Token read time | 5-10ms | < 1ms | Stopwatch |
| WebSocket message processing | 20-30ms | < 10ms | Stopwatch |
| Polling frequency | Every 5s | Only when disconnected | Timer inspection |
| UI jank incidents | 10-20/min | 0/min | Frame drop counter |

## Migration Strategy

1. **Phase 1**: Implement token cache service (low risk)
2. **Phase 2**: Add JSON parsing service (medium risk)
3. **Phase 3**: Update WebSocket service to use background parsing (medium risk)
4. **Phase 4**: Replace polling with event-driven updates (low risk)
5. **Phase 5**: Optimize widget rendering (low risk)

Each phase can be tested independently and rolled back if issues arise.
