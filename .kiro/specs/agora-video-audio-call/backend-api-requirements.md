# Backend API Requirements for Agora Video/Audio Call

## Tổng quan

Tài liệu này định nghĩa các API endpoints cần thiết ở backend để hỗ trợ tính năng gọi video/audio sử dụng Agora SDK trong ứng dụng Chattrix UI. Backend cần cung cấp các endpoints cho việc quản lý token, signaling, và lưu trữ lịch sử cuộc gọi.

## Glossary

- **Agora Token**: Token bảo mật được tạo bởi backend để xác thực khi join channel
- **Channel ID**: Định danh duy nhất cho một phòng gọi
- **Call Signaling**: Quá trình trao đổi thông tin để thiết lập cuộc gọi
- **Backend Server**: Server xử lý logic nghiệp vụ và lưu trữ dữ liệu
- **Token Server**: Service tạo và quản lý Agora tokens
- **Call Metadata**: Thông tin về cuộc gọi (thời gian, người tham gia, trạng thái)

---

## 1. Agora Token Management APIs

### 1.1 Generate RTC Token

**Endpoint**: `POST /api/v1/agora/token/generate`

**Mục đích**: Tạo Agora RTC token để client có thể join channel một cách bảo mật

**Request Body**:
```json
{
  "channelId": "string",
  "userId": "string",
  "role": "publisher|subscriber",
  "expirationSeconds": 3600
}
```

**Response Success (200)**:
```json
{
  "success": true,
  "data": {
    "token": "string",
    "channelId": "string",
    "uid": 0,
    "expiresAt": "2024-01-01T12:00:00Z"
  }
}
```

**Response Error (400/500)**:
```json
{
  "success": false,
  "error": {
    "code": "TOKEN_GENERATION_FAILED",
    "message": "Failed to generate Agora token"
  }
}
```

**Validation Rules**:
- `channelId`: Required, max 64 characters, alphanumeric
- `userId`: Required, must be authenticated user
- `role`: Required, must be "publisher" or "subscriber"
- `expirationSeconds`: Optional, default 3600, max 86400 (24 hours)

**Implementation Details**:

```typescript
async function generateRTCToken(req, res) {
  // 1. Validate request
  const { channelId, userId, role, expirationSeconds = 3600 } = req.body;
  
  // 2. Verify authentication
  const authenticatedUserId = req.user.id;
  if (userId !== authenticatedUserId) {
    return res.status(403).json({
      success: false,
      error: { code: "UNAUTHORIZED_ACCESS", message: "Cannot generate token for other users" }
    });
  }
  
  // 3. Validate channel ID format
  if (!channelId || channelId.length > 64 || !/^[a-zA-Z0-9_-]+$/.test(channelId)) {
    return res.status(400).json({
      success: false,
      error: { code: "INVALID_CHANNEL_ID", message: "Invalid channel ID format" }
    });
  }
  
  // 4. Validate role
  const roleMap = { publisher: 1, subscriber: 2 };
  if (!roleMap[role]) {
    return res.status(400).json({
      success: false,
      error: { code: "INVALID_ROLE", message: "Role must be publisher or subscriber" }
    });
  }
  
  // 5. Validate expiration
  if (expirationSeconds < 60 || expirationSeconds > 86400) {
    return res.status(400).json({
      success: false,
      error: { code: "INVALID_EXPIRATION", message: "Expiration must be between 60 and 86400 seconds" }
    });
  }
  
  try {
    // 6. Generate UID from userId (convert to integer)
    const uid = generateUidFromUserId(userId);
    
    // 7. Calculate expiration timestamp
    const currentTimestamp = Math.floor(Date.now() / 1000);
    const privilegeExpiredTs = currentTimestamp + expirationSeconds;
    
    // 8. Build Agora token using Agora SDK
    const token = RtcTokenBuilder.buildTokenWithUid(
      process.env.AGORA_APP_ID,
      process.env.AGORA_APP_CERTIFICATE,
      channelId,
      uid,
      roleMap[role],
      privilegeExpiredTs
    );
    
    // 9. Log token generation for audit
    await logTokenGeneration({
      userId,
      channelId,
      uid,
      role,
      expiresAt: new Date(privilegeExpiredTs * 1000)
    });
    
    // 10. Return token
    return res.status(200).json({
      success: true,
      data: {
        token,
        channelId,
        uid,
        expiresAt: new Date(privilegeExpiredTs * 1000).toISOString()
      }
    });
    
  } catch (error) {
    console.error("Token generation failed:", error);
    return res.status(500).json({
      success: false,
      error: { code: "TOKEN_GENERATION_FAILED", message: "Failed to generate token" }
    });
  }
}

// Helper function to generate consistent UID from userId
function generateUidFromUserId(userId: string): number {
  // Use hash function to convert string userId to integer UID
  // Ensure UID is within Agora's valid range (0 to 2^32-1)
  const hash = crypto.createHash('md5').update(userId).digest('hex');
  return parseInt(hash.substring(0, 8), 16);
}
```

**Business Logic**:
1. Xác thực user đang request có quyền tạo token cho chính họ
2. Validate format của channelId (alphanumeric, max 64 chars)
3. Convert role string thành Agora role integer (publisher=1, subscriber=2)
4. Generate UID từ userId để đảm bảo consistency
5. Sử dụng Agora SDK để build token với App ID và App Certificate
6. Log việc tạo token để audit trail
7. Return token cùng với expiration time

---

### 1.2 Refresh RTC Token

**Endpoint**: `POST /api/v1/agora/token/refresh`

**Mục đích**: Làm mới token khi token hiện tại sắp hết hạn hoặc đã hết hạn

**Request Body**:
```json
{
  "channelId": "string",
  "userId": "string",
  "oldToken": "string"
}
```

**Response Success (200)**:
```json
{
  "success": true,
  "data": {
    "token": "string",
    "channelId": "string",
    "uid": 0,
    "expiresAt": "2024-01-01T12:00:00Z"
  }
}
```

**Response Error (401/500)**:
```json
{
  "success": false,
  "error": {
    "code": "TOKEN_REFRESH_FAILED",
    "message": "Failed to refresh token"
  }
}
```

**Implementation Details**:

```typescript
async function refreshRTCToken(req, res) {
  const { channelId, userId, oldToken } = req.body;
  
  // 1. Verify authentication
  const authenticatedUserId = req.user.id;
  if (userId !== authenticatedUserId) {
    return res.status(403).json({
      success: false,
      error: { code: "UNAUTHORIZED_ACCESS", message: "Cannot refresh token for other users" }
    });
  }
  
  try {
    // 2. Verify old token is valid (optional - for security)
    // This prevents token refresh abuse
    const tokenRecord = await db.query(
      "SELECT * FROM token_logs WHERE user_id = $1 AND channel_id = $2 ORDER BY created_at DESC LIMIT 1",
      [userId, channelId]
    );
    
    if (!tokenRecord.rows.length) {
      return res.status(401).json({
        success: false,
        error: { code: "NO_PREVIOUS_TOKEN", message: "No previous token found for this channel" }
      });
    }
    
    // 3. Check if user is still in an active call
    const activeCall = await db.query(
      "SELECT * FROM calls WHERE channel_id = $1 AND (caller_id = $2 OR callee_id = $2) AND status IN ('connecting', 'connected')",
      [channelId, userId]
    );
    
    if (!activeCall.rows.length) {
      return res.status(400).json({
        success: false,
        error: { code: "NO_ACTIVE_CALL", message: "No active call found for token refresh" }
      });
    }
    
    // 4. Generate new token with same parameters
    const uid = generateUidFromUserId(userId);
    const currentTimestamp = Math.floor(Date.now() / 1000);
    const privilegeExpiredTs = currentTimestamp + 3600; // 1 hour
    
    const newToken = RtcTokenBuilder.buildTokenWithUid(
      process.env.AGORA_APP_ID,
      process.env.AGORA_APP_CERTIFICATE,
      channelId,
      uid,
      1, // Publisher role
      privilegeExpiredTs
    );
    
    // 5. Log token refresh
    await logTokenRefresh({
      userId,
      channelId,
      uid,
      oldToken: oldToken.substring(0, 20) + "...", // Log partial token for security
      expiresAt: new Date(privilegeExpiredTs * 1000)
    });
    
    // 6. Return new token
    return res.status(200).json({
      success: true,
      data: {
        token: newToken,
        channelId,
        uid,
        expiresAt: new Date(privilegeExpiredTs * 1000).toISOString()
      }
    });
    
  } catch (error) {
    console.error("Token refresh failed:", error);
    return res.status(500).json({
      success: false,
      error: { code: "TOKEN_REFRESH_FAILED", message: "Failed to refresh token" }
    });
  }
}
```

