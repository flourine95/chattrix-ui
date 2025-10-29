# Integration Checklist - Advanced Chat Features

## 📋 Overview

Checklist để integrate các tính năng nâng cao vào chat app.

---

## 🔧 Backend Tasks

### Database Migration
- [ ] Chạy migration SQL để thêm columns
  - [ ] `reply_to_message_id INTEGER`
  - [ ] `reactions JSONB`
  - [ ] `mentions JSONB`
- [ ] Thêm foreign key constraint
- [ ] Thêm indexes (reply_to, reactions, mentions)
- [ ] Test migration trên staging database
- [ ] Backup database trước khi migrate production

### API Endpoints - Reply
- [ ] Update `POST /v1/conversations/{id}/messages` để nhận `replyToMessageId`
- [ ] Include `replyToMessage` object trong response
- [ ] Validate `replyToMessageId` exists
- [ ] Handle deleted reply messages gracefully
- [ ] Test với Postman/curl
- [ ] Write unit tests

### API Endpoints - Reactions
- [ ] Implement `POST /v1/messages/{id}/reactions`
  - [ ] Add reaction logic
  - [ ] Toggle if already exists
  - [ ] Validate emoji format
- [ ] Implement `DELETE /v1/messages/{id}/reactions/{emoji}`
  - [ ] Remove user from reaction array
  - [ ] Clean up empty emoji keys
- [ ] (Optional) Implement `GET /v1/messages/{id}/reactions`
  - [ ] Return detailed reaction info with users
- [ ] Rate limiting (max 10/minute)
- [ ] Test với Postman/curl
- [ ] Write unit tests

### API Endpoints - Mentions
- [ ] Update `POST /v1/conversations/{id}/messages` để nhận `mentions`
- [ ] Validate mentioned users exist
- [ ] Validate mentioned users are in conversation
- [ ] Include `mentionedUsers` array trong response
- [ ] Implement `GET /v1/conversations/{id}/members`
  - [ ] Return all conversation members
  - [ ] Include online status
  - [ ] Cache-friendly response
- [ ] Test với Postman/curl
- [ ] Write unit tests

### API Endpoints - Voice Messages
- [ ] Support `type: "VOICE"` trong messages
- [ ] Validate voice message fields:
  - [ ] `mediaUrl` (required)
  - [ ] `duration` (required, max 300s)
  - [ ] `fileSize` (required, max 10MB)
  - [ ] `fileName` (optional)
- [ ] Test với Postman/curl
- [ ] Write unit tests

### WebSocket Events
- [ ] Update `message.new` event
  - [ ] Include `replyToMessage` if exists
  - [ ] Include `mentionedUsers` if exists
- [ ] Implement `message.reaction` event
  - [ ] Broadcast to all conversation members
  - [ ] Include full reactions object
  - [ ] Include action (add/remove)
- [ ] Implement `message.mention` event
  - [ ] Send to mentioned user only
  - [ ] Include message preview
  - [ ] Trigger push notification
- [ ] Test WebSocket events
- [ ] Write integration tests

### Push Notifications
- [ ] Send notification when user is mentioned
- [ ] Send notification when message is replied to
- [ ] (Optional) Send notification for reactions
- [ ] Test notifications on iOS
- [ ] Test notifications on Android

---

## 📱 Frontend Tasks

### Reply Feature
- [ ] Add long press gesture to message bubbles
  - [ ] Show context menu with "Reply" option
  - [ ] Store selected message in state
- [ ] Show `ReplyMessagePreview` widget
  - [ ] Display above input bar
  - [ ] Show cancel button
  - [ ] Clear on cancel
- [ ] Update send message logic
  - [ ] Include `replyToMessageId` in request
  - [ ] Clear reply state after send
- [ ] Display `QuotedMessageWidget` in bubbles
  - [ ] Show when message has `replyToMessageId`
  - [ ] Display sender name and preview
  - [ ] Handle different message types
- [ ] Implement scroll to message
  - [ ] Tap quoted message to scroll
  - [ ] Highlight target message
  - [ ] Handle message not in view
- [ ] Test on iOS
- [ ] Test on Android

### Reactions Feature
- [ ] Add reaction button to message bubbles
  - [ ] Show on long press or always visible
  - [ ] Position correctly
- [ ] Display `MessageReactions` widget
  - [ ] Show below message content
  - [ ] Display emoji with counts
  - [ ] Highlight current user's reactions
- [ ] Implement add reaction
  - [ ] Show `ReactionPickerBottomSheet`
  - [ ] Call API to add reaction
  - [ ] Update local state optimistically
- [ ] Implement remove reaction
  - [ ] Tap existing reaction to remove
  - [ ] Call API to remove
  - [ ] Update local state
- [ ] Handle WebSocket updates
  - [ ] Listen for `message.reaction` events
  - [ ] Update message reactions in real-time
- [ ] Test on iOS
- [ ] Test on Android

### Mentions Feature
- [ ] Fetch conversation members
  - [ ] Call `GET /v1/conversations/{id}/members`
  - [ ] Cache members list
  - [ ] Refresh on conversation change
- [ ] Replace `TextField` with `MentionTextField`
  - [ ] Pass members list
  - [ ] Handle mention selection
  - [ ] Track mentioned user IDs
