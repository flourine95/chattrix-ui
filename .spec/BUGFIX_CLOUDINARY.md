# Bug Fix: Cloudinary Service API Errors

## Vấn Đề

Khi chạy `flutter analyze`, gặp nhiều lỗi liên quan đến `CloudinaryResponse`:

```
error: The getter 'format' isn't defined for the type 'CloudinaryResponse'.
error: The getter 'width' isn't defined for the type 'CloudinaryResponse'.
error: The getter 'height' isn't defined for the type 'CloudinaryResponse'.
error: The getter 'bytes' isn't defined for the type 'CloudinaryResponse'.
error: The getter 'duration' isn't defined for the type 'CloudinaryResponse'.
error: The method 'deleteFile' isn't defined for the type 'CloudinaryPublic'.
```

## Nguyên Nhân

Package `cloudinary_public` có API khác với những gì được giả định ban đầu:

1. **CloudinaryResponse** chỉ có các trường cơ bản:
   - `secureUrl`
   - `publicId`
   - `url`
   - `createdAt`
   - `data` (Map<String, dynamic>)

2. Các thông tin chi tiết như `format`, `width`, `height`, `bytes`, `duration` nằm trong `response.data` map, không phải là getters trực tiếp.

3. **CloudinaryPublic** không hỗ trợ method `deleteFile()` vì package này chỉ hỗ trợ unsigned uploads (không có API secret).

## Giải Pháp

### 1. Sửa Upload Methods

Thay vì truy cập trực tiếp:
```dart
// ❌ SAI
format: response.format,
width: response.width,
bytes: response.bytes,
```

Phải truy cập qua `data` map:
```dart
// ✅ ĐÚNG
final format = response.data['format'] as String?;
final width = response.data['width'] as int?;
final bytes = response.data['bytes'] as int?;
```

### 2. Sửa Delete Method

Thay vì implement delete (không khả thi với unsigned uploads):
```dart
// ❌ SAI
await _cloudinary.deleteFile(
  publicId: publicId,
  resourceType: resourceType,
);
```

Throw UnimplementedError và hướng dẫn dùng backend:
```dart
// ✅ ĐÚNG
throw UnimplementedError(
  'File deletion requires API secret and should be implemented on backend.'
);
```

## Files Đã Sửa

### 1. lib/core/services/cloudinary_service.dart

**uploadImage():**
```dart
// Extract data from response.data map
final format = response.data['format'] as String?;
final width = response.data['width'] as int?;
final height = response.data['height'] as int?;
final bytes = response.data['bytes'] as int?;

return CloudinaryUploadResult(
  url: response.secureUrl,
  publicId: response.publicId,
  format: format,
  width: width,
  height: height,
  bytes: bytes,
);
```

**uploadVideo():**
```dart
// Extract data from response.data map
final format = response.data['format'] as String?;
final duration = response.data['duration'] as num?;
final bytes = response.data['bytes'] as int?;

return CloudinaryUploadResult(
  url: response.secureUrl,
  thumbnailUrl: thumbnailUrl,
  publicId: response.publicId,
  format: format,
  duration: duration?.toDouble(),
  bytes: bytes,
);
```

**uploadAudio():**
```dart
// Extract data from response.data map
final format = response.data['format'] as String?;
final duration = response.data['duration'] as num?;
final bytes = response.data['bytes'] as int?;

return CloudinaryUploadResult(
  url: response.secureUrl,
  publicId: response.publicId,
  format: format,
  duration: duration?.toDouble(),
  bytes: bytes,
);
```

**uploadDocument():**
```dart
// Extract data from response.data map
final format = response.data['format'] as String?;
final bytes = response.data['bytes'] as int?;

return CloudinaryUploadResult(
  url: response.secureUrl,
  publicId: response.publicId,
  format: format,
  bytes: bytes,
);
```

**deleteFile():**
```dart
Future<void> deleteFile(String publicId, CloudinaryResourceType resourceType) async {
  throw UnimplementedError(
    'File deletion requires API secret and should be implemented on backend. '
    'Use your backend API to delete files from Cloudinary.'
  );
}
```

