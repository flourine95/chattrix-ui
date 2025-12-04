# Khắc phục lỗi trên Windows

## Vấn đề
Khi chạy ứng dụng trên Windows, gặp vấn đề:
- Token cache liên tục báo "Access token not in cache, reading from storage"
- Hiệu suất giảm do phải đọc từ secure storage nhiều lần

## Nguyên nhân
1. **FlutterSecureStorage trên Windows**: Cần cấu hình đặc biệt cho Windows với `WindowsOptions`
2. **Token Cache Logic**: Logic cache không xử lý đúng trường hợp token null/empty, dẫn đến cache token rỗng

## Giải pháp đã áp dụng

### 1. Cấu hình FlutterSecureStorage cho Windows
**File**: `lib/features/auth/presentation/providers/auth_repository_provider.dart`

```dart
@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) {
  // Configure for Windows compatibility
  const windowsOptions = WindowsOptions(
    useBackwardCompatibility: false,
  );
  
  return const FlutterSecureStorage(
    wOptions: windowsOptions,
  );
}
```

### 2. Cải thiện Token Cache Service
**File**: `lib/core/services/token_cache_service.dart`

Thay đổi chính:
- Chỉ cache token khi nó **không null và không empty**
- Thêm logging chi tiết hơn để debug
- Kiểm tra `isNotEmpty` khi lấy token từ cache

**Trước:**
```dart
if (_accessToken != null) {
  return _accessToken;
}
_accessToken = await _secureStorage.read(key: AppConstants.accessTokenKey);
return _accessToken;
```

**Sau:**
```dart
if (_accessToken != null && _accessToken!.isNotEmpty) {
  return _accessToken;
}

final token = await _secureStorage.read(key: AppConstants.accessTokenKey);

// Only cache non-null and non-empty tokens
if (token != null && token.isNotEmpty) {
  _accessToken = token;
  print('✅ [TokenCache] Access token loaded and cached from storage');
} else {
  print('⚠️ [TokenCache] No access token found in storage');
}

return token;
```

## Cách test

1. **Xóa cache và build lại:**
```bash
flutter clean
flutter pub get
```

2. **Chạy ứng dụng trên Windows:**
```bash
flutter run -d windows
```

3. **Kiểm tra log:**
- Sau khi đăng nhập, bạn sẽ thấy: `✅ [TokenCache] Access token loaded and cached from storage`
- Các request tiếp theo sẽ thấy: `🔑 [TokenCache] Access token retrieved from cache` (không đọc từ storage nữa)

## Kết quả mong đợi

✅ Token chỉ đọc từ storage **1 lần** sau khi đăng nhập
✅ Các lần sau sẽ lấy từ cache trong memory
✅ Hiệu suất cải thiện đáng kể
✅ Log rõ ràng hơn để debug

## Lưu ý

- Cấu hình `WindowsOptions` chỉ ảnh hưởng khi chạy trên Windows
- Không ảnh hưởng đến Android, iOS, hoặc các nền tảng khác
- Token cache vẫn được xóa khi logout hoặc token hết hạn

