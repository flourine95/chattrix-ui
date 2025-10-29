# Cloudinary Setup Guide

## Overview
This guide explains how to configure Cloudinary for media storage in the Chattrix chat application.

## 1. Create Cloudinary Account

1. Go to [https://cloudinary.com/](https://cloudinary.com/)
2. Sign up for a free account
3. Verify your email address
4. Log in to your Cloudinary dashboard

## 2. Get Your Credentials

From your Cloudinary dashboard, you'll need:
- **Cloud Name**: Your unique cloud name (e.g., "demo")
- **API Key**: Your API key
- **API Secret**: Your API secret
- **Upload Preset**: You'll create this in the next step

## 3. Create Upload Preset

Upload presets allow unsigned uploads from your Flutter app without exposing your API secret.

### Steps:
1. Go to **Settings** → **Upload** in your Cloudinary dashboard
2. Scroll down to **Upload presets**
3. Click **Add upload preset**
4. Configure the preset:
   - **Preset name**: `chattrix_media` (or any name you prefer)
   - **Signing mode**: **Unsigned** (important!)
   - **Folder**: `chattrix/` (optional, helps organize files)
   - **Access mode**: **Public** (so URLs are accessible)
   - **Unique filename**: **Enabled** (prevents filename conflicts)
   - **Overwrite**: **Disabled**
   - **Resource type**: **Auto** (allows images, videos, and raw files)
5. Click **Save**

### Recommended Settings by Media Type:

#### For Images:
- **Format**: Auto
- **Quality**: Auto
- **Transformation**: Optional (e.g., max width 1920px to reduce file size)

#### For Videos:
- **Format**: Auto
- **Quality**: Auto
- **Video codec**: Auto
- **Generate thumbnail**: **Enabled** (important for video previews)

#### For Documents:
- **Resource type**: Raw
- **Format**: Keep original

## 4. Configure Flutter App

Update the CloudinaryService in your Flutter app:

### File: `lib/core/services/cloudinary_service.dart`

Replace the placeholder values:

```dart
class CloudinaryService {
  // TODO: Replace these with your actual Cloudinary credentials
  static const String _cloudName = 'YOUR_CLOUD_NAME';  // e.g., 'demo'
  static const String _uploadPreset = 'YOUR_UPLOAD_PRESET';  // e.g., 'chattrix_media'

  late final CloudinaryPublic _cloudinary;

  CloudinaryService() {
    _cloudinary = CloudinaryPublic(
      _cloudName,
      _uploadPreset,
      cache: false,
    );
  }
  
  // ... rest of the code
}
```

### Example Configuration:
```dart
static const String _cloudName = 'myapp-cloud';
static const String _uploadPreset = 'chattrix_media';
```

## 5. Test Upload

After configuration, test the upload functionality:

1. Run your Flutter app
2. Open a chat conversation
3. Tap the attachment button (paperclip icon)
4. Select an image from gallery
5. Check if the image uploads successfully
6. Verify the image appears in your Cloudinary dashboard under the `chattrix/` folder

## 6. Cloudinary Dashboard

### View Uploaded Files:
1. Go to **Media Library** in your dashboard
2. You should see uploaded files organized by folder
3. Click on any file to see details (URL, size, format, etc.)

### Monitor Usage:
1. Go to **Dashboard** → **Usage**
2. Check your:
   - Storage usage
   - Bandwidth usage
   - Transformations usage
3. Free tier includes:
   - 25 GB storage
   - 25 GB bandwidth/month
   - 25,000 transformations/month

## 7. Security Best Practices

### 1. Use Upload Presets
- Never expose your API secret in the Flutter app
- Always use unsigned upload presets

### 2. Restrict Upload Preset
In your upload preset settings, you can add restrictions:
- **Max file size**: Set maximum file size (e.g., 10 MB for images, 100 MB for videos)
- **Allowed formats**: Restrict to specific file types
- **Max image dimensions**: Limit image resolution

### 3. Implement Backend Validation
Even though uploads go directly to Cloudinary, validate on your backend:
```javascript
// Example backend validation
function validateMediaUrl(url, messageType) {
  // Check if URL is from your Cloudinary account
  if (!url.startsWith(`https://res.cloudinary.com/${YOUR_CLOUD_NAME}/`)) {
    throw new Error('Invalid media URL');
  }
  
  // Check file type matches message type
  if (messageType === 'IMAGE' && !url.match(/\.(jpg|jpeg|png|gif|webp)$/i)) {
    throw new Error('Invalid image format');
  }
  
  // Add more validations as needed
}
```

### 4. Set Up Webhooks (Optional)
Configure webhooks to get notified when files are uploaded:
1. Go to **Settings** → **Webhooks**
2. Add notification URL (your backend endpoint)
3. Select events: Upload, Delete, etc.

## 8. Advanced Features

### Auto-Generate Thumbnails
For videos, Cloudinary automatically generates thumbnails. Access them via:
```
Original video: https://res.cloudinary.com/demo/video/upload/v1234/video.mp4
Thumbnail: https://res.cloudinary.com/demo/video/upload/v1234/video.jpg
```

### Image Transformations
You can transform images on-the-fly by modifying the URL:
```
Original: https://res.cloudinary.com/demo/image/upload/v1234/image.jpg
Resized: https://res.cloudinary.com/demo/image/upload/w_300,h_300,c_fill/v1234/image.jpg
```

### Video Transformations
```
Original: https://res.cloudinary.com/demo/video/upload/v1234/video.mp4
Compressed: https://res.cloudinary.com/demo/video/upload/q_auto/v1234/video.mp4
```

## 9. Cleanup and Maintenance

### Delete Unused Files
Implement a cleanup job to delete files that are no longer referenced:

```dart
// Example cleanup function
Future<void> deleteCloudinaryFile(String publicId) async {
  // Note: Deletion requires API secret, so this should be done on backend
  // This is just an example of the concept
  
  // Backend endpoint: DELETE /api/media/{publicId}
  // Backend will use Cloudinary Admin API to delete the file
}
```

### Backend Cleanup Script (Node.js Example)
```javascript
const cloudinary = require('cloudinary').v2;

