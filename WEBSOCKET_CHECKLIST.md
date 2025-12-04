# WebSocket Implementation Checklist

## 🎯 Chọn Version

- [ ] **Đã đọc** `WEBSOCKET_README.md`
- [ ] **Đã đọc** `WEBSOCKET_COMPARISON.md`
- [ ] **Đã quyết định** version sử dụng:
  - [ ] SIMPLE Version (không dùng interface)
  - [ ] CLEAN Architecture Version (dùng interface)

---

## ✅ Implementation Checklist

### Nếu chọn SIMPLE Version:

#### 1. Setup Files
- [ ] Có file `lib/core/network/websocket_manager_simple.dart`
- [ ] Có file `lib/features/chat/data/services/chat_websocket_service_simple.dart`
- [ ] Có file `lib/features/chat/presentation/providers/chat_websocket_provider_simple.dart`

#### 2. Update Exports
- [ ] Update `lib/features/chat/presentation/providers/chat_providers.dart`:
  ```dart
  export 'chat_websocket_provider_simple.dart';
  ```

#### 3. Update Existing Files
- [ ] `messages_notifier.dart` - Đổi sang `chatWebSocketServiceSimpleProvider`
- [ ] `conversations_notifier.dart` - Đổi sang `chatWebSocketServiceSimpleProvider`
- [ ] `chat_view_page.dart` - Đổi sang `chatWebSocketServiceSimpleProvider`
- [ ] `call_service_provider.dart` - Update để dùng simple version

#### 4. Update Call Handler
- [ ] Tạo `call_websocket_handler_simple.dart` dùng `ChatWebSocketService`
- [ ] Update `call_service_provider.dart` import

#### 5. Testing
- [ ] WebSocket connect thành công
- [ ] Nhận được messages
- [ ] Gửi messages được
- [ ] Auto-reconnect hoạt động
- [ ] Heartbeat hoạt động
- [ ] Call signaling hoạt động

#### 6. Cleanup
- [ ] Xóa old files (optional):
  - [ ] `chat_websocket_service.dart` (old)
  - [ ] `chat_websocket_provider.dart` (old)

---

### Nếu chọn CLEAN Architecture Version:

#### 1. Setup Files
- [ ] Có file `lib/core/network/websocket_client.dart`
- [ ] Có file `lib/core/network/websocket_client_impl.dart`
- [ ] Có file `lib/core/network/websocket_connection_manager.dart`
- [ ] Có file `lib/features/chat/domain/datasources/chat_websocket_datasource.dart`
- [ ] Có file `lib/features/chat/data/datasources/chat_websocket_datasource_impl.dart`
- [ ] Có file `lib/features/chat/presentation/providers/chat_websocket_provider_new.dart`

#### 2. Update Exports
- [ ] Update `lib/features/chat/presentation/providers/chat_providers.dart`:
  ```dart
  export 'chat_websocket_provider_new.dart';
  ```

#### 3. Update Existing Files (ĐÃ HOÀN THÀNH ✅)
- [x] `messages_notifier.dart` - Đổi sang `chatWebSocketDataSourceProvider`
- [x] `conversations_notifier.dart` - Đổi sang `chatWebSocketDataSourceProvider`
- [x] `chat_view_page.dart` - Đổi sang `chatWebSocketDataSourceProvider`
- [x] `call_service_provider.dart` - Update import

#### 4. Update Call Handler (ĐÃ HOÀN THÀNH ✅)
- [x] Có file `call_websocket_handler_new.dart`
- [x] Update `call_service_provider.dart`

#### 5. Testing
- [ ] WebSocket connect thành công
- [ ] Nhận được messages
- [ ] Gửi messages được
- [ ] Auto-reconnect hoạt động
- [ ] Heartbeat hoạt động
- [ ] Call signaling hoạt động
- [ ] Unit tests pass (nếu có)

#### 6. Cleanup
- [ ] Xóa old files:
  - [ ] `chat_websocket_service.dart` (old)
  - [ ] `chat_websocket_provider.dart` (old)
  - [ ] `call_websocket_handler.dart` (old)

