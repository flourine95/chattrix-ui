# Hướng Dẫn Test Typing Indicator

## 🎯 Mục đích
Hướng dẫn này giúp bạn kiểm tra xem typing indicator có hoạt động đúng không.

## 📋 Các Cách Test

### 1. Test Với Debug Logs (Khuyến nghị)

Khi bạn chạy app, mở Debug Console và quan sát các logs sau:

#### Khi BẠN gõ tin nhắn:
```
⌨️ [Chat] User started typing in conversation: 123
🟢 [Typing] START typing in conversation: 123
🔄 [Typing] Sending periodic typing.start for conversation: 123
⌨️ [Chat] User stopped typing (debounce) in conversation: 123
🔴 [Typing] STOP typing in conversation: 123
```

#### Khi NGƯỜI KHÁC gõ tin nhắn:
```
📨 [Typing] Received typing indicator for conversation: 123
   Users typing: John Doe, Jane Smith
👁️ [Typing Widget] Showing typing indicator for 2 user(s)
⏰ [Typing] Auto-clearing typing indicator (timeout)
```

### 2. Test Với 2 Thiết Bị / 2 Tài Khoản

**Cách test tốt nhất:**

1. **Thiết bị 1** (hoặc tab 1):
   - Đăng nhập tài khoản A
   - Mở conversation với tài khoản B
   - Quan sát màn hình

2. **Thiết bị 2** (hoặc tab 2):
   - Đăng nhập tài khoản B
   - Mở cùng conversation
   - BẮT ĐẦU GÕ (không cần gửi)

3. **Kết quả mong đợi trên Thiết bị 1:**
   - Thấy animated dots xuất hiện
   - Thấy text "B is typing"
   - Sau 2 giây không gõ, indicator biến mất

### 3. Test Với Test Widget (Nhanh nhất)

Thêm test widget vào chat view để test ngay lập tức:

```dart
// Trong chat_view_page.dart, thêm vào body:
Column(
  children: [
    // Test widget - XÓA SAU KHI TEST XONG
    TypingIndicatorTestWidget(
      conversationId: chatId,
      currentUserId: me?.id,
    ),
    
    // ... phần còn lại của UI
  ],
)
```

Sau đó nhấn các nút test để xem typing indicator hoạt động.

## 🔍 Checklist Kiểm Tra

### ✅ Gửi Events (Khi BẠN gõ)
- [ ] Khi bắt đầu gõ, thấy log `🟢 [Typing] START typing`
- [ ] Mỗi 3 giây, thấy log `🔄 [Typing] Sending periodic typing.start`
- [ ] Khi dừng gõ 2 giây, thấy log `🔴 [Typing] STOP typing`
- [ ] Khi gửi tin nhắn, thấy log `⌨️ [Chat] User sent message, stopping typing`

### ✅ Nhận Events (Khi NGƯỜI KHÁC gõ)
- [ ] Thấy log `📨 [Typing] Received typing indicator`
- [ ] Thấy log `👁️ [Typing Widget] Showing typing indicator`
- [ ] Thấy animated dots xuất hiện
- [ ] Thấy tên người đang gõ
- [ ] Sau 3 giây không có update, indicator tự động biến mất

### ✅ UI/UX
- [ ] Dots có animation mượt mà
- [ ] Text hiển thị đúng:
  - 1 người: "John is typing"
  - 2 người: "John and Jane are typing"
  - 3+ người: "John and 2 others are typing"
- [ ] Không thấy tên của chính mình trong typing indicator
- [ ] Indicator xuất hiện ở đúng vị trí (dưới messages, trên input bar)

## 🐛 Troubleshooting

### Vấn đề: Không thấy logs
**Giải pháp:**
- Kiểm tra Debug Console có đang mở không
- Chạy app ở debug mode (không phải release mode)
- Kiểm tra filter logs (tìm "Typing" hoặc "Chat")

### Vấn đề: Không thấy typing indicator của người khác
**Kiểm tra:**
1. WebSocket có connected không?
   - Tìm log: `✅ Marked conversation X as read`
   - Nếu không có → WebSocket chưa connect

2. Người khác có đang gõ không?
   - Họ phải GÕ ít nhất 1 ký tự
   - Họ KHÔNG được gửi tin nhắn (gửi sẽ stop typing)

3. Conversation ID có đúng không?
   - Check log `📨 [Typing] Received typing indicator for conversation: X`
   - X phải giống với chatId hiện tại

### Vấn đề: Typing indicator không biến mất
**Kiểm tra:**
- Có thấy log `⏰ [Typing] Auto-clearing typing indicator` không?
- Nếu không → Timer có vấn đề
- Nếu có → UI không update → Check widget rebuild

### Vấn đề: Gửi typing events nhưng người khác không thấy
**Kiểm tra:**
1. WebSocket có connected không?
2. Backend có nhận được events không? (check backend logs)
3. Backend có broadcast đúng không?

## 📊 Test Scenarios

### Scenario 1: Basic Typing
1. User A mở chat với User B
2. User A bắt đầu gõ
3. **Expected:** User B thấy "A is typing" với animated dots
4. User A dừng gõ 2 giây
5. **Expected:** Typing indicator biến mất

### Scenario 2: Multiple Users (Group Chat)
1. User A, B, C trong cùng group
2. User B và C cùng gõ
3. **Expected:** User A thấy "B and C are typing"
4. User B dừng gõ
5. **Expected:** User A thấy "C is typing"

### Scenario 3: Send Message
1. User A đang gõ
2. User B thấy typing indicator
3. User A gửi tin nhắn
4. **Expected:** Typing indicator biến mất ngay lập tức

### Scenario 4: Leave Chat
1. User A đang gõ
2. User A thoát khỏi chat (back button)
3. **Expected:** Typing stop event được gửi
4. **Expected:** User B không còn thấy typing indicator

## 🎨 Visual Test

Nếu bạn muốn test UI mà không cần WebSocket:

```dart
// Tạo fake typing indicator
final fakeTyping = TypingIndicator(
  conversationId: '123',
  typingUsers: [
    TypingUser(id: '1', username: 'john', fullName: 'John Doe'),
    TypingUser(id: '2', username: 'jane', fullName: 'Jane Smith'),
  ],
);

// Hiển thị
TypingIndicatorWidget(
  typingIndicator: fakeTyping,
  currentUserId: null,
)
```

## 📝 Notes

- **Debounce time:** 2 giây (có thể thay đổi trong code)
- **Periodic send:** 3 giây (có thể thay đổi trong code)
- **Auto-clear timeout:** 3 giây (có thể thay đổi trong code)
- **Animation duration:** 1.4 giây (có thể thay đổi trong code)

## 🚀 Quick Test Command

Để test nhanh, chạy app và làm theo:

1. Mở Debug Console
2. Mở chat với bất kỳ ai
3. Gõ vài ký tự (không gửi)
4. Quan sát logs:
   - Phải thấy `🟢 [Typing] START typing`
   - Sau 3s phải thấy `🔄 [Typing] Sending periodic`
5. Dừng gõ 2 giây
6. Quan sát logs:
   - Phải thấy `🔴 [Typing] STOP typing`

Nếu thấy đầy đủ các logs trên → **Typing indicator đang hoạt động!** ✅

Để test nhận typing từ người khác, cần 2 thiết bị hoặc 2 tài khoản.
