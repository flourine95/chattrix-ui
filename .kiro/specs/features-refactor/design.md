# Design Document - Remaining Features Refactor

## 1. Overview

This document outlines the technical design for refactoring all remaining features (Call, Chat, Contacts, Notes, Profile) to align with the Clean Architecture template established in the auth refactor. This ensures consistency, maintainability, and eliminates code duplication across the entire codebase.

### 1.1. Goals

- **Consistency**: All features follow the same Clean Architecture pattern
- **Code Reduction**: Implement BaseRepository to reduce repository code by ~60%
- **Modern Dependencies**: Complete migration from dartz to fpdart
- **Explicit Separation**: Clear DTOs, Entities, and Mappers for all features
- **Error Handling**: Consistent 7-type Failure system across all features
- **Maintainability**: Easy to understand, test, and extend

### 1.2. Features to Refactor

1. **Profile Feature** (6 errors) - User profile management, reuses auth User entity
2. **Notes Feature** - Personal notes CRUD operations
3. **Contacts Feature** (48 errors) - Friend management and contact lists
4. **Call Feature** (16 errors) - Voice/video calling with Agora
5. **Chat Feature** (26 errors) - Messaging with text, media, voice

**Total**: 96 errors to resolve

### 1.3. Architecture Overview

All features will follow this layered architecture:

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                        │
│  - Providers (Riverpod 3 with @riverpod)                    │
│  - UI Widgets (HookConsumerWidget)                          │
│  - Exception Mapping (7 types)                              │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                     DOMAIN LAYER                             │
│  - Entities (Framework-agnostic, proper Dart types)         │
│  - Repository Interfaces (Either<Failure, T>)               │
│  - Use Cases (Business logic with fpdart)                   │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                      DATA LAYER                              │
│  - DTOs (API JSON structure)                                │
│  - Mappers (DTO ↔ Entity conversion)                        │
│  - API Services (Dio)                                        │
│  - Repository Implementations (extends BaseRepository)       │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Core Infrastructure (Already Complete)

The following core infrastructure was created during the auth refactor and will be reused:

### 2.1. BaseRepository
**File**: `lib/core/repositories/base_repository.dart` ✅

Provides centralized error handling with `executeApiCall<T>()` wrapper.

### 2.2. Failure Types
**File**: `lib/core/errors/failures.dart` ✅

7 standardized failure types:
- `server` - Server errors
- `network` - Network connectivity issues
- `validation` - Input validation with field details
- `auth` - Authentication/authorization errors
- `notFound` - Resource not found
- `conflict` - Resource conflicts
- `rateLimit` - Rate limiting

### 2.3. Exception Types
**File**: `lib/core/errors/exceptions.dart` ✅

- `ApiException` - Thrown by interceptor
- `ServerException` - Server errors
- `NetworkException` - Network errors

### 2.4. API Response Wrapper
**File**: `lib/core/network/api_response.dart` ✅

Generic wrapper for all API responses.

### 2.5. API Interceptor
**File**: `lib/core/network/api_interceptor.dart` ✅

Parses error responses and throws ApiException.

---

## 3. Feature-Specific Designs


### 3.1. Profile Feature Design

**Priority**: 1 (Simplest, reuses auth components)

#### 3.1.1. Data Layer

**DTOs**: Reuse from auth feature
- `UserDto` from `lib/features/auth/data/models/user_dto.dart` ✅

**Mappers**: Reuse from auth feature
- `UserMapper` from `lib/features/auth/data/mappers/user_mapper.dart` ✅

**Repository Implementation**:
```dart
// lib/features/profile/data/repositories/profile_repository_impl.dart
class ProfileRepositoryImpl extends BaseRepository implements ProfileRepository {
  final ProfileApiService _apiService;
  
  ProfileRepositoryImpl(this._apiService);
  
  @override
  Future<Either<Failure, User>> getProfile(int userId) async {
    return executeApiCall(() async {
      final response = await _apiService.getProfile(userId);
      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }
      throw ApiException(
        message: response.message,
        code: 'PROFILE_ERROR',
        statusCode: 500,
      );
    });
  }
  
  @override
  Future<Either<Failure, User>> updateProfile({
    required int userId,
    String? fullName,
    String? bio,
    // ... other fields
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.updateProfile(
        userId: userId,
        fullName: fullName,
        bio: bio,
      );
      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }
      throw ApiException(
        message: response.message,
        code: 'UPDATE_PROFILE_ERROR',
        statusCode: 500,
      );
    });
  }
}
```

#### 3.1.2. Domain Layer

**Entities**: Reuse from auth feature
- `User` from `lib/features/auth/domain/entities/user.dart` ✅

**Repository Interface**:
```dart
// lib/features/profile/domain/repositories/profile_repository.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/domain/entities/user.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getProfile(int userId);
  Future<Either<Failure, User>> updateProfile({
    required int userId,
    String? fullName,
    String? bio,
    String? phone,
    String? gender,
    String? dateOfBirth,
    String? location,
    String? profileVisibility,
  });
  Future<Either<Failure, String>> uploadAvatar({
    required int userId,
    required String filePath,
  });
}
```