---

## 🧪 Testing Checklist

### Manual Testing
- [ ] Login vào app
- [ ] WebSocket connection hiển thị "Connected"
- [ ] Gửi message → Nhận được response
- [ ] Nhận message từ user khác
- [ ] Typing indicator hoạt động
- [ ] User status update hoạt động
- [ ] Tắt WiFi → Thấy "Disconnected"
- [ ] Bật lại WiFi → Auto-reconnect → "Connected"
- [ ] Call invitation hoạt động
- [ ] Accept/Reject call hoạt động

### Unit Testing (nếu có)
- [ ] WebSocket connection test
- [ ] Message sending test
- [ ] Message receiving test
- [ ] Auto-reconnect test
- [ ] Heartbeat test

---

## 📝 Migration Progress (nếu từ old code)

### Step 1: Backup
- [ ] Git commit current code
- [ ] Create backup branch

### Step 2: Add New Files
- [ ] Copy new files vào project
- [ ] Verify imports

### Step 3: Update References
- [ ] Update all imports
- [ ] Update all providers
- [ ] Update all usages

### Step 4: Test
- [ ] Run `flutter analyze`
- [ ] Run `flutter test`
- [ ] Manual testing

### Step 5: Cleanup
- [ ] Remove old files
- [ ] Update documentation
- [ ] Git commit

---

## 🔍 Code Review Checklist

- [ ] **Imports**: Tất cả imports đúng
- [ ] **Providers**: Riverpod providers được setup đúng
- [ ] **Lifecycle**: `ref.onDispose()` được gọi
- [ ] **Streams**: Streams được close properly
- [ ] **Timers**: Timers được cancel properly
- [ ] **Error Handling**: Có try-catch ở đúng chỗ
- [ ] **Logging**: Có log để debug
- [ ] **Comments**: Code có comments giải thích

---

## 📊 Performance Checklist

- [ ] No memory leaks (streams, timers closed)
- [ ] Reconnect không quá nhanh (có delay)
- [ ] Heartbeat interval hợp lý (30s)
- [ ] JSON parsing không block UI
- [ ] Connection state updates smooth

---

## 🚀 Deployment Checklist

### Before Deploy
- [ ] All tests pass
- [ ] Manual testing complete
- [ ] Performance checked
- [ ] No console errors
- [ ] Code reviewed

### Environment
- [ ] `.env` file configured
- [ ] WebSocket URL correct
- [ ] Production uses WSS (secure)
- [ ] Debug uses WS (insecure OK)

### Monitoring
- [ ] Add analytics for connection success/failure
- [ ] Log reconnection attempts
- [ ] Monitor message latency

---

## 📚 Documentation Checklist

- [ ] README updated
- [ ] API documentation updated
- [ ] Architecture diagram updated
- [ ] Team notified về changes

---

## ❓ Troubleshooting Checklist

Nếu gặp lỗi, check:

### Connection Issues
- [ ] WebSocket URL đúng chưa?
- [ ] Token valid chưa?
- [ ] Network connected chưa?
- [ ] Server running chưa?

### Message Issues
- [ ] JSON format đúng chưa?
- [ ] Message type đúng chưa?
- [ ] Stream subscriptions active chưa?

### Riverpod Issues
- [ ] Provider dependencies đúng chưa?
- [ ] `ref.watch()` vs `ref.read()` đúng chưa?
- [ ] Provider scope đúng chưa?

---

## ✨ Final Checklist

- [ ] **Đã chọn version** (SIMPLE hoặc CLEAN)
- [ ] **Đã implement** theo checklist
- [ ] **Đã test** đầy đủ
- [ ] **Đã cleanup** old code
- [ ] **Đã commit** code
- [ ] **Đã update** documentation

---

## 🎉 Completion

Khi tất cả checkboxes đều ✅:

**CONGRATULATIONS! 🎊**

WebSocket implementation hoàn thành!

Next steps:
1. Monitor production
2. Collect metrics
3. Optimize if needed
4. Share learnings with team

---

*Last updated: December 2, 2025*