cloudinary.config({
  cloud_name: 'YOUR_CLOUD_NAME',
  api_key: 'YOUR_API_KEY',
  api_secret: 'YOUR_API_SECRET'
});

async function deleteUnusedMedia() {
  // Get all media URLs from database
  const usedUrls = await db.query('SELECT DISTINCT media_url FROM messages WHERE media_url IS NOT NULL');
  
  // Get all files from Cloudinary
  const cloudinaryFiles = await cloudinary.api.resources({
    type: 'upload',
    prefix: 'chattrix/',
    max_results: 500
  });
  
  // Find and delete unused files
  for (const file of cloudinaryFiles.resources) {
    if (!usedUrls.includes(file.secure_url)) {
      await cloudinary.uploader.destroy(file.public_id);
      console.log(`Deleted unused file: ${file.public_id}`);
    }
  }
}
```

## 10. Troubleshooting

### Upload Fails with "Invalid Signature"
- Check that your upload preset is set to **Unsigned**
- Verify cloud name and upload preset are correct

### Upload Fails with "File Too Large"
- Check upload preset max file size setting
- Reduce file size before upload (compress images/videos)

### Thumbnail Not Generated for Video
- Ensure "Generate thumbnail" is enabled in upload preset
- Wait a few seconds after upload for thumbnail generation
- Access thumbnail by changing file extension from .mp4 to .jpg

### CORS Errors
- Cloudinary should handle CORS automatically
- If issues persist, check your upload preset settings
- Ensure you're using the correct Cloudinary domain

### Files Not Appearing in Dashboard
- Check the folder path in your upload preset
- Verify the upload actually succeeded (check network logs)
- Refresh the Media Library page

## 11. Cost Optimization

### Free Tier Limits:
- 25 GB storage
- 25 GB bandwidth/month
- 25,000 transformations/month

### Tips to Stay Within Free Tier:
1. **Compress images** before upload (use Flutter image compression)
2. **Limit video duration** (e.g., max 2 minutes)
3. **Delete old media** regularly
4. **Use lazy loading** for images in chat
5. **Cache transformed images** on device

### When to Upgrade:
- If you exceed free tier limits
- If you need advanced features (AI, video transcoding, etc.)
- If you need higher upload limits

## 12. Alternative: Self-Hosted Storage

If you prefer not to use Cloudinary, you can:
1. Set up your own file storage server (e.g., MinIO, AWS S3)
2. Modify `CloudinaryService` to use your storage API
3. Update backend to handle file uploads directly

However, Cloudinary provides:
- CDN for fast delivery
- Automatic image/video optimization
- Thumbnail generation
- Format conversion
- No server maintenance

## 13. Support and Resources

- **Documentation**: [https://cloudinary.com/documentation](https://cloudinary.com/documentation)
- **Flutter SDK**: [https://pub.dev/packages/cloudinary_public](https://pub.dev/packages/cloudinary_public)
- **Support**: [https://support.cloudinary.com](https://support.cloudinary.com)
- **Community**: [https://community.cloudinary.com](https://community.cloudinary.com)

## 14. Quick Reference

### Upload Endpoints:
- Images: `https://api.cloudinary.com/v1_1/{cloud_name}/image/upload`
- Videos: `https://api.cloudinary.com/v1_1/{cloud_name}/video/upload`
- Raw files: `https://api.cloudinary.com/v1_1/{cloud_name}/raw/upload`

### URL Format:
```
https://res.cloudinary.com/{cloud_name}/{resource_type}/upload/{transformations}/{version}/{public_id}.{format}
```

### Common Transformations:
- Resize: `w_300,h_300,c_fill`
- Quality: `q_auto`
- Format: `f_auto`
- Crop: `c_crop,g_face`