**Use Cases**: Update to use fpdart
- `GetProfileUseCase`
- `UpdateProfileUseCase`
- `UploadAvatarUseCase`

#### 3.1.3. Presentation Layer

**Providers**: Update exception mapping to 7 types
```dart
Exception _mapFailureToException(Failure failure) {
  return failure.when(
    server: (message, code, requestId) => ServerException(message),
    network: (message, code) => NetworkException(message),
    validation: (message, code, details, requestId) => 
        ValidationException(message, details),
    auth: (message, code, requestId) => AuthException(message),
    notFound: (message, code, requestId) => NotFoundException(message),
    conflict: (message, code, requestId) => ConflictException(message),
    rateLimit: (message, code, requestId) => RateLimitException(message),
  );
}
```

---

### 3.2. Notes Feature Design

**Priority**: 2 (Simple CRUD operations)

#### 3.2.1. Data Layer

**DTOs**:
```dart
// lib/features/notes/data/models/note_dto.dart
@freezed
class NoteDto with _$NoteDto {
  const factory NoteDto({
    required int id,
    required int userId,
    required String title,
    required String content,
    String? tags,  // Comma-separated string from API
    required String createdAt,  // ISO string
    String? updatedAt,  // ISO string
  }) = _NoteDto;

  factory NoteDto.fromJson(Map<String, dynamic> json) =>
      _$NoteDtoFromJson(json);
}
```

**Mappers**:
```dart
// lib/features/notes/data/mappers/note_mapper.dart
extension NoteDtoMapper on NoteDto {
  Note toEntity() {
    return Note(
      id: id,
      userId: userId,
      title: title,
      content: content,
      tags: tags?.split(',').map((e) => e.trim()).toList() ?? [],
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
    );
  }
}

extension NoteEntityMapper on Note {
  NoteDto toDto() {
    return NoteDto(
      id: id,
      userId: userId,
      title: title,
      content: content,
      tags: tags.join(','),
      createdAt: createdAt.toIso8601String(),
      updatedAt: updatedAt?.toIso8601String(),
    );
  }
}
```

**Repository Implementation**:
```dart
// lib/features/notes/data/repositories/notes_repository_impl.dart
class NotesRepositoryImpl extends BaseRepository implements NotesRepository {
  final NotesApiService _apiService;
  
  NotesRepositoryImpl(this._apiService);
  
  @override
  Future<Either<Failure, List<Note>>> getNotes(int userId) async {
    return executeApiCall(() async {
      final response = await _apiService.getNotes(userId);
      if (response.success && response.data != null) {
        return response.data!.map((dto) => dto.toEntity()).toList();
      }
      throw ApiException(
        message: response.message,
        code: 'GET_NOTES_ERROR',
        statusCode: 500,
      );
    });
  }
  
  @override
  Future<Either<Failure, Note>> createNote({
    required int userId,
    required String title,
    required String content,
    List<String>? tags,
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.createNote(
        userId: userId,
        title: title,
        content: content,
        tags: tags?.join(','),
      );
      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }
      throw ApiException(
        message: response.message,
        code: 'CREATE_NOTE_ERROR',
        statusCode: 500,
      );
    });
  }
}
```

#### 3.2.2. Domain Layer

**Entities**:
```dart
// lib/features/notes/domain/entities/note.dart
@freezed
class Note with _$Note {
  const factory Note({
    required int id,
    required int userId,
    required String title,
    required String content,
    required List<String> tags,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Note;
}
```

**Use Cases**: Update to use fpdart
- `GetNotesUseCase`
- `CreateNoteUseCase`
- `UpdateNoteUseCase`
- `DeleteNoteUseCase`

---


### 3.3. Contacts Feature Design

**Priority**: 3 (Medium complexity, friend management)

#### 3.3.1. Data Layer

**DTOs**:
```dart
// lib/features/contacts/data/models/contact_dto.dart
@freezed
class ContactDto with _$ContactDto {
  const factory ContactDto({
    required int id,
    required int userId,
    required int contactUserId,
    required String status,  // "PENDING", "ACCEPTED", "BLOCKED"
    required String createdAt,
    String? updatedAt,
  }) = _ContactDto;

  factory ContactDto.fromJson(Map<String, dynamic> json) =>
      _$ContactDtoFromJson(json);
}

// lib/features/contacts/data/models/friend_request_dto.dart
@freezed
class FriendRequestDto with _$FriendRequestDto {
  const factory FriendRequestDto({
    required int id,
    required int senderId,
    required int receiverId,
    required String status,  // "PENDING", "ACCEPTED", "REJECTED"
    required String createdAt,
    String? respondedAt,
  }) = _FriendRequestDto;

  factory FriendRequestDto.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestDtoFromJson(json);
}
```

