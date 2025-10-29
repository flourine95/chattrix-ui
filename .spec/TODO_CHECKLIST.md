# TODO Checklist - Rich Media Chat Features

## ✅ Đã Hoàn Thành

- [x] Mở rộng Message model với các trường mới
- [x] Tạo CloudinaryService để upload media
- [x] Tạo MediaPickerService để chọn media từ thiết bị
- [x] Tạo AttachmentPickerBottomSheet UI
- [x] Tạo các MessageBubble widgets cho từng loại tin nhắn
- [x] Cập nhật API layer để hỗ trợ rich media
- [x] Tích hợp attachment picker vào chat view
- [x] Sửa lỗi CloudinaryResponse API
- [x] Dọn dẹp warnings và unused code
- [x] Build runner thành công
- [x] Flutter analyze pass (chỉ 1 info về deprecated API)

## 🔧 Cần Làm Ngay (Bắt Buộc)

### 1. Cấu Hình Cloudinary ⚠️ QUAN TRỌNG

**File:** `lib/core/services/cloudinary_service.dart`

```dart
// Dòng 11-12, thay thế:
static const String _cloudName = 'dk3gud5kq';  // ← Thay bằng cloud name của bạn
static const String _uploadPreset = 'chattrix_media';  // ← Thay bằng preset của bạn
```

**Các bước:**
1. Đăng ký tài khoản tại https://cloudinary.com
2. Tạo upload preset (unsigned) tên `chattrix_media`
3. Copy cloud name từ dashboard
4. Cập nhật 2 dòng trên

**Xem chi tiết:** `CLOUDINARY_SETUP.md`

### 2. Cập Nhật Backend Database ⚠️ QUAN TRỌNG

**Chạy SQL migration:**
```sql
ALTER TABLE messages 
ADD COLUMN type VARCHAR(20) DEFAULT 'TEXT',
ADD COLUMN media_url TEXT,
ADD COLUMN thumbnail_url TEXT,
ADD COLUMN file_name VARCHAR(255),
ADD COLUMN file_size BIGINT,
ADD COLUMN duration INTEGER,
ADD COLUMN latitude DOUBLE PRECISION,
ADD COLUMN longitude DOUBLE PRECISION,
ADD COLUMN location_name VARCHAR(255),
ADD COLUMN reply_to_message_id INTEGER,
ADD COLUMN reactions JSONB,
ADD COLUMN mentions JSONB;

CREATE INDEX idx_messages_type ON messages(type);
CREATE INDEX idx_messages_reply_to ON messages(reply_to_message_id);
```

### 3. Cập Nhật Backend API ⚠️ QUAN TRỌNG

**Endpoint:** `POST /v1/conversations/{id}/messages`

**Request body cần nhận thêm các trường:**
- `type` (string, optional)
- `mediaUrl` (string, optional)
- `thumbnailUrl` (string, optional)
- `fileName` (string, optional)
- `fileSize` (integer, optional)
- `duration` (integer, optional)
- `latitude` (double, optional)
- `longitude` (double, optional)
- `locationName` (string, optional)
- `replyToMessageId` (integer, optional)
- `mentions` (string, optional)
- `reactions` (string, optional)

**Response cần trả về tất cả các trường trên (có thể null)**

**Xem chi tiết:** `API_REQUIREMENTS.md`

### 4. Test Cơ Bản

```bash
# 1. Chạy app
flutter run

# 2. Test các chức năng:
- [ ] Gửi tin nhắn text (phải hoạt động như cũ)
- [ ] Nhấn nút attachment (📎)
- [ ] Chọn Gallery
- [ ] Chọn 1 ảnh
- [ ] Xem ảnh upload và hiển thị trong chat
```

## 📋 Cần Làm Sau (Tùy Chọn)

### 1. Implement Reply Feature

**UI cần tạo:**
- [ ] Nút reply trên mỗi tin nhắn
- [ ] Hiển thị quoted message khi reply
- [ ] Cancel reply button
- [ ] Scroll to original message khi tap vào quoted message

