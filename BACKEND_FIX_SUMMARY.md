# ✅ Đã sửa lỗi kết nối Backend trên Windows

## 🎯 Vấn đề đã phát hiện

Từ log của bạn:
```
⚠️ [TokenCache] No access token found in storage
```

**2 vấn đề chính:**

### 1. ❌ Chưa đăng nhập
- Không có access token trong storage
- WebSocket cần token để kết nối
- **Giải pháp**: Đăng nhập vào ứng dụng

### 2. ❌ Windows Desktop dùng sai host
- Code cũ: Dùng `10.0.2.2` (Android emulator host) cho tất cả platform không phải web
- Trên Windows Desktop: Cần dùng `localhost` hoặc IP thực tế
- **Đã sửa**: Windows giờ dùng `API_HOST` từ `.env`

## 🔧 Các thay đổi đã thực hiện

### 1. Sửa Platform Detection
**File**: `lib/core/constants/api_constants.dart`

**Trước:**
```dart
// Tất cả platform không phải web đều dùng Android emulator host
final host = kIsWeb ? _host : _androidEmulatorHost;
```

**Sau:**
```dart
static String get _effectiveHost {
  if (kIsWeb) return _host;
  
  // Chỉ Android mới dùng emulator host
  if (defaultTargetPlatform == TargetPlatform.android) {
    return _androidEmulatorHost;
  }
  
  // Windows, iOS, macOS, Linux: dùng API_HOST từ .env
  return _host;
}
```

### 2. Thêm Backend Configuration trong .env
**File**: `.env`

```env
# Backend API Configuration
API_HOST=localhost
API_PORT=8080
API_PATH=/api
WS_PATH=

# Use secure protocols (HTTPS/WSS)
USE_SECURE_PROTOCOL=false
```

### 3. Cải thiện Logging

**WebSocket Connection:**
```dart
⚠️ [WebSocketConnection] No access token available - User not logged in
⚠️ [WebSocketConnection] Please login to connect to backend
```

**API URLs:**
```dart
🌐 [ApiConstants] Platform: windows
🌐 [ApiConstants] Effective Host: localhost
🌐 [ApiConstants] HTTP Base URL: http://localhost:8080/api
🌐 [ApiConstants] WebSocket Base URL: ws://localhost:8080
```

**Token Cache:**
```dart
✅ [TokenCache] Access token loaded and cached from storage
⚠️ [TokenCache] No access token found in storage
```

## 🚀 Cách sử dụng

### Bước 1: Cấu hình Backend trong .env

Mở file `.env` và cập nhật:

**Nếu backend chạy trên cùng máy:**
```env
API_HOST=localhost
API_PORT=8080
USE_SECURE_PROTOCOL=false
```

**Nếu backend chạy trên máy khác:**
```env
API_HOST=192.168.1.100    # IP của máy chạy backend
API_PORT=8080
USE_SECURE_PROTOCOL=false
```

### Bước 2: Chạy lại ứng dụng

```bash
flutter run -d windows
```

### Bước 3: Kiểm tra log

Bạn sẽ thấy log hiển thị URL được tạo:

```
🌐 [ApiConstants] Platform: windows
🌐 [ApiConstants] Effective Host: localhost
🌐 [ApiConstants] HTTP Base URL: http://localhost:8080/api
🌐 [ApiConstants] WebSocket Base URL: ws://localhost:8080
```

### Bước 4: Đăng nhập

1. Mở ứng dụng
2. Vào màn hình Login
3. Đăng nhập với tài khoản

**Sau khi đăng nhập, bạn sẽ thấy:**

```
✅ [TokenCache] Tokens saved to cache and storage
✅ [TokenCache] Access token loaded and cached from storage
🔌 [WebSocketConnection] Initializing connection...
✅ [WebSocketConnection] Access token found, proceeding with connection
🌐 [ApiConstants] WebSocket Base URL: ws://localhost:8080
🔌 [WebSocketClient] Connecting to: ws://localhost:8080/ws/chat?token=...
✅ [WebSocketClient] Connected successfully
```

## 📊 So sánh URL được tạo

| Platform | Trước | Sau |
|----------|-------|-----|
| Android Emulator | `http://10.0.2.2:8080/api` | `http://10.0.2.2:8080/api` ✅ (không đổi) |
| Windows Desktop | `http://10.0.2.2:8080/api` ❌ | `http://localhost:8080/api` ✅ |
| iOS Simulator | `http://10.0.2.2:8080/api` ❌ | `http://localhost:8080/api` ✅ |
| macOS Desktop | `http://10.0.2.2:8080/api` ❌ | `http://localhost:8080/api` ✅ |
| Web | `http://localhost:8080/api` ✅ | `http://localhost:8080/api` ✅ (không đổi) |

## 🔍 Debug

### Kiểm tra Backend có chạy không

```bash
# Windows PowerShell
Invoke-WebRequest -Uri "http://localhost:8080/api/v1/auth/login" -Method OPTIONS
```

Hoặc:
```bash
curl http://localhost:8080/api/v1/auth/login
```

### Kiểm tra log kết nối

**Thành công:**
```
✅ [WebSocketClient] Connected successfully
```

**Thất bại:**
```
❌ [WebSocketClient] Connection failed: ...
```

### Các lỗi thường gặp

| Log | Nguyên nhân | Giải pháp |
|-----|-------------|-----------|
| `No access token found` | Chưa đăng nhập | Đăng nhập vào app |
| `Connection refused` | Backend không chạy | Khởi động backend |
| `Connection timeout` | Sai host/port | Kiểm tra `.env` |
| `Effective Host: 10.0.2.2` trên Windows | Chưa update code | Hot reload lại `R` |

## 📝 Files đã thay đổi

1. ✅ `lib/core/constants/api_constants.dart` - Platform-aware host selection
2. ✅ `lib/features/chat/presentation/providers/chat_websocket_provider_new.dart` - Better logging
3. ✅ `lib/core/network/websocket_connection_manager.dart` - Connection logging
4. ✅ `lib/core/network/websocket_client_impl.dart` - Detailed error logging
5. ✅ `.env` - Backend configuration

## 📚 Tài liệu

- `BACKEND_CONNECTION_GUIDE.md` - Hướng dẫn chi tiết kết nối backend
- `WINDOWS_FIX.md` - Sửa lỗi Token Cache trên Windows

## 🎉 Kết quả

✅ Windows Desktop giờ dùng đúng `localhost` hoặc IP từ `.env`  
✅ Logging rõ ràng, dễ debug  
✅ Tương thích với tất cả platforms (Android, iOS, Windows, macOS, Web)  
✅ Hướng dẫn chi tiết cho người dùng  

---

**Lưu ý quan trọng**: Sau khi sửa code, hãy **hot reload** (nhấn `R`) hoặc **restart app** để áp dụng thay đổi!