**Mappers**:
```dart
// lib/features/contacts/data/mappers/contact_mapper.dart
extension ContactDtoMapper on ContactDto {
  Contact toEntity() {
    return Contact(
      id: id,
      userId: userId,
      contactUserId: contactUserId,
      status: _parseContactStatus(status),
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
    );
  }

  ContactStatus _parseContactStatus(String value) {
    switch (value.toUpperCase()) {
      case 'PENDING':
        return ContactStatus.pending;
      case 'ACCEPTED':
        return ContactStatus.accepted;
      case 'BLOCKED':
        return ContactStatus.blocked;
      default:
        return ContactStatus.pending;
    }
  }
}

extension FriendRequestDtoMapper on FriendRequestDto {
  FriendRequest toEntity() {
    return FriendRequest(
      id: id,
      senderId: senderId,
      receiverId: receiverId,
      status: _parseFriendRequestStatus(status),
      createdAt: DateTime.parse(createdAt),
      respondedAt: respondedAt != null ? DateTime.parse(respondedAt!) : null,
    );
  }

  FriendRequestStatus _parseFriendRequestStatus(String value) {
    switch (value.toUpperCase()) {
      case 'PENDING':
        return FriendRequestStatus.pending;
      case 'ACCEPTED':
        return FriendRequestStatus.accepted;
      case 'REJECTED':
        return FriendRequestStatus.rejected;
      default:
        return FriendRequestStatus.pending;
    }
  }
}
```

**Repository Implementation**:
```dart
// lib/features/contacts/data/repositories/contacts_repository_impl.dart
class ContactsRepositoryImpl extends BaseRepository implements ContactsRepository {
  final ContactsApiService _apiService;
  
  ContactsRepositoryImpl(this._apiService);
  
  @override
  Future<Either<Failure, List<Contact>>> getContacts(int userId) async {
    return executeApiCall(() async {
      final response = await _apiService.getContacts(userId);
      if (response.success && response.data != null) {
        return response.data!.map((dto) => dto.toEntity()).toList();
      }
      throw ApiException(
        message: response.message,
        code: 'GET_CONTACTS_ERROR',
        statusCode: 500,
      );
    });
  }
  
  @override
  Future<Either<Failure, FriendRequest>> sendFriendRequest({
    required int senderId,
    required int receiverId,
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.sendFriendRequest(
        senderId: senderId,
        receiverId: receiverId,
      );
      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }
      throw ApiException(
        message: response.message,
        code: 'SEND_FRIEND_REQUEST_ERROR',
        statusCode: 500,
      );
    });
  }
}
```

#### 3.3.2. Domain Layer

**Entities**:
```dart
// lib/features/contacts/domain/entities/contact.dart
@freezed
class Contact with _$Contact {
  const factory Contact({
    required int id,
    required int userId,
    required int contactUserId,
    required ContactStatus status,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Contact;
}

enum ContactStatus {
  pending,
  accepted,
  blocked,
}

// lib/features/contacts/domain/entities/friend_request.dart
@freezed
class FriendRequest with _$FriendRequest {
  const factory FriendRequest({
    required int id,
    required int senderId,
    required int receiverId,
    required FriendRequestStatus status,
    required DateTime createdAt,
    DateTime? respondedAt,
  }) = _FriendRequest;
}

enum FriendRequestStatus {
  pending,
  accepted,
  rejected,
}
```

**Use Cases**: Update to use fpdart
- `GetContactsUseCase`
- `SendFriendRequestUseCase`
- `AcceptFriendRequestUseCase`
- `RejectFriendRequestUseCase`
- `RemoveContactUseCase`
- `BlockContactUseCase`

---

### 3.4. Call Feature Design

**Priority**: 4 (Real-time communication with Agora)

#### 3.4.1. Data Layer

**DTOs**:
```dart
// lib/features/call/data/models/call_dto.dart
@freezed
class CallDto with _$CallDto {
  const factory CallDto({
    required int id,
    required int callerId,
    required int receiverId,
    required String callType,  // "VOICE", "VIDEO"
    required String status,  // "INITIATED", "RINGING", "ONGOING", "ENDED", "MISSED", "REJECTED"
    String? channelName,
    String? agoraToken,
    required String createdAt,
    String? startedAt,
    String? endedAt,
    int? duration,  // seconds
  }) = _CallDto;

  factory CallDto.fromJson(Map<String, dynamic> json) =>
      _$CallDtoFromJson(json);
}

// lib/features/call/data/models/call_participant_dto.dart
@freezed
class CallParticipantDto with _$CallParticipantDto {
  const factory CallParticipantDto({
    required int id,
    required int callId,
    required int userId,
    required String role,  // "CALLER", "RECEIVER"
    required String status,  // "JOINED", "LEFT"
    required String joinedAt,
    String? leftAt,
  }) = _CallParticipantDto;

  factory CallParticipantDto.fromJson(Map<String, dynamic> json) =>
      _$CallParticipantDtoFromJson(json);
}
```

