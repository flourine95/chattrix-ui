# WebSocket Architecture - Visual Diagrams

## 🎨 So sánh trực quan 2 versions

### 🟢 SIMPLE VERSION (Không dùng Interface)

```
┌─────────────────────────────────────────────────────────┐
│                    PRESENTATION                         │
│  ┌───────────────────────────────────────────────┐     │
│  │  Riverpod Providers                           │     │
│  │  - webSocketManagerProvider                   │     │
│  │  - chatWebSocketServiceSimpleProvider         │     │
│  │  - webSocketConnectionSimpleProvider          │     │
│  └───────────────────────────────────────────────┘     │
│                      ↓ uses                             │
└─────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────┐
│                    SERVICE LAYER                        │
│  ┌───────────────────────────────────────────────┐     │
│  │  ChatWebSocketService (concrete)              │     │
│  │  - sendMessage()                              │     │
│  │  - Stream<Message> messageStream              │     │
│  └───────────────────────────────────────────────┘     │
│                      ↓ uses                             │
└─────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────┐
│                    CORE LAYER                           │
│  ┌───────────────────────────────────────────────┐     │
│  │  WebSocketManager (concrete)                  │     │
│  │  - connect(String url)                        │     │
│  │  - send(String message)                       │     │
│  │  - Stream<String> messageStream               │     │
│  │  - Auto-reconnect logic                       │     │
│  │  - Heartbeat mechanism                        │     │
│  └───────────────────────────────────────────────┘     │
│                      ↓ uses                             │
│  ┌───────────────────────────────────────────────┐     │
│  │  WebSocketChannel (web_socket_channel pkg)    │     │
│  └───────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────┘

Tổng: 3 files
Complexity: ⭐⭐ (Simple)
```

---

### 🔵 CLEAN ARCHITECTURE VERSION (Dùng Interface)

```
┌─────────────────────────────────────────────────────────┐
│                    PRESENTATION                         │
│  ┌───────────────────────────────────────────────┐     │
│  │  Riverpod Providers                           │     │
│  │  - chatWebSocketDataSourceProvider            │     │
│  │  - webSocketConnectionProvider                │     │
│  └───────────────────────────────────────────────┘     │
│                      ↓ depends on                       │
└─────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────┐
│                    DOMAIN LAYER                         │
│  ┌───────────────────────────────────────────────┐     │
│  │  ChatWebSocketDataSource (interface) 🎯       │     │
│  │  abstract class {                             │     │
│  │    Future<void> connect(String token);        │     │
│  │    Stream<Message> get messageStream;         │     │
│  │  }                                             │     │
│  └───────────────────────────────────────────────┘     │
│                      ↑ implements                       │
└─────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────┐
│                    DATA LAYER                           │
│  ┌───────────────────────────────────────────────┐     │
│  │  ChatWebSocketDataSourceImpl (concrete)       │     │
│  │  implements ChatWebSocketDataSource           │     │
│  └───────────────────────────────────────────────┘     │
│                      ↓ uses                             │
│  ┌───────────────────────────────────────────────┐     │
│  │  WebSocketConnectionManager (concrete)        │     │
│  │  - Auto-reconnect                             │     │
│  │  - Heartbeat                                  │     │
│  └───────────────────────────────────────────────┘     │
│                      ↓ depends on                       │
└─────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────┐
│                    INFRASTRUCTURE                       │
│  ┌───────────────────────────────────────────────┐     │
│  │  WebSocketClient (interface) 🎯               │     │
│  │  abstract class {                             │     │
│  │    Future<void> connect(String url);          │     │
│  │    Stream<String> get messageStream;          │     │
│  │  }                                             │     │
│  └───────────────────────────────────────────────┘     │
│                      ↑ implements                       │
│  ┌───────────────────────────────────────────────┐     │
│  │  WebSocketClientImpl (concrete)               │     │
│  │  implements WebSocketClient                   │     │
│  └───────────────────────────────────────────────┘     │
│                      ↓ uses                             │
│  ┌───────────────────────────────────────────────┐     │
│  │  WebSocketChannel (web_socket_channel pkg)    │     │
│  └───────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────┘

Tổng: 7 files
Complexity: ⭐⭐⭐⭐ (Advanced)
```

---

## 🔄 Riverpod Lifecycle - Cả 2 versions đều dùng

```
┌──────────────────────────────────────────────────┐
│  App starts                                      │
└──────────────────────────────────────────────────┘
                    ↓
┌──────────────────────────────────────────────────┐
│  Riverpod creates provider instance              │
│  - Provider auto-detect dependencies             │
│  - Lazy initialization                           │
└──────────────────────────────────────────────────┘
                    ↓
┌──────────────────────────────────────────────────┐
│  ref.watch() triggers provider build             │
│                                                   │
│  final service = ref.watch(wsProvider);          │
│  └─→ Riverpod creates WebSocketManager           │
│      └─→ Returns instance                        │
└──────────────────────────────────────────────────┘
                    ↓
┌──────────────────────────────────────────────────┐
│  Provider is active                              │
│  - Instance stays alive                          │
│  - ref.onDispose() is registered                 │
└──────────────────────────────────────────────────┘
                    ↓
┌──────────────────────────────────────────────────┐
│  When provider is disposed:                      │
│  1. ref.onDispose() callbacks are called         │
│  2. service.dispose() is called                  │
│  3. WebSocket is disconnected                    │
│  4. Streams are closed                           │
│  5. Timers are cancelled                         │
└──────────────────────────────────────────────────┘
```