**Backend:**
- [ ] API đã hỗ trợ `replyToMessageId` field
- [ ] WebSocket broadcast reply messages

### 2. Implement Reactions Feature

**UI cần tạo:**
- [ ] Emoji picker bottom sheet
- [ ] Hiển thị reactions dưới tin nhắn
- [ ] Tap để add/remove reaction
- [ ] Hiển thị danh sách users đã react

**Backend cần thêm:**
- [ ] `POST /v1/messages/{id}/reactions` - Add reaction
- [ ] `DELETE /v1/messages/{id}/reactions/{emoji}` - Remove reaction
- [ ] WebSocket broadcast reaction updates

**Data structure:**
```json
{
  "reactions": "{\"👍\": [1, 2, 3], \"❤️\": [4, 5]}"
}
```

### 3. Implement Mentions Feature

**UI cần tạo:**
- [ ] Autocomplete khi gõ @ trong input
- [ ] Hiển thị danh sách users để mention
- [ ] Highlight mentions trong tin nhắn
- [ ] Tap vào mention để xem profile

**Backend:**
- [ ] API parse mentions từ content
- [ ] Gửi notification cho users được mention
- [ ] WebSocket broadcast mentions

**Data structure:**
```json
{
  "content": "@john @jane Check this out!",
  "mentions": "[123, 456]"
}
```

### 4. Voice Recording

**Packages cần thêm:**
```yaml
dependencies:
  record: ^5.0.0  # Hoặc flutter_sound
  path_provider: ^2.1.0
```

**Chức năng:**
- [ ] Nút record trong input bar
- [ ] Recording UI với waveform
- [ ] Pause/Resume recording
- [ ] Cancel/Send recording
- [ ] Upload audio file lên Cloudinary

### 5. Video Recording

**Packages cần thêm:**
```yaml
dependencies:
  camera: ^0.10.0
```

**Chức năng:**
- [ ] Mở camera để quay video
- [ ] Preview video trước khi gửi
- [ ] Trim video (optional)
- [ ] Upload video lên Cloudinary

### 6. Media Preview Before Sending

**Chức năng:**
- [ ] Preview ảnh/video trước khi gửi
- [ ] Thêm caption
- [ ] Crop/rotate ảnh (optional)
- [ ] Compress media
- [ ] Cancel/Send

### 7. Image Compression

**Package:**
```yaml
dependencies:
  flutter_image_compress: ^2.0.0
```

**Chức năng:**
- [ ] Tự động compress ảnh trước khi upload
- [ ] Giảm kích thước file
- [ ] Giữ chất lượng hợp lý
- [ ] Tiết kiệm bandwidth và storage

### 8. Upload Progress Indicator

**Chức năng:**
- [ ] Hiển thị progress bar khi upload
- [ ] Cho phép cancel upload
- [ ] Retry nếu upload fail
- [ ] Queue multiple uploads

### 9. Media Gallery View

**Chức năng:**
- [ ] Tap vào ảnh/video để xem fullscreen
- [ ] Swipe để xem ảnh/video khác
- [ ] Zoom in/out
- [ ] Share/Download media
- [ ] View all media trong conversation

### 10. Backend File Deletion

**Backend API:**
```javascript
// Node.js example
app.delete('/api/media/:publicId', async (req, res) => {
  const cloudinary = require('cloudinary').v2;
  await cloudinary.uploader.destroy(req.params.publicId);
  res.json({ success: true });
});
```

**Flutter:**
```dart
// Update CloudinaryService.deleteFile() to call backend API
Future<void> deleteFile(String publicId) async {
  await http.delete(Uri.parse('$baseUrl/api/media/$publicId'));
}
```

## 🐛 Known Issues

### 1. Deprecated Geolocator API

**Warning:**
```
'desiredAccuracy' is deprecated and shouldn't be used.
```

**Fix (optional):**
```dart
// File: lib/core/services/media_picker_service.dart
// Line 185, thay thế:
final position = await Geolocator.getCurrentPosition(
  desiredAccuracy: LocationAccuracy.high,
);

// Bằng:
final position = await Geolocator.getCurrentPosition(
  locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.high,
  ),
);
```