### 2. Dọn Dẹp Warnings

**Xóa unused imports:**
- `lib/features/chat/presentation/pages/chat_list_page.dart` - Xóa `dart:async`
- `lib/features/chat/presentation/state/conversations_notifier.dart` - Xóa `flutter/foundation.dart`
- `lib/features/chat/presentation/state/messages_notifier.dart` - Xóa `flutter/foundation.dart`
- `lib/features/chat/presentation/widgets/message_bubbles/audio_message_bubble.dart` - Xóa `font_awesome_flutter`
- `lib/features/chat/presentation/widgets/message_bubbles/video_message_bubble.dart` - Xóa `font_awesome_flutter`

**Xóa unused variables:**
- `lib/features/chat/presentation/pages/chat_list_page.dart` - Xóa `wsService` variable
- `lib/features/chat/presentation/widgets/message_bubbles/location_message_bubble.dart` - Xóa `mapUrl` variable và `_generateStaticMapUrl()` method

## Kết Quả

### Trước Khi Sửa:
```
13 errors found
8 warnings found
```

### Sau Khi Sửa:
```
0 errors found
1 info (deprecated API in geolocator package - không phải lỗi của chúng ta)
```

## Lưu Ý Quan Trọng

### 1. Cloudinary Response Data Structure

Khi làm việc với `cloudinary_public`, luôn nhớ:
- Các trường cơ bản: `response.secureUrl`, `response.publicId`
- Các trường chi tiết: `response.data['field_name']`
- Luôn cast type an toàn: `as String?`, `as int?`, `as num?`

### 2. File Deletion

Để xóa file từ Cloudinary:
1. **Không thể** xóa từ Flutter app (cần API secret)
2. **Phải** implement trên backend
3. Backend dùng Cloudinary Admin API với credentials đầy đủ

Example backend (Node.js):
```javascript
const cloudinary = require('cloudinary').v2;

cloudinary.config({
  cloud_name: 'YOUR_CLOUD_NAME',
  api_key: 'YOUR_API_KEY',
  api_secret: 'YOUR_API_SECRET'
});

app.delete('/api/media/:publicId', async (req, res) => {
  try {
    await cloudinary.uploader.destroy(req.params.publicId);
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

### 3. Type Safety

Khi extract data từ `response.data`:
```dart
// ✅ ĐÚNG - Safe casting
final duration = response.data['duration'] as num?;
final durationDouble = duration?.toDouble();

// ❌ SAI - Có thể crash nếu type không khớp
final duration = response.data['duration'] as double;
```

### 4. Null Safety

Tất cả các trường từ `response.data` đều có thể null:
```dart
// ✅ ĐÚNG - Nullable types
final format = response.data['format'] as String?;
final bytes = response.data['bytes'] as int?;

// ❌ SAI - Non-nullable, có thể crash
final format = response.data['format'] as String;
```

## Testing

Sau khi sửa, đã test:
1. ✅ `flutter analyze` - Pass (chỉ 1 info về deprecated API)
2. ✅ `flutter pub run build_runner build` - Success
3. ⏳ Runtime testing - Cần test khi có Cloudinary credentials

## Next Steps

1. **Cấu hình Cloudinary:**
   - Thay `YOUR_CLOUD_NAME` và `YOUR_UPLOAD_PRESET` trong `cloudinary_service.dart`
   - Xem `CLOUDINARY_SETUP.md` để biết chi tiết

2. **Test Upload:**
   - Chạy app
   - Thử upload ảnh, video, document
   - Kiểm tra Cloudinary dashboard

3. **Implement Backend Delete:**
   - Tạo API endpoint để xóa file
   - Dùng Cloudinary Admin API
   - Update Flutter app để gọi backend API

## Tài Liệu Tham Khảo

- [cloudinary_public package](https://pub.dev/packages/cloudinary_public)
- [CloudinaryResponse API](https://pub.dev/documentation/cloudinary_public/latest/cloudinary_public/CloudinaryResponse-class.html)
- [Cloudinary Upload API](https://cloudinary.com/documentation/upload_images)
- [Cloudinary Admin API](https://cloudinary.com/documentation/admin_api)

