# WebSocket Clean Architecture - Migration Guide

## Tổng quan

Đã thiết kế lại hệ thống WebSocket theo Clean Architecture principles với các cải tiến:

### ✅ Lợi ích

1. **Separation of Concerns**: Tách biệt rõ ràng giữa các layer
2. **Testability**: Dễ dàng test với dependency injection
3. **Maintainability**: Code dễ bảo trì và mở rộng
4. **Flexibility**: Dễ dàng thay đổi implementation (ví dụ: từ web_socket_channel sang socket_io)
5. **Reusability**: WebSocket client có thể tái sử dụng cho các feature khác

---

## Kiến trúc mới

### 📁 Cấu trúc thư mục

```
lib/
├── core/
│   └── network/
│       ├── websocket_client.dart                    # Interface
│       ├── websocket_client_impl.dart               # Implementation
│       └── websocket_connection_manager.dart        # Connection management
│
└── features/
    └── chat/
        ├── domain/
        │   └── datasources/
        │       └── chat_websocket_datasource.dart   # Interface (Domain layer)
        │
        ├── data/
        │   └── datasources/
        │       └── chat_websocket_datasource_impl.dart  # Implementation
        │
        └── presentation/
            └── providers/
                └── chat_websocket_provider_new.dart  # Riverpod providers
```

---

## So sánh Old vs New

### 🔴 **CŨ** - `ChatWebSocketService`

```dart
// ❌ Trực tiếp phụ thuộc vào WebSocketChannel
// ❌ Khó test vì tightly coupled
// ❌ Vi phạm Dependency Inversion Principle

class ChatWebSocketService {
  WebSocketChannel? _channel;  // Concrete implementation
  
  Future<void> connect(String accessToken) async {
    _channel = WebSocketChannel.connect(...);  // Direct instantiation
  }
}
```

**Vấn đề:**
- Service layer trực tiếp phụ thuộc vào implementation cụ thể
- Không có abstraction layer
- Khó mock cho unit testing
- Connection management và message parsing lẫn lộn

---

### 🟢 **MỚI** - Clean Architecture Layers

#### 1️⃣ **Core Layer** - Infrastructure abstraction

```dart
// ✅ Abstract interface - có thể thay đổi implementation
abstract class WebSocketClient {
  Future<void> connect(String url);
  Future<void> disconnect();
  void send(String message);
  Stream<String> get messageStream;
  Stream<bool> get connectionStream;
  bool get isConnected;
}
```

#### 2️⃣ **Domain Layer** - Business rules interface

```dart
// ✅ Domain định nghĩa contract
abstract class ChatWebSocketDataSource {
  Future<void> connect(String accessToken);
  void sendMessage({required String conversationId, required String content});
  Stream<Message> get messageStream;
  Stream<TypingIndicator> get typingStream;
  // ...
}
```

#### 3️⃣ **Data Layer** - Implementation

```dart
// ✅ Implements domain interface
// ✅ Depends on abstraction (WebSocketClient)
class ChatWebSocketDataSourceImpl implements ChatWebSocketDataSource {
  final WebSocketConnectionManager _connectionManager;
  
  ChatWebSocketDataSourceImpl({
    required WebSocketConnectionManager connectionManager,
  }) : _connectionManager = connectionManager;
  
  @override
  Future<void> connect(String accessToken) async {
    await _connectionManager.connect();
  }
}
```

#### 4️⃣ **Presentation Layer** - Riverpod providers

```dart
// ✅ Dependency injection through providers
final chatWebSocketDataSourceProvider = Provider<ChatWebSocketDataSource>((ref) {
  final client = WebSocketClientImpl();
  final connectionManager = WebSocketConnectionManager(client: client, ...);
  final dataSource = ChatWebSocketDataSourceImpl(connectionManager: connectionManager);
  return dataSource;
});
```

---

## Hướng dẫn Migration

### Bước 1: Update imports

**CŨ:**
```dart
import 'package:chattrix_ui/features/chat/data/services/chat_websocket_service.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider.dart';
```

**MỚI:**
```dart
import 'package:chattrix_ui/features/chat/domain/datasources/chat_websocket_datasource.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
```

---

### Bước 2: Update providers

**CŨ:**
```dart
final wsService = ref.watch(chatWebSocketServiceProvider);
wsService.messageStream.listen((message) { ... });
```

**MỚI:**
```dart
final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);
wsDataSource.messageStream.listen((message) { ... });
```

---

### Bước 3: Update CallWebSocketHandler

**CŨ:**
```dart
// file: call_websocket_handler.dart
CallWebSocketHandler({required ChatWebSocketService webSocketService})
```

