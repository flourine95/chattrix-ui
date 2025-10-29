# Quick Start Guide - Rich Media Chat Features

## 🚀 Get Started in 5 Minutes

### Step 1: Configure Cloudinary (2 minutes)

1. **Sign up for Cloudinary:**
   - Go to https://cloudinary.com/users/register/free
   - Create a free account

2. **Get your credentials:**
   - After login, you'll see your dashboard
   - Note down your **Cloud Name** (e.g., "demo")

3. **Create upload preset:**
   - Go to Settings → Upload
   - Scroll to "Upload presets"
   - Click "Add upload preset"
   - Set **Preset name**: `chattrix_media`
   - Set **Signing mode**: **Unsigned** ⚠️ Important!
   - Click Save

4. **Update Flutter code:**
   ```dart
   // File: lib/core/services/cloudinary_service.dart
   // Line 4-5, replace:
   static const String _cloudName = 'YOUR_CLOUD_NAME';  // Your cloud name here
   static const String _uploadPreset = 'chattrix_media';  // Your preset name
   ```

### Step 2: Update Backend API (3 minutes)

1. **Add database columns:**
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
   ```

2. **Update API endpoint:**
   Your `POST /v1/conversations/{id}/messages` endpoint should accept these optional fields:
   - `type`, `mediaUrl`, `thumbnailUrl`, `fileName`, `fileSize`, `duration`
   - `latitude`, `longitude`, `locationName`
   - `replyToMessageId`, `mentions`, `reactions`

3. **Update response:**
   Make sure your API returns all these fields in the response (can be null)

### Step 3: Test the App

1. **Run the app:**
   ```bash
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   flutter run
   ```

2. **Test sending media:**
   - Open a chat conversation
   - Tap the paperclip (📎) button
   - Select "Gallery"
   - Choose an image
   - Wait for upload (you'll see "Processing..." message)
   - Image should appear in chat

3. **Verify in Cloudinary:**
   - Go to Cloudinary dashboard → Media Library
   - You should see your uploaded image

## ✅ Checklist

- [ ] Cloudinary account created
- [ ] Upload preset created (unsigned)
- [ ] Cloud name and preset updated in code
- [ ] Database columns added
- [ ] Backend API updated to accept new fields
- [ ] Backend API returns new fields in response
- [ ] Flutter app runs without errors
- [ ] Can send text messages
- [ ] Can send images
- [ ] Can send videos
- [ ] Can send documents
- [ ] Can share location

## 🐛 Troubleshooting

### "Invalid signature" error
- Make sure upload preset is set to **Unsigned**
- Double-check cloud name and preset name

### Upload fails silently
- Check console logs for errors
- Verify Cloudinary credentials
- Check internet connection

### Backend returns 400 error
- Make sure backend accepts the new fields
- Check API request in network logs
- Verify field names match exactly

### Images don't display
- Check if `mediaUrl` is returned from backend
- Verify URL is accessible (open in browser)
- Check console for image loading errors

### Location permission denied
- Grant location permission in device settings
- On iOS: Info.plist needs location usage description
- On Android: AndroidManifest.xml needs location permission

## 📱 Permissions Setup

### Android (android/app/src/main/AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

### iOS (ios/Runner/Info.plist)
```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to take photos</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need photo library access to select images</string>
<key>NSMicrophoneUsageDescription</key>
<string>We need microphone access to record audio</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need location access to share your location</string>
```

## 🎯 What Works Now

✅ **Text messages** - Works as before
✅ **Image messages** - Upload and display images
✅ **Video messages** - Upload videos with thumbnails
✅ **Audio messages** - Upload audio files
✅ **Document messages** - Upload PDF, DOCX, etc.
✅ **Location sharing** - Share GPS coordinates
✅ **Rich message bubbles** - Different UI for each type

## ⏳ What's Not Implemented Yet

❌ **Reply to messages** - Quote and reply to specific messages
❌ **Reactions** - Add emoji reactions to messages
❌ **Mentions** - @mention users in messages
❌ **Voice recording** - Record audio directly in app
❌ **Video recording** - Record video directly in app
❌ **Image editing** - Crop/filter images before sending
❌ **Media preview** - Preview media before sending

## 📖 Full Documentation

- **API_REQUIREMENTS.md** - Complete backend API specification
- **CLOUDINARY_SETUP.md** - Detailed Cloudinary configuration guide
- **IMPLEMENTATION_SUMMARY_VI.md** - Full implementation summary (Vietnamese)

## 🔥 Quick Test Script

Use this to test your backend API with curl:

```bash
# Test sending image message
curl -X POST http://localhost:3000/v1/conversations/123/messages \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "content": "Check this out!",
    "type": "IMAGE",
    "mediaUrl": "https://res.cloudinary.com/demo/image/upload/sample.jpg",
    "fileSize": 245678
  }'

# Test sending location message
curl -X POST http://localhost:3000/v1/conversations/123/messages \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "content": "I am here",
    "type": "LOCATION",
    "latitude": 21.028511,
    "longitude": 105.804817,
    "locationName": "Hanoi, Vietnam"
  }'
```

## 💡 Pro Tips

1. **Test with small files first** - Start with small images (< 1MB)
2. **Check Cloudinary dashboard** - Verify uploads appear there
3. **Use Postman** - Test backend API separately from Flutter app
4. **Check network logs** - Use Flutter DevTools to inspect API calls
5. **Read error messages** - Console logs will tell you what's wrong

## 🎉 Success Criteria

You'll know everything is working when:
1. ✅ You can send an image and it appears in chat
2. ✅ The image is visible in Cloudinary dashboard
3. ✅ Other users receive the image via WebSocket
4. ✅ The image loads when you scroll back in chat history
5. ✅ You can send different types of media (video, document, etc.)

## 📞 Need Help?

If you're stuck:
1. Read the error message carefully
2. Check the relevant documentation file
3. Verify each step in this guide
4. Test backend API with Postman
5. Check Cloudinary dashboard for uploads

## 🚀 Next Steps After Basic Setup

Once basic media messaging works:
1. Implement reply feature
2. Add reaction picker
3. Implement @mentions
4. Add voice recording
5. Add image preview before sending
6. Optimize image compression
7. Add progress indicators
8. Implement media gallery view

## 📊 Expected Results

After completing this guide:
- ⏱️ Setup time: ~5 minutes
- 📦 App size increase: ~2MB
- 🚀 Upload speed: 2-5 seconds for images
- 💾 Storage: Cloudinary free tier (25GB)
- 🎯 Success rate: Should work on first try if steps followed correctly

Good luck! 🎉

