# Chattrix API Integration Guide

Hướng dẫn tích hợp API cho các tính năng mới của Chattrix.

## 📋 Mục lục

1. [Group Invite Links](#1-group-invite-links)
2. [Member Mute](#2-member-mute)
3. [Announcements](#3-announcements)
4. [Pinned Messages](#4-pinned-messages)
5. [Global Search](#5-global-search)

---

## 🔐 Authentication

Tất cả các API (trừ public endpoints) yêu cầu JWT token trong header:

```http
Authorization: Bearer <your_access_token>
```

**Base URL:** `http://localhost:8080/api/v1` (hoặc URL ngrok của bạn)

---

## 1. Group Invite Links

### 1.1 Create Invite Link

Tạo link mời vào nhóm (chỉ admin/member).

**Endpoint:** `POST /v1/invite-links/conversations/{conversationId}`

**Headers:**
```http
Authorization: Bearer <token>
Content-Type: application/json
```

**Request Body:**
```json
{
  "expiresIn": 86400,
  "maxUses": 100
}
```

**Request Parameters:**
- `expiresIn` (optional): Thời gian hết hạn tính bằng giây (null = không hết hạn)
- `maxUses` (optional): Số lần sử dụng tối đa (null = không giới hạn)

**Response:** `201 Created`
```json
{
    "success": true,
    "message": "Invite link created successfully",
    "data": {
        "id": 3,
        "token": "d7fcc2cfcc1f4a4a",
        "conversationId": 2,
        "createdBy": 1,
        "createdByUsername": "user1",
        "createdAt": "2025-12-23T15:08:23.866364933Z",
        "expiresAt": "2025-12-24T15:08:23.865997361Z",
        "maxUses": 100,
        "currentUses": 0,
        "revoked": false,
        "valid": true
    }
}
```

---

### 1.2 Get All Invite Links

Lấy danh sách tất cả invite links của một nhóm (có phân trang).

**Endpoint:** `GET /v1/invite-links/conversations/{conversationId}`

**Headers:**
```http
Authorization: Bearer <token>
```

**Query Parameters:**
- `cursor` (optional): Cursor cho phân trang
- `limit` (optional, default: 20): Số lượng mỗi trang
- `includeRevoked` (optional, default: false): Có bao gồm link đã thu hồi không

**Example:**
```
GET /v1/invite-links/conversations/2?limit=20&includeRevoked=false
```

**Response:** `200 OK`
```json
{
    "success": true,
    "message": "Invite links retrieved successfully",
    "data": {
        "items": [
            {
                "id": 3,
                "token": "d7fcc2cfcc1f4a4a",
                "conversationId": 2,
                "createdBy": 1,
                "createdByUsername": "user1",
                "createdAt": "2025-12-23T15:08:23.866365Z",
                "expiresAt": "2025-12-24T15:08:23.865997Z",
                "maxUses": 100,
                "currentUses": 0,
                "revoked": false,
                "valid": true
            },
            {
                "id": 1,
                "token": "c0f950aaba98488e",
                "conversationId": 2,
                "createdBy": 1,
                "createdByUsername": "user1",
                "createdAt": "2025-12-23T14:58:55.023688Z",
                "expiresAt": "2025-12-24T14:58:55.023466Z",
                "maxUses": 10,
                "currentUses": 0,
                "revoked": false,
                "valid": true
            }
        ],
        "meta": {
            "nextCursor": "1",
            "hasNextPage": true,
            "itemsPerPage": 20
        }
    }
}
```

---

### 1.3 Revoke Invite Link

Thu hồi một invite link (chỉ admin hoặc người tạo).

**Endpoint:** `DELETE /v1/invite-links/conversations/{conversationId}/links/{linkId}`

**Headers:**
```http
Authorization: Bearer <token>
```

**Response:** `200 OK`
```json
{
    "success": true,
    "message": "Invite link revoked successfully",
    "data": {
        "id": 2,
        "token": "2cd0320d3431485c",
        "conversationId": 2,
        "createdBy": 1,
        "createdByUsername": "user1",
        "createdAt": "2025-12-23T15:01:12.049348Z",
        "expiresAt": "2025-12-24T15:01:12.049236Z",
        "maxUses": 100,
        "currentUses": 0,
        "revoked": true,
        "revokedAt": "2025-12-23T15:02:29.279290546Z",
        "revokedBy": 1,
        "valid": false
    }
}
```

---

### 1.4 Get QR Code

Lấy QR code cho invite link (trả về ảnh PNG).

**Endpoint:** `GET /v1/invite-links/conversations/{conversationId}/links/{linkId}/qr`

**Headers:**
```http
Authorization: Bearer <token>
```

**Query Parameters:**
- `size` (optional, default: 300): Kích thước QR code (width & height)
- `apiUrl` (optional): Base URL của API (dùng cho ngrok)

**Example:**
```
GET /v1/invite-links/conversations/2/links/2/qr?size=1000
```

**Response:** `200 OK`
- Content-Type: `image/png`
- Body: Binary image data

**Usage in HTML:**
```html
<img src="http://localhost:8080/api/v1/invite-links/conversations/2/links/2/qr?size=1000" />
```

---

### 1.5 Get Invite Link Info (Public)

Lấy thông tin về invite link (không cần authentication).

**Endpoint:** `GET /v1/invite-links/{token}`

**Headers:** None required

**Response:** `200 OK`
```json
{
    "success": true,
    "message": "Invite link info retrieved successfully",
    "data": {
        "token": "d7fcc2cfcc1f4a4a",
        "groupId": 2,
        "groupName": "hoi ae cay khe",
        "memberCount": 4,
        "valid": true,
        "expiresAt": "2025-12-24T15:08:23.865997Z",
        "createdBy": 1,
        "createdByUsername": "user1",
        "createdByFullName": "Nguyen Linh La"
    }
}
```

---

### 1.6 Join Group via Invite Link

Tham gia nhóm thông qua invite link.

**Endpoint:** `POST /v1/invite-links/{token}`

**Headers:**
```http
Authorization: Bearer <token>
```

**Response:** `200 OK`
```json
{
    "success": true,
    "message": "Successfully joined conversation via invite link",
    "data": {
        "success": true,
        "conversationId": 2,
        "message": "Successfully joined group"
    }
}
```

**Error Cases:**
- `400`: Link đã hết hạn hoặc đã đạt giới hạn sử dụng
- `404`: Link không tồn tại

---

## 2. Member Mute

### 2.1 Mute Member

Tắt tiếng thành viên trong nhóm (chỉ admin).

**Endpoint:** `POST /v1/conversations/{conversationId}/members/{memberId}/mute`

**Headers:**
```http
Authorization: Bearer <token>
Content-Type: application/json
```

**Request Body:**
```json
{
  "duration": 3600
}
```

**Request Parameters:**
- `duration` (optional): Thời gian mute tính bằng giây
  - `null` hoặc `-1`: Mute vĩnh viễn
  - `> 0`: Mute trong khoảng thời gian cụ thể

**Response:** `200 OK`
```json
{
    "success": true,
    "message": "Member muted successfully",
    "data": {
        "userId": 2,
        "username": "user2",
        "fullName": "Tran Van Binh",
        "muted": true,
        "mutedAt": "2025-12-23T15:20:16.820754302Z",
        "mutedBy": 1
    }
}
```

---

### 2.2 Unmute Member

Bỏ tắt tiếng thành viên (chỉ admin).

**Endpoint:** `POST /v1/conversations/{conversationId}/members/{memberId}/unmute`

**Headers:**
```http
Authorization: Bearer <token>
```

**Response:** `200 OK`
```json
{
    "success": true,
    "message": "Member unmuted successfully",
    "data": {
        "userId": 2,
        "username": "user2",
        "fullName": "Tran Van Binh",
        "muted": false
    }
}
```

---

## 3. Announcements

### 3.1 Create Announcement

Tạo thông báo trong nhóm (chỉ admin).

**Endpoint:** `POST /v1/conversations/{conversationId}/announcements`

**Headers:**
```http
Authorization: Bearer <token>
Content-Type: application/json
```

**Request Body:**
```json
{
  "content": "Important: Team meeting tomorrow at 10 AM!"
}
```

**Validation:**
- `content`: Required, max 5000 characters

**Response:** `201 Created`
```json
{
    "success": true,
    "message": "Announcement created successfully",
    "data": {
        "id": 6,
        "conversationId": 2,
        "senderId": 1,
        "senderUsername": "user1",
        "senderFullName": "Nguyen Linh La",
        "content": "Important: Team meeting tomorrow at 10 AM!",
        "type": "ANNOUNCEMENT",
        "reactions": {},
        "sentAt": "2025-12-23T15:25:11.855008228Z",
        "createdAt": "2025-12-23T15:25:11.855012313Z",
        "updatedAt": "2025-12-23T15:25:11.855012740Z",
        "edited": false,
        "deleted": false,
        "forwarded": false,
        "forwardCount": 0,
        "pinned": false,
        "scheduled": false
    }
}
```

---

### 3.2 Get Announcements

Lấy danh sách thông báo của nhóm.

**Endpoint:** `GET /v1/conversations/{conversationId}/announcements`

**Headers:**
```http
Authorization: Bearer <token>
```

**Query Parameters:**
- `cursor` (optional): Cursor cho phân trang
- `limit` (optional, default: 20): Số lượng mỗi trang

**Example:**
```
GET /v1/conversations/2/announcements?limit=20
```

**Response:** `200 OK`
```json
{
    "success": true,
    "message": "Announcements retrieved successfully",
    "data": {
        "items": [
            {
                "id": 6,
                "conversationId": 2,
                "senderId": 1,
                "senderUsername": "user1",
                "senderFullName": "Nguyen Linh La",
                "content": "Important: Team meeting tomorrow at 10 AM!",
                "type": "ANNOUNCEMENT",
                "reactions": {},
                "sentAt": "2025-12-23T15:25:11.855008Z",
                "createdAt": "2025-12-23T15:25:11.855012Z",
                "updatedAt": "2025-12-23T15:25:11.855013Z",
                "edited": false,
                "deleted": false,
                "forwarded": false,
                "forwardCount": 0,
                "pinned": false,
                "scheduled": false
            },
            {
                "id": 5,
                "conversationId": 2,
                "senderId": 1,
                "senderUsername": "user1",
                "senderFullName": "Nguyen Linh La",
                "content": "Important: Team meeting tomorrow at 10 AM!",
                "type": "ANNOUNCEMENT",
                "reactions": {},
                "sentAt": "2025-12-23T15:21:57.544687Z",
                "createdAt": "2025-12-23T15:21:57.544688Z",
                "updatedAt": "2025-12-23T15:21:57.544688Z",
                "edited": false,
                "deleted": false,
                "forwarded": false,
                "forwardCount": 0,
                "pinned": false,
                "scheduled": false
            }
        ],
        "meta": {
            "nextCursor": "5",
            "hasNextPage": true,
            "itemsPerPage": 20
        }
    }
}
```

---

### 3.3 Delete Announcement

Xóa thông báo (chỉ admin).

**Endpoint:** `DELETE /v1/conversations/{conversationId}/announcements/{messageId}`

**Headers:**
```http
Authorization: Bearer <token>
```

**Response:** `204 No Content`
```json
{
    "success": true,
    "message": "Announcement deleted successfully",
    "data": {
        "messageId": 5,
        "conversationId": 2
    }
}
```

---

## 4. Pinned Messages

### 4.1 Pin Message

Ghim tin nhắn trong nhóm (chỉ admin).

**Endpoint:** `POST /v1/conversations/{conversationId}/messages/{messageId}/pin`

**Headers:**
```http
Authorization: Bearer <token>
```

**Response:** `200 OK`
```json
{
    "success": true,
    "message": "Message pinned successfully",
    "data": {
        "id": 2,
        "conversationId": 2,
        "senderId": 13,
        "senderUsername": "caothaison13",
        "senderFullName": "Cao Thai Son",
        "content": "{\"invitedBy\":1,\"type\":\"user_joined_via_link\",\"userName\":\"Cao Thai Son\",\"userId\":13,\"username\":\"caothaison13\",\"timestamp\":1766503097120}",
        "type": "SYSTEM",
        "reactions": {},
        "sentAt": "2025-12-23T15:18:17.120516Z",
        "createdAt": "2025-12-23T15:18:17.120517Z",
        "updatedAt": "2025-12-23T15:18:17.120517Z",
        "edited": false,
        "deleted": false,
        "forwarded": false,
        "forwardCount": 0,
        "pinned": true,
        "pinnedAt": "2025-12-23T15:31:13.121828340Z",
        "pinnedBy": 1,
        "pinnedByUsername": "user1",
        "pinnedByFullName": "Nguyen Linh La",
        "scheduled": false
    }
}
```

---

### 4.2 Unpin Message

Bỏ ghim tin nhắn (chỉ admin).

**Endpoint:** `POST /v1/conversations/{conversationId}/messages/{messageId}/unpin`

**Headers:**
```http
Authorization: Bearer <token>
```

**Response:** `200 OK`
```json
{
    "success": true,
    "message": "Message unpinned successfully",
    "data": {
        "id": 2,
        "conversationId": 2,
        "senderId": 13,
        "senderUsername": "caothaison13",
        "senderFullName": "Cao Thai Son",
        "content": "{\"invitedBy\":1,\"type\":\"user_joined_via_link\",\"userName\":\"Cao Thai Son\",\"userId\":13,\"username\":\"caothaison13\",\"timestamp\":1766503097120}",
        "type": "SYSTEM",
        "reactions": {},
        "sentAt": "2025-12-23T15:18:17.120516Z",
        "createdAt": "2025-12-23T15:18:17.120517Z",
        "updatedAt": "2025-12-23T15:31:13.132710Z",
        "edited": false,
        "deleted": false,
        "forwarded": false,
        "forwardCount": 0,
        "pinned": false,
        "scheduled": false
    }
}
```

---

### 4.3 Get Pinned Messages

Lấy danh sách tin nhắn đã ghim.

**Endpoint:** `GET /v1/conversations/{conversationId}/messages/pinned`

**Headers:**
```http
Authorization: Bearer <token>
```

**Response:** `200 OK`
```json
{
    "success": true,
    "message": "Pinned messages retrieved",
    "data": [
        {
            "id": 2,
            "conversationId": 2,
            "senderId": 13,
            "senderUsername": "caothaison13",
            "senderFullName": "Cao Thai Son",
            "content": "{\"invitedBy\":1,\"type\":\"user_joined_via_link\",\"userName\":\"Cao Thai Son\",\"userId\":13,\"username\":\"caothaison13\",\"timestamp\":1766503097120}",
            "type": "SYSTEM",
            "reactions": {},
            "sentAt": "2025-12-23T15:18:17.120516Z",
            "createdAt": "2025-12-23T15:18:17.120517Z",
            "updatedAt": "2025-12-23T15:34:32.980654Z",
            "edited": false,
            "deleted": false,
            "forwarded": false,
            "forwardCount": 0,
            "pinned": true,
            "pinnedAt": "2025-12-23T15:34:32.976179Z",
            "pinnedBy": 1,
            "pinnedByUsername": "user1",
            "pinnedByFullName": "Nguyen Linh La",
            "scheduled": false
        }
    ]
}
```

---

## 5. Global Search

### 5.1 Search Messages

Tìm kiếm tin nhắn trên tất cả các cuộc hội thoại của user.

**Endpoint:** `GET /v1/search/messages`

**Headers:**
```http
Authorization: Bearer <token>
```

**Query Parameters:**
- `query` (required): Từ khóa tìm kiếm
- `type` (optional): Loại tin nhắn (`TEXT`, `IMAGE`, `VIDEO`, `FILE`, `AUDIO`)
- `cursor` (optional): Cursor cho phân trang (thay vì page)
- `limit` (optional, default: 20): Số lượng mỗi trang (thay vì size)

**Example:**
```
GET /v1/search/messages?query=a&limit=20
```

**Response:** `200 OK`
```json
{
    "success": true,
    "message": "Search completed successfully",
    "data": {
        "items": [
            {
                "messageId": 6,
                "content": "Important: Team meeting tomorrow at 10 AM!",
                "type": "ANNOUNCEMENT",
                "sentAt": "2025-12-23T15:25:11.855008Z",
                "senderId": 1,
                "senderUsername": "user1",
                "senderFullName": "Nguyen Linh La",
                "senderAvatarUrl": "https://res.cloudinary.com/dk3gud5kq/image/upload/v1766376425/avatars/user_v2_1.png",
                "conversationId": 2,
                "conversationName": "hoi ae cay khe",
                "conversationType": "GROUP"
            },
            {
                "messageId": 4,
                "content": "{\"unmutedBy\":1,\"type\":\"member_unmuted\",\"userName\":\"Tran Van Binh\",\"userId\":2,\"username\":\"user2\",\"timestamp\":1766503258968}",
                "type": "SYSTEM",
                "sentAt": "2025-12-23T15:20:58.968534Z",
                "senderId": 2,
                "senderUsername": "user2",
                "senderFullName": "Tran Van Binh",
                "senderAvatarUrl": "https://res.cloudinary.com/dk3gud5kq/image/upload/v1766376427/avatars/user_v2_2.png",
                "conversationId": 2,
                "conversationName": "hoi ae cay khe",
                "conversationType": "GROUP"
            },
            {
                "messageId": 3,
                "content": "{\"mutedBy\":1,\"type\":\"member_muted\",\"userName\":\"Tran Van Binh\",\"userId\":2,\"username\":\"user2\",\"timestamp\":1766503216833}",
                "type": "SYSTEM",
                "sentAt": "2025-12-23T15:20:16.833403Z",
                "senderId": 2,
                "senderUsername": "user2",
                "senderFullName": "Tran Van Binh",
                "senderAvatarUrl": "https://res.cloudinary.com/dk3gud5kq/image/upload/v1766376427/avatars/user_v2_2.png",
                "conversationId": 2,
                "conversationName": "hoi ae cay khe",
                "conversationType": "GROUP"
            },
            {
                "messageId": 2,
                "content": "{\"invitedBy\":1,\"type\":\"user_joined_via_link\",\"userName\":\"Cao Thai Son\",\"userId\":13,\"username\":\"caothaison13\",\"timestamp\":1766503097120}",
                "type": "SYSTEM",
                "sentAt": "2025-12-23T15:18:17.120516Z",
                "senderId": 13,
                "senderUsername": "caothaison13",
                "senderFullName": "Cao Thai Son",
                "senderAvatarUrl": "https://res.cloudinary.com/dk3gud5kq/image/upload/v1766376444/avatars/user_v2_13.png",
                "conversationId": 2,
                "conversationName": "hoi ae cay khe",
                "conversationType": "GROUP"
            }
        ],
        "meta": {
            "nextCursor": "2",
            "hasNextPage": true,
            "itemsPerPage": 20
        }
    }
}
```

---

### 5.2 Get Message Context

Lấy ngữ cảnh xung quanh một tin nhắn (các tin nhắn trước và sau).

**Endpoint:** `GET /v1/search/messages/{messageId}/context`

**Headers:**
```http
Authorization: Bearer <token>
```

**Query Parameters:**
- `conversationId` (required): ID của cuộc hội thoại
- `contextSize` (optional, default: 10): Số tin nhắn trước và sau

**Example:**
```
GET /v1/search/messages/100/context?conversationId=5&contextSize=10
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "targetMessage": {
      "id": 100,
      "content": "Team meeting tomorrow at 10 AM",
      "senderId": 10,
      "sentAt": "2024-01-15T10:30:00.000Z"
    },
    "beforeMessages": [
      {
        "id": 99,
        "content": "What time is the meeting?",
        "senderId": 15,
        "sentAt": "2024-01-15T10:29:00.000Z"
      }
    ],
    "afterMessages": [
      {
        "id": 101,
        "content": "Thanks for the reminder!",
        "senderId": 20,
        "sentAt": "2024-01-15T10:31:00.000Z"
      }
    ]
  }
}