**Business Logic**:
1. Xác thực user có quyền refresh token
2. Kiểm tra có token cũ tồn tại trong hệ thống không (security check)
3. Verify user đang trong active call (không cho refresh token khi không có call)
4. Generate token mới với expiration time mới
5. Log việc refresh token để audit
6. Return token mới

---

## 2. Call Signaling APIs

### 2.1 Initiate Call

**Endpoint**: `POST /api/v1/calls/initiate`

**Mục đích**: Khởi tạo cuộc gọi và gửi thông báo đến người nhận

**Request Body**:
```json
{
  "callId": "uuid",
  "calleeId": "string",
  "callType": "audio|video",
  "channelId": "string"
}
```

**Response Success (200)**:
```json
{
  "success": true,
  "data": {
    "callId": "uuid",
    "channelId": "string",
    "callerId": "string",
    "callerName": "string",
    "callerAvatar": "string",
    "calleeId": "string",
    "calleeName": "string",
    "calleeAvatar": "string",
    "callType": "audio|video",
    "status": "initiating",
    "createdAt": "2024-01-01T12:00:00Z"
  }
}
```

**Response Error (400/404)**:
```json
{
  "success": false,
  "error": {
    "code": "USER_NOT_FOUND|INVALID_CALL_TYPE",
    "message": "Callee user not found"
  }
}
```

**Side Effects**:
- Gửi WebSocket message đến callee với thông tin cuộc gọi
- Tạo notification cho callee nếu offline
- Lưu call metadata vào database

**Implementation Details**:

```typescript
async function initiateCall(req, res) {
  const { callId, calleeId, callType, channelId } = req.body;
  const callerId = req.user.id;
  
  try {
    // 1. Validate call type
    if (!['audio', 'video'].includes(callType)) {
      return res.status(400).json({
        success: false,
        error: { code: "INVALID_CALL_TYPE", message: "Call type must be audio or video" }
      });
    }
    
    // 2. Check if callee exists and get their info
    const callee = await db.query(
      "SELECT id, username, avatar_url, is_online FROM users WHERE id = $1",
      [calleeId]
    );
    
    if (!callee.rows.length) {
      return res.status(404).json({
        success: false,
        error: { code: "USER_NOT_FOUND", message: "Callee user not found" }
      });
    }
    
    // 3. Get caller info
    const caller = await db.query(
      "SELECT id, username, avatar_url FROM users WHERE id = $1",
      [callerId]
    );
    
    // 4. Check if callee is already in a call
    const existingCall = await db.query(
      "SELECT * FROM calls WHERE (caller_id = $1 OR callee_id = $1) AND status IN ('initiating', 'ringing', 'connecting', 'connected')",
      [calleeId]
    );
    
    if (existingCall.rows.length > 0) {
      return res.status(409).json({
        success: false,
        error: { code: "USER_BUSY", message: "User is already in a call" }
      });
    }
    
    // 5. Check if caller is already in a call
    const callerExistingCall = await db.query(
      "SELECT * FROM calls WHERE (caller_id = $1 OR callee_id = $1) AND status IN ('initiating', 'ringing', 'connecting', 'connected')",
      [callerId]
    );
    
    if (callerExistingCall.rows.length > 0) {
      return res.status(409).json({
        success: false,
        error: { code: "USER_BUSY", message: "You are already in a call" }
      });
    }
    
    // 6. Verify caller and callee are contacts (optional - business rule)
    const areContacts = await db.query(
      "SELECT * FROM contacts WHERE (user_id = $1 AND contact_id = $2) OR (user_id = $2 AND contact_id = $1)",
      [callerId, calleeId]
    );
    
    if (!areContacts.rows.length) {
      return res.status(403).json({
        success: false,
        error: { code: "NOT_CONTACTS", message: "You can only call your contacts" }
      });
    }
    
    // 7. Create call record in database
    const callRecord = await db.query(
      `INSERT INTO calls (id, channel_id, caller_id, callee_id, call_type, status, start_time, created_at, updated_at)
       VALUES ($1, $2, $3, $4, $5, 'initiating', NOW(), NOW(), NOW())
       RETURNING *`,
      [callId, channelId, callerId, calleeId, callType]
    );
    
    // 8. Prepare call data for response and WebSocket
    const callData = {
      callId,
      channelId,
      callerId: caller.rows[0].id,
      callerName: caller.rows[0].username,
      callerAvatar: caller.rows[0].avatar_url,
      calleeId: callee.rows[0].id,
      calleeName: callee.rows[0].username,
      calleeAvatar: callee.rows[0].avatar_url,
      callType,
      status: 'initiating',
      createdAt: callRecord.rows[0].created_at
    };
    
    // 9. Send WebSocket notification to callee
    const wsMessage = {
      type: 'call_invitation',
      data: {
        callId,
        channelId,
        callerId: caller.rows[0].id,
        callerName: caller.rows[0].username,
        callerAvatar: caller.rows[0].avatar_url,
        callType,
        timestamp: new Date().toISOString()
      }
    };
    
    await sendWebSocketMessage(calleeId, wsMessage);
    
    // 10. Update call status to 'ringing' after sending invitation
    await db.query(
      "UPDATE calls SET status = 'ringing', updated_at = NOW() WHERE id = $1",
      [callId]
    );
    
    // 11. Create push notification if callee is offline
    if (!callee.rows[0].is_online) {
      await createPushNotification({
        userId: calleeId,
        title: `${caller.rows[0].username} is calling`,
        body: `Incoming ${callType} call`,
        data: { callId, channelId, callType, callerId }
      });
    }
    
    // 12. Set timeout to auto-cancel call after 60 seconds
    setTimeout(async () => {
      const call = await db.query("SELECT status FROM calls WHERE id = $1", [callId]);
      if (call.rows.length && call.rows[0].status === 'ringing') {
        await db.query(
          "UPDATE calls SET status = 'missed', updated_at = NOW() WHERE id = $1",
          [callId]
        );
        
        // Notify caller that call timed out
        await sendWebSocketMessage(callerId, {
          type: 'call_timeout',
          data: { callId, timestamp: new Date().toISOString() }
        });
        
        // Notify callee to dismiss notification
        await sendWebSocketMessage(calleeId, {
          type: 'call_timeout',
          data: { callId, timestamp: new Date().toISOString() }
        });
      }
    }, 60000); // 60 seconds timeout
    
    // 13. Log call initiation
    await logCallEvent({
      callId,
      eventType: 'call_initiated',
      userId: callerId,
      metadata: { calleeId, callType, channelId }
    });
    
    // 14. Return success response
    return res.status(200).json({
      success: true,
      data: callData
    });
    
  } catch (error) {
    console.error("Call initiation failed:", error);
    return res.status(500).json({
      success: false,
      error: { code: "CALL_INITIATION_FAILED", message: "Failed to initiate call" }
    });
  }
}
```

