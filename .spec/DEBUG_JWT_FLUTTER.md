# 🐛 Debug JWT Auto-Refresh trong Flutter

## ✅ Kết quả kiểm tra code

### 1. Dio Provider Setup: ✅ ĐÚNG
**File:** `lib/features/auth/presentation/providers/auth_repository_provider.dart`
```dart
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = DioClient.createDio();
  final secureStorage = ref.watch(secureStorageProvider);
  
  // ✅ AuthInterceptor được thêm vào
  dio.interceptors.add(AuthInterceptor(dio: dio, secureStorage: secureStorage));
  
  return dio;
}
```

### 2. AuthInterceptor Logic: ✅ ĐÚNG
**File:** `lib/core/network/auth_interceptor.dart`
- ✅ Tự động thêm access token vào header
- ✅ Bắt 401 và gọi refresh
- ✅ Retry request với token mới
- ✅ Sử dụng `QueuedInterceptor` để tránh race condition

### 3. API Endpoints: ✅ ĐÚNG
**File:** `lib/core/constants/api_constants.dart`
- ✅ Refresh endpoint: `/v1/auth/refresh`
- ✅ Backend có path `/v1/auth` (đã kiểm tra)

### 4. Các Features Khác: ✅ ĐÚNG
- ✅ Chat feature dùng `dioProvider` từ auth
- ✅ Không có Dio instance riêng nào

## 🔍 Vấn đề có thể xảy ra

### Scenario 1: Interceptor không được gọi
**Nguyên nhân:** Có thể có nhiều Dio instances

**Cách kiểm tra:**
```dart
// Thêm vào auth_interceptor.dart
@override
Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
  print('🟢 [AuthInterceptor] Request: ${options.method} ${options.path}');
  
  final accessToken = await secureStorage.read(key: AppConstants.accessTokenKey);
  
  if (accessToken != null) {
    print('🔑 [AuthInterceptor] Adding token to header');
    options.headers[AppConstants.authorization] = '${AppConstants.bearer} $accessToken';
  } else {
    print('⚠️  [AuthInterceptor] No access token found');
  }
  
  handler.next(options);
}
```

### Scenario 2: Refresh token thất bại
**Nguyên nhân:** Refresh token hết hạn hoặc API error

**Cách kiểm tra:**
```dart
// Thêm vào auth_interceptor.dart
Future<String?> _refreshAccessToken() async {
  print('🔄 [AuthInterceptor] Starting token refresh...');
  
  try {
    final refreshToken = await secureStorage.read(key: AppConstants.refreshTokenKey);
    
    if (refreshToken == null) {
      print('❌ [AuthInterceptor] No refresh token found');
      await _clearTokens();
      return null;
    }
    
    print('🔄 [AuthInterceptor] Calling refresh API...');
    print('🔄 [AuthInterceptor] Refresh token: ${refreshToken.substring(0, 20)}...');
    
    final response = await _refreshDio.post(
      ApiConstants.refresh, 
      data: {'refreshToken': refreshToken}
    );
    
    print('🔄 [AuthInterceptor] Refresh response: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      final data = response.data['data'];
      final newAccessToken = data['accessToken'] as String;
      final newRefreshToken = data['refreshToken'] as String;
      
      print('✅ [AuthInterceptor] Token refreshed successfully');
      print('🔑 [AuthInterceptor] New access token: ${newAccessToken.substring(0, 20)}...');
      
      await secureStorage.write(key: AppConstants.accessTokenKey, value: newAccessToken);
      await secureStorage.write(key: AppConstants.refreshTokenKey, value: newRefreshToken);
      
      return newAccessToken;
    } else {
      print('❌ [AuthInterceptor] Refresh failed with status: ${response.statusCode}');
      print('❌ [AuthInterceptor] Response: ${response.data}');
      await _clearTokens();
      return null;
    }
  } catch (e) {
    print('❌ [AuthInterceptor] Refresh error: $e');
    await _clearTokens();
    return null;
  }
}
```