**Mappers**:
```dart
// lib/features/call/data/mappers/call_mapper.dart
extension CallDtoMapper on CallDto {
  Call toEntity() {
    return Call(
      id: id,
      callerId: callerId,
      receiverId: receiverId,
      callType: _parseCallType(callType),
      status: _parseCallStatus(status),
      channelName: channelName,
      agoraToken: agoraToken,
      createdAt: DateTime.parse(createdAt),
      startedAt: startedAt != null ? DateTime.parse(startedAt!) : null,
      endedAt: endedAt != null ? DateTime.parse(endedAt!) : null,
      duration: duration,
    );
  }

  CallType _parseCallType(String value) {
    switch (value.toUpperCase()) {
      case 'VOICE':
        return CallType.voice;
      case 'VIDEO':
        return CallType.video;
      default:
        return CallType.voice;
    }
  }

  CallStatus _parseCallStatus(String value) {
    switch (value.toUpperCase()) {
      case 'INITIATED':
        return CallStatus.initiated;
      case 'RINGING':
        return CallStatus.ringing;
      case 'ONGOING':
        return CallStatus.ongoing;
      case 'ENDED':
        return CallStatus.ended;
      case 'MISSED':
        return CallStatus.missed;
      case 'REJECTED':
        return CallStatus.rejected;
      default:
        return CallStatus.initiated;
    }
  }
}
```

**Repository Implementation**:
```dart
// lib/features/call/data/repositories/call_repository_impl.dart
class CallRepositoryImpl extends BaseRepository implements CallRepository {
  final CallApiService _apiService;
  
  CallRepositoryImpl(this._apiService);
  
  @override
  Future<Either<Failure, Call>> initiateCall({
    required int callerId,
    required int receiverId,
    required CallType callType,
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.initiateCall(
        callerId: callerId,
        receiverId: receiverId,
        callType: callType.name.toUpperCase(),
      );
      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }
      throw ApiException(
        message: response.message,
        code: 'INITIATE_CALL_ERROR',
        statusCode: 500,
      );
    });
  }
  
  @override
  Future<Either<Failure, Call>> answerCall(int callId) async {
    return executeApiCall(() async {
      final response = await _apiService.answerCall(callId);
      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }
      throw ApiException(
        message: response.message,
        code: 'ANSWER_CALL_ERROR',
        statusCode: 500,
      );
    });
  }
}
```

#### 3.4.2. Domain Layer

**Entities**:
```dart
// lib/features/call/domain/entities/call.dart
@freezed
class Call with _$Call {
  const factory Call({
    required int id,
    required int callerId,
    required int receiverId,
    required CallType callType,
    required CallStatus status,
    String? channelName,
    String? agoraToken,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? endedAt,
    int? duration,
  }) = _Call;
}

enum CallType {
  voice,
  video,
}

enum CallStatus {
  initiated,
  ringing,
  ongoing,
  ended,
  missed,
  rejected,
}
```

**Use Cases**: Update to use fpdart
- `InitiateCallUseCase`
- `AnswerCallUseCase`
- `EndCallUseCase`
- `RejectCallUseCase`
- `GetCallHistoryUseCase`

---


### 3.5. Chat Feature Design

**Priority**: 5 (Most complex, multiple DTOs, media handling)

#### 3.5.1. Data Layer

**DTOs**:
```dart
// lib/features/chat/data/models/message_dto.dart
@freezed
class MessageDto with _$MessageDto {
  const factory MessageDto({
    required int id,
    required int conversationId,
    required int senderId,
    required String messageType,  // "TEXT", "IMAGE", "VIDEO", "VOICE", "FILE"
    String? content,  // For text messages
    String? mediaUrl,  // For media messages
    String? thumbnailUrl,  // For video messages
    int? duration,  // For voice/video messages (seconds)
    int? fileSize,  // For file messages (bytes)
    String? fileName,  // For file messages
    String? replyToMessageId,  // For reply messages
    required String status,  // "SENT", "DELIVERED", "READ", "FAILED"
    required String createdAt,
    String? updatedAt,
    String? deletedAt,
  }) = _MessageDto;

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);
}

// lib/features/chat/data/models/conversation_dto.dart
@freezed
class ConversationDto with _$ConversationDto {
  const factory ConversationDto({
    required int id,
    required String conversationType,  // "DIRECT", "GROUP"
    String? name,  // For group conversations
    String? avatarUrl,  // For group conversations
    required List<int> participantIds,
    int? lastMessageId,
    String? lastMessageContent,
    String? lastMessageTime,
    int? unreadCount,
    required String createdAt,
    String? updatedAt,
  }) = _ConversationDto;

  factory ConversationDto.fromJson(Map<String, dynamic> json) =>
      _$ConversationDtoFromJson(json);
}

// lib/features/chat/data/models/search_user_dto.dart
@freezed
class SearchUserDto with _$SearchUserDto {
  const factory SearchUserDto({
    required int id,
    required String username,
    required String fullName,
    String? avatarUrl,
    required bool online,
  }) = _SearchUserDto;

  factory SearchUserDto.fromJson(Map<String, dynamic> json) =>
      _$SearchUserDtoFromJson(json);
}
```

