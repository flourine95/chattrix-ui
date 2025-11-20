# 🧪 Test JWT Auto-Refresh

## ✅ Đã thêm logging vào code

### File đã sửa:
1. **`lib/core/network/auth_interceptor.dart`** - Thêm logs JWT
2. **`lib/core/network/dio_client.dart`** - Tắt logs Dio không cần thiết

### Logs sẽ hiển thị:
- `🔧 [JWT]` - Khởi tạo
- `🔑 [JWT]` - Token được thêm vào request
- `🔴 [JWT]` - Lỗi 401
- `🔄 [JWT]` - Đang refresh token
- `✅ [JWT]` - Thành công
- `❌ [JWT]` - Thất bại
- `🗑️  [JWT]` - Xóa tokens

## 🚀 Cách test

### Bước 1: Chạy app
```bash
cd chattrix-ui
flutter run
```

### Bước 2: Login vào app
Sau khi login, bạn sẽ thấy:
```
🔧 [JWT] AuthInterceptor initialized
🔧 [JWT] Refresh endpoint: http://10.0.2.2:8080/api/v1/auth/refresh
🔑 [JWT] Token added to: POST /v1/auth/login
🔑 [JWT] Token added to: GET /v1/auth/me
```

### Bước 3: Đợi token hết hạn

**Option A: Đợi 15 phút** (chậm)

**Option B: Set token 1 phút** (nhanh - khuyến nghị)
```bash
# 1. Sửa file chattrix-api/.env
JWT_ACCESS_EXPIRATION_MINUTES=1

# 2. Restart backend
cd chattrix-api
docker-compose restart

# 3. Login lại vào app
# 4. Đợi 2 phút
```

### Bước 4: Gọi API sau khi token hết hạn

Thử navigate trong app hoặc pull to refresh. Bạn sẽ thấy:

**Nếu auto-refresh HOẠT ĐỘNG:**
```
🔴 [JWT] 401 Unauthorized: GET /v1/users/me
🔄 [JWT] Attempting token refresh...
🔄 [JWT] Calling refresh API...
🔄 [JWT] Refresh token: 550e8400-e29b-41d4...
🔄 [JWT] Refresh response status: 200
✅ [JWT] New tokens received
✅ [JWT] New access token: eyJhbGciOiJIUzI1NiIs...
✅ [JWT] Token refreshed, retrying request...
✅ [JWT] Retry successful: 200
```

**Nếu auto-refresh KHÔNG HOẠT ĐỘNG:**
```
🔴 [JWT] 401 Unauthorized: GET /v1/users/me
🔄 [JWT] Attempting token refresh...
❌ [JWT] No refresh token found in storage
🗑️  [JWT] Clearing tokens from storage
❌ [JWT] Token refresh failed, user will be logged out
```

Hoặc:
```
🔴 [JWT] 401 Unauthorized: GET /v1/users/me
🔄 [JWT] Attempting token refresh...
🔄 [JWT] Calling refresh API...
🔄 [JWT] Refresh token: 550e8400-e29b-41d4...
🔄 [JWT] Refresh response status: 401
❌ [JWT] Refresh failed with status: 401
❌ [JWT] Response: {success: false, error: {...}}
🗑️  [JWT] Clearing tokens from storage
❌ [JWT] Token refresh failed, user will be logged out
```

## 🔍 Phân tích kết quả

### ✅ Trường hợp 1: Auto-refresh thành công
```
🔴 401 → 🔄 Refresh → ✅ Success → ✅ Retry → User không bị logout
```
**Kết luận:** Hệ thống hoạt động ĐÚNG!

### ❌ Trường hợp 2: Không có refresh token
```
🔴 401 → 🔄 Refresh → ❌ No refresh token → User bị logout
```
**Nguyên nhân:**
- Refresh token bị xóa khỏi storage
- User đã logout trước đó
- Storage bị clear

**Giải pháp:** Login lại

### ❌ Trường hợp 3: Refresh token hết hạn
```
🔴 401 → 🔄 Refresh → 🔄 Call API → ❌ 401 → User bị logout
```
**Nguyên nhân:**
- Refresh token hết hạn (7 ngày)
- Refresh token bị revoke (logout all devices)

**Giải pháp:** 
- Login lại
- Hoặc tăng `JWT_REFRESH_EXPIRATION_DAYS` trong backend

### ❌ Trường hợp 4: Network error
```
🔴 401 → 🔄 Refresh → ❌ Error: Connection refused → User bị logout
```
**Nguyên nhân:**
- Backend không chạy
- Network không ổn định
- Base URL sai

**Giải pháp:**
- Kiểm tra backend đang chạy
- Kiểm tra network
- Kiểm tra base URL trong `.env`

## 🐛 Các vấn đề thường gặp

### Vấn đề 1: Không thấy logs `[JWT]`
**Nguyên nhân:** AuthInterceptor không được gọi

**Kiểm tra:**
```dart
// Xem file auth_repository_provider.dart
// Phải có dòng này:
dio.interceptors.add(AuthInterceptor(dio: dio, secureStorage: secureStorage));
```

### Vấn đề 2: Thấy 401 nhưng không thấy "Attempting token refresh"
**Nguyên nhân:** Request là auth endpoint (login, register, etc.)

**Giải thích:** Đúng! Không nên refresh cho auth endpoints

### Vấn đề 3: Refresh thành công nhưng vẫn bị logout
**Nguyên nhân:** Có lỗi khác sau khi retry

**Debug:** Xem logs sau dòng "Retry successful"

### Vấn đề 4: Refresh token luôn trả 401
**Nguyên nhân:** 
- Refresh token đã bị revoke
- Refresh token không đúng format
- Backend có vấn đề

**Kiểm tra:** Test với Postman (xem file `HUONG_DAN_TEST_JWT.md`)

## 📊 Kết quả mong đợi

### Sau 1 phút (token hết hạn):
1. User tiếp tục dùng app bình thường
2. Khi gọi API, nhận 401
3. Auto-refresh được trigger
4. Lấy token mới
5. Retry request thành công
6. **User KHÔNG BỊ LOGOUT**

### Sau 7 ngày (refresh token hết hạn):
1. User mở app
2. Gọi API, nhận 401
3. Auto-refresh được trigger
4. Refresh token hết hạn → 401
5. **User BỊ LOGOUT** (đúng!)

## 💡 Tips

### Để test nhanh:
```bash
# Backend: Token 1 phút
JWT_ACCESS_EXPIRATION_MINUTES=1

# Restart
docker-compose restart

# Login vào app, đợi 2 phút, thử gọi API
```

### Để tắt logs JWT:
```dart
// Trong auth_interceptor.dart
// Xóa hoặc comment các dòng:
if (kDebugMode) {
  print('...');
}
```

### Để xem logs chi tiết hơn:
```dart
// Thêm vào _refreshAccessToken():
print('🔄 [JWT] Full response: ${response.data}');
```

## 📞 Báo cáo kết quả

Sau khi test, gửi cho tôi:
1. **Logs khi token hết hạn** (copy từ console)
2. **Kết quả:** User có bị logout không?
3. **Backend logs** (nếu có lỗi): `docker-compose logs -f wildfly`

Tôi sẽ phân tích và tìm ra vấn đề chính xác!