### 2. WebSocket Send Message

**Issue:** WebSocket hiện tại chỉ gửi text content

**Fix needed:**
```dart
// File: lib/core/services/chat_websocket_service.dart
// Update sendMessage() method để gửi thêm:
// - type
// - mediaUrl
// - thumbnailUrl
// - fileName
// - fileSize
// - duration
// - latitude
// - longitude
// - locationName
```

## 📊 Testing Checklist

### Manual Testing

- [ ] **Text messages** - Gửi và nhận text bình thường
- [ ] **Image from gallery** - Chọn ảnh từ thư viện
- [ ] **Take photo** - Chụp ảnh bằng camera
- [ ] **Video from gallery** - Chọn video từ thư viện
- [ ] **Audio file** - Chọn file audio
- [ ] **Document file** - Chọn PDF/DOCX
- [ ] **Location sharing** - Chia sẻ vị trí GPS
- [ ] **Image display** - Ảnh hiển thị đúng trong chat
- [ ] **Video display** - Video có thumbnail và play button
- [ ] **Audio display** - Audio có play button và duration
- [ ] **Document display** - Document có icon và file name
- [ ] **Location display** - Location có map preview
- [ ] **WebSocket receive** - Nhận tin nhắn real-time
- [ ] **Scroll performance** - Scroll mượt với nhiều media
- [ ] **Memory usage** - Không bị memory leak

### Error Handling

- [ ] **No internet** - Hiển thị error khi không có mạng
- [ ] **Upload failed** - Hiển thị error và cho phép retry
- [ ] **Permission denied** - Hiển thị message khi không có permission
- [ ] **File too large** - Hiển thị error khi file quá lớn
- [ ] **Invalid file type** - Hiển thị error khi file type không hợp lệ
- [ ] **Backend error** - Hiển thị error khi API fail

### Performance Testing

- [ ] **Large images** - Test với ảnh > 5MB
- [ ] **Long videos** - Test với video > 1 phút
- [ ] **Many messages** - Test với > 100 tin nhắn
- [ ] **Slow network** - Test với 3G/2G
- [ ] **Low memory device** - Test trên thiết bị cũ

## 📚 Documentation Files

- `README.md` - Tổng quan project (nếu có)
- `API_REQUIREMENTS.md` - Chi tiết backend API requirements
- `CLOUDINARY_SETUP.md` - Hướng dẫn cấu hình Cloudinary
- `IMPLEMENTATION_SUMMARY_VI.md` - Tóm tắt implementation (tiếng Việt)
- `QUICK_START.md` - Hướng dẫn bắt đầu nhanh
- `BUGFIX_CLOUDINARY.md` - Chi tiết bug fix CloudinaryResponse
- `TODO_CHECKLIST.md` - File này

## 🎯 Priority Order

### Must Do (Bắt buộc):
1. ⚠️ Cấu hình Cloudinary
2. ⚠️ Cập nhật backend database
3. ⚠️ Cập nhật backend API
4. ⚠️ Test basic functionality

### Should Do (Nên làm):
5. Implement reply feature
6. Implement reactions
7. Implement mentions
8. Add upload progress indicator
9. Add image compression

### Nice to Have (Tùy chọn):
10. Voice recording
11. Video recording
12. Media preview before sending
13. Media gallery view
14. Backend file deletion

## 💡 Tips

1. **Test từng feature một** - Đừng implement tất cả cùng lúc
2. **Bắt đầu với basic** - Text, image, video trước
3. **Test trên real device** - Không chỉ emulator
4. **Monitor Cloudinary usage** - Free tier có giới hạn
5. **Optimize images** - Compress trước khi upload
6. **Handle errors gracefully** - Luôn có fallback UI
7. **Log everything** - Debug logs giúp fix bug nhanh hơn

## 🚀 Ready to Start?

1. ✅ Code đã sẵn sàng
2. ⏳ Cần cấu hình Cloudinary
3. ⏳ Cần cập nhật backend
4. ⏳ Sẵn sàng test

**Next step:** Đọc `QUICK_START.md` để bắt đầu! 🎉

