# WeChat Media Picker Usage Guide

## Overview

The `MediaPickerService` has been migrated to use `wechat_assets_picker` (v10.0.0) and `wechat_camera_picker` (v4.4.0) for a better user experience with WeChat-style UI.

## Key Changes

### Before (image_picker)
```dart
// Old way - no context needed
final file = await mediaPicker.takePhoto();
final files = await mediaPicker.pickMultipleImagesFromGallery();
```

### After (wechat_camera_picker & wechat_assets_picker)
```dart
// New way - BuildContext required
final file = await mediaPicker.takePhoto(context);
final files = await mediaPicker.pickMultipleImagesFromGallery(context);
```

## Available Methods

### 1. Pick Single Image from Gallery
```dart
Future<File?> pickImageFromGallery(BuildContext context)
```
- Opens WeChat-style asset picker
- Allows selection of 1 image
- No preview mode for faster selection
- Returns `File?` (null if cancelled)

### 2. Pick Multiple Images from Gallery
```dart
Future<List<File>> pickMultipleImagesFromGallery(BuildContext context)
```
- Opens WeChat-style asset picker
- Allows selection of up to 9 images
- Shows preview and selection indicators
- Returns `List<File>` (empty if cancelled)

### 3. Take Photo with Camera
```dart
Future<File?> takePhoto(BuildContext context)
```
- Opens WeChat-style camera interface
- Photo mode only (no video recording)
- Requests camera permission automatically
- Returns `File?` (null if cancelled or permission denied)

### 4. Pick Video from Gallery
```dart
Future<File?> pickVideoFromGallery(BuildContext context)
```
- Opens WeChat-style asset picker for videos
- Maximum duration: 5 minutes (300 seconds)
- Throws exception if video exceeds duration limit
- Returns `File?` (null if cancelled)

### 5. Record Video with Camera
```dart
Future<File?> recordVideo(BuildContext context)
```
- Opens WeChat-style camera interface in video mode
- Recording only mode (no photo capture)
- Maximum recording duration: 5 minutes
- Shows real-time duration feedback
- Returns `File?` (null if cancelled or permission denied)

## Configuration Details

### Image Picker Config
```dart
AssetPickerConfig(
  maxAssets: 9,                    // Max 9 images for multi-select
  requestType: RequestType.image,  // Images only
)
```

### Video Picker Config
```dart
AssetPickerConfig(
  maxAssets: 1,                    // Single video selection
  requestType: RequestType.video,  // Videos only
)
```

### Camera Picker Config (Photo)
```dart
CameraPickerConfig(
  enableRecording: false,          // Photo mode
  maximumRecordingDuration: Duration(seconds: 15),
)
```

### Camera Picker Config (Video)
```dart
CameraPickerConfig(
  enableRecording: true,           // Video mode enabled
  onlyEnableRecording: true,       // Video only, no photo
  maximumRecordingDuration: Duration(minutes: 5),
)
```

## Permissions

The service automatically handles permission requests:

- **Camera**: Required for `takePhoto()` and `recordVideo()`
- **Photos**: Automatically requested by wechat_assets_picker when needed

If permission is denied, methods return `null` and log a warning.

## Error Handling

All methods:
- Log errors using `AppLogger`
- Rethrow exceptions for upstream handling
- Return `null` or empty list on cancellation (not an error)

Example error handling:
```dart
try {
  final file = await mediaPicker.takePhoto(context);
  if (file != null) {
    // Process file
  } else {
    // User cancelled or permission denied
  }
} catch (e) {
  // Handle error (e.g., show error message)
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Failed to capture photo: $e')),
  );
}
```

## Migration Checklist

- [x] Replace `image_picker` with `wechat_camera_picker` for camera operations
- [x] Replace `image_picker.pickMultiImage` with `wechat_assets_picker` for gallery
- [x] Add `BuildContext` parameter to all picker methods
- [x] Update all method calls to pass `context`
- [x] Keep `file_picker` for audio and document selection (not changed)
- [x] Test camera photo capture
- [x] Test gallery multi-image selection
- [x] Test video recording
- [x] Test video gallery selection with duration validation

## Benefits

1. **Better UX**: WeChat-style UI is familiar and intuitive
2. **Multi-selection**: Native support for selecting multiple images (up to 9)
3. **Preview**: Built-in preview before confirming selection
4. **Performance**: Optimized for large photo libraries
5. **Consistency**: Same UI pattern across iOS and Android
6. **Maintained**: Both packages are actively maintained (v10.0.0 and v4.4.0)

## Notes

- `image_picker` is still in `pubspec.yaml` because the profile feature uses it
- If you migrate profile feature, you can remove `image_picker` completely
- `file_picker` is still used for audio and document selection (unchanged)