**Business Logic**:
1. Validate call type (audio/video)
2. Kiểm tra callee có tồn tại không
3. Kiểm tra callee có đang trong cuộc gọi khác không (USER_BUSY)
4. Kiểm tra caller có đang trong cuộc gọi khác không
5. Verify caller và callee là contacts (business rule)
6. Tạo call record trong database với status 'initiating'
7. Gửi WebSocket message đến callee
8. Update status thành 'ringing'
9. Tạo push notification nếu callee offline
10. Set timeout 60s để auto-cancel nếu không được accept
11. Log event để audit
12. Return call data

---

### 2.2 Accept Call

**Endpoint**: `POST /api/v1/calls/{callId}/accept`

**Mục đích**: Chấp nhận cuộc gọi đến

**Path Parameters**:
- `callId`: UUID của cuộc gọi

**Request Body**:
```json
{
  "userId": "string"
}
```

**Response Success (200)**:
```json
{
  "success": true,
  "data": {
    "callId": "uuid",
    "channelId": "string",
    "status": "connecting",
    "acceptedAt": "2024-01-01T12:00:00Z"
  }
}
```

**Side Effects**:
- Cập nhật trạng thái cuộc gọi thành "connecting"
- Gửi WebSocket message đến caller thông báo call được accept
- Dismiss notification nếu có

**Implementation Details**:

```typescript
async function acceptCall(req, res) {
  const { callId } = req.params;
  const { userId } = req.body;
  const authenticatedUserId = req.user.id;
  
  try {
    // 1. Verify authentication
    if (userId !== authenticatedUserId) {
      return res.status(403).json({
        success: false,
        error: { code: "UNAUTHORIZED_ACCESS", message: "Cannot accept call for other users" }
      });
    }
    
    // 2. Get call details
    const call = await db.query(
      "SELECT * FROM calls WHERE id = $1",
      [callId]
    );
    
    if (!call.rows.length) {
      return res.status(404).json({
        success: false,
        error: { code: "CALL_NOT_FOUND", message: "Call not found" }
      });
    }
    
    const callData = call.rows[0];
    
    // 3. Verify user is the callee
    if (callData.callee_id !== userId) {
      return res.status(403).json({
        success: false,
        error: { code: "UNAUTHORIZED_ACCESS", message: "Only callee can accept the call" }
      });
    }
    
    // 4. Check call status - can only accept if ringing
    if (callData.status !== 'ringing') {
      return res.status(400).json({
        success: false,
        error: { 
          code: "INVALID_CALL_STATUS", 
          message: `Cannot accept call with status: ${callData.status}` 
        }
      });
    }
    
    // 5. Check if call has timed out (older than 60 seconds)
    const callAge = Date.now() - new Date(callData.created_at).getTime();
    if (callAge > 60000) {
      await db.query(
        "UPDATE calls SET status = 'missed', updated_at = NOW() WHERE id = $1",
        [callId]
      );
      
      return res.status(400).json({
        success: false,
        error: { code: "CALL_TIMEOUT", message: "Call has timed out" }
      });
    }
    
    // 6. Update call status to 'connecting'
    const updatedCall = await db.query(
      "UPDATE calls SET status = 'connecting', updated_at = NOW() WHERE id = $1 RETURNING *",
      [callId]
    );
    
    // 7. Send WebSocket message to caller
    await sendWebSocketMessage(callData.caller_id, {
      type: 'call_accepted',
      data: {
        callId,
        acceptedBy: userId,
        timestamp: new Date().toISOString()
      }
    });
    
    // 8. Dismiss push notification if exists
    await dismissPushNotification({
      userId,
      notificationType: 'call_invitation',
      callId
    });
    
    // 9. Log call acceptance
    await logCallEvent({
      callId,
      eventType: 'call_accepted',
      userId,
      metadata: { callerId: callData.caller_id }
    });
    
    // 10. Return success response
    return res.status(200).json({
      success: true,
      data: {
        callId,
        channelId: callData.channel_id,
        status: 'connecting',
        acceptedAt: updatedCall.rows[0].updated_at
      }
    });
    
  } catch (error) {
    console.error("Accept call failed:", error);
    return res.status(500).json({
      success: false,
      error: { code: "ACCEPT_CALL_FAILED", message: "Failed to accept call" }
    });
  }
}
```

**Business Logic**:
1. Verify user có quyền accept call (phải là callee)
2. Kiểm tra call có tồn tại không
3. Kiểm tra call status phải là 'ringing' mới accept được
4. Kiểm tra call có timeout chưa (> 60s)
5. Update status thành 'connecting'
6. Gửi WebSocket message đến caller
7. Dismiss push notification
8. Log event
9. Return success với channel info để callee join

---

### 2.3 Reject Call

**Endpoint**: `POST /api/v1/calls/{callId}/reject`

**Mục đích**: Từ chối cuộc gọi đến

**Path Parameters**:
- `callId`: UUID của cuộc gọi

**Request Body**:
```json
{
  "userId": "string",
  "reason": "busy|declined|unavailable"
}
```

**Response Success (200)**:
```json
{
  "success": true,
  "data": {
    "callId": "uuid",
    "status": "rejected",
    "rejectedAt": "2024-01-01T12:00:00Z"
  }
}
```

**Side Effects**:
- Cập nhật trạng thái cuộc gọi thành "rejected"
- Gửi WebSocket message đến caller thông báo call bị reject
- Lưu vào call history với status "rejected"

**Implementation Details**:

```typescript
async function rejectCall(req, res) {
  const { callId } = req.params;
  const { userId, reason = 'declined' } = req.body;
  const authenticatedUserId = req.user.id;
  
  try {
    // 1. Verify authentication
    if (userId !== authenticatedUserId) {
      return res.status(403).json({
        success: false,
        error: { code: "UNAUTHORIZED_ACCESS", message: "Cannot reject call for other users" }
      });
    }
    
    // 2. Validate reason
    const validReasons = ['busy', 'declined', 'unavailable'];
    if (!validReasons.includes(reason)) {
      return res.status(400).json({
        success: false,
        error: { code: "INVALID_REASON", message: "Invalid rejection reason" }
      });
    }
    
    // 3. Get call details
    const call = await db.query(
      "SELECT * FROM calls WHERE id = $1",
      [callId]
    );
    
    if (!call.rows.length) {
      return res.status(404).json({
        success: false,
        error: { code: "CALL_NOT_FOUND", message: "Call not found" }
      });
    }
    
    const callData = call.rows[0];
    
    // 4. Verify user is the callee
    if (callData.callee_id !== userId) {
      return res.status(403).json({
        success: false,
        error: { code: "UNAUTHORIZED_ACCESS", message: "Only callee can reject the call" }
      });
    }
    
    // 5. Check call status - can only reject if initiating or ringing
    if (!['initiating', 'ringing'].includes(callData.status)) {
      return res.status(400).json({
        success: false,
        error: { 
          code: "INVALID_CALL_STATUS", 
          message: `Cannot reject call with status: ${callData.status}` 
        }
      });
    }
    
    // 6. Update call status to 'rejected'
    const updatedCall = await db.query(
      `UPDATE calls 
       SET status = 'rejected', 
           end_time = NOW(), 
           updated_at = NOW() 
       WHERE id = $1 
       RETURNING *`,
      [callId]
    );
    
    // 7. Store rejection reason in metadata (optional)
    await db.query(
      `INSERT INTO call_metadata (call_id, key, value, created_at)
       VALUES ($1, 'rejection_reason', $2, NOW())`,
      [callId, reason]
    );
    
    // 8. Send WebSocket message to caller
    await sendWebSocketMessage(callData.caller_id, {
      type: 'call_rejected',
      data: {
        callId,
        rejectedBy: userId,
        reason,
        timestamp: new Date().toISOString()
      }
    });
    
    // 9. Dismiss push notification if exists
    await dismissPushNotification({
      userId,
      notificationType: 'call_invitation',
      callId
    });
    
    // 10. Log call rejection
    await logCallEvent({
      callId,
      eventType: 'call_rejected',
      userId,
      metadata: { callerId: callData.caller_id, reason }
    });
    
    // 11. Return success response
    return res.status(200).json({
      success: true,
      data: {
        callId,
        status: 'rejected',
        rejectedAt: updatedCall.rows[0].updated_at
      }
    });
    
  } catch (error) {
    console.error("Reject call failed:", error);
    return res.status(500).json({
      success: false,
      error: { code: "REJECT_CALL_FAILED", message: "Failed to reject call" }
    });
  }
}
```