---

## 📦 File Structure Comparison

### SIMPLE Version (3 files):

```
lib/
├── core/
│   └── network/
│       └── websocket_manager_simple.dart         ← 1 file
│
└── features/chat/
    ├── data/services/
    │   └── chat_websocket_service_simple.dart    ← 1 file
    │
    └── presentation/providers/
        └── chat_websocket_provider_simple.dart   ← 1 file
```

### CLEAN Version (7 files):

```
lib/
├── core/
│   ���── network/
│       ├── websocket_client.dart                 ← Interface
│       ├── websocket_client_impl.dart            ← Implementation
│       └── websocket_connection_manager.dart     ← Manager
│
└── features/chat/
    ├── domain/datasources/
    │   └── chat_websocket_datasource.dart        ← Interface
    │
    ├── data/datasources/
    │   └── chat_websocket_datasource_impl.dart   ← Implementation
    │
    └── presentation/providers/
        └── chat_websocket_provider_new.dart      ← Providers
```

---

## 🎯 Dependency Injection Flow

### SIMPLE Version:

```
Provider creates instance
        ↓
WebSocketManager (concrete class)
        ↓
ChatWebSocketService uses WebSocketManager
        ↓
MessagesNotifier uses ChatWebSocketService
```

### CLEAN Version:

```
Provider creates instance
        ↓
WebSocketClient (interface) ← WebSocketClientImpl (concrete)
        ↓
WebSocketConnectionManager depends on WebSocketClient interface
        ↓
ChatWebSocketDataSource (interface) ← ChatWebSocketDataSourceImpl (concrete)
        ↓
MessagesNotifier depends on ChatWebSocketDataSource interface
```

---

## 🧪 Testing Difficulty

### SIMPLE - Mock concrete class:

```dart
class MockWebSocketManager extends Mock implements WebSocketManager {
  // ⚠️ Must override ALL methods from concrete class
}

// In test:
final mock = MockWebSocketManager();
when(mock.messageStream).thenAnswer(...);
when(mock.connectionStream).thenAnswer(...);
when(mock.isConnected).thenReturn(...);
when(mock.connect(any)).thenAnswer(...);
when(mock.disconnect()).thenAnswer(...);
when(mock.send(any)).thenReturn(null);
// ... many more stubs needed
```

### CLEAN - Mock interface:

```dart
class MockWebSocketClient extends Mock implements WebSocketClient {
  // ✅ Only need to override interface methods
}

// In test:
final mock = MockWebSocketClient();
when(mock.messageStream).thenAnswer(...);
when(mock.connect(any)).thenAnswer(...);
// ... fewer stubs needed, cleaner
```

---

## 💰 Cost vs Benefit

```
                    SIMPLE              CLEAN ARCHITECTURE
                      ↓                        ↓
Files               3 files                 7 files
Lines of code       ~400 LOC               ~800 LOC
Learning curve      1 day                  3-5 days
Setup time          30 mins                2 hours
Test difficulty     Medium                 Easy
Flexibility         Low                    High
Maintainability     Medium                 High
Team size           1-3 people             4+ people
Project lifetime    < 1 year               2+ years
```

---

## 🚀 Quick Start Guide

### Dùng SIMPLE version:

```dart
// 1. Update provider export
// chat_providers.dart
export 'chat_websocket_provider_simple.dart';

// 2. In your code
final service = ref.watch(chatWebSocketServiceSimpleProvider);

// 3. Use it
service.messageStream.listen((message) { ... });
service.sendMessage(conversationId: '...', content: '...');
```

### Dùng CLEAN version:

```dart
// 1. Update provider export
// chat_providers.dart
export 'chat_websocket_provider_new.dart';

// 2. In your code
final dataSource = ref.watch(chatWebSocketDataSourceProvider);

// 3. Use it
dataSource.messageStream.listen((message) { ... });
dataSource.sendMessage(conversationId: '...', content: '...');
```

**→ API usage giống nhau 95%!**

---

## 📈 When to Upgrade from SIMPLE to CLEAN?

Signals bạn nên upgrade:

1. ✅ Team > 3 people
2. ✅ Need unit tests coverage > 70%
3. ✅ Planning to switch WebSocket library
4. ✅ Code review mentions "tight coupling"
5. ✅ Hard to test current implementation
6. ✅ Need to mock WebSocket for testing
7. ✅ Project will run 2+ years

Nếu **3+ signals**, nên upgrade sang CLEAN!

---

## 🎓 Kết luận

### Cả 2 versions đều:
- ✅ Dùng **Riverpod** để quản lý lifecycle
- ✅ **Auto-reconnect** khi mất kết nối
- ✅ **Heartbeat** để giữ connection
- ✅ **Stream-based** API
- ✅ **Production ready**

### Khác nhau:
- **SIMPLE**: Concrete classes, ít files, dễ hiểu
- **CLEAN**: Interfaces, nhiều files, flexible hơn

### Chọn nào?
- **Start SIMPLE** → Ship fast
- **Grow to CLEAN** → Scale well

**Cả 2 đều TỐT!** Chọn theo nhu cầu dự án của bạn. 🎉

