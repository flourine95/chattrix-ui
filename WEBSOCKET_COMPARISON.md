# So sánh 2 cách thiết kế WebSocket

## 🎯 Câu hỏi của bạn:

1. **Có thể dùng Riverpod không?** → ✅ CÓ! Cả 2 version đều dùng Riverpod
2. **Có cần viết interface không?** → ⚖️ TÙY THEO nhu cầu

---

## 📊 So sánh 2 versions

| Tiêu chí | Version SIMPLE (Mới) | Version CLEAN ARCHITECTURE (Đã làm) |
|----------|---------------------|-------------------------------------|
| **Số files** | 3 files | 7 files |
| **Complexity** | ⭐⭐ Đơn giản | ⭐⭐⭐⭐ Phức tạp hơn |
| **Interfaces** | ❌ Không có | ✅ Có (abstract classes) |
| **Testability** | ⚠️ Khó test (phải mock concrete class) | ✅ Dễ test (mock interface) |
| **Flexibility** | ⚠️ Khó đổi implementation | ✅ Dễ đổi implementation |
| **Learning curve** | ✅ Dễ hiểu | ⚠️ Cần hiểu Clean Architecture |
| **Dùng Riverpod** | ✅ CÓ | ✅ CÓ |
| **Production ready** | ✅ CÓ | ✅ CÓ |

---

## 🟢 VERSION SIMPLE - Không dùng Interface

### Files cần tạo:

```
lib/
├── core/network/
│   └── websocket_manager_simple.dart          # 1 file duy nhất
│
└── features/chat/
    ├── data/services/
    │   └── chat_websocket_service_simple.dart # Service layer
    │
    └── presentation/providers/
        └── chat_websocket_provider_simple.dart # Riverpod providers
```

### Code example:

```dart
// ✅ Concrete class - Không cần interface
class WebSocketManager {
  WebSocketChannel? _channel;
  
  Future<void> connect(String url) async {
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }
  
  void send(String message) {
    _channel?.sink.add(message);
  }
}

// ✅ Riverpod quản lý lifecycle
final webSocketManagerProvider = Provider<WebSocketManager>((ref) {
  final manager = WebSocketManager();
  ref.onDispose(() => manager.dispose());
  return manager;
});

// ✅ Sử dụng
final service = ref.watch(webSocketManagerProvider);
service.connect('ws://...');
```

### ✅ Ưu điểm:
- Code ngắn gọn, dễ hiểu
- Ít files hơn → dễ maintain
- Không cần học Clean Architecture
- Riverpod vẫn quản lý lifecycle tốt
- **Đủ dùng cho hầu hết ứng dụng**

### ❌ Nhược điểm:
- Khó viết unit test (phải mock concrete class)
- Khó thay đổi WebSocket library (ví dụ: đổi sang socket_io)
- Không theo chuẩn Clean Architecture

---

## 🔵 VERSION CLEAN ARCHITECTURE - Dùng Interface

### Files cần tạo:

```
lib/
├── core/network/
│   ├── websocket_client.dart              # Interface
│   ├── websocket_client_impl.dart         # Implementation
│   └── websocket_connection_manager.dart  # Manager
│
└── features/chat/
    ├── domain/datasources/
    │   └── chat_websocket_datasource.dart      # Interface
    │
    ├── data/datasources/
    │   └── chat_websocket_datasource_impl.dart # Implementation
    │
    └── presentation/providers/
        └── chat_websocket_provider_new.dart    # Riverpod providers
```

### Code example:

```dart
// ✅ Abstract interface
abstract class WebSocketClient {
  Future<void> connect(String url);
  void send(String message);
  Stream<String> get messageStream;
}

// ✅ Concrete implementation
class WebSocketClientImpl implements WebSocketClient {
  WebSocketChannel? _channel;
  
  @override
  Future<void> connect(String url) async {
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }
}

// ✅ Riverpod inject dependency
final webSocketClientProvider = Provider<WebSocketClient>((ref) {
  final client = WebSocketClientImpl();
  ref.onDispose(() => client.dispose());
  return client;
});

// ✅ Domain layer depends on interface
abstract class ChatWebSocketDataSource {
  Future<void> connect(String token);
  Stream<Message> get messageStream;
}
```

### ✅ Ưu điểm:
- **Rất dễ test** - Mock interface
- **Flexible** - Dễ đổi implementation
- **Clean Architecture** - Separation of concerns
- **Professional** - Theo best practices
- Riverpod vẫn quản lý lifecycle

### ❌ Nhược điểm:
- Nhiều files hơn
- Code dài hơn
- Cần hiểu Clean Architecture
- Overkill cho dự án nhỏ