**Business Logic**:
1. Verify user có quyền reject call (phải là callee)
2. Validate rejection reason
3. Kiểm tra call có tồn tại không
4. Kiểm tra call status phải là 'initiating' hoặc 'ringing'
5. Update status thành 'rejected' và set end_time
6. Lưu rejection reason vào metadata
7. Gửi WebSocket message đến caller với reason
8. Dismiss push notification
9. Log event với reason
10. Return success

---

### 2.4 End Call

**Endpoint**: `POST /api/v1/calls/{callId}/end`

**Mục đích**: Kết thúc cuộc gọi đang diễn ra

**Path Parameters**:
- `callId`: UUID của cuộc gọi

**Request Body**:
```json
{
  "userId": "string",
  "endedBy": "caller|callee",
  "durationSeconds": 120
}
```

**Response Success (200)**:
```json
{
  "success": true,
  "data": {
    "callId": "uuid",
    "status": "ended",
    "durationSeconds": 120,
    "endedAt": "2024-01-01T12:00:00Z"
  }
}
```

**Side Effects**:
- Cập nhật trạng thái cuộc gọi thành "ended"
- Lưu duration vào database
- Gửi WebSocket message đến participant còn lại
- Lưu vào call history với status "completed"

**Implementation Details**:

```typescript
async function endCall(req, res) {
  const { callId } = req.params;
  const { userId, endedBy, durationSeconds } = req.body;
  const authenticatedUserId = req.user.id;
  
  try {
    // 1. Verify authentication
    if (userId !== authenticatedUserId) {
      return res.status(403).json({
        success: false,
        error: { code: "UNAUTHORIZED_ACCESS", message: "Cannot end call for other users" }
      });
    }
    
    // 2. Get call details
    const call = await db.query(
      "SELECT * FROM calls WHERE id = $1",
      [callId]
    );
    
    if (!call.rows.length) {
      return res.status(404).json({
        success: false,
        error: { code: "CALL_NOT_FOUND", message: "Call not found" }
      });
    }
    
    const callData = call.rows[0];
    
    // 3. Verify user is a participant (caller or callee)
    if (callData.caller_id !== userId && callData.callee_id !== userId) {
      return res.status(403).json({
        success: false,
        error: { code: "UNAUTHORIZED_ACCESS", message: "Only call participants can end the call" }
      });
    }
    
    // 4. Check if call is already ended
    if (['ended', 'rejected', 'missed', 'failed'].includes(callData.status)) {
      return res.status(400).json({
        success: false,
        error: { code: "CALL_ALREADY_ENDED", message: "Call has already ended" }
      });
    }
    
    // 5. Calculate duration if not provided
    let finalDuration = durationSeconds;
    if (!finalDuration && callData.start_time) {
      const startTime = new Date(callData.start_time).getTime();
      const endTime = Date.now();
      finalDuration = Math.floor((endTime - startTime) / 1000);
    }
    
    // 6. Validate duration
    if (finalDuration < 0) {
      finalDuration = 0;
    }
    
    // 7. Update call status to 'ended'
    const updatedCall = await db.query(
      `UPDATE calls 
       SET status = 'ended', 
           end_time = NOW(), 
           duration_seconds = $2,
           updated_at = NOW() 
       WHERE id = $1 
       RETURNING *`,
      [callId, finalDuration]
    );
    
    // 8. Determine the other participant
    const otherParticipantId = callData.caller_id === userId 
      ? callData.callee_id 
      : callData.caller_id;
    
    // 9. Send WebSocket message to other participant
    await sendWebSocketMessage(otherParticipantId, {
      type: 'call_ended',
      data: {
        callId,
        endedBy: userId,
        durationSeconds: finalDuration,
        timestamp: new Date().toISOString()
      }
    });
    
    // 10. Create call history entries for both participants
    await Promise.all([
      createCallHistoryEntry({
        userId: callData.caller_id,
        callId,
        remoteUserId: callData.callee_id,
        callType: callData.call_type,
        status: 'completed',
        direction: 'outgoing',
        durationSeconds: finalDuration,
        timestamp: callData.start_time
      }),
      createCallHistoryEntry({
        userId: callData.callee_id,
        callId,
        remoteUserId: callData.caller_id,
        callType: callData.call_type,
        status: 'completed',
        direction: 'incoming',
        durationSeconds: finalDuration,
        timestamp: callData.start_time
      })
    ]);
    
    // 11. Calculate call quality average if metrics exist
    const qualityMetrics = await db.query(
      `SELECT AVG(
         CASE network_quality
           WHEN 'excellent' THEN 5
           WHEN 'good' THEN 4
           WHEN 'poor' THEN 3
           WHEN 'bad' THEN 2
           WHEN 'veryBad' THEN 1
           ELSE 0
         END
       ) as avg_quality,
       AVG(packet_loss_rate) as avg_packet_loss
       FROM call_quality_metrics
       WHERE call_id = $1`,
      [callId]
    );
    
    // 12. Store final call statistics
    if (qualityMetrics.rows.length) {
      await db.query(
        `INSERT INTO call_statistics (call_id, avg_quality, avg_packet_loss, created_at)
         VALUES ($1, $2, $3, NOW())`,
        [callId, qualityMetrics.rows[0].avg_quality, qualityMetrics.rows[0].avg_packet_loss]
      );
    }
    
    // 13. Log call end
    await logCallEvent({
      callId,
      eventType: 'call_ended',
      userId,
      metadata: { 
        endedBy,
        durationSeconds: finalDuration,
        otherParticipant: otherParticipantId
      }
    });
    
    // 14. Return success response
    return res.status(200).json({
      success: true,
      data: {
        callId,
        status: 'ended',
        durationSeconds: finalDuration,
        endedAt: updatedCall.rows[0].end_time
      }
    });
    
  } catch (error) {
    console.error("End call failed:", error);
    return res.status(500).json({
      success: false,
      error: { code: "END_CALL_FAILED", message: "Failed to end call" }
    });
  }
}

// Helper function to create call history entry
async function createCallHistoryEntry(data) {
  const { userId, callId, remoteUserId, callType, status, direction, durationSeconds, timestamp } = data;
  
  // Get remote user info
  const remoteUser = await db.query(
    "SELECT username, avatar_url FROM users WHERE id = $1",
    [remoteUserId]
  );
  
  if (!remoteUser.rows.length) return;
  
  await db.query(
    `INSERT INTO call_history (
      id, user_id, call_id, remote_user_id, remote_user_name, remote_user_avatar,
      call_type, status, direction, duration_seconds, timestamp, created_at
    ) VALUES (gen_random_uuid(), $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, NOW())
    ON CONFLICT (user_id, call_id) DO UPDATE SET
      status = EXCLUDED.status,
      duration_seconds = EXCLUDED.duration_seconds,
      updated_at = NOW()`,
    [
      userId, callId, remoteUserId, 
      remoteUser.rows[0].username,
      remoteUser.rows[0].avatar_url,
      callType, status, direction, durationSeconds, timestamp
    ]
  );
}
```