### Scenario 3: 401 không được bắt
**Nguyên nhân:** Endpoint không trả 401 hoặc có lỗi khác

**Cách kiểm tra:**
```dart
// Thêm vào auth_interceptor.dart
@override
Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
  print('🔴 [AuthInterceptor] Error occurred');
  print('🔴 [AuthInterceptor] Status: ${err.response?.statusCode}');
  print('🔴 [AuthInterceptor] Path: ${err.requestOptions.path}');
  print('🔴 [AuthInterceptor] Method: ${err.requestOptions.method}');
  
  if (err.response?.statusCode == 401) {
    print('🔴 [AuthInterceptor] 401 Unauthorized detected');
    
    final isRefreshEndpoint = err.requestOptions.path.contains('/auth/refresh');
    final isLoginEndpoint = err.requestOptions.path.contains('/auth/login');
    final isRegisterEndpoint = err.requestOptions.path.contains('/auth/register');
    final isVerifyEndpoint = err.requestOptions.path.contains('/auth/verify-email');
    final isResendEndpoint = err.requestOptions.path.contains('/auth/resend-verification');
    final isForgotPasswordEndpoint = err.requestOptions.path.contains('/auth/forgot-password');
    final isResetPasswordEndpoint = err.requestOptions.path.contains('/auth/reset-password');
    
    if (isRefreshEndpoint ||
        isLoginEndpoint ||
        isRegisterEndpoint ||
        isVerifyEndpoint ||
        isResendEndpoint ||
        isForgotPasswordEndpoint ||
        isResetPasswordEndpoint) {
      print('⚠️  [AuthInterceptor] Skipping refresh for auth endpoint');
      return handler.next(err);
    }
    
    try {
      print('🔄 [AuthInterceptor] Attempting token refresh...');
      final newAccessToken = await _refreshAccessToken();
      
      if (newAccessToken != null) {
        print('✅ [AuthInterceptor] Token refreshed, retrying request...');
        err.requestOptions.headers[AppConstants.authorization] = '${AppConstants.bearer} $newAccessToken';
        
        final response = await dio.fetch(err.requestOptions);
        print('✅ [AuthInterceptor] Retry successful: ${response.statusCode}');
        return handler.resolve(response);
      } else {
        print('❌ [AuthInterceptor] Token refresh failed, passing error to app');
        return handler.next(err);
      }
    } catch (refreshError) {
      print('❌ [AuthInterceptor] Refresh exception: $refreshError');
      await _clearTokens();
      return handler.next(err);
    }
  }
  
  print('🔴 [AuthInterceptor] Passing error to app');
  handler.next(err);
}
```

## 🧪 Cách test

### Bước 1: Thêm logging
Copy các đoạn code logging ở trên vào file `auth_interceptor.dart`

### Bước 2: Chạy app với logs
```bash
cd chattrix-ui
flutter run
```

### Bước 3: Test flow
1. **Login vào app**
   - Xem logs: `🟢 [AuthInterceptor] Request: POST /v1/auth/login`
   - Xem logs: `🔑 [AuthInterceptor] Adding token to header`

2. **Gọi API bình thường**
   - Xem logs: `🟢 [AuthInterceptor] Request: GET /v1/users/me`
   - Xem logs: `🔑 [AuthInterceptor] Adding token to header`

3. **Đợi token hết hạn (15 phút hoặc set 1 phút)**
   - Hoặc thay đổi `.env`: `JWT_ACCESS_EXPIRATION_MINUTES=1`
   - Restart backend: `docker-compose restart`

4. **Gọi API sau khi token hết hạn**
   - Xem logs:
     ```
     🔴 [AuthInterceptor] Error occurred
     🔴 [AuthInterceptor] Status: 401
     🔴 [AuthInterceptor] 401 Unauthorized detected
     🔄 [AuthInterceptor] Attempting token refresh...
     🔄 [AuthInterceptor] Starting token refresh...
     🔄 [AuthInterceptor] Calling refresh API...
     ✅ [AuthInterceptor] Token refreshed successfully
     ✅ [AuthInterceptor] Token refreshed, retrying request...
     ✅ [AuthInterceptor] Retry successful: 200
     ```

