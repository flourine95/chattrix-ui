# WebSocket Clean Architecture - Sơ đồ kiến trúc

## Tổng quan Layers

```
┌─────────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                            │
│  ┌────────────────────────────────────────────────────────┐    │
│  │  chat_websocket_provider_new.dart                      │    │
│  │  - chatWebSocketDataSourceProvider                     │    │
│  │  - webSocketConnectionProvider                         │    │
│  │  - WebSocketConnectionNotifier                         │    │
│  └────────────────────────────────────────────────────────┘    │
│  ┌────────────────────────────────────────────────────────┐    │
│  │  State Notifiers                                       │    │
│  │  - MessagesNotifier (messages_notifier.dart)           │    │
│  │  - ConversationsNotifier (conversations_notifier.dart) │    │
│  └────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
                              ↓ depends on
┌─────────────────────────────────────────────────────────────────┐
│                      DOMAIN LAYER                                │
│  ┌────────────────────────────────────────────────────────┐    │
│  │  chat_websocket_datasource.dart (Interface)            │    │
│  │  abstract class ChatWebSocketDataSource {              │    │
│  │    Future<void> connect(String accessToken);           │    │
│  │    void sendMessage({...});                            │    │
│  │    Stream<Message> get messageStream;                  │    │
│  │    Stream<TypingIndicator> get typingStream;           │    │
│  │    Stream<bool> get connectionStream;                  │    │
│  │    // ... other methods                                │    │
│  │  }                                                      │    │
│  └────────────────────────────────────────────────────────┘    │
│  ┌────────────────────────────────────────────────────────┐    │
│  │  Domain Entities                                       │    │
│  │  - Message                                             │    │
│  │  - TypingIndicator                                     │    │
│  │  - ConversationUpdate                                  │    │
│  │  - UserStatusUpdate                                    │    │
│  └────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
                              ↓ implements
┌─────────────────────────────────────────────────────────────────┐
│                       DATA LAYER                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │  chat_websocket_datasource_impl.dart                   │    │
│  │  class ChatWebSocketDataSourceImpl                     │    │
│  │      implements ChatWebSocketDataSource {              │    │
│  │                                                         │    │
│  │    final WebSocketConnectionManager _connectionManager;│    │
│  │                                                         │    │
│  │    - Handles message routing                           │    │
│  │    - JSON parsing with background isolates             │    │
│  │    - Event broadcasting via streams                    │    │
│  │  }                                                      │    │
│  └────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
                              ↓ depends on
┌─────────────────────────────────────────────────────────────────┐
│                  INFRASTRUCTURE LAYER (Core)                     │
│  ┌────────────────────────────────────────────────────────┐    │
│  │  websocket_connection_manager.dart                     │    │
│  │  - Auto-reconnection logic                             │    │
│  │  - Heartbeat mechanism                                 │    │
│  │  - Connection state management                         │    │
│  └────────────────────────────────────────────────────────┘    │
│  ┌────────────────────────────────────────────────────────┐    │
│  │  websocket_client.dart (Interface)                     │    │
│  │  abstract class WebSocketClient {                      │    │
│  │    Future<void> connect(String url);                   │    │
│  │    void send(String message);                          │    │
│  │    Stream<String> get messageStream;                   │    │
│  │    Stream<bool> get connectionStream;                  │    │
│  │  }                                                      │    │
│  └────────────────────────────────────────────────────────┘    │
│  ┌────────────────────────────────────────────────────────┐    │
│  │  websocket_client_impl.dart                            │    │
│  │  - Concrete implementation using web_socket_channel    │    │
│  │  - Can be replaced with socket_io or other libraries   │    │
│  └────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
```

---

## Data Flow - Message Receiving