**Business Logic**:
1. Verify user có quyền end call (phải là participant)
2. Kiểm tra call có tồn tại không
3. Kiểm tra call chưa ended
4. Calculate duration từ start_time nếu không được provide
5. Update status thành 'ended' và lưu duration
6. Xác định participant còn lại
7. Gửi WebSocket message đến participant còn lại
8. Tạo call history entries cho cả 2 participants
9. Calculate average call quality từ metrics
10. Store call statistics
11. Log event
12. Return success với duration

---

### 2.5 Update Call Status

**Endpoint**: `PATCH /api/v1/calls/{callId}/status`

**Mục đích**: Cập nhật trạng thái cuộc gọi (connecting, connected, etc.)

**Path Parameters**:
- `callId`: UUID của cuộc gọi

**Request Body**:
```json
{
  "status": "connecting|connected|disconnecting",
  "userId": "string"
}
```

**Response Success (200)**:
```json
{
  "success": true,
  "data": {
    "callId": "uuid",
    "status": "connected",
    "updatedAt": "2024-01-01T12:00:00Z"
  }
}
```

**Implementation Details**:

```typescript
async function updateCallStatus(req, res) {
  const { callId } = req.params;
  const { status, userId } = req.body;
  const authenticatedUserId = req.user.id;
  
  try {
    // 1. Verify authentication
    if (userId !== authenticatedUserId) {
      return res.status(403).json({
        success: false,
        error: { code: "UNAUTHORIZED_ACCESS", message: "Cannot update call for other users" }
      });
    }
    
    // 2. Validate status
    const validStatuses = ['connecting', 'connected', 'disconnecting'];
    if (!validStatuses.includes(status)) {
      return res.status(400).json({
        success: false,
        error: { code: "INVALID_STATUS", message: "Invalid call status" }
      });
    }
    
    // 3. Get call details
    const call = await db.query(
      "SELECT * FROM calls WHERE id = $1",
      [callId]
    );
    
    if (!call.rows.length) {
      return res.status(404).json({
        success: false,
        error: { code: "CALL_NOT_FOUND", message: "Call not found" }
      });
    }
    
    const callData = call.rows[0];
    
    // 4. Verify user is a participant
    if (callData.caller_id !== userId && callData.callee_id !== userId) {
      return res.status(403).json({
        success: false,
        error: { code: "UNAUTHORIZED_ACCESS", message: "Only participants can update call status" }
      });
    }
    
    // 5. Validate status transition
    const validTransitions = {
      'ringing': ['connecting'],
      'connecting': ['connected', 'disconnecting'],
      'connected': ['disconnecting']
    };
    
    if (!validTransitions[callData.status]?.includes(status)) {
      return res.status(400).json({
        success: false,
        error: { 
          code: "INVALID_STATUS_TRANSITION", 
          message: `Cannot transition from ${callData.status} to ${status}` 
        }
      });
    }
    
    // 6. Update call status
    const updatedCall = await db.query(
      "UPDATE calls SET status = $2, updated_at = NOW() WHERE id = $1 RETURNING *",
      [callId, status]
    );
    
    // 7. If status is 'connected', record actual start time
    if (status === 'connected' && !callData.start_time) {
      await db.query(
        "UPDATE calls SET start_time = NOW() WHERE id = $1",
        [callId]
      );
    }
    
    // 8. Notify other participant
    const otherParticipantId = callData.caller_id === userId 
      ? callData.callee_id 
      : callData.caller_id;
    
    await sendWebSocketMessage(otherParticipantId, {
      type: 'call_status_updated',
      data: {
        callId,
        status,
        updatedBy: userId,
        timestamp: new Date().toISOString()
      }
    });
    
    // 9. Log status change
    await logCallEvent({
      callId,
      eventType: 'status_updated',
      userId,
      metadata: { 
        oldStatus: callData.status,
        newStatus: status
      }
    });
    
    // 10. Return success
    return res.status(200).json({
      success: true,
      data: {
        callId,
        status,
        updatedAt: updatedCall.rows[0].updated_at
      }
    });
    
  } catch (error) {
    console.error("Update call status failed:", error);
    return res.status(500).json({
      success: false,
      error: { code: "UPDATE_STATUS_FAILED", message: "Failed to update call status" }
    });
  }
}
```

**Business Logic**:
1. Verify user có quyền update (phải là participant)
2. Validate status value
3. Kiểm tra call có tồn tại không
4. Validate status transition (state machine)
5. Update status trong database
6. Nếu status là 'connected', record start_time
7. Notify participant còn lại qua WebSocket
8. Log status change
9. Return success

---

## 3. Call History APIs

### 3.1 Get Call History

**Endpoint**: `GET /api/v1/calls/history`

**Mục đích**: Lấy danh sách lịch sử cuộc gọi của user

**Query Parameters**:
- `page`: number (default: 1)
- `limit`: number (default: 20, max: 100)
- `callType`: "audio|video|all" (default: "all")
- `status`: "completed|missed|rejected|all" (default: "all")

**Response Success (200)**:
```json
{
  "success": true,
  "data": {
    "calls": [
      {
        "id": "uuid",
        "remoteUserId": "string",
        "remoteUserName": "string",
        "remoteUserAvatar": "string",
        "callType": "audio|video",
        "status": "completed|missed|rejected|failed",
        "direction": "incoming|outgoing",
        "timestamp": "2024-01-01T12:00:00Z",
        "durationSeconds": 120
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 150,
      "totalPages": 8
    }
  }
}
```

**Implementation Details**:

```typescript
async function getCallHistory(req, res) {
  const userId = req.user.id;
  const { 
    page = 1, 
    limit = 20, 
    callType = 'all', 
    status = 'all' 
  } = req.query;
  
  try {
    // 1. Validate pagination parameters
    const pageNum = Math.max(1, parseInt(page));
    const limitNum = Math.min(100, Math.max(1, parseInt(limit)));
    const offset = (pageNum - 1) * limitNum;
    
    // 2. Build WHERE clause based on filters
    let whereConditions = ['user_id = $1'];
    let queryParams = [userId];
    let paramIndex = 2;
    
    if (callType !== 'all') {
      whereConditions.push(`call_type = $${paramIndex}`);
      queryParams.push(callType);
      paramIndex++;
    }
    
    if (status !== 'all') {
      whereConditions.push(`status = $${paramIndex}`);
      queryParams.push(status);
      paramIndex++;
    }
    
    const whereClause = whereConditions.join(' AND ');
    
    // 3. Get total count for pagination
    const countQuery = `
      SELECT COUNT(*) as total
      FROM call_history
      WHERE ${whereClause}
    `;
    
    const countResult = await db.query(countQuery, queryParams);
    const total = parseInt(countResult.rows[0].total);
    const totalPages = Math.ceil(total / limitNum);
    
    // 4. Get call history with pagination
    const historyQuery = `
      SELECT 
        id,
        call_id,
        remote_user_id,
        remote_user_name,
        remote_user_avatar,
        call_type,
        status,
        direction,
        timestamp,
        duration_seconds,
        created_at
      FROM call_history
      WHERE ${whereClause}
      ORDER BY timestamp DESC
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;
    
    queryParams.push(limitNum, offset);
    
    const historyResult = await db.query(historyQuery, queryParams);
    
    // 5. Format response data
    const calls = historyResult.rows.map(row => ({
      id: row.id,
      callId: row.call_id,
      remoteUserId: row.remote_user_id,
      remoteUserName: row.remote_user_name,
      remoteUserAvatar: row.remote_user_avatar,
      callType: row.call_type,
      status: row.status,
      direction: row.direction,
      timestamp: row.timestamp,
      durationSeconds: row.duration_seconds
    }));
    
    // 6. Return paginated response
    return res.status(200).json({
      success: true,
      data: {
        calls,
        pagination: {
          page: pageNum,
          limit: limitNum,
          total,
          totalPages,
          hasNextPage: pageNum < totalPages,
          hasPrevPage: pageNum > 1
        }
      }
    });
    
  } catch (error) {
    console.error("Get call history failed:", error);
    return res.status(500).json({
      success: false,
      error: { code: "GET_HISTORY_FAILED", message: "Failed to retrieve call history" }
    });
  }
}
```

**Business Logic**:
1. Validate và sanitize pagination parameters
2. Build dynamic WHERE clause dựa trên filters
3. Get total count để calculate pagination
4. Query call history với ORDER BY timestamp DESC
5. Format data theo response schema
6. Return với pagination metadata

---

### 3.2 Get Call Details

**Endpoint**: `GET /api/v1/calls/{callId}`

**Mục đích**: Lấy thông tin chi tiết của một cuộc gọi

**Path Parameters**:
- `callId`: UUID của cuộc gọi

**Response Success (200)**:
```json
{
  "success": true,
  "data": {
    "callId": "uuid",
    "channelId": "string",
    "callerId": "string",
    "callerName": "string",
    "calleeId": "string",
    "calleeName": "string",
    "callType": "audio|video",
    "status": "completed",
    "startTime": "2024-01-01T12:00:00Z",
    "endTime": "2024-01-01T12:02:00Z",
    "durationSeconds": 120,
    "qualityMetrics": {
      "averageNetworkQuality": "good",
      "packetLossRate": 0.02
    }
  }
}
```

---

### 3.3 Delete Call History

**Endpoint**: `DELETE /api/v1/calls/history/{callId}`

**Mục đích**: Xóa một cuộc gọi khỏi lịch sử

**Path Parameters**:
- `callId`: UUID của cuộc gọi

**Response Success (200)**:
```json
{
  "success": true,
  "message": "Call history deleted successfully"
}
```

---

## 4. Call Quality & Analytics APIs

### 4.1 Report Call Quality

**Endpoint**: `POST /api/v1/calls/{callId}/quality`

**Mục đích**: Gửi metrics về chất lượng cuộc gọi để phân tích

**Path Parameters**:
- `callId`: UUID của cuộc gọi

**Request Body**:
```json
{
  "userId": "string",
  "networkQuality": "excellent|good|poor|bad|veryBad",
  "packetLossRate": 0.02,
  "roundTripTime": 50,
  "timestamp": "2024-01-01T12:00:00Z"
}
```

**Response Success (200)**:
```json
{
  "success": true,
  "message": "Quality metrics recorded"
}
```

**Implementation Details**:

```typescript
async function reportCallQuality(req, res) {
  const { callId } = req.params;
  const { 
    userId, 
    networkQuality, 
    packetLossRate, 
    roundTripTime, 
    timestamp 
  } = req.body;
  const authenticatedUserId = req.user.id;
  
  try {
    // 1. Verify authentication
    if (userId !== authenticatedUserId) {
      return res.status(403).json({
        success: false,
        error: { code: "UNAUTHORIZED_ACCESS", message: "Cannot report quality for other users" }
      });
    }
    
    // 2. Validate network quality
    const validQualities = ['excellent', 'good', 'poor', 'bad', 'veryBad', 'unknown'];
    if (!validQualities.includes(networkQuality)) {
      return res.status(400).json({
        success: false,
        error: { code: "INVALID_QUALITY", message: "Invalid network quality value" }
      });
    }
    
    // 3. Validate packet loss rate (0-1)
    if (packetLossRate < 0 || packetLossRate > 1) {
      return res.status(400).json({
        success: false,
        error: { code: "INVALID_PACKET_LOSS", message: "Packet loss rate must be between 0 and 1" }
      });
    }
    
    // 4. Validate round trip time (positive number)
    if (roundTripTime < 0) {
      return res.status(400).json({
        success: false,
        error: { code: "INVALID_RTT", message: "Round trip time must be positive" }
      });
    }
    
    // 5. Verify call exists
    const call = await db.query(
      "SELECT * FROM calls WHERE id = $1",
      [callId]
    );
    
    if (!call.rows.length) {
      return res.status(404).json({
        success: false,
        error: { code: "CALL_NOT_FOUND", message: "Call not found" }
      });
    }
    
    const callData = call.rows[0];
    
    // 6. Verify user is a participant
    if (callData.caller_id !== userId && callData.callee_id !== userId) {
      return res.status(403).json({
        success: false,
        error: { code: "UNAUTHORIZED_ACCESS", message: "Only participants can report quality" }
      });
    }
    
    // 7. Insert quality metrics
    await db.query(
      `INSERT INTO call_quality_metrics (
        id, call_id, user_id, network_quality, 
        packet_loss_rate, round_trip_time, recorded_at
      ) VALUES (gen_random_uuid(), $1, $2, $3, $4, $5, $6)`,
      [callId, userId, networkQuality, packetLossRate, roundTripTime, timestamp || new Date()]
    );
    
    // 8. Check if quality is poor and send alert to other participant
    if (['poor', 'bad', 'veryBad'].includes(networkQuality)) {
      const otherParticipantId = callData.caller_id === userId 
        ? callData.callee_id 
        : callData.caller_id;
      
      await sendWebSocketMessage(otherParticipantId, {
        type: 'call_quality_warning',
        data: {
          callId,
          participantId: userId,
          networkQuality,
          timestamp: new Date().toISOString()
        }
      });
    }
    
    // 9. Update call's latest quality in cache (Redis)
    await redis.setex(
      `call:${callId}:quality:${userId}`,
      300, // 5 minutes TTL
      JSON.stringify({ networkQuality, packetLossRate, roundTripTime, timestamp })
    );
    
    // 10. Log quality report
    await logCallEvent({
      callId,
      eventType: 'quality_reported',
      userId,
      metadata: { networkQuality, packetLossRate, roundTripTime }
    });
    
    // 11. Return success
    return res.status(200).json({
      success: true,
      message: "Quality metrics recorded"
    });
    
  } catch (error) {
    console.error("Report call quality failed:", error);
    return res.status(500).json({
      success: false,
      error: { code: "REPORT_QUALITY_FAILED", message: "Failed to report quality metrics" }
    });
  }
}
```

**Business Logic**:
1. Verify user có quyền report quality (phải là participant)
2. Validate network quality value
3. Validate packet loss rate (0-1 range)
4. Validate round trip time (positive)
5. Verify call tồn tại
6. Insert metrics vào database
7. Nếu quality poor, gửi warning đến participant còn lại
8. Cache latest quality trong Redis
9. Log event
10. Return success

---

### 4.2 Get Call Statistics

**Endpoint**: `GET /api/v1/calls/statistics`

**Mục đích**: Lấy thống kê về cuộc gọi của user

**Query Parameters**:
- `period`: "day|week|month|year" (default: "month")

**Response Success (200)**:
```json
{
  "success": true,
  "data": {
    "totalCalls": 150,
    "totalDurationMinutes": 3600,
    "callsByType": {
      "audio": 80,
      "video": 70
    },
    "callsByStatus": {
      "completed": 120,
      "missed": 20,
      "rejected": 10
    },
    "averageCallDuration": 24
  }
}
```

---

## 5. WebSocket Events

Backend cần gửi các WebSocket events sau đến clients:

### 5.1 Incoming Call Event

```json
{
  "type": "call_invitation",
  "data": {
    "callId": "uuid",
    "channelId": "string",
    "callerId": "string",
    "callerName": "string",
    "callerAvatar": "string",
    "callType": "audio|video",
    "timestamp": "2024-01-01T12:00:00Z"
  }
}
```

### 5.2 Call Accepted Event

```json
{
  "type": "call_accepted",
  "data": {
    "callId": "uuid",
    "acceptedBy": "string",
    "timestamp": "2024-01-01T12:00:00Z"
  }
}
```

### 5.3 Call Rejected Event

```json
{
  "type": "call_rejected",
  "data": {
    "callId": "uuid",
    "rejectedBy": "string",
    "reason": "busy|declined|unavailable",
    "timestamp": "2024-01-01T12:00:00Z"
  }
}
```

### 5.4 Call Ended Event

```json
{
  "type": "call_ended",
  "data": {
    "callId": "uuid",
    "endedBy": "string",
    "durationSeconds": 120,
    "timestamp": "2024-01-01T12:00:00Z"
  }
}
```

### 5.5 Call Timeout Event

```json
{
  "type": "call_timeout",
  "data": {
    "callId": "uuid",
    "timestamp": "2024-01-01T12:00:00Z"
  }
}
```

---

## 6. Database Schema Requirements

### 6.1 Calls Table

```sql
CREATE TABLE calls (
  id UUID PRIMARY KEY,
  channel_id VARCHAR(64) NOT NULL,
  caller_id VARCHAR(255) NOT NULL,
  callee_id VARCHAR(255) NOT NULL,
  call_type VARCHAR(10) NOT NULL CHECK (call_type IN ('audio', 'video')),
  status VARCHAR(20) NOT NULL CHECK (status IN ('initiating', 'ringing', 'connecting', 'connected', 'disconnecting', 'ended', 'missed', 'rejected', 'failed')),
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP,
  duration_seconds INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_caller_id (caller_id),
  INDEX idx_callee_id (callee_id),
  INDEX idx_status (status),
  INDEX idx_start_time (start_time)
);
```

### 6.2 Call Quality Metrics Table

```sql
CREATE TABLE call_quality_metrics (
  id UUID PRIMARY KEY,
  call_id UUID NOT NULL REFERENCES calls(id) ON DELETE CASCADE,
  user_id VARCHAR(255) NOT NULL,
  network_quality VARCHAR(20),
  packet_loss_rate DECIMAL(5,4),
  round_trip_time INTEGER,
  recorded_at TIMESTAMP NOT NULL,
  
  INDEX idx_call_id (call_id),
  INDEX idx_recorded_at (recorded_at)
);
```

---

## 7. Security & Authentication

### 7.1 Authentication Requirements

- Tất cả API endpoints PHẢI yêu cầu authentication token (JWT/Bearer token)
- Token phải được validate trước khi xử lý request
- User chỉ có thể truy cập dữ liệu của chính họ

### 7.2 Authorization Rules

- User chỉ có thể initiate call với contacts của họ
- User chỉ có thể accept/reject calls được gửi đến họ
- User chỉ có thể end calls mà họ tham gia
- User chỉ có thể xem call history của chính họ

### 7.3 Rate Limiting

- Token generation: 10 requests/minute per user
- Call initiation: 5 requests/minute per user
- Call history: 20 requests/minute per user

---

## 8. Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| `TOKEN_GENERATION_FAILED` | 500 | Không thể tạo Agora token |
| `TOKEN_REFRESH_FAILED` | 401 | Không thể refresh token |
| `USER_NOT_FOUND` | 404 | User không tồn tại |
| `INVALID_CALL_TYPE` | 400 | Call type không hợp lệ |
| `CALL_NOT_FOUND` | 404 | Cuộc gọi không tồn tại |
| `UNAUTHORIZED_ACCESS` | 403 | Không có quyền truy cập |
| `CALL_ALREADY_ENDED` | 400 | Cuộc gọi đã kết thúc |
| `USER_BUSY` | 409 | User đang trong cuộc gọi khác |
| `INVALID_CALL_STATUS` | 400 | Trạng thái cuộc gọi không hợp lệ |
| `RATE_LIMIT_EXCEEDED` | 429 | Vượt quá giới hạn request |

---

## 9. Environment Variables

Backend cần các environment variables sau:

```env
# Agora Configuration
AGORA_APP_ID=your_agora_app_id
AGORA_APP_CERTIFICATE=your_agora_app_certificate