**Mappers**:
```dart
// lib/features/chat/data/mappers/message_mapper.dart
extension MessageDtoMapper on MessageDto {
  Message toEntity() {
    return Message(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      messageType: _parseMessageType(messageType),
      content: content,
      mediaUrl: mediaUrl,
      thumbnailUrl: thumbnailUrl,
      duration: duration,
      fileSize: fileSize,
      fileName: fileName,
      replyToMessageId: replyToMessageId != null 
          ? int.tryParse(replyToMessageId!) 
          : null,
      status: _parseMessageStatus(status),
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
      deletedAt: deletedAt != null ? DateTime.parse(deletedAt!) : null,
    );
  }

  MessageType _parseMessageType(String value) {
    switch (value.toUpperCase()) {
      case 'TEXT':
        return MessageType.text;
      case 'IMAGE':
        return MessageType.image;
      case 'VIDEO':
        return MessageType.video;
      case 'VOICE':
        return MessageType.voice;
      case 'FILE':
        return MessageType.file;
      default:
        return MessageType.text;
    }
  }

  MessageStatus _parseMessageStatus(String value) {
    switch (value.toUpperCase()) {
      case 'SENT':
        return MessageStatus.sent;
      case 'DELIVERED':
        return MessageStatus.delivered;
      case 'READ':
        return MessageStatus.read;
      case 'FAILED':
        return MessageStatus.failed;
      default:
        return MessageStatus.sent;
    }
  }
}

// lib/features/chat/data/mappers/conversation_mapper.dart
extension ConversationDtoMapper on ConversationDto {
  Conversation toEntity() {
    return Conversation(
      id: id,
      conversationType: _parseConversationType(conversationType),
      name: name,
      avatarUrl: avatarUrl,
      participantIds: participantIds,
      lastMessageId: lastMessageId,
      lastMessageContent: lastMessageContent,
      lastMessageTime: lastMessageTime != null 
          ? DateTime.parse(lastMessageTime!) 
          : null,
      unreadCount: unreadCount ?? 0,
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
    );
  }

  ConversationType _parseConversationType(String value) {
    switch (value.toUpperCase()) {
      case 'DIRECT':
        return ConversationType.direct;
      case 'GROUP':
        return ConversationType.group;
      default:
        return ConversationType.direct;
    }
  }
}

// lib/features/chat/data/mappers/search_user_mapper.dart
extension SearchUserDtoMapper on SearchUserDto {
  SearchUser toEntity() {
    return SearchUser(
      id: id,
      username: username,
      fullName: fullName,
      avatarUrl: avatarUrl,
      online: online,
    );
  }
}
```

**Repository Implementation**:
```dart
// lib/features/chat/data/repositories/chat_repository_impl.dart
class ChatRepositoryImpl extends BaseRepository implements ChatRepository {
  final ChatApiService _apiService;
  
  ChatRepositoryImpl(this._apiService);
  
  @override
  Future<Either<Failure, List<Conversation>>> getConversations(int userId) async {
    return executeApiCall(() async {
      final response = await _apiService.getConversations(userId);
      if (response.success && response.data != null) {
        return response.data!.map((dto) => dto.toEntity()).toList();
      }
      throw ApiException(
        message: response.message,
        code: 'GET_CONVERSATIONS_ERROR',
        statusCode: 500,
      );
    });
  }
  
  @override
  Future<Either<Failure, List<Message>>> getMessages({
    required int conversationId,
    int? limit,
    int? offset,
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.getMessages(
        conversationId: conversationId,
        limit: limit,
        offset: offset,
      );
      if (response.success && response.data != null) {
        return response.data!.map((dto) => dto.toEntity()).toList();
      }
      throw ApiException(
        message: response.message,
        code: 'GET_MESSAGES_ERROR',
        statusCode: 500,
      );
    });
  }
  
  @override
  Future<Either<Failure, Message>> sendMessage({
    required int conversationId,
    required int senderId,
    required MessageType messageType,
    String? content,
    String? mediaUrl,
  }) async {
    return executeApiCall(() async {
      final response = await _apiService.sendMessage(
        conversationId: conversationId,
        senderId: senderId,
        messageType: messageType.name.toUpperCase(),
        content: content,
        mediaUrl: mediaUrl,
      );
      if (response.success && response.data != null) {
        return response.data!.toEntity();
      }
      throw ApiException(
        message: response.message,
        code: 'SEND_MESSAGE_ERROR',
        statusCode: 500,
      );
    });
  }
  
  @override
  Future<Either<Failure, List<SearchUser>>> searchUsers(String query) async {
    return executeApiCall(() async {
      final response = await _apiService.searchUsers(query);
      if (response.success && response.data != null) {
        return response.data!.map((dto) => dto.toEntity()).toList();
      }
      throw ApiException(
        message: response.message,
        code: 'SEARCH_USERS_ERROR',
        statusCode: 500,
      );
    });
  }
}
```

#### 3.5.2. Domain Layer

**Entities**:
```dart
// lib/features/chat/domain/entities/message.dart
@freezed
class Message with _$Message {
  const factory Message({
    required int id,
    required int conversationId,
    required int senderId,
    required MessageType messageType,
    String? content,
    String? mediaUrl,
    String? thumbnailUrl,
    int? duration,
    int? fileSize,
    String? fileName,
    int? replyToMessageId,
    required MessageStatus status,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) = _Message;
}

enum MessageType {
  text,
  image,
  video,
  voice,
  file,
}

enum MessageStatus {
  sent,
  delivered,
  read,
  failed,
}

// lib/features/chat/domain/entities/conversation.dart
@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required int id,
    required ConversationType conversationType,
    String? name,
    String? avatarUrl,
    required List<int> participantIds,
    int? lastMessageId,
    String? lastMessageContent,
    DateTime? lastMessageTime,
    required int unreadCount,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Conversation;
}

enum ConversationType {
  direct,
  group,
}

// lib/features/chat/domain/entities/search_user.dart
@freezed
class SearchUser with _$SearchUser {
  const factory SearchUser({
    required int id,
    required String username,
    required String fullName,
    String? avatarUrl,
    required bool online,
  }) = _SearchUser;
}
```

