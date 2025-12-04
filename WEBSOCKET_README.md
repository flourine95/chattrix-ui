# 🚀 WebSocket Implementation - Hướng dẫn đầy đủ

Đã thiết kế lại WebSocket với **2 VERSIONS** để bạn chọn:

---

## 📚 Tài liệu

Đọc theo thứ tự:

1. **[WEBSOCKET_COMPARISON.md](./WEBSOCKET_COMPARISON.md)** ← BẮT ĐẦU ĐÂY
   - So sánh 2 versions chi tiết
   - Khi nào dùng version nào
   - Code examples

2. **[WEBSOCKET_VISUAL_GUIDE.md](./WEBSOCKET_VISUAL_GUIDE.md)**
   - Sơ đồ trực quan
   - Flow diagrams
   - File structure

3. **[WEBSOCKET_ARCHITECTURE.md](./WEBSOCKET_ARCHITECTURE.md)**
   - Chi tiết Clean Architecture version
   - Data flow
   - Testing strategy

4. **[WEBSOCKET_MIGRATION_GUIDE.md](./WEBSOCKET_MIGRATION_GUIDE.md)**
   - Hướng dẫn migration từ old code
   - Step-by-step guide
   - Checklist

---

## ⚡ Quick Decision

### Chọn SIMPLE nếu:
- ✅ Dự án nhỏ / MVP / startup
- ✅ Team 1-3 người
- ✅ Muốn ship nhanh
- ✅ Chưa quen Clean Architecture

👉 **Dùng files:**
- `websocket_manager_simple.dart`
- `chat_websocket_service_simple.dart`
- `chat_websocket_provider_simple.dart`

### Chọn CLEAN ARCHITECTURE nếu:
- ✅ Dự án lớn / production
- ✅ Team 4+ người
- ✅ Cần test coverage cao
- ✅ Maintain lâu dài (2+ years)

👉 **Dùng files:**
- `websocket_client.dart` + `websocket_client_impl.dart`
- `websocket_connection_manager.dart`
- `chat_websocket_datasource.dart` + `chat_websocket_datasource_impl.dart`
- `chat_websocket_provider_new.dart`

---

## 🎯 TL;DR

### Câu hỏi: Có thể dùng Riverpod không?
**Trả lời:** ✅ **CÓ!** Cả 2 versions đều dùng Riverpod để quản lý lifecycle.

### Câu hỏi: Có cần viết interface không?
**Trả lời:** ⚖️ **TÙY THEO:**
- **KHÔNG CẦN** → Dùng SIMPLE version (3 files)
- **NÊN CÓ** → Dùng CLEAN version (7 files)

---

## 📦 Files đã tạo

### ✅ SIMPLE Version (Không dùng interface):
```
lib/core/network/
  └── websocket_manager_simple.dart

lib/features/chat/data/services/
  └── chat_websocket_service_simple.dart

lib/features/chat/presentation/providers/
  └── chat_websocket_provider_simple.dart
```

### ✅ CLEAN Architecture Version (Dùng interface):
```
lib/core/network/
  ├── websocket_client.dart (interface)
  ├── websocket_client_impl.dart
  └── websocket_connection_manager.dart

lib/features/chat/domain/datasources/
  └── chat_websocket_datasource.dart (interface)

lib/features/chat/data/datasources/
  └── chat_websocket_datasource_impl.dart

lib/features/chat/presentation/providers/
  └── chat_websocket_provider_new.dart
```

### 📝 Documentation:
- `WEBSOCKET_COMPARISON.md` - So sánh 2 versions
- `WEBSOCKET_VISUAL_GUIDE.md` - Sơ đồ trực quan
- `WEBSOCKET_ARCHITECTURE.md` - Chi tiết kiến trúc
- `WEBSOCKET_MIGRATION_GUIDE.md` - Hướng dẫn migration

---

## 🚀 Quick Start

### SIMPLE Version:

```dart
// 1. Import
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_simple.dart';

// 2. Watch provider
final service = ref.watch(chatWebSocketServiceSimpleProvider);
final wsConnection = ref.watch(webSocketConnectionSimpleProvider);

// 3. Use it
service.messageStream.listen((message) {
  print('New message: ${message.content}');
});

service.sendMessage(
  conversationId: '123',
  content: 'Hello!',
);
```

### CLEAN Version:

```dart
// 1. Import
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';

// 2. Watch provider
final dataSource = ref.watch(chatWebSocketDataSourceProvider);
final wsConnection = ref.watch(webSocketConnectionProvider);

// 3. Use it
dataSource.messageStream.listen((message) {
  print('New message: ${message.content}');
});

dataSource.sendMessage(
  conversationId: '123',
  content: 'Hello!',
);
```

---

## ⚙️ Features (cả 2 versions)

- ✅ **Riverpod** lifecycle management
- ✅ **Auto-reconnect** on disconnect
- ✅ **Heartbeat** mechanism (30s interval)
- ✅ **Connection state** monitoring
- ✅ **Message routing** by type
- ✅ **Call signaling** support
- ✅ **Background JSON parsing**
- ✅ **Token refresh** support

---

## 🧪 Testing

### SIMPLE Version:
```dart
class MockWebSocketManager extends Mock implements WebSocketManager {}

test('should send message', () {
  final mock = MockWebSocketManager();
  when(mock.send(any)).thenReturn(null);
  
  final service = ChatWebSocketService(wsManager: mock);
  service.sendMessage(conversationId: '1', content: 'Hi');
  
  verify(mock.send(any)).called(1);
});
```

### CLEAN Version:
```dart
class MockWebSocketClient extends Mock implements WebSocketClient {}

test('should send message', () {
  final mockClient = MockWebSocketClient();
  final manager = WebSocketConnectionManager(client: mockClient);
  final dataSource = ChatWebSocketDataSourceImpl(connectionManager: manager);
  
  dataSource.sendMessage(conversationId: '1', content: 'Hi');
  
  verify(mockClient.send(any)).called(1);
});
```

---

## 📊 Comparison Summary

| Feature | SIMPLE | CLEAN |
|---------|--------|-------|
| Files | 3 | 7 |
| Interfaces | ❌ | ✅ |
| Testability | Medium | High |
| Complexity | Low | Medium |
| Flexibility | Low | High |
| Riverpod | ✅ | ✅ |

---

## 🎓 Learning Path

1. Đọc `WEBSOCKET_COMPARISON.md` - Hiểu khác biệt
2. Chọn version phù hợp
3. Đọc `WEBSOCKET_VISUAL_GUIDE.md` - Xem sơ đồ
4. Implement theo Quick Start
5. Nếu cần migrate: đọc `WEBSOCKET_MIGRATION_GUIDE.md`

---

## ❓ FAQ

**Q: Tôi nên chọn version nào?**
A: Start với SIMPLE, upgrade to CLEAN khi cần.

**Q: Có thể mix 2 versions không?**
A: Không nên. Chọn 1 và dùng nhất quán.

**Q: Riverpod có tự động dispose không?**
A: Có! `ref.onDispose()` được gọi tự động.

**Q: Performance khác nhau không?**
A: Không. Cả 2 versions đều optimized.

**Q: Làm sao test WebSocket?**
A: SIMPLE dùng mock concrete class, CLEAN dùng mock interface.

---

## 🤝 Contributing

Nếu bạn improve được design, welcome to contribute:
1. Update code
2. Update documentation
3. Add tests
4. Submit PR

---

## 📞 Support

- Đọc docs ở trên trước
- Check examples trong docs
- Tạo issue nếu cần help

---

**Happy coding! 🎉**

*Designed with ❤️ following Clean Architecture & SOLID principles*