# Token Configuration
AGORA_TOKEN_EXPIRATION_SECONDS=3600

# Call Configuration
CALL_TIMEOUT_SECONDS=60
MAX_CALL_DURATION_SECONDS=7200

# WebSocket Configuration
WEBSOCKET_URL=wss://your-backend.com/ws
```

---

## 10. Implementation Priority

### Phase 1 (Critical - MVP)
1. Generate RTC Token API
2. Initiate Call API
3. Accept/Reject Call APIs
4. End Call API
5. WebSocket Events (incoming call, accepted, rejected, ended)

### Phase 2 (Important)
6. Refresh RTC Token API
7. Get Call History API
8. Update Call Status API
9. Get Call Details API

### Phase 3 (Nice to have)
10. Report Call Quality API
11. Get Call Statistics API
12. Delete Call History API
13. Call Timeout handling

---

## 11. Testing Requirements

### 11.1 Unit Tests
- Test token generation với valid/invalid inputs
- Test call state transitions
- Test authorization logic

### 11.2 Integration Tests
- Test end-to-end call flow (initiate → accept → end)
- Test WebSocket event delivery
- Test concurrent calls handling

### 11.3 Load Tests
- Test token generation under load
- Test concurrent call initiations
- Test WebSocket scalability

---

## 12. Complete Call Flow Diagram

### Successful Video Call Flow

```
CALLER (User A)                    BACKEND                      CALLEE (User B)
    |                                 |                              |
    |--1. POST /calls/initiate------->|                              |
    |   {calleeId, callType: video}   |                              |
    |                                 |                              |
    |<--2. 200 OK---------------------|                              |
    |   {callId, channelId, status}   |                              |
    |                                 |                              |
    |                                 |--3. WS: call_invitation----->|
    |                                 |   {callId, caller info}      |
    |                                 |                              |
    |                                 |<--4. POST /calls/{id}/accept-|
    |                                 |   {userId}                   |
    |                                 |                              |
    |<--5. WS: call_accepted----------|                              |
    |   {callId, acceptedBy}          |                              |
    |                                 |                              |
    |--6. POST /agora/token/generate->|                              |
    |                                 |--7. POST /agora/token/gen--->|
    |<--8. {token, uid}---------------|<--9. {token, uid}------------|
    |                                 |                              |
    |--10. Join Agora Channel---------|-----Join Agora Channel------>|
    |   (using token)                 |     (using token)            |
    |                                 |                              |
    |--11. PATCH /calls/{id}/status-->|                              |
    |   {status: connected}           |                              |
    |                                 |--12. WS: status_updated----->|
    |                                 |                              |
    |<==============VIDEO/AUDIO STREAM ESTABLISHED==================>|
    |                                 |                              |
    |--13. POST /calls/{id}/quality-->|                              |
    |   (periodic quality reports)    |<--14. POST quality-----------|
    |                                 |                              |
    |--15. POST /calls/{id}/end------>|                              |
    |   {durationSeconds}             |                              |
    |                                 |--16. WS: call_ended--------->|
    |                                 |                              |
    |<--17. 200 OK--------------------|                              |
    |   {status: ended, duration}     |                              |
    |                                 |                              |
    |--18. Leave Agora Channel--------|-----Leave Agora Channel----->|
