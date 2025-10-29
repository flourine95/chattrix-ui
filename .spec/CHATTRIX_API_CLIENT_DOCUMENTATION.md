# Chattrix API - Tài liệu cho Client Developer

**Base URL:** `http://localhost:8080/api` (hoặc domain production của bạn)

**API Version:** `v1`

**Authentication:** Hầu hết endpoints yêu cầu JWT Bearer Token trong header:
```
Authorization: Bearer <your_access_token>
```

---

## 📋 Mục lục

1. [Authentication API](#1-authentication-api)
2. [User Search API](#2-user-search-api)
3. [Contact API](#3-contact-api)
4. [Conversation API](#4-conversation-api)
5. [Message API](#5-message-api)
6. [Reaction API](#6-reaction-api)
7. [User Status API](#7-user-status-api)
8. [Typing Indicator API](#8-typing-indicator-api)
9. [WebSocket API](#9-websocket-api)
10. [Response Format](#10-response-format)
11. [Error Codes](#11-error-codes)

---

## 1. Authentication API

**Base Path:** `/v1/auth`

### 1.1. Đăng ký tài khoản

**Endpoint:** `POST /v1/auth/register`

**Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
{
  "username": "john_doe",
  "email": "john@example.com",
  "password": "password123",
  "fullName": "John Doe"
}
```

**Validation Rules:**
- `username`: 4-20 ký tự, phải có ít nhất 1 chữ cái, không bắt đầu/kết thúc bằng `.` hoặc `_`
- `email`: Email hợp lệ
- `password`: Tối thiểu 6 ký tự
- `fullName`: 1-100 ký tự

**Response:** `201 Created`
```json
{
  "success": true,
  "message": "Registration successful. Please check your email to verify your account.",
  "data": null
}
```

---

### 1.2. Đăng nhập

**Endpoint:** `POST /v1/auth/login`

**Request Body:**
```json
{
  "usernameOrEmail": "john_doe",
  "password": "password123"
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "tokenType": "Bearer",
    "expiresIn": 3600
  }
}
```

---

### 1.3. Lấy thông tin user hiện tại 🔒

**Endpoint:** `GET /v1/auth/me`

**Headers:**
```
Authorization: Bearer <access_token>
```

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "User retrieved successfully",
  "data": {
    "id": 1,
    "username": "john_doe",
    "email": "john@example.com",
    "fullName": "John Doe",
    "avatarUrl": "https://example.com/avatar.jpg",
    "isOnline": true,
    "lastSeen": "2025-10-29T10:30:00.000Z"
  }
}
```

---

### 1.4. Đăng xuất 🔒

**Endpoint:** `POST /v1/auth/logout`

**Headers:**
```
Authorization: Bearer <access_token>
```

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Logged out successfully",
  "data": null
}
```

---

### 1.5. Đăng xuất tất cả thiết bị 🔒

**Endpoint:** `POST /v1/auth/logout-all`

**Response:** `200 OK`

---

### 1.6. Refresh token

**Endpoint:** `POST /v1/auth/refresh`

**Request Body:**
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Token refreshed successfully",
  "data": {
    "accessToken": "new_access_token",
    "refreshToken": "new_refresh_token",
    "tokenType": "Bearer",
    "expiresIn": 3600
  }
}
```

---

### 1.7. Đổi mật khẩu 🔒

**Endpoint:** `PUT /v1/auth/change-password`

**Request Body:**
```json
{
  "oldPassword": "old_password",
  "newPassword": "new_password"
}
```

**Response:** `200 OK`

---

## 2. User Search API

**Base Path:** `/v1/users/search`

### 2.1. Tìm kiếm người dùng 🔒

**Endpoint:** `GET /v1/users/search`

**Query Parameters:**
- `query` (required): Từ khóa tìm kiếm (username, email, hoặc full name)
- `limit` (optional): Số lượng kết quả (1-50, mặc định: 20)

**Example:**
```
GET /v1/users/search?query=john&limit=10
```

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Users found successfully",
  "data": [
    {
      "id": 2,
      "username": "john_smith",
      "fullName": "John Smith",
      "avatarUrl": "https://example.com/avatar2.jpg",
      "isOnline": false,
      "lastSeen": "2025-10-29T09:15:00.000Z"
    }
  ]
}
```

---

## 3. Contact API

**Base Path:** `/v1/contacts`

**Authentication:** Tất cả endpoints yêu cầu Bearer Token 🔒

### 3.1. Lấy danh sách contacts

**Endpoint:** `GET /v1/contacts`

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Contacts retrieved successfully",
  "data": [
    {
      "id": 1,
      "contactUserId": 5,
      "username": "alice_wonder",
      "fullName": "Alice Wonder",
      "avatarUrl": "https://example.com/alice.jpg",
      "nickname": "Alice",
      "isFavorite": true,
      "isOnline": true,
      "lastSeen": "2025-10-29T10:30:00.000Z",
      "createdAt": "2025-10-20T08:00:00.000Z"
    }
  ]
}
```

---

### 3.2. Lấy danh sách contacts yêu thích

**Endpoint:** `GET /v1/contacts/favorites`

**Response:** `200 OK` (cùng format như 3.1)

---

### 3.3. Thêm contact mới

**Endpoint:** `POST /v1/contacts`

**Request Body:**
```json
{
  "contactUserId": 5,
  "nickname": "Alice"
}
```

**Response:** `201 Created`

---

### 3.4. Cập nhật contact

**Endpoint:** `PUT /v1/contacts/{contactId}`

**Request Body:**
```json
{
  "nickname": "Alice Wonderland",
  "isFavorite": true
}
```

**Response:** `200 OK`

---

### 3.5. Xóa contact

**Endpoint:** `DELETE /v1/contacts/{contactId}`

**Response:** `200 OK`

---

## 4. Conversation API

**Base Path:** `/v1/conversations`

**Authentication:** Tất cả endpoints yêu cầu Bearer Token 🔒

### 4.1. Tạo cuộc trò chuyện mới

**Endpoint:** `POST /v1/conversations`

**Request Body (Direct Chat):**
```json
{
  "type": "DIRECT",
  "participantIds": [5]
}
```

**Request Body (Group Chat):**
```json
{
  "type": "GROUP",
  "name": "Project Team",
  "participantIds": [5, 7, 9]
}
```

**Response:** `201 Created`
```json
{
  "success": true,
  "message": "Conversation created successfully",
  "data": {
    "id": 10,
    "type": "GROUP",
    "name": "Project Team",
    "createdAt": "2025-10-29T10:30:00.000Z",
    "updatedAt": "2025-10-29T10:30:00.000Z",
    "participants": [
      {
        "userId": 1,
        "username": "john_doe",
        "role": "ADMIN"
      },
      {
        "userId": 5,
        "username": "alice_wonder",
        "role": "MEMBER"
      }
    ],
    "lastMessage": null
  }
}
```

---

### 4.2. Lấy danh sách conversations

**Endpoint:** `GET /v1/conversations`

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Conversations retrieved successfully",
  "data": [
    {
      "id": 10,
      "type": "GROUP",
      "name": "Project Team",
      "createdAt": "2025-10-29T10:30:00.000Z",
      "updatedAt": "2025-10-29T11:45:00.000Z",
      "participants": [
        {
          "userId": 1,
          "username": "john_doe",
          "role": "ADMIN"
        }
      ],
      "lastMessage": {
        "id": 123,
        "content": "Hello team!",
        "senderId": 1,
        "senderUsername": "john_doe",
        "sentAt": "2025-10-29T11:45:00.000Z",
        "type": "TEXT"
      }
    }
  ]
}
```

---

### 4.3. Lấy chi tiết một conversation

**Endpoint:** `GET /v1/conversations/{conversationId}`

**Response:** `200 OK` (cùng format như 4.2)

---

### 4.4. Lấy danh sách members của conversation

**Endpoint:** `GET /v1/conversations/{conversationId}/members`

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Conversation members retrieved successfully",
  "data": [
    {
      "userId": 1,
      "username": "john_doe",
      "fullName": "John Doe",
      "avatarUrl": "https://example.com/john.jpg",
      "role": "ADMIN",
      "joinedAt": "2025-10-29T10:30:00.000Z"
    }
  ]
}
```

---

## 5. Message API

**Base Path:** `/v1/conversations/{conversationId}/messages`

**Authentication:** Tất cả endpoints yêu cầu Bearer Token 🔒

### 5.1. Lấy danh sách messages

**Endpoint:** `GET /v1/conversations/{conversationId}/messages`

**Query Parameters:**
- `page` (optional): Số trang (mặc định: 0)
- `size` (optional): Số lượng messages mỗi trang (mặc định: 50)
- `sort` (optional): Thứ tự sắp xếp - `ASC` hoặc `DESC` (mặc định: DESC)

**Example:**
```
GET /v1/conversations/10/messages?page=0&size=20&sort=DESC
```

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Messages retrieved successfully",
  "data": [
    {
      "id": 123,
      "conversationId": 10,
      "senderId": 1,
      "senderUsername": "john_doe",
      "senderName": "John Doe",
      "content": "Hello everyone!",
      "type": "TEXT",
      "mediaUrl": null,
      "thumbnailUrl": null,
      "fileName": null,
      "fileSize": null,
      "duration": null,
      "latitude": null,
      "longitude": null,
      "locationName": null,
      "replyToMessageId": null,
      "replyToMessage": null,
      "reactions": {
        "👍": [1, 5],
        "❤️": [7]
      },
      "mentions": [5],
      "mentionedUsers": [
        {
          "id": 5,
          "username": "alice_wonder",
          "fullName": "Alice Wonder"
        }
      ],
      "sentAt": "2025-10-29T11:45:00.000Z",
      "createdAt": "2025-10-29T11:45:00.000Z",
      "updatedAt": "2025-10-29T11:45:00.000Z"
    }
  ]
}
```

---

### 5.2. Gửi message

**Endpoint:** `POST /v1/conversations/{conversationId}/messages`

**Content-Type:** `application/json`

#### 5.2.1. Message văn bản đơn giản

**Request Body:**
```json
{
  "content": "Hello, this is a text message",
  "type": "TEXT"
}
```

#### 5.2.2. Message hình ảnh

**Request Body:**
```json
{
  "content": "Check out this image!",
  "type": "IMAGE",
  "mediaUrl": "https://example.com/images/photo.jpg",
  "thumbnailUrl": "https://example.com/images/photo_thumb.jpg",
  "fileName": "vacation_photo.jpg",
  "fileSize": 2048576
}
```



#### 5.2.3. Message video

**Request Body:**
```json
{
  "content": "Amazing video clip",
  "type": "VIDEO",
  "mediaUrl": "https://example.com/videos/clip.mp4",
  "thumbnailUrl": "https://example.com/videos/clip_thumb.jpg",
  "fileName": "funny_clip.mp4",
  "fileSize": 15728640,
  "duration": 45
}
```

#### 5.2.4. Message âm thanh/voice

**Request Body:**
```json
{
  "content": "Voice message",
  "type": "VOICE",
  "mediaUrl": "https://example.com/audio/voice_note.mp3",
  "fileName": "voice_note.mp3",
  "fileSize": 524288,
  "duration": 30
}
```

#### 5.2.5. Message tài liệu

**Request Body:**
```json
{
  "content": "Important document",
  "type": "DOCUMENT",
  "mediaUrl": "https://example.com/docs/report.pdf",
  "fileName": "quarterly_report.pdf",
  "fileSize": 1048576
}
```

#### 5.2.6. Message vị trí

**Request Body:**
```json
{
  "content": "My current location",
  "type": "LOCATION",
  "latitude": 21.028511,
  "longitude": 105.804817,
  "locationName": "Hoan Kiem Lake, Hanoi"
}
```

#### 5.2.7. Message với reply (trả lời tin nhắn)

**Request Body:**
```json
{
  "content": "I agree with you!",
  "type": "TEXT",
  "replyToMessageId": 123
}
```

#### 5.2.8. Message với mentions (tag người dùng)

**Request Body:**
```json
{
  "content": "Hey @alice and @bob, check this out!",
  "type": "TEXT",
  "mentions": [5, 7]
}
```

#### 5.2.9. Message đầy đủ tính năng

**Request Body:**
```json
{
  "content": "Look at this photo @alice!",
  "type": "IMAGE",
  "mediaUrl": "https://example.com/images/sunset.jpg",
  "thumbnailUrl": "https://example.com/images/sunset_thumb.jpg",
  "fileName": "sunset_beach.jpg",
  "fileSize": 3145728,
  "replyToMessageId": 120,
  "mentions": [5]
}
```

**Response:** `201 Created`
```json
{
  "success": true,
  "message": "Message sent successfully",
  "data": {
    "id": 124,
    "conversationId": 10,
    "senderId": 1,
    "senderUsername": "john_doe",
    "senderName": "John Doe",
    "content": "Look at this photo @alice!",
    "type": "IMAGE",
    "mediaUrl": "https://example.com/images/sunset.jpg",
    "thumbnailUrl": "https://example.com/images/sunset_thumb.jpg",
    "fileName": "sunset_beach.jpg",
    "fileSize": 3145728,
    "duration": null,
    "latitude": null,
    "longitude": null,
    "locationName": null,
    "replyToMessageId": 120,
    "replyToMessage": {
      "id": 120,
      "content": "Previous message",
      "senderId": 5,
      "senderUsername": "alice_wonder",
      "type": "TEXT"
    },
    "reactions": {},
    "mentions": [5],
    "mentionedUsers": [
      {
        "id": 5,
        "username": "alice_wonder",
        "fullName": "Alice Wonder"
      }
    ],
    "sentAt": "2025-10-29T12:00:00.000Z",
    "createdAt": "2025-10-29T12:00:00.000Z",
    "updatedAt": "2025-10-29T12:00:00.000Z"
  }
}
```

**Validation Rules:**
- `content`: Bắt buộc, không được để trống
- `type`: Các giá trị hợp lệ: `TEXT`, `IMAGE`, `VIDEO`, `VOICE`, `AUDIO`, `DOCUMENT`, `LOCATION`, `SYSTEM`
- `fileSize`: Đơn vị bytes (ví dụ: 1048576 = 1MB)
- `duration`: Đơn vị giây (seconds)
- `latitude`, `longitude`: Số thập phân (decimal degrees)

---

### 5.3. Lấy chi tiết một message

**Endpoint:** `GET /v1/conversations/{conversationId}/messages/{messageId}`

**Response:** `200 OK` (cùng format như response của 5.2)

---

## 6. Reaction API

**Base Path:** `/v1/messages/{messageId}/reactions`

**Authentication:** Tất cả endpoints yêu cầu Bearer Token 🔒

### 6.1. Thêm reaction vào message

**Endpoint:** `POST /v1/messages/{messageId}/reactions`

**Request Body:**
```json
{
  "emoji": "👍"
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Reaction toggled successfully",
  "data": {
    "messageId": 123,
    "reactions": {
      "👍": [1, 5],
      "❤️": [7]
    }
  }
}
```

**Note:** Nếu user đã react với emoji này, reaction sẽ bị xóa (toggle behavior)

---

### 6.2. Xóa reaction khỏi message

**Endpoint:** `DELETE /v1/messages/{messageId}/reactions/{emoji}`

**Example:**
```
DELETE /v1/messages/123/reactions/👍
```

**Response:** `200 OK`

---

### 6.3. Lấy danh sách reactions của message

**Endpoint:** `GET /v1/messages/{messageId}/reactions`

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Reactions retrieved successfully",
  "data": {
    "messageId": 123,
    "reactions": {
      "👍": [1, 5, 9],
      "❤️": [7, 11],
      "😂": [3]
    }
  }
}
```

---

## 7. User Status API

**Base Path:** `/v1/users/status`

**Authentication:** Tất cả endpoints yêu cầu Bearer Token 🔒

### 7.1. Lấy danh sách users đang online

**Endpoint:** `GET /v1/users/status/online`

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Online users retrieved successfully",
  "data": [
    {
      "id": 5,
      "username": "alice_wonder",
      "email": "alice@example.com",
      "fullName": "Alice Wonder",
      "avatarUrl": "https://example.com/alice.jpg",
      "isOnline": true,
      "lastSeen": "2025-10-29T12:00:00.000Z"
    }
  ]
}
```

---

## 8. Typing Indicator API

**Base Path:** `/v1/typing`

**Authentication:** Tất cả endpoints yêu cầu Bearer Token 🔒

### 8.1. Bắt đầu typing

**Endpoint:** `POST /v1/typing/start`

**Query Parameters:**
- `conversationId` (required): ID của conversation

**Example:**
```
POST /v1/typing/start?conversationId=10
```

**Response:** `200 OK`

---

### 8.2. Dừng typing

**Endpoint:** `POST /v1/typing/stop`

**Query Parameters:**
- `conversationId` (required): ID của conversation

**Example:**
```
POST /v1/typing/stop?conversationId=10
```

**Response:** `200 OK`

---

### 8.3. Lấy trạng thái typing trong conversation

**Endpoint:** `GET /v1/typing/status/{conversationId}`

**Query Parameters:**
- `excludeUserId` (optional): Loại trừ user ID (thường là current user)

**Example:**
```
GET /v1/typing/status/10?excludeUserId=1
```

**Response:** `200 OK`
```json
{
  "success": true,
  "message": "Typing status retrieved successfully",
  "data": {
    "conversationId": 10,
    "typingUserIds": [5, 7]
  }
}
```

---

## 9. WebSocket API

**WebSocket Endpoint:** `ws://localhost:8080/api/ws/chat`

**Authentication:** Gửi JWT token trong query parameter hoặc header khi kết nối

**Example:**
```javascript
const ws = new WebSocket('ws://localhost:8080/api/ws/chat?token=YOUR_JWT_TOKEN');
```

### 9.1. Gửi message qua WebSocket

**Message Format:**
```json
{
  "type": "CHAT_MESSAGE",
  "conversationId": 10,
  "content": "Hello via WebSocket!",
  "messageType": "TEXT",
  "mediaUrl": null,
  "thumbnailUrl": null,
  "fileName": null,
  "fileSize": null,
  "duration": null,
  "latitude": null,
  "longitude": null,
  "locationName": null,
  "replyToMessageId": null,
  "mentions": []
}
```

### 9.2. Nhận message từ WebSocket

**Incoming Message Format:**
```json
{
  "type": "NEW_MESSAGE",
  "data": {
    "id": 125,
    "conversationId": 10,
    "senderId": 5,
    "senderUsername": "alice_wonder",
    "senderName": "Alice Wonder",
    "content": "Hello!",
    "type": "TEXT",
    "sentAt": "2025-10-29T12:05:00.000Z"
  }
}
```

### 9.3. Typing Indicator qua WebSocket

**Gửi typing start:**
```json
{
  "type": "TYPING_START",
  "conversationId": 10
}
```

**Gửi typing stop:**
```json
{
  "type": "TYPING_STOP",
  "conversationId": 10
}
```

**Nhận typing notification:**
```json
{
  "type": "USER_TYPING",
  "data": {
    "conversationId": 10,
    "userId": 5,
    "username": "alice_wonder",
    "isTyping": true
  }
}
```

### 9.4. User Status qua WebSocket

**Nhận user online status:**
```json
{
  "type": "USER_STATUS_CHANGED",
  "data": {
    "userId": 5,
    "username": "alice_wonder",
    "isOnline": true,
    "lastSeen": "2025-10-29T12:10:00.000Z"
  }
}
```

---

## 10. Response Format

### 10.1. Success Response

```json
{
  "success": true,
  "message": "Operation successful",
  "data": { ... }
}
```

### 10.2. Error Response

```json
{
  "success": false,
  "message": "Error description",
  "errorCode": "ERROR_CODE",
  "errors": [
    {
      "field": "fieldName",
      "message": "Validation error message"
    }
  ]
}
```

---

## 11. Error Codes

| HTTP Status | Error Code | Description |
|-------------|------------|-------------|
| 400 | `INVALID_REQUEST` | Request body không hợp lệ |
| 400 | `VALIDATION_ERROR` | Lỗi validation dữ liệu |
| 401 | `UNAUTHORIZED` | Chưa đăng nhập hoặc token không hợp lệ |
| 403 | `FORBIDDEN` | Không có quyền truy cập |
| 404 | `NOT_FOUND` | Resource không tồn tại |
| 409 | `CONFLICT` | Conflict (ví dụ: username đã tồn tại) |
| 429 | `RATE_LIMIT_EXCEEDED` | Vượt quá giới hạn request |
| 500 | `INTERNAL_SERVER_ERROR` | Lỗi server |

---

## 12. Best Practices cho Client

### 12.1. Authentication Flow

1. **Đăng ký/Đăng nhập:** Lưu `accessToken` và `refreshToken`
2. **Gửi request:** Thêm `Authorization: Bearer <accessToken>` vào header
3. **Token hết hạn:** Khi nhận `401`, sử dụng `refreshToken` để lấy token mới
4. **Refresh token hết hạn:** Yêu cầu user đăng nhập lại

### 12.2. WebSocket Connection

1. Kết nối WebSocket sau khi đăng nhập thành công
2. Gửi token trong query parameter hoặc header
3. Xử lý reconnection khi mất kết nối
4. Đóng connection khi đăng xuất

### 12.3. Pagination

- Sử dụng `page` và `size` parameters cho danh sách dài
- Load thêm messages khi user scroll lên (infinite scroll)
- Cache messages đã load để giảm số lượng request

### 12.4. Real-time Updates

- Sử dụng WebSocket cho real-time messages, typing indicators, user status
- Fallback về polling nếu WebSocket không khả dụng
- Sync lại data khi reconnect WebSocket

### 12.5. File Upload

- Upload file lên storage service (S3, Cloudinary, etc.) trước
- Lấy URL của file đã upload
- Gửi message với `mediaUrl` là URL vừa nhận được

### 12.6. Error Handling

```javascript
try {
  const response = await fetch('/api/v1/conversations', {
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/json'
    }
  });

  const result = await response.json();

  if (!result.success) {
    // Handle error
    console.error(result.message);
  } else {
    // Handle success
    console.log(result.data);
  }
} catch (error) {
  // Handle network error
  console.error('Network error:', error);
}
```

---

## 13. Example Client Code

### 13.1. JavaScript/TypeScript Example

```javascript
class ChattrixClient {
  constructor(baseUrl, accessToken) {
    this.baseUrl = baseUrl;
    this.accessToken = accessToken;
  }

  async request(endpoint, options = {}) {
    const url = `${this.baseUrl}${endpoint}`;
    const headers = {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${this.accessToken}`,
      ...options.headers
    };

    const response = await fetch(url, { ...options, headers });
    return response.json();
  }

  // Authentication
  async login(usernameOrEmail, password) {
    return this.request('/v1/auth/login', {
      method: 'POST',
      body: JSON.stringify({ usernameOrEmail, password })
    });
  }

  // Conversations
  async getConversations() {
    return this.request('/v1/conversations');
  }

  async createConversation(type, participantIds, name = null) {
    return this.request('/v1/conversations', {
      method: 'POST',
      body: JSON.stringify({ type, participantIds, name })
    });
  }

  // Messages
  async getMessages(conversationId, page = 0, size = 50) {
    return this.request(
      `/v1/conversations/${conversationId}/messages?page=${page}&size=${size}`
    );
  }

  async sendMessage(conversationId, messageData) {
    return this.request(`/v1/conversations/${conversationId}/messages`, {
      method: 'POST',
      body: JSON.stringify(messageData)
    });
  }

  // WebSocket
  connectWebSocket(token) {
    this.ws = new WebSocket(`ws://localhost:8080/api/ws/chat?token=${token}`);

    this.ws.onopen = () => {
      console.log('WebSocket connected');
    };

    this.ws.onmessage = (event) => {
      const message = JSON.parse(event.data);
      this.handleWebSocketMessage(message);
    };

    this.ws.onerror = (error) => {
      console.error('WebSocket error:', error);
    };

    this.ws.onclose = () => {
      console.log('WebSocket disconnected');
      // Implement reconnection logic
    };
  }

  handleWebSocketMessage(message) {
    switch (message.type) {
      case 'NEW_MESSAGE':
        console.log('New message:', message.data);
        break;
      case 'USER_TYPING':
        console.log('User typing:', message.data);
        break;
      case 'USER_STATUS_CHANGED':
        console.log('User status changed:', message.data);
        break;
    }
  }

  sendWebSocketMessage(conversationId, content, type = 'TEXT') {
    const message = {
      type: 'CHAT_MESSAGE',
      conversationId,
      content,
      messageType: type
    };
    this.ws.send(JSON.stringify(message));
  }
}

// Usage
const client = new ChattrixClient('http://localhost:8080/api', 'your_access_token');

// Login
const authResult = await client.login('john_doe', 'password123');
console.log('Logged in:', authResult);

// Get conversations
const conversations = await client.getConversations();
console.log('Conversations:', conversations);

// Send message
const messageResult = await client.sendMessage(10, {
  content: 'Hello!',
  type: 'TEXT'
});
console.log('Message sent:', messageResult);

// Connect WebSocket
client.connectWebSocket(authResult.data.accessToken);
```

---

## 14. Postman Collection

Bạn có thể import các endpoint sau vào Postman để test:

**Environment Variables:**
- `base_url`: `http://localhost:8080/api`
- `access_token`: Token nhận được sau khi login

**Pre-request Script (cho authenticated requests):**
```javascript
pm.request.headers.add({
  key: 'Authorization',
  value: 'Bearer ' + pm.environment.get('access_token')
});
```

---

🔒 = Requires Authentication

**Lưu ý:**
- Tất cả timestamps đều ở định dạng ISO 8601 UTC
- File sizes tính bằng bytes
- Duration tính bằng giây
- Coordinates (latitude/longitude) là số thập phân

---

**Version:** 1.0.0
**Last Updated:** 2025-10-29
