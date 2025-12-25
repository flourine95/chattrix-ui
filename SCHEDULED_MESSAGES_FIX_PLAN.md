# 📅 Scheduled Messages - Fix Plan

## ✅ STATUS: COMPLETED

All scheduled message operations now correctly use conversation-specific endpoints as per the API specification.

---

## 🔴 Problem (RESOLVED)

Code was trying to fetch **all scheduled messages globally** (without conversationId), but API **only supports per-conversation endpoints**.

**Previous Error:**
```
404 Not Found: GET /v1/messages/scheduled?status=PENDING
```

**Correct API (per spec):**
```
GET /v1/conversations/{conversationId}/messages/scheduled
```

---

## ✅ Solution Implemented

### 1. **Removed global "All Scheduled Messages" page** ✅
   - Scheduled messages now only accessible per conversation
   - Always requires conversationId

### 2. **Display scheduled messages in Chat Info** ✅
   - From Chat Info Page → Scheduled Messages (for that conversation)
   - Always passes conversationId to API

### 3. **Updated all layers:**

#### A. Data Layer (Datasource) ✅ COMPLETED
- File: `lib/features/chat/data/datasources/scheduled_message_datasource_impl.dart`
- Changes:
  - ✅ `getScheduledMessages()` - Requires conversationId
  - ✅ `getScheduledMessage()` - Added conversationId parameter
  - ✅ `updateScheduledMessage()` - Added conversationId parameter
  - ✅ `cancelScheduledMessage()` - Added conversationId parameter
  - ✅ `bulkCancelScheduledMessages()` - Added conversationId parameter
  - ✅ All API calls use `/v1/conversations/{conversationId}/messages/scheduled`

#### B. Domain Layer (Interface) ✅ COMPLETED
- File: `lib/features/chat/domain/datasources/scheduled_message_datasource.dart`
- Changes:
  - ✅ Updated all method signatures to require conversationId

#### C. Repository Layer ✅ COMPLETED
- Files:
  - `lib/features/chat/data/repositories/scheduled_message_repository_impl.dart`
  - `lib/features/chat/domain/repositories/scheduled_message_repository.dart`
- Changes:
  - ✅ Updated `getScheduledMessage()` - Added conversationId parameter
  - ✅ Updated `updateScheduledMessage()` - Added conversationId parameter
  - ✅ Updated `cancelScheduledMessage()` - Added conversationId parameter
  - ✅ Updated `bulkCancelScheduledMessages()` - Added conversationId parameter

#### D. Use Cases ✅ COMPLETED
- Files:
  - `lib/features/chat/domain/usecases/update_scheduled_message_usecase.dart`
  - `lib/features/chat/domain/usecases/cancel_scheduled_message_usecase.dart`
- Changes:
  - ✅ Added conversationId parameter to all use cases

#### E. Presentation Layer ✅ COMPLETED
- File: `lib/features/chat/presentation/state/scheduled_messages_notifier.dart`
- Changes:
  - ✅ Made conversationId **required** (not nullable)
  - ✅ Updated all method calls to pass conversationId
  - ✅ Removed `keepAlive: true` (was causing warnings)

#### F. UI Pages ✅ COMPLETED
- Files:
  - `lib/features/chat/presentation/pages/scheduled_messages_page.dart`
  - `lib/features/chat/presentation/pages/schedule_message_page.dart`
- Changes:
  - ✅ Required conversationId in constructor
  - ✅ Updated all provider calls to include conversationId
  - ✅ Fixed navigation to use correct routes

#### G. Router ✅ COMPLETED
- File: `lib/core/router/route_config.dart`
- File: `lib/core/router/route_paths.dart`
- Changes:
  - ✅ Updated route from `/scheduled-messages` to `/chat/:id/scheduled-messages`
  - ✅ Router parses conversationId from path parameter

#### H. Navigation ✅ COMPLETED
- File: `lib/features/chat/presentation/pages/chat_info_page.dart`
- Changes:
  - ✅ Updated navigation to use `context.push('/chat/${conversation.id}/scheduled-messages')`
  - ✅ Added `go_router` import
  - ✅ Removed unused `ScheduledMessagesPage` import

#### I. Code Generation ✅ COMPLETED
- ✅ Ran `dart run build_runner build --delete-conflicting-outputs`
- ✅ All `.g.dart` files regenerated successfully
- ✅ No compilation errors

---

## 📋 API Endpoints (from .spec2/MESSAGE_FEATURES_API.md)

All scheduled message endpoints are conversation-specific:

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/v1/conversations/{conversationId}/messages/schedule` | Create scheduled message |
| GET | `/v1/conversations/{conversationId}/messages/scheduled` | List scheduled messages |
| GET | `/v1/conversations/{conversationId}/messages/scheduled/{scheduledMessageId}` | Get one scheduled message |
| PUT | `/v1/conversations/{conversationId}/messages/scheduled/{scheduledMessageId}` | Update scheduled message |
| DELETE | `/v1/conversations/{conversationId}/messages/scheduled/{scheduledMessageId}` | Cancel scheduled message |
| DELETE | `/v1/conversations/{conversationId}/messages/scheduled/bulk` | Bulk cancel |

---

## 🧪 Testing Checklist

Ready to test:
- [ ] Open chat info page
- [ ] Click "Schedule Message"
- [ ] Create new scheduled message
- [ ] View scheduled messages list
- [ ] Edit scheduled message
- [ ] Cancel scheduled message
- [ ] Verify API calls include conversationId in URL path
- [ ] Check that each conversation has its own scheduled messages
- [ ] Test navigation between pages

---

## 🚨 Breaking Changes

1. **Removed global scheduled messages page** - No longer accessible from main menu
2. **conversationId now required** - All scheduled message operations need conversationId
3. **Route changed** - From `/scheduled-messages` to `/chat/:id/scheduled-messages`

---

## 📝 Notes

### Known Warnings (Non-blocking)
- IDE shows 4 warnings about keepAlive in `scheduled_messages_notifier.dart`
- These are false positives - the generated code shows `isAutoDispose: true`
- The provider does NOT have keepAlive anymore
- These warnings can be ignored

### Key Changes
1. **conversationId is now required** - No more nullable conversationId
2. **Each conversation has its own scheduled messages** - No global list
3. **Route changed** - From `/scheduled-messages` to `/chat/:id/scheduled-messages`
4. **All API calls updated** - Include conversationId in URL path
5. **Follows Telegram/WhatsApp design** - Scheduled messages per chat

---

## 🚀 Deployment Status

**Status:** ✅ READY FOR TESTING

All code changes complete. The scheduled messages feature now correctly uses conversation-specific endpoints as per the API specification.

**Files Modified:** 12 files
**Time Taken:** ~45 minutes
**Build Status:** ✅ Success (no errors)

