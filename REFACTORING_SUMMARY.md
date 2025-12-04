# Refactoring Summary - Call Page & Widget Structure

## Vấn đề đã khắc phục (Issues Fixed)

### 1. Call Page hiển thị Bottom Navigation
**Vấn đề:** Các trang call (incoming, outgoing, active call) đang hiển thị cả bottom navigation bar vì chúng nằm trong ShellRoute.

**Giải pháp:** Di chuyển tất cả các route call ra ngoài ShellRoute trong `app_router.dart`. Cấu trúc mới:

```
Routes:
├── Call Routes (OUTSIDE ShellRoute - no bottom nav)
│   ├── /incoming-call
│   ├── /outgoing-call
│   └── /call
│
├── Auth Routes (OUTSIDE ShellRoute - no bottom nav)
│   ├── /login
│   ├── /register
│   ├── /forgot-password
│   └── /otp
│
└── ShellRoute (WITH bottom nav)
    ├── / (chats)
    ├── /contacts
    ├── /profile
    ├── /chat/:id
    ├── /new-chat
    ├── /new-group
    └── /chat-info
```

### 2. Loại bỏ CallListener Wrapper Widget
**Vấn đề cũ:** Code phải bọc nhiều layer widgets:
```dart
CallListener(
  child: MaterialApp.router(
    builder: (context, child) => ToastOverlay(...)
  )
)
```

**Giải pháp mới:** Khởi tạo providers trực tiếp trong build method:
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  // Initialize WebSocket & call state
  ref.watch(webSocketConnectionProvider);
  ref.watch(callProvider);
  
  return MaterialApp.router(
    builder: (context, child) => ToastOverlay(...)
  );
}
```

## Thay đổi chi tiết (Detailed Changes)

### `lib/main.dart`
1. **Loại bỏ** import `call_listener.dart`
2. **Thêm** imports cho providers:
   - `features/call/presentation/state/call_notifier.dart`
   - `features/chat/presentation/providers/chat_websocket_provider.dart`
3. **Refactor** MyApp widget: Thay CallListener wrapper bằng việc watch providers trực tiếp

### `lib/core/router/app_router.dart`
1. **Di chuyển** Call routes lên đầu (trước ShellRoute)
2. **Di chuyển** Auth routes lên trước ShellRoute
3. **Nhóm** các routes có bottom nav vào trong ShellRoute
4. **Giữ nguyên** redirect logic cho cả auth và call states

## Lợi ích (Benefits)

✅ **Code sạch hơn**: Không cần wrapper widgets không cần thiết
✅ **Dễ đọc hơn**: Cấu trúc routing rõ ràng
✅ **Fix bug**: Call pages không còn hiển thị bottom navigation
✅ **Maintainability**: Dễ dàng thêm routes mới vào đúng vị trí

## Testing Checklist

- [ ] Call pages (incoming/outgoing/active) không hiển thị bottom nav
- [ ] Auth pages không hiển thị bottom nav
- [ ] Main app pages (chats/contacts/profile) có bottom nav
- [ ] Navigation giữa các pages hoạt động bình thường
- [ ] WebSocket connection được khởi tạo đúng
- [ ] Call state được watch và redirect đúng
- [ ] Toast overlay hoạt động trên tất cả pages

## Notes

- `CallListener` widget có thể bị xóa nếu không dùng ở đâu khác
- Router redirect logic vẫn hoạt động như cũ
- Toast overlay vẫn được áp dụng cho toàn bộ app thông qua `MaterialApp.router.builder`