### Bước 4: Phân tích logs

**Nếu thấy:**
- ✅ `🟢 Request` → Interceptor đang hoạt động
- ✅ `🔑 Adding token` → Token được thêm vào header
- ✅ `🔴 401 Unauthorized detected` → Backend trả 401 đúng
- ✅ `🔄 Attempting token refresh` → Interceptor bắt 401
- ✅ `✅ Token refreshed successfully` → Refresh thành công
- ✅ `✅ Retry successful` → Request được retry thành công

**Nếu KHÔNG thấy:**
- ❌ Không có `🟢 Request` → Interceptor không được gọi
- ❌ Không có `🔴 401` → Backend không trả 401
- ❌ Có `❌ Refresh failed` → Refresh token hết hạn hoặc API error
- ❌ Có `❌ No refresh token found` → Refresh token bị mất

## 🔧 Các vấn đề thường gặp

### Vấn đề 1: Không thấy logs của interceptor
**Nguyên nhân:** Có Dio instance khác không có interceptor

**Giải pháp:**
```bash
# Tìm tất cả nơi tạo Dio
cd chattrix-ui
grep -r "Dio(" lib/
grep -r "DioClient.createDio" lib/
```

### Vấn đề 2: Refresh token hết hạn
**Triệu chứng:** Logs hiển thị `❌ Refresh failed with status: 401`

**Giải pháp:**
- Login lại
- Hoặc tăng `JWT_REFRESH_EXPIRATION_DAYS` trong backend

### Vấn đề 3: Race condition (nhiều requests cùng lúc)
**Triệu chứng:** Nhiều requests refresh cùng lúc

**Giải pháp:** Đã dùng `QueuedInterceptor` nên không vấn đề

### Vấn đề 4: Base URL sai
**Triệu chứng:** Logs hiển thị `❌ Refresh error: Connection refused`

**Kiểm tra:**
```dart
// Thêm vào auth_interceptor.dart constructor
AuthInterceptor({required this.dio, required this.secureStorage}) {
  print('🔧 [AuthInterceptor] Initializing...');
  print('🔧 [AuthInterceptor] Refresh URL: ${ApiConstants.refresh}');
  
  _refreshDio = Dio(
    BaseOptions(
      contentType: AppConstants.contentTypeJson,
      validateStatus: (status) => status != null && status < 500,
    ),
  );
}
```

## 📊 Kết quả mong đợi

Sau khi thêm logging, bạn sẽ thấy:

### Flow bình thường (token còn hạn):
```
🟢 [AuthInterceptor] Request: GET /v1/users/me
🔑 [AuthInterceptor] Adding token to header
```

### Flow khi token hết hạn:
```
🟢 [AuthInterceptor] Request: GET /v1/users/me
🔑 [AuthInterceptor] Adding token to header
🔴 [AuthInterceptor] Error occurred
🔴 [AuthInterceptor] Status: 401
🔴 [AuthInterceptor] 401 Unauthorized detected
🔄 [AuthInterceptor] Attempting token refresh...
🔄 [AuthInterceptor] Starting token refresh...
🔄 [AuthInterceptor] Calling refresh API...
✅ [AuthInterceptor] Token refreshed successfully
✅ [AuthInterceptor] Token refreshed, retrying request...
✅ [AuthInterceptor] Retry successful: 200
```

## 💡 Next Steps

1. **Thêm logging** vào `auth_interceptor.dart`
2. **Chạy app** và xem logs
3. **Test với token hết hạn** (set 1 phút)
4. **Gửi logs** cho tôi để phân tích

Sau khi có logs, tôi sẽ biết chính xác vấn đề ở đâu!
