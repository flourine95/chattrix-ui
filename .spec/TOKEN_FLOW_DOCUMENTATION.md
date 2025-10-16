# 🔐 Tài liệu: Khi nào Access Token & Refresh Token được sử dụng?

## 📌 Tổng quan

### Access Token
- **Lưu trữ**: Secure Storage (FlutterSecureStorage)
- **Tự động thêm vào**: Mọi API request (trừ login/register/verify)
- **Được xử lý bởi**: `AuthHttpClient`

### Refresh Token
- **Lưu trữ**: Secure Storage (FlutterSecureStorage)
- **Chỉ sử dụng**: Khi access token hết hạn (401)
- **Được xử lý bởi**: `AuthHttpClient._refreshAccessToken()`

---

## 🔄 Flow hoạt động

### 1️⃣ **Access Token được SỬ DỤNG khi:**

#### Tự động thêm vào HEADER của mọi API request
```dart
// File: auth_http_client.dart - Dòng 30-34
final accessToken = await _secureStorage.read(key: ApiConstants.accessTokenKey);
if (accessToken != null && !request.headers.containsKey('Authorization')) {
  request.headers['Authorization'] = 'Bearer $accessToken';
}
```

#### Các API sử dụng Access Token:
✅ **GET /api/v1/users/me** - Lấy thông tin user hiện tại
✅ **PUT /api/v1/auth/change-password** - Đổi mật khẩu
✅ **POST /api/v1/auth/logout** - Đăng xuất thiết bị hiện tại
✅ **POST /api/v1/auth/logout-all** - Đăng xuất tất cả thiết bị
✅ Tất cả các API khác (chat, contacts, profile, etc.)

#### Các API KHÔNG sử dụng Access Token:
❌ **POST /api/v1/auth/login** - Đăng nhập
❌ **POST /api/v1/auth/register** - Đăng ký
❌ **POST /api/v1/auth/verify-email** - Xác thực email
❌ **POST /api/v1/auth/resend-verification** - Gửi lại OTP
❌ **POST /api/v1/auth/forgot-password** - Quên mật khẩu
❌ **POST /api/v1/auth/reset-password** - Reset mật khẩu
❌ **POST /api/v1/auth/refresh** - Refresh token

---

### 2️⃣ **Refresh Token được SỬ DỤNG khi:**

#### Khi nhận 401 Unauthorized
```dart
// File: auth_http_client.dart - Dòng 48-50
if (response.statusCode == 401) {
  // Tự động gọi refresh token
  final newAccessToken = await _refreshAccessToken();
  // ...retry request với token mới
}
```

#### Chi tiết flow auto-refresh:
1. **User gọi API** (ví dụ: GET /users/me)
2. **AuthHttpClient** tự động thêm access token vào header
3. **Backend trả về 401** (token hết hạn)
4. **AuthHttpClient tự động:**
   - Lấy refresh token từ Secure Storage
   - Gọi API `POST /api/v1/auth/refresh` với refresh token
   - Backend trả về access token MỚI + refresh token MỚI
   - Lưu cả 2 tokens mới vào Secure Storage
   - Retry request gốc với access token mới
5. **Request thành công** → User không biết gì cả!

#### API refresh token:
```dart
// File: auth_http_client.dart - Dòng 115-124
final response = await _inner.post(
  Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.refresh}'),
  headers: {'Content-Type': ApiConstants.contentTypeJson},
  body: jsonEncode({'refreshToken': refreshToken}),
);

// Lưu tokens mới
await _secureStorage.write(key: ApiConstants.accessTokenKey, value: newAccessToken);
await _secureStorage.write(key: ApiConstants.refreshTokenKey, value: newRefreshToken);
```

---

### 3️⃣ **Access Token được LƯU khi:**

#### Sau khi login thành công
```dart
// File: auth_repository_impl.dart - login()
final tokensModel = await remoteDataSource.login(...);

// Lưu tokens
await localDataSource.saveTokens(
  accessToken: tokensModel.accessToken,
  refreshToken: tokensModel.refreshToken,
);
```

#### Sau khi refresh token thành công
```dart
// File: auth_http_client.dart - _refreshAccessToken()
await _secureStorage.write(
  key: ApiConstants.accessTokenKey,
  value: newAccessToken,
);
await _secureStorage.write(
  key: ApiConstants.refreshTokenKey,
  value: newRefreshToken,
);
```

---

### 4️⃣ **Tokens được XÓA khi:**

#### User logout
```dart
// File: auth_repository_impl.dart - logout()
await remoteDataSource.logout('');
await localDataSource.deleteTokens(); // ← Xóa tokens
```

#### Refresh token hết hạn (401)
```dart
// File: auth_http_client.dart - _refreshAccessToken()
if (response.statusCode == 401) {
  await _clearTokens(); // ← Xóa tokens
  return null;
}
```

#### Auto-refresh thất bại
```dart
// File: auth_http_client.dart - send()
catch (e) {
  debugPrint('❌ Auto-refresh failed: $e');
  await _clearTokens(); // ← Xóa tokens
}
```

---

## 📊 Timeline ví dụ

### Scenario: User đang dùng app

```
[00:00] User login
        ↓
        POST /api/v1/auth/login
        ← Response: { accessToken, refreshToken }
        → Lưu vào Secure Storage

[00:05] User xem profile
        ↓
        GET /api/v1/users/me
        → AuthHttpClient tự động thêm: Authorization: Bearer {accessToken}
        ← 200 OK

[00:30] Access token hết hạn, user vẫn xem profile
        ↓
        GET /api/v1/users/me
        → AuthHttpClient thêm: Authorization: Bearer {accessToken_cũ}
        ← 401 Unauthorized
        ↓
        🔄 Auto-refresh:
        POST /api/v1/auth/refresh
        → Body: { refreshToken }
        ← 200 OK: { accessToken_mới, refreshToken_mới }
        → Lưu tokens mới vào Secure Storage
        ↓
        🔄 Retry:
        GET /api/v1/users/me
        → Authorization: Bearer {accessToken_mới}
        ← 200 OK ✅

[07:00] 7 ngày sau, user không dùng app
        ↓
        Refresh token hết hạn
        ↓
        User mở app
        → GET /api/v1/users/me
        ← 401 Unauthorized
        ↓
        🔄 Auto-refresh:
        POST /api/v1/auth/refresh
        ← 401 Unauthorized (refresh token hết hạn)
        → Xóa tất cả tokens
        → Chuyển về màn hình login ❌
```

---

## 🎯 Kết luận

### Access Token được dùng:
- ✅ **Tự động** cho MỌI API request cần authentication
- ✅ **Không cần** developer thủ công thêm vào header
- ✅ **AuthHttpClient** tự động lấy từ Secure Storage

### Refresh Token được dùng:
- ✅ **Chỉ khi** access token hết hạn (401)
- ✅ **Tự động** bởi AuthHttpClient
- ✅ **Developer không cần** xử lý gì cả
- ✅ **Sliding Session**: Mỗi lần refresh → cả 2 tokens đều mới

### Developer chỉ cần:
```dart
// Gọi API bình thường
final result = await ref.read(getCurrentUserUseCaseProvider)();

// AuthHttpClient tự động xử lý:
// - Thêm access token vào header
// - Auto-refresh nếu hết hạn
// - Retry request
// - Lưu tokens mới
```

**Quá trình hoàn toàn TRANSPARENT (trong suốt)!** 🎉