- [ ] Update send message logic
  - [ ] Include `mentions` array in request
  - [ ] Parse mentions from text
- [ ] Display mentions in messages
  - [ ] Use `MentionText` widget
  - [ ] Highlight mentions with color
  - [ ] (Optional) Make mentions tappable
- [ ] Handle mention notifications
  - [ ] Listen for `message.mention` events
  - [ ] Show in-app notification
- [ ] Test on iOS
- [ ] Test on Android

### Voice Recording Feature
- [ ] Add mic button to input bar
  - [ ] Show when text is empty
  - [ ] Hide when typing
  - [ ] Request microphone permission
- [ ] Show `VoiceRecorderWidget`
  - [ ] Display when mic button pressed
  - [ ] Show waveform animation
  - [ ] Display duration
- [ ] Implement recording controls
  - [ ] Start recording
  - [ ] Pause/resume
  - [ ] Cancel (delete file)
  - [ ] Send (upload and send)
- [ ] Upload voice file
  - [ ] Upload to Cloudinary
  - [ ] Show upload progress
  - [ ] Handle errors
- [ ] Send voice message
  - [ ] Call API with voice message data
  - [ ] Include duration and file size
  - [ ] Clear recorder state
- [ ] Display voice messages
  - [ ] Use existing `AudioMessageBubble`
  - [ ] Show play/pause button
  - [ ] Show duration
  - [ ] Show waveform (optional)
- [ ] Test on iOS
- [ ] Test on Android

### Image Compression Feature
- [ ] Integrate compression service
  - [ ] Call before uploading images
  - [ ] Use quality 85 by default
  - [ ] Max dimensions 1920x1920
- [ ] Show compression progress
  - [ ] Display "Compressing..." message
  - [ ] Show spinner
- [ ] Handle compression errors
  - [ ] Fallback to original image
  - [ ] Show error message
- [ ] Test with various image sizes
  - [ ] Small images (<500KB)
  - [ ] Medium images (500KB-2MB)
  - [ ] Large images (>2MB)
- [ ] Verify file size reduction
- [ ] Test on iOS
- [ ] Test on Android

### Upload Progress Feature
- [ ] Track upload progress
  - [ ] Get progress from Cloudinary upload
  - [ ] Update state with percentage
- [ ] Show `UploadProgressWidget`
  - [ ] Display as overlay
  - [ ] Show file name
  - [ ] Show progress bar
  - [ ] Show percentage
- [ ] Implement cancel upload
  - [ ] Cancel Cloudinary upload
  - [ ] Clear upload state
  - [ ] Show cancellation message
- [ ] Auto-hide on complete
  - [ ] Hide after 1 second
  - [ ] Clear upload state
- [ ] Handle upload errors
  - [ ] Show error message
  - [ ] Allow retry
- [ ] Test on iOS
- [ ] Test on Android

---

## 🧪 Testing Tasks

### Unit Tests
- [ ] Test `VoiceRecorderService`
  - [ ] Start/stop recording
  - [ ] Pause/resume
  - [ ] Duration tracking
- [ ] Test `ImageCompressionService`
  - [ ] Compress with quality
  - [ ] Compress to target size
  - [ ] Handle errors
- [ ] Test `MentionTextField`
  - [ ] Autocomplete logic
  - [ ] Mention insertion
  - [ ] Mention parsing

### Integration Tests
- [ ] Test reply flow end-to-end
- [ ] Test reaction flow end-to-end
- [ ] Test mention flow end-to-end
- [ ] Test voice recording flow end-to-end
- [ ] Test image compression flow
- [ ] Test upload progress display

### Manual Testing
- [ ] Test on real iOS device
- [ ] Test on real Android device
- [ ] Test with slow network
- [ ] Test with no network
- [ ] Test with multiple users
- [ ] Test WebSocket reconnection
- [ ] Test push notifications

---

## 📊 Progress Tracking

### Backend Progress
- Database: ⏳ 0/5 tasks
- Reply API: ⏳ 0/6 tasks
- Reactions API: ⏳ 0/7 tasks
- Mentions API: ⏳ 0/7 tasks
- Voice API: ⏳ 0/4 tasks
- WebSocket: ⏳ 0/5 tasks
- Notifications: ⏳ 0/4 tasks

**Total Backend: 0/38 tasks (0%)**

### Frontend Progress
- Reply: ⏳ 0/7 tasks
- Reactions: ⏳ 0/7 tasks
- Mentions: ⏳ 0/7 tasks
- Voice: ⏳ 0/9 tasks
- Compression: ⏳ 0/6 tasks
- Progress: ⏳ 0/6 tasks

**Total Frontend: 0/42 tasks (0%)**

### Testing Progress
- Unit Tests: ⏳ 0/3 tasks
- Integration Tests: ⏳ 0/6 tasks
- Manual Testing: ⏳ 0/7 tasks

**Total Testing: 0/16 tasks (0%)**

---

## 🎯 Overall Progress

**Total: 0/96 tasks (0%)**

---

## 📝 Notes

- Mark tasks as complete with `[x]` when done
- Update progress percentages regularly
- Add notes for any blockers or issues
- Estimate: 4-6 days for full implementation

---

## 🚀 Ready to Start!

Begin with backend tasks, then move to frontend integration, and finally testing.

Good luck! 🎉