**Use Cases**: Update to use fpdart
- `GetConversationsUseCase`
- `GetMessagesUseCase`
- `SendMessageUseCase`
- `SendImageMessageUseCase`
- `SendVoiceMessageUseCase`
- `SendVideoMessageUseCase`
- `MarkMessageAsReadUseCase`
- `DeleteMessageUseCase`
- `SearchUsersUseCase`
- `CreateConversationUseCase`

---

## 4. Presentation Layer Updates

### 4.1. Exception Mapping (All Features)

All providers must map the 7 Failure types to 7 Exception types:

```dart
Exception _mapFailureToException(Failure failure) {
  return failure.when(
    server: (message, code, requestId) => ServerException(message),
    network: (message, code) => NetworkException(message),
    validation: (message, code, details, requestId) => 
        ValidationException(message, details),
    auth: (message, code, requestId) => AuthException(message),
    notFound: (message, code, requestId) => NotFoundException(message),
    conflict: (message, code, requestId) => ConflictException(message),
    rateLimit: (message, code, requestId) => RateLimitException(message),
  );
}
```

### 4.2. Custom Exceptions for UI

```dart
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String>? details;
  ValidationException(this.message, [this.details]);
  
  @override
  String toString() {
    if (details != null && details!.isNotEmpty) {
      return details!.values.join(', ');
    }
    return message;
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
  @override
  String toString() => message;
}

class ConflictException implements Exception {
  final String message;
  ConflictException(this.message);
  @override
  String toString() => message;
}

class RateLimitException implements Exception {
  final String message;
  RateLimitException(this.message);
  @override
  String toString() => message;
}
```

### 4.3. UI Error Handling Pattern

```dart
Widget _buildError(BuildContext context, Object error) {
  String message = 'An error occurred';
  String? details;

  if (error is ValidationException) {
    message = error.message;
    if (error.details != null) {
      details = error.details!.entries
          .map((e) => '${e.key}: ${e.value}')
          .join('\n');
    }
  } else if (error is AuthException) {
    message = error.message;
    // Navigate to login
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.go('/login');
      }
    });
  } else if (error is NetworkException) {
    message = error.message;
  } else if (error is ConflictException) {
    message = error.message;
  } else if (error is RateLimitException) {
    message = error.message;
  } else if (error is NotFoundException) {
    message = error.message;
  } else if (error is ServerException) {
    message = error.message;
  }

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 48, color: Colors.red),
        const SizedBox(height: 16),
        Text(message, style: const TextStyle(fontSize: 16)),
        if (details != null) ...[
          const SizedBox(height: 8),
          Text(
            details,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    ),
  );
}
```

---


## 5. Migration Strategy

### 5.1. Phase-by-Phase Approach

Each feature will be refactored in phases to minimize risk:

**Phase 1: Data Layer**
1. Rename `*_model.dart` → `*_dto.dart`
2. Create mappers in `data/mappers/`
3. Update repository to extend BaseRepository
4. Use `executeApiCall()` wrapper
5. Remove manual try-catch blocks
6. Run code generation

**Phase 2: Domain Layer**
1. Update entities (remove `abstract class` if single factory)
2. Update repository interface (dartz → fpdart)
3. Update all usecases (dartz → fpdart)
4. Run code generation

**Phase 3: Presentation Layer**
1. Update providers to use 7 exception types
2. Update UI error handling
3. Test all feature flows

**Phase 4: Verification**
1. Run all tests
2. Manual testing
3. Fix any issues
4. Code review

### 5.2. Feature Order

1. **Profile** (1 day) - Simplest, reuses auth components
2. **Notes** (1 day) - Simple CRUD
3. **Contacts** (2 days) - Medium complexity
4. **Call** (2 days) - Real-time features
5. **Chat** (3 days) - Most complex

**Total**: ~9 days implementation + 2 days testing = 11 days

---

## 6. Testing Strategy

### 6.1. Unit Tests

**Repository Tests**:
```dart
test('should return entity when API call succeeds', () async {
  // Arrange
  when(mockApiService.method()).thenAnswer((_) async => mockResponse);
  
  // Act
  final result = await repository.method();
  
  // Assert
  expect(result.isRight(), true);
  result.fold(
    (failure) => fail('Should not fail'),
    (entity) => expect(entity, expectedEntity),
  );
});

test('should return ValidationFailure when API returns 400', () async {
  // Arrange
  when(mockApiService.method()).thenThrow(
    ApiException(
      code: 'VALIDATION_ERROR',
      message: 'Validation failed',
      statusCode: 400,
      details: {'field': 'error message'},
    ),
  );
  
  // Act
  final result = await repository.method();
  
  // Assert
  expect(result.isLeft(), true);
  result.fold(
    (failure) {
      expect(failure, isA<ValidationFailure>());
      expect(failure.code, 'VALIDATION_ERROR');
    },
    (entity) => fail('Should not succeed'),
  );
});
```