```
┌──────────────┐
│   Server     │ Sends WebSocket message
└──────────────┘
       ↓
┌──────────────────────────────────────────────┐
│  WebSocketClientImpl                         │
│  - Receives raw WebSocket message (String)   │
│  - Emits to messageStream                    │
└──────────────────────────────────────────────┘
       ↓
┌──────────────────────────────────────────────┐
│  WebSocketConnectionManager                  │
│  - Passes through to datasource              │
└──────────────────────────────────────────────┘
       ↓
┌──────────────────────────────────────────────┐
│  ChatWebSocketDataSourceImpl                 │
│  - Parses JSON                               │
│  - Routes by message type:                   │
│    • chat.message → messageStream            │
│    • typing.indicator → typingStream         │
│    • user.status → userStatusStream          │
│    • conversation.update → conversationUpdate│
│    • call.* → rawMessageStream               │
└──────────────────────────────────────────────┘
       ↓
┌──────────────────────────────────────────────┐
│  MessagesNotifier / ConversationsNotifier    │
│  - Listens to specific streams               │
│  - Updates UI state                          │
└──────────────────────────────────────────────┘
       ↓
┌──────────────────────────────────────────────┐
│  UI (ChatViewPage, etc.)                     │
│  - Reactively updates from state             │
└──────────────────────────────────────────────┘
```

---

## Data Flow - Message Sending

```
┌──────────────┐
│  User input  │ Types message and presses send
└──────────────┘
       ↓
┌──────────────────────────────────────────────┐
│  ChatViewPage                                 │
│  - Calls wsDataSource.sendMessage(...)       │
└──────────────────────────────────────────────┘
       ↓
┌──────────────────────────────────────────────┐
│  ChatWebSocketDataSourceImpl                 │
│  - Constructs JSON payload                   │
│  - Calls connectionManager.client.send()     │
└──────────────────────────────────────────────┘
       ↓
┌──────────────────────────────────────────────┐
│  WebSocketConnectionManager                  │
│  - Passes through to client                  │
└──────────────────────────────────────────────┘
       ↓
┌──────────────────────────────────────────────┐
│  WebSocketClientImpl                         │
│  - Sends via WebSocketChannel                │
└──────────────────────────────────────────────┘
       ↓
┌──────────────┐
│   Server     │ Processes and broadcasts to all clients
└──────────────┘
       ↓
       Back to "Message Receiving" flow
```

---

## Connection Lifecycle

```
┌─────────────────────────────────────────────────────────┐
│ 1. App Initialization                                   │
│    - WebSocketConnectionNotifier.build() is called      │
│    - Reads access token from TokenCacheService          │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ 2. Connection Request                                   │
│    - dataSource.connect(accessToken) is called          │
│    - URL is constructed: ws://host/chat?token=xxx       │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ 3. WebSocket Handshake                                  │
│    - WebSocketClientImpl.connect(url)                   │
│    - WebSocketChannel.connect(Uri.parse(url))           │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ 4. Connection Established                               │
│    - connectionStream emits true                        │
│    - Heartbeat timer starts (every 30s)                 │
│    - Message listener starts                            │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ 5. Active Communication                                 │
│    - Messages are sent/received                         │
│    - Heartbeat keeps connection alive                   │
└─────────────────────────────────────────────────────────┘
                        ↓ (if disconnected)
┌─────────────────────────────────────────────────────────┐
│ 6. Auto-Reconnection                                    │
│    - connectionStream emits false                       │
│    - Reconnect timer starts (5s delay)                  │
│    - Attempts to reconnect with last URL                │
└─────────────────────────────────────────────────────────┘
```

---

## Dependency Injection Flow

```
Provider Hierarchy:

chatWebSocketDataSourceProvider
    ↓ creates
WebSocketClientImpl
    ↓ injected into
WebSocketConnectionManager
    ↓ injected into
ChatWebSocketDataSourceImpl
    ↓ provided as
ChatWebSocketDataSource (interface)
    ↓ used by
messagesProvider, conversationsProvider, callHandlerProvider
```

---

## Clean Architecture Benefits Illustrated

### ❌ Old Architecture (Tight Coupling)

```
MessagesNotifier
    ↓ direct dependency
ChatWebSocketService
    ↓ direct dependency
WebSocketChannel (concrete)
```

**Problem:** Cannot easily:
- Test in isolation
- Replace WebSocket library
- Mock for unit tests
- Reuse components

---

### ✅ New Architecture (Loose Coupling)

```
MessagesNotifier
    ↓ depends on interface
ChatWebSocketDataSource (abstract)
    ↑ implemented by
ChatWebSocketDataSourceImpl
    ↓ depends on interface
WebSocketClient (abstract)
    ↑ implemented by
WebSocketClientImpl
```

