# 🎯 Tóm tắt: Debug JWT Auto-Refresh

## ✅ Đã làm gì

### 1. Thêm logging vào AuthInterceptor
**File:** `lib/core/network/auth_interceptor.dart`

Logs sẽ hiển thị:
- `🔧 [JWT]` Khởi tạo interceptor
- `🔑 [JWT]` Token được thêm vào request
- `🔴 [JWT]` Phát hiện 401 Unauthorized
- `🔄 [JWT]` Đang refresh token
- `✅ [JWT]` Refresh thành công
- `❌ [JWT]` Refresh thất bại
- `🗑️  [JWT]` Xóa tokens

### 2. Tắt logs Dio không cần thiết
**File:** `lib/core/network/dio_client.dart`

Chỉ log errors, tắt request/response body

## 🚀 Cách test ngay

### Bước 1: Set token hết hạn sau 1 phút
```bash
# Sửa chattrix-api/.env
JWT_ACCESS_EXPIRATION_MINUTES=1

# Restart
cd chattrix-api
docker-compose restart
```

### Bước 2: Chạy app
```bash
cd chattrix-ui
flutter run
```

### Bước 3: Login và đợi 2 phút

### Bước 4: Thử gọi API (navigate hoặc pull to refresh)

## 📊 Kết quả mong đợi

### ✅ Nếu auto-refresh HOẠT ĐỘNG:
```
🔴 [JWT] 401 Unauthorized: GET /v1/users/me
🔄 [JWT] Attempting token refresh...
🔄 [JWT] Calling refresh API...
✅ [JWT] New tokens received
✅ [JWT] Token refreshed, retrying request...
✅ [JWT] Retry successful: 200
```
→ **User KHÔNG bị logout**

### ❌ Nếu auto-refresh KHÔNG HOẠT ĐỘNG:
```
🔴 [JWT] 401 Unauthorized: GET /v1/users/me
🔄 [JWT] Attempting token refresh...
❌ [JWT] No refresh token found in storage
```
→ **User BỊ logout**

Hoặc:
```
🔴 [JWT] 401 Unauthorized: GET /v1/users/me
🔄 [JWT] Attempting token refresh...
🔄 [JWT] Refresh response status: 401
❌ [JWT] Refresh failed with status: 401
```
→ **Refresh token hết hạn**

## 🔍 Nguyên nhân có thể

1. **Refresh token bị xóa** → Login lại
2. **Refresh token hết hạn (7 ngày)** → Login lại
3. **Network error** → Kiểm tra backend
4. **Base URL sai** → Kiểm tra `.env`

## 📞 Gửi kết quả

Copy logs từ console và gửi cho tôi để phân tích!

---

**Chi tiết:** Xem file `TEST_JWT_REFRESH.md`