**Mapper Tests**:
```dart
test('should convert DTO to Entity correctly', () {
  // Arrange
  final dto = MessageDto(
    id: 1,
    conversationId: 1,
    senderId: 1,
    messageType: 'TEXT',
    content: 'Hello',
    status: 'SENT',
    createdAt: '2025-01-01T00:00:00Z',
  );
  
  // Act
  final entity = dto.toEntity();
  
  // Assert
  expect(entity.id, 1);
  expect(entity.messageType, MessageType.text);
  expect(entity.status, MessageStatus.sent);
  expect(entity.createdAt, DateTime.parse('2025-01-01T00:00:00Z'));
});

test('should handle nullable fields correctly', () {
  // Arrange
  final dto = MessageDto(
    id: 1,
    conversationId: 1,
    senderId: 1,
    messageType: 'TEXT',
    status: 'SENT',
    createdAt: '2025-01-01T00:00:00Z',
    // content, mediaUrl, etc. are null
  );
  
  // Act
  final entity = dto.toEntity();
  
  // Assert
  expect(entity.content, null);
  expect(entity.mediaUrl, null);
});
```

### 6.2. Integration Tests

**Feature Flow Tests**:
```dart
test('should complete send message flow successfully', () async {
  // Arrange
  final container = ProviderContainer(
    overrides: [
      chatRepositoryProvider.overrideWithValue(mockRepository),
    ],
  );
  
  when(mockRepository.sendMessage(
    conversationId: 1,
    senderId: 1,
    messageType: MessageType.text,
    content: 'Hello',
  )).thenAnswer((_) async => right(mockMessage));
  
  // Act
  await container.read(chatProvider.notifier).sendMessage(
    conversationId: 1,
    senderId: 1,
    messageType: MessageType.text,
    content: 'Hello',
  );
  
  // Assert
  final state = container.read(chatProvider);
  expect(state.hasValue, true);
  expect(state.value!.messages.length, 1);
});
```

---

## 7. File Structure

```
lib/
├── core/
│   ├── errors/
│   │   ├── failures.dart ✅
│   │   └── exceptions.dart ✅
│   ├── network/
│   │   ├── api_response.dart ✅
│   │   └── api_interceptor.dart ✅
│   └── repositories/
│       └── base_repository.dart ✅
│
└── features/
    ├── profile/
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── profile_api_service.dart
    │   │   └── repositories/
    │   │       └── profile_repository_impl.dart (extends BaseRepository)
    │   ├── domain/
    │   │   ├── entities/ (reuse auth User entity)
    │   │   ├── repositories/
    │   │   │   └── profile_repository.dart (uses fpdart)
    │   │   └── usecases/
    │   │       └── ... (use fpdart)
    │   └── presentation/
    │       └── providers/
    │           └── ... (7 exception types)
    │
    ├── notes/
    │   ├── data/
    │   │   ├── models/
    │   │   │   └── note_dto.dart
    │   │   ├── mappers/
    │   │   │   └── note_mapper.dart
    │   │   └── repositories/
    │   │       └── notes_repository_impl.dart (extends BaseRepository)
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── note.dart
    │   │   ├── repositories/
    │   │   │   └── notes_repository.dart (uses fpdart)
    │   │   └── usecases/
    │   │       └── ... (use fpdart)
    │   └── presentation/
    │       └── providers/
    │           └── ... (7 exception types)
    │
    ├── contacts/
    │   ├── data/
    │   │   ├── models/
    │   │   │   ├── contact_dto.dart
    │   │   │   └── friend_request_dto.dart
    │   │   ├── mappers/
    │   │   │   ├── contact_mapper.dart
    │   │   │   └── friend_request_mapper.dart
    │   │   └── repositories/
    │   │       └── contacts_repository_impl.dart (extends BaseRepository)
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   ├── contact.dart
    │   │   │   └── friend_request.dart
    │   │   ├── repositories/
    │   │   │   └── contacts_repository.dart (uses fpdart)
    │   │   └── usecases/
    │   │       └── ... (use fpdart)
    │   └── presentation/
    │       └── providers/
    │           └── ... (7 exception types)
    │
    ├── call/
    │   ├── data/
    │   │   ├── models/
    │   │   │   ├── call_dto.dart
    │   │   │   └── call_participant_dto.dart
    │   │   ├── mappers/
    │   │   │   ├── call_mapper.dart
    │   │   │   └── call_participant_mapper.dart
    │   │   └── repositories/
    │   │       └── call_repository_impl.dart (extends BaseRepository)
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   ├── call.dart
    │   │   │   └── call_participant.dart
    │   │   ├── repositories/
    │   │   │   └── call_repository.dart (uses fpdart)
    │   │   └── usecases/
    │   │       └── ... (use fpdart)
    │   └── presentation/
    │       └── providers/
    │           └── ... (7 exception types)
    │
    └── chat/
        ├── data/
        │   ├── models/
        │   │   ├── message_dto.dart
        │   │   ├── conversation_dto.dart
        │   │   └── search_user_dto.dart
        │   ├── mappers/
        │   │   ├── message_mapper.dart
        │   │   ├── conversation_mapper.dart
        │   │   └── search_user_mapper.dart
        │   └── repositories/
        │       └── chat_repository_impl.dart (extends BaseRepository)
        ├── domain/
        │   ├── entities/
        │   │   ├── message.dart
        │   │   ├── conversation.dart
        │   │   └── search_user.dart
        │   ├── repositories/
        │   │   └── chat_repository.dart (uses fpdart)
        │   └── usecases/
        │       └── ... (use fpdart)
        └── presentation/
            └── providers/
                └── ... (7 exception types)
```