**Benefits:**
- ✅ Easy to test (mock interfaces)
- ✅ Easy to replace implementation
- ✅ Clear separation of concerns
- ✅ Reusable components

---

## Message Type Routing

```
Incoming WebSocket Message:
{
  "type": "chat.message",
  "payload": {...}
}

ChatWebSocketDataSourceImpl._handleMessage():
    ↓
Parse JSON to get type
    ↓
Switch on type:
    ├─ "chat.message"        → messageStream
    ├─ "typing.indicator"    → typingStream
    ├─ "user.status"         → userStatusStream
    ├─ "conversation.update" → conversationUpdateStream
    ├─ "call.incoming"       → rawMessageStream
    ├─ "call.accepted"       → rawMessageStream
    ├─ "call.rejected"       → rawMessageStream
    └─ "call.ended"          → rawMessageStream
```

---

## Call Signaling Integration

```
┌─────────────────────────────────────────┐
│  ChatWebSocketDataSourceImpl           │
│  - rawMessageStream emits all messages  │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│  CallWebSocketHandler                   │
│  - Subscribes to rawMessageStream       │
│  - Filters call-related messages        │
│  - Parses to CallInvitation entities    │
│  - Emits to specialized call streams    │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│  CallNotifier (or call-related UI)      │
│  - Shows incoming call UI               │
│  - Manages call state                   │
└─────────────────────────────────────────┘
```

---

## Testing Strategy

### Unit Tests

```dart
// Mock the WebSocket client
class MockWebSocketClient extends Mock implements WebSocketClient {}

test('should route chat messages correctly', () {
  // Arrange
  final mockClient = MockWebSocketClient();
  final messageController = StreamController<String>();
  
  when(mockClient.messageStream).thenAnswer((_) => messageController.stream);
  when(mockClient.connectionStream).thenAnswer((_) => Stream.value(true));
  
  final manager = WebSocketConnectionManager(client: mockClient);
  final dataSource = ChatWebSocketDataSourceImpl(connectionManager: manager);
  
  // Act
  messageController.add('{"type":"chat.message","payload":{...}}');
  
  // Assert
  expect(dataSource.messageStream, emits(isA<Message>()));
});
```

### Integration Tests

```dart
test('should reconnect automatically on disconnect', () async {
  // Test auto-reconnection logic
  // Verify heartbeat mechanism
  // Test token refresh on reconnect
});
```

---

## Files Created/Modified Summary

### ✅ New Files Created:

1. `lib/core/network/websocket_client.dart` - Interface
2. `lib/core/network/websocket_client_impl.dart` - Implementation
3. `lib/core/network/websocket_connection_manager.dart` - Connection logic
4. `lib/features/chat/domain/datasources/chat_websocket_datasource.dart` - Domain interface
5. `lib/features/chat/data/datasources/chat_websocket_datasource_impl.dart` - Data implementation
6. `lib/features/chat/presentation/providers/chat_websocket_provider_new.dart` - New providers
7. `lib/features/call/services/call_websocket_handler_new.dart` - Updated handler

### ✏️ Files Modified:

1. `lib/features/chat/presentation/state/messages_notifier.dart`
2. `lib/features/chat/presentation/state/conversations_notifier.dart`
3. `lib/features/call/presentation/providers/call_service_provider.dart`
4. `lib/features/chat/presentation/pages/chat_view_page.dart`
5. `lib/features/chat/presentation/providers/chat_providers.dart`

### 📚 Documentation:

1. `WEBSOCKET_MIGRATION_GUIDE.md` - Migration guide
2. `WEBSOCKET_ARCHITECTURE.md` - This file

---

## Conclusion

Thiết kế mới tuân thủ Clean Architecture với:

- **Domain Layer** định nghĩa business rules (interfaces)
- **Data Layer** implement các interfaces
- **Infrastructure Layer** cung cấp technical capabilities
- **Presentation Layer** sử dụng dependency injection

Tất cả dependencies đều point inward (toward domain), không có circular dependencies, dễ test và maintain.