```

### Call Rejection Flow

```
CALLER (User A)                    BACKEND                      CALLEE (User B)
    |                                 |                              |
    |--1. POST /calls/initiate------->|                              |
    |                                 |--2. WS: call_invitation----->|
    |                                 |                              |
    |                                 |<--3. POST /calls/{id}/reject-|
    |                                 |   {reason: declined}         |
    |                                 |                              |
    |<--4. WS: call_rejected----------|                              |
    |   {callId, reason}              |                              |
    |                                 |                              |
    |                                 |--5. Save to call_history---->|
    |                                 |   (status: rejected)         |
```

### Call Timeout Flow

```
CALLER (User A)                    BACKEND                      CALLEE (User B)
    |                                 |                              |
    |--1. POST /calls/initiate------->|                              |
    |                                 |--2. WS: call_invitation----->|
    |                                 |   (User B không response)    |
    |                                 |                              |
    |         ... 60 seconds ...      |                              |
    |                                 |                              |
    |<--3. WS: call_timeout-----------|--4. WS: call_timeout-------->|
    |                                 |                              |
    |                                 |--5. Update status: missed--->|
    |                                 |                              |
    |                                 |--6. Save to call_history---->|
    |                                 |   (status: missed)           |
```

## 13. API Implementation Checklist

### Phase 1: MVP (Critical)
- [ ] **Token Management**
  - [ ] POST /api/v1/agora/token/generate
  - [ ] Implement Agora token generation logic
  - [ ] Add token logging for audit
  
- [ ] **Call Signaling**
  - [ ] POST /api/v1/calls/initiate
  - [ ] POST /api/v1/calls/{callId}/accept
  - [ ] POST /api/v1/calls/{callId}/reject
  - [ ] POST /api/v1/calls/{callId}/end
  - [ ] Implement call timeout mechanism (60s)
  
- [ ] **WebSocket Events**
  - [ ] call_invitation event
  - [ ] call_accepted event
  - [ ] call_rejected event
  - [ ] call_ended event
  - [ ] call_timeout event
  
- [ ] **Database**
  - [ ] Create calls table
  - [ ] Create call_history table
  - [ ] Add indexes for performance

### Phase 2: Important Features
- [ ] **Token Management**
  - [ ] POST /api/v1/agora/token/refresh
  - [ ] Implement token expiration handling
  
- [ ] **Call Management**
  - [ ] PATCH /api/v1/calls/{callId}/status
  - [ ] Implement status transition validation
  
- [ ] **Call History**
  - [ ] GET /api/v1/calls/history
  - [ ] GET /api/v1/calls/{callId}
  - [ ] Implement pagination
  - [ ] Add filtering by type/status

### Phase 3: Analytics & Optimization
- [ ] **Quality Monitoring**
  - [ ] POST /api/v1/calls/{callId}/quality
  - [ ] GET /api/v1/calls/statistics
  - [ ] Create call_quality_metrics table
  - [ ] Implement quality alerts
  
- [ ] **Advanced Features**
  - [ ] DELETE /api/v1/calls/history/{callId}
  - [ ] Implement Redis caching for active calls
  - [ ] Add rate limiting
  - [ ] Implement push notifications

## 14. Key Implementation Notes

### Token Generation
```typescript
// Sử dụng Agora SDK để generate token
import { RtcTokenBuilder, RtcRole } from 'agora-access-token';

const token = RtcTokenBuilder.buildTokenWithUid(
  appId,           // From environment
  appCertificate,  // From environment
  channelName,     // Channel ID
  uid,             // User UID (integer)
  role,            // Publisher = 1, Subscriber = 2
  privilegeExpiredTs // Current timestamp + expiration seconds
);
```

### WebSocket Message Format
```typescript
// Tất cả WebSocket messages phải follow format này
interface WebSocketMessage {
  type: string;           // Event type
  data: any;              // Event data
  timestamp?: string;     // ISO 8601 timestamp
}

// Example
await sendWebSocketMessage(userId, {
  type: 'call_invitation',
  data: {
    callId: 'uuid',
    callerId: 'user123',
    callerName: 'John Doe',
    callType: 'video'
  },
  timestamp: new Date().toISOString()
});
```

### Call Status State Machine
```
initiating → ringing → connecting → connected → disconnecting → ended
                ↓           ↓
            rejected    failed
                ↓
            missed (timeout)
```

### Database Indexes
```sql
-- Critical indexes for performance
CREATE INDEX idx_calls_caller_id ON calls(caller_id);
CREATE INDEX idx_calls_callee_id ON calls(callee_id);
CREATE INDEX idx_calls_status ON calls(status);
CREATE INDEX idx_calls_channel_id ON calls(channel_id);
CREATE INDEX idx_call_history_user_id ON call_history(user_id);
CREATE INDEX idx_call_history_timestamp ON call_history(timestamp DESC);
```

### Error Handling Pattern
```typescript
// Tất cả API endpoints phải follow error handling pattern này
try {
  // Business logic
  return res.status(200).json({ success: true, data: result });
} catch (error) {
  console.error("Operation failed:", error);
  
  // Log to monitoring service (Sentry, DataDog, etc.)
  logger.error({
    operation: 'operation_name',
    error: error.message,
    stack: error.stack,
    userId: req.user?.id,
    requestId: req.id
  });
  
  return res.status(500).json({
    success: false,
    error: {
      code: 'OPERATION_FAILED',
      message: 'User-friendly error message',
      requestId: req.id // For support debugging
    }
  });
}
```

## Tổng kết

Backend cần implement:
- **5 nhóm API chính**: Token Management, Call Signaling, Call History, Quality Analytics, và WebSocket Events
- **13 REST endpoints** để quản lý cuộc gọi
- **5 WebSocket events** để real-time signaling
- **3 database tables** để lưu trữ call data, history và quality metrics
- **Security & rate limiting** để bảo vệ hệ thống
- **Complete error handling** với logging và monitoring

**Ưu tiên implementation**:
1. **Phase 1 (MVP)**: Token generation + Call signaling + WebSocket events
2. **Phase 2**: Token refresh + Call history + Status management
3. **Phase 3**: Quality monitoring + Statistics + Advanced features

**Estimated Development Time**:
- Phase 1: 2-3 weeks (MVP functional)
- Phase 2: 1-2 weeks (Production ready)
- Phase 3: 1-2 weeks (Full featured)

**Testing Requirements**:
- Unit tests cho tất cả business logic
- Integration tests cho call flows
- Load tests cho concurrent calls
- WebSocket connection stability tests