**MỚI:**
```dart
// file: call_websocket_handler_new.dart
CallWebSocketHandler({required ChatWebSocketDataSource webSocketDataSource})
```

---

### Bước 4: Update provider definitions

**CŨ:**
```dart
final callWebSocketHandlerProvider = Provider<CallWebSocketHandler>((ref) {
  final webSocketService = ref.watch(chatWebSocketServiceProvider);
  return CallWebSocketHandler(webSocketService: webSocketService);
});
```

**MỚI:**
```dart
final callWebSocketHandlerProvider = Provider<CallWebSocketHandler>((ref) {
  final webSocketDataSource = ref.watch(chatWebSocketDataSourceProvider);
  return CallWebSocketHandler(webSocketDataSource: webSocketDataSource);
});
```

---

## Chi tiết các file cần thay đổi

### ✏️ Files to UPDATE:

1. **messages_notifier.dart**
   - Import: `chat_websocket_provider_new.dart`
   - Provider: `chatWebSocketServiceProvider` → `chatWebSocketDataSourceProvider`
   - Type: `ChatWebSocketService` → `ChatWebSocketDataSource`

2. **conversations_notifier.dart**
   - Import: `chat_websocket_provider_new.dart`
   - Provider: `chatWebSocketServiceProvider` → `chatWebSocketDataSourceProvider`
   - Type: `ChatWebSocketService` → `ChatWebSocketDataSource`

3. **call_service_provider.dart**
   - Import: `call_websocket_handler_new.dart` và `chat_websocket_provider_new.dart`
   - Provider: `chatWebSocketServiceProvider` → `chatWebSocketDataSourceProvider`

4. **call_websocket_handler.dart**
   - Thay thế bằng `call_websocket_handler_new.dart`

5. **chat_view_page.dart**
   - Import: `chat_websocket_provider_new.dart`
   - Provider: `chatWebSocketServiceProvider` → `chatWebSocketDataSourceProvider`

---

## Các tính năng được giữ nguyên

✅ Auto-reconnection với exponential backoff  
✅ Heartbeat để maintain connection  
✅ Connection state management  
✅ Message type routing (chat, typing, status, call)  
✅ Raw message stream cho custom handlers  
✅ Background JSON parsing với isolates  
✅ Token refresh support  

---

## Testing Benefits

### Old way - Khó test
```dart
// ❌ Không thể mock WebSocketChannel dễ dàng
test('should receive messages', () {
  final service = ChatWebSocketService();
  // Làm sao test được khi nó connect thật?
});
```

### New way - Dễ test
```dart
// ✅ Mock interface
class MockWebSocketClient extends Mock implements WebSocketClient {}

test('should receive messages', () {
  final mockClient = MockWebSocketClient();
  when(mockClient.messageStream).thenAnswer((_) => Stream.value('{"type":"chat.message"}'));
  
  final connectionManager = WebSocketConnectionManager(client: mockClient, ...);
  final dataSource = ChatWebSocketDataSourceImpl(connectionManager: connectionManager);
  
  // Test logic here
});
```

---

## Checklist Migration

- [ ] Copy các file mới vào project
- [ ] Update `messages_notifier.dart`
- [ ] Update `conversations_notifier.dart`
- [ ] Update `call_service_provider.dart`
- [ ] Update `chat_view_page.dart`
- [ ] Replace `call_websocket_handler.dart` với version mới
- [ ] Test WebSocket connection
- [ ] Test message receiving
- [ ] Test call signaling
- [ ] Test auto-reconnection
- [ ] Xóa các file cũ:
  - [ ] `chat_websocket_service.dart`
  - [ ] `chat_websocket_provider.dart` (old)
  - [ ] `call_websocket_handler.dart` (old)

---

## Câu hỏi thường gặp (FAQ)

### Q: Có cần thay đổi API backend không?
**A:** Không, architecture mới 100% backward compatible với API hiện tại.

### Q: Performance có bị ảnh hưởng không?
**A:** Không, thậm chí có thể tốt hơn vì separation of concerns giúp optimize từng layer riêng.

### Q: Có thể dùng cả old và new cùng lúc không?
**A:** Có, nhưng không nên. Migration nên được làm một lần cho toàn bộ codebase.

### Q: Làm sao test được?
**A:** Tạo mock implementations của `WebSocketClient` và `ChatWebSocketDataSource` interfaces.

---

## Liên hệ

Nếu gặp vấn đề trong quá trình migration, vui lòng tạo issue hoặc liên hệ team.