---

## 🎯 Nên chọn version nào?

### Chọn **SIMPLE** nếu:
- ✅ Dự án cá nhân / startup / MVP
- ✅ Team nhỏ (1-3 người)
- ✅ Chưa quen Clean Architecture
- ✅ Không cần test coverage cao
- ✅ Muốn ship nhanh

### Chọn **CLEAN ARCHITECTURE** nếu:
- ✅ Dự án lớn / production app
- ✅ Team đông (4+ người)
- ✅ Cần test coverage cao (>80%)
- ✅ Cần maintain lâu dài (2+ years)
- ✅ Có thể cần đổi WebSocket library sau này

---

## 🔄 Migration Guide

### Nếu dùng SIMPLE version:

#### 1. Update imports:
```dart
// OLD
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';

// NEW
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_simple.dart';
```

#### 2. Update provider:
```dart
// OLD
final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);

// NEW
final wsService = ref.watch(chatWebSocketServiceSimpleProvider);
```

#### 3. Usage giữ nguyên:
```dart
// Vẫn dùng như cũ
wsService.messageStream.listen(...);
wsService.sendMessage(conversationId: '...', content: '...');
```

---

## 📝 Example Usage - Cả 2 version đều dùng Riverpod

### SIMPLE Version:

```dart
// messages_notifier.dart
@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  @override
  FutureOr<List<Message>> build(String conversationId) async {
    // ✅ Riverpod inject dependency
    final wsService = ref.watch(chatWebSocketServiceSimpleProvider);

    // ✅ Listen to WebSocket
    wsService.messageStream.listen((message) {
      if (message.conversationId == conversationId) {
        refresh();
      }
    });

    return _fetchMessages(conversationId);
  }
}
```

### CLEAN ARCHITECTURE Version:

```dart
// messages_notifier.dart
@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  @override
  FutureOr<List<Message>> build(String conversationId) async {
    // ✅ Riverpod inject dependency (interface)
    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);

    // ✅ Listen to WebSocket
    wsDataSource.messageStream.listen((message) {
      if (message.conversationId == conversationId) {
        refresh();
      }
    });

    return _fetchMessages(conversationId);
  }
}
```

**→ Từ góc độ sử dụng, CẢ 2 VERSIONS ĐEU GIỐNG NHAU!**

---

## 🧪 Testing Comparison

### SIMPLE - Khó test hơn:

```dart
// ❌ Phải mock concrete class
class MockWebSocketManager extends Mock implements WebSocketManager {}

test('should receive messages', () {
  final mockManager = MockWebSocketManager();
  // Phải mock tất cả methods của concrete class
  when(mockManager.messageStream).thenAnswer((_) => Stream.value('...'));
  when(mockManager.connectionStream).thenAnswer((_) => Stream.value(true));
  when(mockManager.isConnected).thenReturn(true);
  
  final service = ChatWebSocketService(wsManager: mockManager);
  // ... test logic
});
```

### CLEAN ARCHITECTURE - Dễ test:

```dart
// ✅ Mock interface - rất clean
class MockWebSocketClient extends Mock implements WebSocketClient {}

test('should receive messages', () {
  final mockClient = MockWebSocketClient();
  when(mockClient.messageStream).thenAnswer((_) => Stream.value('...'));
  
  final manager = WebSocketConnectionManager(client: mockClient);
  // ... test logic
});
```

---

## 💡 Kết luận

### TL;DR:

1. **CÓ thể dùng Riverpod** ✅
   - Cả 2 versions đều dùng Riverpod
   - Riverpod quản lý lifecycle, dependency injection

2. **KHÔNG BẮT BUỘC viết interface** ⚖️
   - Version SIMPLE: Không cần interface → Đơn giản hơn
   - Version CLEAN: Có interface → Flexible, testable hơn

### Khuyến nghị:

- **Bắt đầu với SIMPLE** → Ship nhanh
- **Nếu dự án phát triển** → Refactor sang CLEAN ARCHITECTURE sau

### Files đã tạo cho bạn:

✅ **SIMPLE version:**
- `websocket_manager_simple.dart`
- `chat_websocket_service_simple.dart`
- `chat_websocket_provider_simple.dart`

✅ **CLEAN version:**
- `websocket_client.dart` + `websocket_client_impl.dart`
- `websocket_connection_manager.dart`
- `chat_websocket_datasource.dart` + `chat_websocket_datasource_impl.dart`
- `chat_websocket_provider_new.dart`

**Bạn chọn version nào cũng được!** 🎉