---

## 8. Success Criteria

### 8.1. Code Quality

- ✅ Zero `dartz` imports across entire codebase
- ✅ Zero Freezed deprecation warnings
- ✅ BaseRepository used by all 5 feature repositories
- ✅ Repository code reduced by ~60% across all features
- ✅ All error codes match API spec exactly
- ✅ Explicit mappers for all DTO ↔ Entity conversions
- ✅ All 96 errors resolved

### 8.2. Functionality

- ✅ All feature flows work identically to before
- ✅ Profile: Get profile, update profile, upload avatar work
- ✅ Notes: Create, read, update, delete notes work
- ✅ Contacts: Add friend, accept/reject requests, remove contact work
- ✅ Call: Initiate, answer, end, reject calls work
- ✅ Chat: Send/receive messages, upload media, search users work
- ✅ Error messages are user-friendly and consistent

### 8.3. Testing

- ✅ All unit tests pass
- ✅ All integration tests pass
- ✅ Code coverage maintained or improved
- ✅ No flaky tests

### 8.4. Build

- ✅ Build succeeds without errors or warnings
- ✅ Code generation completes successfully
- ✅ No runtime errors

---

## 9. Risk Mitigation

### 9.1. Breaking Changes

**Risk**: Refactor breaks existing functionality

**Mitigation**:
- Implement one feature at a time
- Run tests after each feature
- Manual testing before moving to next feature
- Keep old code until new code is verified

### 9.2. Shared Dependencies

**Risk**: Profile and Chat features depend on auth User entity

**Mitigation**:
- Ensure auth refactor is complete and stable
- Test User entity/mapper thoroughly
- Document shared dependencies clearly

### 9.3. Complex Features

**Risk**: Chat and Call features are complex with many edge cases

**Mitigation**:
- Break down into smaller tasks
- Test incrementally
- Focus on core functionality first
- Add comprehensive error handling

---

## 10. Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: Repository Error Handling Consistency
*For any* repository method that makes an API call, when an ApiException is thrown, the BaseRepository should automatically convert it to the appropriate Failure type based on the error code.

**Validates: Requirements 1.3, 3.1-3.10**

### Property 2: DTO to Entity Conversion Preserves Data
*For any* DTO, converting to Entity and back to DTO should preserve all non-null field values.

**Validates: Requirements 4.5, 4.9**

### Property 3: Nullable Field Handling
*For any* DTO with nullable fields that are omitted from the API response, the mapper should set the corresponding Entity field to null without throwing an error.

**Validates: Requirements 4.3, 4.9**

### Property 4: Date String Conversion
*For any* valid ISO 8601 date string in a DTO, the mapper should successfully convert it to a DateTime object in the Entity.

**Validates: Requirements 4.7**

### Property 5: Enum String Conversion
*For any* valid enum string value in a DTO, the mapper should successfully convert it to the corresponding enum type in the Entity.

**Validates: Requirements 4.8**

### Property 6: Failure Type Mapping
*For any* API error code, the BaseRepository should map it to exactly one of the 7 Failure types (server, network, validation, auth, notFound, conflict, rateLimit).

**Validates: Requirements 3.1-3.10**

### Property 7: Exception Type Mapping
*For any* Failure type, the provider should map it to exactly one of the 7 Exception types for UI display.

**Validates: Requirements 11.1-11.7**

### Property 8: Backward Compatibility
*For any* existing feature flow, after refactoring, the flow should produce the same user-visible result as before.

**Validates: Requirements 12.1-12.10**

---

## 11. References

- [fpdart Documentation](https://pub.dev/packages/fpdart)
- [Freezed 3 Documentation](https://pub.dev/packages/freezed)
- [Riverpod 3 Documentation](https://riverpod.dev/)
- [Clean Architecture Principles](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- Auth Refactor Spec: `.kiro/specs/auth-refactor/`
- API Flow Template: `.kiro/steering/api_flow_template.md`
- Riverpod 3 Standards: `.kiro/steering/riverpod_3_prompt.md`
- Tech Stack Rules: `.kiro/steering/tech.md`
- API Specification: `api-spec.yaml`

---

## 12. Next Steps

1. **Review this design document** with team
2. **Get approval** from stakeholders
3. **Create tasks.md** with detailed implementation checklist
4. **Begin with Profile feature** (simplest)
5. **Iterate** through features in priority order
6. **Test thoroughly** after each feature
7. **Document** any issues or learnings

