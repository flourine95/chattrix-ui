# Hướng dẫn kết nối Backend

## ⚠️ Vấn đề hiện tại

Từ log của bạn:
```
⚠️ [TokenCache] No access token found in storage
```

**Nguyên nhân**: Bạn chưa đăng nhập vào ứng dụng, nên:
1. ❌ Không có access token
2. ❌ WebSocket không thể kết nối (cần token để xác thực)
3. ❌ Không có kết nối tới backend

## ✅ Giải pháp

### Bước 1: Cấu hình Backend URL

Kiểm tra file `.env` và cập nhật theo backend của bạn:

```env
# Backend API Configuration
API_HOST=localhost          # Thay đổi theo backend của bạn
API_PORT=8080              # Thay đổi theo port backend
API_PATH=/api
WS_PATH=

# Secure protocols
USE_SECURE_PROTOCOL=false   # false cho local development
```

#### Các trường hợp cấu hình:

**1. Backend chạy trên cùng máy (localhost)**
```env
API_HOST=localhost
API_PORT=8080
USE_SECURE_PROTOCOL=false
```

**2. Backend chạy trên máy khác trong mạng LAN**
```env
API_HOST=192.168.1.100      # IP của máy chạy backend
API_PORT=8080
USE_SECURE_PROTOCOL=false
```

**3. Backend production (remote server)**
```env
API_HOST=api.chattrix.com
API_PORT=443
USE_SECURE_PROTOCOL=true    # Bắt buộc HTTPS/WSS
```

### Bước 2: Khởi động Backend

Đảm bảo backend đang chạy:
```bash
# Kiểm tra backend có chạy không
curl http://localhost:8080/api/v1/auth/login
```

Nếu backend chưa chạy, hãy khởi động nó trước khi chạy app.

### Bước 3: Chạy lại ứng dụng

Sau khi cấu hình `.env`:

```bash
# Chạy lại để load .env mới
flutter run -d windows
```

### Bước 4: Đăng nhập

1. Mở ứng dụng
2. Vào màn hình Login
3. Đăng nhập với tài khoản của bạn

**Sau khi đăng nhập thành công**, bạn sẽ thấy log:

```
✅ [TokenCache] Access token loaded and cached from storage
🔌 [WebSocketConnection] Initializing connection...
✅ [WebSocketConnection] Access token found, proceeding with connection
🔌 [WebSocketClient] Connecting to: ws://localhost:8080/ws/chat?token=...
✅ [WebSocketClient] Connected successfully
```

## 🔍 Debug - Kiểm tra kết nối

### 1. Kiểm tra backend URL được tạo

Thêm log trong `lib/core/constants/api_constants.dart`:

```dart
static String get _baseUrl {
  final host = kIsWeb ? _host : _androidEmulatorHost;
  final protocol = _useSecureProtocol ? 'https' : 'http';
  final url = '$protocol://$host:$_port$_apiPath';
  print('🌐 [ApiConstants] Base URL: $url');
  return url;
}

static String get _wsBaseUrl {
  final host = kIsWeb ? _host : _androidEmulatorHost;
  final protocol = _useSecureProtocol ? 'wss' : 'ws';
  final url = '$protocol://$host:$_port$_wsPath';
  print('🌐 [ApiConstants] WebSocket URL: $url');
  return url;
}
```

### 2. Kiểm tra log sau khi đăng nhập

**Nếu đăng nhập thành công:**
```
✅ [TokenCache] Tokens saved to cache and storage
🔌 [WebSocketConnection] Connecting to: ws://...
✅ [WebSocketClient] Connected successfully
```

**Nếu không kết nối được:**
```
❌ [WebSocketClient] Connection failed: ...
```

### 3. Các lỗi thường gặp

| Lỗi | Nguyên nhân | Giải pháp |
|------|-------------|-----------|
| `No access token found` | Chưa đăng nhập | Đăng nhập vào app |
| `Connection refused` | Backend không chạy | Khởi động backend |
| `Connection timeout` | Sai URL/Port | Kiểm tra `.env` |
| `WebSocket error` | Backend không hỗ trợ WS | Kiểm tra backend config |

## 📝 Checklist

- [ ] Backend đang chạy
- [ ] File `.env` đã cấu hình đúng `API_HOST` và `API_PORT`
- [ ] Đã restart app sau khi sửa `.env`
- [ ] Đã đăng nhập vào ứng dụng
- [ ] Kiểm tra log có `✅ Connected successfully`

## 🚀 Sau khi kết nối thành công

Bạn sẽ thấy:
1. ✅ Token được lưu và cache
2. ✅ WebSocket kết nối thành công
3. ✅ Có thể gửi/nhận tin nhắn real-time
4. ✅ Có thể nhận cuộc gọi

## 💡 Tips

1. **Windows Firewall**: Đảm bảo firewall không chặn kết nối tới backend
2. **Network**: Nếu backend ở máy khác, đảm bảo 2 máy cùng mạng
3. **Port**: Kiểm tra port không bị chương trình khác sử dụng
4. **HTTPS/WSS**: Chỉ dùng khi backend có SSL certificate

## 🔗 API Endpoints được tạo

Với cấu hình mặc định (`localhost:8080`):

- **HTTP API**: `http://localhost:8080/api/v1/...`
- **WebSocket**: `ws://localhost:8080/ws/chat?token=...`

Kiểm tra trong log khi app khởi động để xác nhận URL đúng.

