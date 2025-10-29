# 🐛 Hướng Dẫn Debug WebSocket Chat

## 📋 Tổng Quan

File này hướng dẫn cách debug vấn đề WebSocket không tự động cập nhật tin nhắn.

## 🔍 Các Logs Quan Trọng

### 1. Khi Khởi Động App

Khi mở trang chat, bạn sẽ thấy:

```
🏗️ [MessagesNotifier] Building for conversation: <conversationId>
🔌 [MessagesNotifier] WebSocket connected: true/false
👂 [MessagesNotifier] Stream listener setup complete
```

**✅ Điều kiện bình thường:**
- `WebSocket connected: true` - WebSocket đã kết nối
- Stream listener được setup thành công

**❌ Vấn đề:**
- `WebSocket connected: false` - WebSocket chưa kết nối → Kiểm tra authentication

---

### 2. Khi Gửi Tin Nhắn

Khi UserA gửi tin nhắn, bạn sẽ thấy:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 [ChatView] Sending message: "Hello"
   Conversation ID: 123
🌐 [ChatView] Sending via WebSocket
✅ [ChatView] Message sent via WebSocket
⏳ [ChatView] Waiting 500ms for WebSocket response...
🔄 [ChatView] Manually refreshing messages after WebSocket send
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**✅ Điều kiện bình thường:**
- Message được gửi qua WebSocket
- Sau 500ms sẽ tự động refresh

**❌ Vấn đề:**
- `Sending via HTTP (WebSocket not connected)` - WebSocket bị disconnect

---

### 3. Khi Backend Gửi Message Về

Đây là phần **QUAN TRỌNG NHẤT** để debug!

#### A. WebSocket Service Nhận Message

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📥 [WebSocket] Raw message received: {"type":"chat.message","payload":{...}}
📦 [WebSocket] Parsed data: {...}
🔍 [WebSocket] Message type: chat.message
📨 [WebSocket] Broadcasting chat message to stream...
   Message ID: 456
   ConversationId: 123
   Content: "Hello"
   Sender: userA
   Stream has listeners: true
✅ [WebSocket] Message broadcasted to active listeners
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**✅ Điều kiện bình thường:**
- `Stream has listeners: true` - Có listener đang lắng nghe
- Message được broadcast thành công

**❌ Vấn đề:**
- `Stream has listeners: false` hoặc `NO listeners` - **KHÔNG CÓ AI LẮNG NGHE!**
  - Nguyên nhân: MessagesNotifier chưa được khởi tạo hoặc đã bị dispose
  - Giải pháp: Kiểm tra xem trang chat có đang mở không

#### B. MessagesNotifier Nhận Message

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📨 [MessagesNotifier] WebSocket message received!
   Message ID: 456
   Content: "Hello"
   Sender: userA
   Message conversationId: "123" (String)
   Current conversationId: "123" (String)
   Match: true
✅ [MessagesNotifier] Message matches! Calling refresh()...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**✅ Điều kiện bình thường:**
- `Match: true` - ConversationId khớp
- `Calling refresh()...` - Gọi refresh để cập nhật UI

**❌ Vấn đề:**
- `Match: false` - ConversationId KHÔNG khớp
  - Nguyên nhân: Backend gửi sai conversationId hoặc type không đúng
  - Kiểm tra: So sánh `Message conversationId` vs `Current conversationId`

#### C. Refresh Messages

```
🔄 [MessagesNotifier] refresh() called for conversation 123
   Current state: _AsyncData<List<Message>>
   New state: _AsyncData<List<Message>>
   New message count: 15
✅ [MessagesNotifier] State updated!
```

**✅ Điều kiện bình thường:**
- State được update thành công
- Message count tăng lên

**❌ Vấn đề:**
- Không thấy log này → refresh() không được gọi
- Message count không tăng → Backend không trả về message mới

---

## 🎯 Các Trường Hợp Lỗi Thường Gặp

### Trường Hợp 1: Không Thấy Log WebSocket Nhận Message

**Triệu chứng:**
- UserA gửi message
- UserB không thấy message
- Console của UserB **KHÔNG** có log `📥 [WebSocket] Raw message received`

**Nguyên nhân:**
- Backend không gửi message qua WebSocket
- WebSocket connection bị disconnect

**Cách kiểm tra:**
1. Xem log WebSocket connection:
   ```
   🔌 [MessagesNotifier] WebSocket connected: true
   ```
2. Nếu `false`, kiểm tra:
   - Token hết hạn?
   - Backend WebSocket server có đang chạy không?
   - Network có vấn đề không?

