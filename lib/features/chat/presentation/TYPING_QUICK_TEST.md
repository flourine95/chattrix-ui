# 🚀 Quick Test - Typing Indicator

## Cách Test Nhanh Nhất (1 phút)

### Bước 1: Chạy App
```bash
flutter run
```

### Bước 2: Mở Debug Console
- VS Code: View → Debug Console
- Android Studio: Run → View → Tool Windows → Debug

### Bước 3: Mở Chat
- Mở bất kỳ conversation nào

### Bước 4: Gõ Tin Nhắn (KHÔNG GỬI)
- Gõ vài ký tự vào input field
- **QUAN TRỌNG:** Đừng nhấn Send!

### Bước 5: Kiểm Tra Logs

Bạn phải thấy các logs này:

```
⌨️ [Chat] User started typing in conversation: 123
🟢 [Typing] START typing in conversation: 123
```

Sau 3 giây:
```
🔄 [Typing] Sending periodic typing.start for conversation: 123
```

Dừng gõ 2 giây:
```
⌨️ [Chat] User stopped typing (debounce) in conversation: 123
🔴 [Typing] STOP typing in conversation: 123
```

## ✅ Nếu Thấy Logs → THÀNH CÔNG!

Typing indicator của bạn đang hoạt động! 

Để thấy typing indicator hiển thị, bạn cần:
- **2 thiết bị** HOẶC
- **2 tài khoản** (mở 2 tab/window)

## 🎯 Test Với 2 Thiết Bị

### Thiết bị 1:
1. Đăng nhập User A
2. Mở chat với User B
3. **CHỜ** và quan sát

### Thiết bị 2:
1. Đăng nhập User B
2. Mở cùng chat
3. **GÕ** (không gửi)

### Kết quả trên Thiết bị 1:
- Thấy animated dots: ⚫⚫⚫
- Thấy text: "B is typing"

## 🐛 Không Thấy Logs?

### Check 1: Debug Mode
```bash
# Đảm bảo chạy debug mode
flutter run --debug
```

### Check 2: Filter Logs
Trong Debug Console, tìm kiếm:
- `Typing`
- `Chat`
- `⌨️`

### Check 3: WebSocket
Tìm log này khi mở chat:
```
✅ Marked conversation X as read
```

Nếu không thấy → WebSocket chưa connect

## 📊 Logs Cheat Sheet

| Log | Ý nghĩa |
|-----|---------|
| `⌨️ [Chat] User started typing` | Bạn bắt đầu gõ |
| `🟢 [Typing] START typing` | Gửi typing.start |
| `🔄 [Typing] Sending periodic` | Gửi lại mỗi 3s |
| `🔴 [Typing] STOP typing` | Gửi typing.stop |
| `📨 [Typing] Received typing` | Nhận typing từ người khác |
| `👁️ [Typing Widget] Showing` | Hiển thị typing indicator |
| `⏰ [Typing] Auto-clearing` | Tự động xóa sau 3s |

## 🎨 Test UI Nhanh (Không Cần WebSocket)

Thêm code này vào `chat_view_page.dart` (tạm thời):

```dart
// Trong body, thêm ở đầu Column:
TypingIndicatorTestWidget(
  conversationId: chatId,
  currentUserId: me?.id,
),
```

Nhấn các nút test để xem typing indicator ngay lập tức!

**Nhớ xóa sau khi test xong!**

## 💡 Tips

1. **Logs là bạn của bạn**: Nếu thấy logs → feature hoạt động
2. **Test với 2 thiết bị**: Cách duy nhất để thấy UI thực tế
3. **Không gửi tin nhắn**: Gửi sẽ stop typing ngay lập tức
4. **Chờ 2 giây**: Typing tự động stop sau 2s không gõ

## 🎯 Success Criteria

✅ Thấy logs khi gõ  
✅ Logs xuất hiện đúng thời điểm  
✅ Typing stop sau 2s không gõ  
✅ Typing stop khi gửi tin nhắn  

→ **TYPING INDICATOR HOẠT ĐỘNG!** 🎉

---

**Cần help?** Check file `TYPING_INDICATOR_TESTING.md` để biết chi tiết hơn.