**Giải pháp:**
- Kiểm tra backend logs
- Kiểm tra WebSocket endpoint: `ws://10.0.2.2:8080/chattrix-api/ws/chat?token=...`

---

### Trường Hợp 2: WebSocket Nhận Message Nhưng Không Match

**Triệu chứng:**
- Console có log `📥 [WebSocket] Raw message received`
- Nhưng có log `⚠️ [MessagesNotifier] Message does NOT match current conversation`

**Nguyên nhân:**
- Backend gửi sai `conversationId`
- Type mismatch (String vs Int)

**Cách kiểm tra:**
```
Message conversationId: "123" (String)
Current conversationId: "456" (String)
Match: false
```

**Giải pháp:**
- Kiểm tra backend: Đảm bảo gửi đúng conversationId
- Kiểm tra type: String vs Int

---

### Trường Hợp 3: Stream Không Có Listener

**Triệu chứng:**
- Console có log `Stream has listeners: false` hoặc `NO listeners`

**Nguyên nhân:**
- MessagesNotifier chưa được khởi tạo
- Trang chat đã bị dispose

**Cách kiểm tra:**
1. Xem có log `🏗️ [MessagesNotifier] Building` không?
2. Xem có log `🧹 [MessagesNotifier] Disposing` không?

**Giải pháp:**
- Đảm bảo trang chat đang mở
- Không navigate ra khỏi trang chat quá nhanh

---

### Trường Hợp 4: Refresh Được Gọi Nhưng UI Không Update

**Triệu chứng:**
- Console có log `🔄 [MessagesNotifier] refresh() called`
- Console có log `✅ [MessagesNotifier] State updated!`
- Nhưng UI không hiển thị message mới

**Nguyên nhân:**
- Backend không trả về message mới trong API response
- Cache issue

**Cách kiểm tra:**
```
New message count: 15
```
- Xem message count có tăng không?

**Giải pháp:**
- Kiểm tra backend API: `GET /api/conversations/{id}/messages`
- Xem response có chứa message mới không?

---

## 📊 Flow Hoàn Chỉnh (Khi Hoạt Động Đúng)

### UserA Gửi Message:

```
1. [ChatView] Sending message: "Hello"
2. [ChatView] Sending via WebSocket
3. [ChatView] Message sent via WebSocket
4. [ChatView] Waiting 500ms...
5. [ChatView] Manually refreshing messages
6. [MessagesNotifier] refresh() called
7. [MessagesNotifier] State updated! (UserA thấy message)
```

### Backend Broadcast Message:

```
8. [WebSocket] Raw message received (UserA)
9. [WebSocket] Broadcasting to active listeners (UserA)
10. [MessagesNotifier] Message received (UserA)
11. [MessagesNotifier] Match: true (UserA)
12. [MessagesNotifier] Calling refresh() (UserA)
13. [MessagesNotifier] State updated! (UserA thấy message lần 2 - duplicate)

14. [WebSocket] Raw message received (UserB)
15. [WebSocket] Broadcasting to active listeners (UserB)
16. [MessagesNotifier] Message received (UserB)
17. [MessagesNotifier] Match: true (UserB)
18. [MessagesNotifier] Calling refresh() (UserB)
19. [MessagesNotifier] State updated! (UserB thấy message)
```

---

## 🔧 Cách Sử Dụng

### 1. Chạy App Với Debug Mode

```bash
flutter run
```

### 2. Mở Console/Terminal

Xem logs real-time

### 3. Test Scenario

#### Test 1: Gửi Message
1. UserA gửi message "Test 1"
2. Xem console của UserA
3. Xem console của UserB

#### Test 2: Nhận Message
1. UserB gửi message "Test 2"
2. Xem console của UserB
3. Xem console của UserA

### 4. Phân Tích Logs

Tìm các dấu hiệu:
- ✅ `Stream has listeners: true`
- ✅ `Match: true`
- ✅ `State updated!`
- ❌ `Stream has listeners: false`
- ❌ `Match: false`
- ❌ Không có log nào

---

## 🎓 Kết Luận

Với debug logs chi tiết này, bạn có thể:

1. **Xác định chính xác** vấn đề nằm ở đâu:
   - Frontend (Flutter)
   - Backend (WebSocket)
   - Network

2. **Theo dõi flow** từ đầu đến cuối:
   - Gửi message
   - WebSocket nhận
   - Stream broadcast
   - Notifier refresh
   - UI update

3. **Fix nhanh chóng** dựa trên logs

---

## 📞 Hỗ Trợ

Nếu vẫn gặp vấn đề, hãy:
1. Copy toàn bộ logs từ console
2. Gửi cho developer
3. Mô tả chi tiết scenario

Good luck! 🚀

