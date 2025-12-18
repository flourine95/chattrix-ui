# Implementation Plan - Remaining Features Refactor

This plan outlines the step-by-step tasks to refactor all remaining features (Profile, Notes, Contacts, Call, Chat) to use Clean Architecture with BaseRepository pattern and fpdart.

---

## Feature 1: Profile Feature (Priority 1)

### 1. Refactor Profile Data Layer

- [ ] 1.1 Update ProfileRepositoryImpl to extend BaseRepository
  - Extend BaseRepository abstract class
  - Use `executeApiCall()` wrapper for all API calls
  - Remove manual try-catch blocks
  - Use UserMapper from auth feature for DTO ↔ Entity conversion
  - _Requirements: 1.1, 6.1_

- [ ] 1.2 Update ProfileApiService to return ApiResponse
  - Wrap all responses in ApiResponse<UserDto>
  - Handle success and error cases
  - _Requirements: 6.1_

- [ ] 1.3 Run code generation
  - Execute `dart run build_runner build --delete-conflicting-outputs`
  - Verify no build errors
  - _Requirements: 1.4_

### 2. Refactor Profile Domain Layer

- [ ] 2.1 Update ProfileRepository interface to use fpdart
  - Change imports from `dartz` to `fpdart`
  - Update all method signatures to use `Either<Failure, T>`
  - _Requirements: 2.1, 2.3, 6.1_

- [ ] 2.2 Update all Profile usecases to use fpdart
  - GetProfileUseCase
  - UpdateProfileUseCase
  - UploadAvatarUseCase
  - Change imports from `dartz` to `fpdart`
  - Use lowercase `right()` and `left()` functions
  - _Requirements: 2.1, 2.2, 6.5_

### 3. Refactor Profile Presentation Layer

- [ ] 3.1 Update Profile providers to use 7 exception types
  - Update `_mapFailureToException()` to handle 7 Failure types
  - Use: ServerException, NetworkException, ValidationException, AuthException, NotFoundException, ConflictException, RateLimitException
  - _Requirements: 11.1-11.7, 6.6_

- [ ] 3.2 Update Profile UI error handling
  - Update error display widgets to handle 7 exception types
  - Show user-friendly messages
  - _Requirements: 14.1-14.10_

### 4. Test Profile Feature

- [ ] 4.1 Manual testing of Profile feature
  - Test get profile
  - Test update profile (fullName, bio, phone, etc.)
  - Test upload avatar
  - Test error scenarios (network error, validation error, etc.)
  - _Requirements: 12.1, 12.7, 6.8_

- [ ] 4.2 Verify all 6 Profile errors are resolved
  - Run `flutter analyze`
  - Confirm zero errors in Profile feature
  - _Requirements: 6.7_

---

## Feature 2: Notes Feature (Priority 2)

### 5. Create Notes DTOs and Mappers

- [ ] 5.1 Create NoteDto
  - Create `lib/features/notes/data/models/note_dto.dart`
  - Use `@freezed` and `@JsonSerializable` annotations
  - Fields: id, userId, title, content, tags (String), createdAt (String), updatedAt (String?)
  - _Requirements: 4.1, 4.2, 9.2_

- [ ] 5.2 Create NoteMapper
  - Create `lib/features/notes/data/mappers/note_mapper.dart`
  - Extension `NoteDtoMapper` with `toEntity()` method
  - Extension `NoteEntityMapper` with `toDto()` method
  - Convert tags: String ↔ List<String>
  - Convert dates: String ↔ DateTime
  - _Requirements: 4.4, 4.7, 9.3_

- [ ] 5.3 Run code generation for Notes DTOs
  - Execute `dart run build_runner build --delete-conflicting-outputs`
  - Verify NoteDto.freezed.dart and NoteDto.g.dart are generated
  - _Requirements: 4.2_

### 6. Refactor Notes Data Layer

- [ ] 6.1 Update NotesRepositoryImpl to extend BaseRepository
  - Extend BaseRepository abstract class
  - Use `executeApiCall()` wrapper for all API calls
  - Remove manual try-catch blocks
  - Use NoteMapper for DTO ↔ Entity conversion
  - _Requirements: 1.1, 9.1_

- [ ] 6.2 Update NotesApiService to return ApiResponse
  - Wrap all responses in ApiResponse<NoteDto> or ApiResponse<List<NoteDto>>
  - Handle success and error cases
  - _Requirements: 9.1_

### 7. Refactor Notes Domain Layer

- [ ] 7.1 Update Note entity to Freezed 3 standards
  - Remove `abstract class` keyword (optional for single factory)
  - Verify no json_annotation imports
  - Use proper Dart types (DateTime, List<String>)
  - _Requirements: 5.1-5.7, 9.4_

- [ ] 7.2 Update NotesRepository interface to use fpdart
  - Change imports from `dartz` to `fpdart`
  - Update all method signatures
  - _Requirements: 2.1, 2.3, 9.1_

- [ ] 7.3 Update all Notes usecases to use fpdart
  - GetNotesUseCase
  - CreateNoteUseCase
  - UpdateNoteUseCase
  - DeleteNoteUseCase
  - Change imports from `dartz` to `fpdart`
  - Use lowercase `right()` and `left()` functions
  - _Requirements: 2.1, 2.2, 9.5_

### 8. Refactor Notes Presentation Layer

- [ ] 8.1 Update Notes providers to use 7 exception types
  - Update `_mapFailureToException()` to handle 7 Failure types
  - _Requirements: 11.1-11.7, 9.6_

- [ ] 8.2 Update Notes UI error handling
  - Update error display widgets
  - _Requirements: 14.1-14.10_

### 9. Test Notes Feature

- [ ] 9.1 Manual testing of Notes feature
  - Test create note
  - Test get notes list
  - Test update note
  - Test delete note
  - Test error scenarios
  - _Requirements: 12.1, 12.6, 9.8_

- [ ] 9.2 Verify all Notes errors are resolved
  - Run `flutter analyze`
  - Confirm zero errors in Notes feature
  - _Requirements: 9.7_

---

## Feature 3: Contacts Feature (Priority 3)

### 10. Create Contacts DTOs and Mappers

- [ ] 10.1 Create ContactDto
  - Create `lib/features/contacts/data/models/contact_dto.dart`
  - Use `@freezed` and `@JsonSerializable`
  - Fields: id, userId, contactUserId, status (String), createdAt (String), updatedAt (String?)
  - _Requirements: 4.1, 4.2, 8.2_

- [ ] 10.2 Create FriendRequestDto
  - Create `lib/features/contacts/data/models/friend_request_dto.dart`
  - Use `@freezed` and `@JsonSerializable`
  - Fields: id, senderId, receiverId, status (String), createdAt (String), respondedAt (String?)
  - _Requirements: 4.1, 4.2, 8.2_

- [ ] 10.3 Create ContactMapper
  - Create `lib/features/contacts/data/mappers/contact_mapper.dart`
  - Extension `ContactDtoMapper` with `toEntity()` method
  - Convert status: String ↔ ContactStatus enum
  - Convert dates: String ↔ DateTime
  - _Requirements: 4.4, 4.7, 4.8, 8.3_

- [ ] 10.4 Create FriendRequestMapper
  - Create `lib/features/contacts/data/mappers/friend_request_mapper.dart`
  - Extension `FriendRequestDtoMapper` with `toEntity()` method
  - Convert status: String ↔ FriendRequestStatus enum
  - Convert dates: String ↔ DateTime
  - _Requirements: 4.4, 4.7, 4.8, 8.3_

- [ ] 10.5 Run code generation for Contacts DTOs
  - Execute `dart run build_runner build --delete-conflicting-outputs`
  - Verify all .freezed.dart and .g.dart files are generated
  - _Requirements: 4.2_

### 11. Refactor Contacts Data Layer

- [ ] 11.1 Update ContactsRepositoryImpl to extend BaseRepository
  - Extend BaseRepository abstract class
  - Use `executeApiCall()` wrapper for all API calls
  - Remove manual try-catch blocks
  - Use ContactMapper and FriendRequestMapper
  - _Requirements: 1.1, 8.1_

- [ ] 11.2 Update ContactsApiService to return ApiResponse
  - Wrap all responses in ApiResponse
  - Handle success and error cases
  - _Requirements: 8.1_

### 12. Refactor Contacts Domain Layer

- [ ] 12.1 Update Contact and FriendRequest entities
  - Remove `abstract class` keyword (optional for single factory)
  - Verify no json_annotation imports
  - Use proper Dart types (DateTime, enums)
  - _Requirements: 5.1-5.7, 8.4_

- [ ] 12.2 Update ContactsRepository interface to use fpdart
  - Change imports from `dartz` to `fpdart`
  - Update all method signatures
  - _Requirements: 2.1, 2.3, 8.1_

- [ ] 12.3 Update all Contacts usecases to use fpdart
  - GetContactsUseCase
  - SendFriendRequestUseCase
  - AcceptFriendRequestUseCase
  - RejectFriendRequestUseCase
  - RemoveContactUseCase
  - BlockContactUseCase
  - Change imports from `dartz` to `fpdart`
  - Use lowercase `right()` and `left()` functions
  - _Requirements: 2.1, 2.2, 8.5_

### 13. Refactor Contacts Presentation Layer

- [ ] 13.1 Update Contacts providers to use 7 exception types
  - Update `_mapFailureToException()` to handle 7 Failure types
  - _Requirements: 11.1-11.7, 8.6_

- [ ] 13.2 Update Contacts UI error handling
  - Update error display widgets
  - _Requirements: 14.1-14.10_

### 14. Test Contacts Feature

- [ ] 14.1 Manual testing of Contacts feature
  - Test get contacts list
  - Test send friend request
  - Test accept friend request
  - Test reject friend request
  - Test remove contact
  - Test block contact
  - Test error scenarios
  - _Requirements: 12.1, 12.5, 8.8_

- [ ] 14.2 Verify all 48 Contacts errors are resolved
  - Run `flutter analyze`
  - Confirm zero errors in Contacts feature
  - _Requirements: 8.7_

---

## Feature 4: Call Feature (Priority 4)

### 15. Create Call DTOs and Mappers

- [ ] 15.1 Create CallDto
  - Create `lib/features/call/data/models/call_dto.dart`
  - Use `@freezed` and `@JsonSerializable`
  - Fields: id, callerId, receiverId, callType (String), status (String), channelName, agoraToken, createdAt (String), startedAt (String?), endedAt (String?), duration (int?)
  - _Requirements: 4.1, 4.2, 7.2_

- [ ] 15.2 Create CallParticipantDto
  - Create `lib/features/call/data/models/call_participant_dto.dart`
  - Use `@freezed` and `@JsonSerializable`
  - Fields: id, callId, userId, role (String), status (String), joinedAt (String), leftAt (String?)
  - _Requirements: 4.1, 4.2, 7.2_

- [ ] 15.3 Create CallMapper
  - Create `lib/features/call/data/mappers/call_mapper.dart`
  - Extension `CallDtoMapper` with `toEntity()` method
  - Convert callType: String ↔ CallType enum
  - Convert status: String ↔ CallStatus enum
  - Convert dates: String ↔ DateTime
  - _Requirements: 4.4, 4.7, 4.8, 7.3_

- [ ] 15.4 Create CallParticipantMapper
  - Create `lib/features/call/data/mappers/call_participant_mapper.dart`
  - Extension `CallParticipantDtoMapper` with `toEntity()` method
  - Convert role and status: String ↔ enum
  - Convert dates: String ↔ DateTime
  - _Requirements: 4.4, 4.7, 4.8, 7.3_

- [ ] 15.5 Run code generation for Call DTOs
  - Execute `dart run build_runner build --delete-conflicting-outputs`
  - Verify all .freezed.dart and .g.dart files are generated
  - _Requirements: 4.2_

### 16. Refactor Call Data Layer

- [ ] 16.1 Update CallRepositoryImpl to extend BaseRepository
  - Extend BaseRepository abstract class
  - Use `executeApiCall()` wrapper for all API calls
  - Remove manual try-catch blocks
  - Use CallMapper and CallParticipantMapper
  - _Requirements: 1.1, 7.1_

- [ ] 16.2 Update CallApiService to return ApiResponse
  - Wrap all responses in ApiResponse
  - Handle success and error cases
  - _Requirements: 7.1_

### 17. Refactor Call Domain Layer

- [ ] 17.1 Update Call and CallParticipant entities
  - Remove `abstract class` keyword (optional for single factory)
  - Verify no json_annotation imports
  - Use proper Dart types (DateTime, enums)
  - _Requirements: 5.1-5.7, 7.4_

- [ ] 17.2 Update CallRepository interface to use fpdart
  - Change imports from `dartz` to `fpdart`
  - Update all method signatures
  - _Requirements: 2.1, 2.3, 7.1_

- [ ] 17.3 Update all Call usecases to use fpdart
  - InitiateCallUseCase
  - AnswerCallUseCase
  - EndCallUseCase
  - RejectCallUseCase
  - GetCallHistoryUseCase
  - Change imports from `dartz` to `fpdart`
  - Use lowercase `right()` and `left()` functions
  - _Requirements: 2.1, 2.2, 7.5_

### 18. Refactor Call Presentation Layer

- [ ] 18.1 Update Call providers to use 7 exception types
  - Update `_mapFailureToException()` to handle 7 Failure types
  - _Requirements: 11.1-11.7, 7.6_

- [ ] 18.2 Update Call UI error handling
  - Update error display widgets
  - _Requirements: 14.1-14.10_

### 19. Test Call Feature

- [ ] 19.1 Manual testing of Call feature
  - Test initiate call
  - Test answer call
  - Test end call
  - Test reject call
  - Test call history
  - Test error scenarios
  - _Requirements: 12.1, 12.2, 7.8_

- [ ] 19.2 Verify all 16 Call errors are resolved
  - Run `flutter analyze`
  - Confirm zero errors in Call feature
  - _Requirements: 7.7_

---

## Feature 5: Chat Feature (Priority 5)

### 20. Create Chat DTOs and Mappers

- [ ] 20.1 Create MessageDto
  - Create `lib/features/chat/data/models/message_dto.dart`
  - Use `@freezed` and `@JsonSerializable`
  - Fields: id, conversationId, senderId, messageType (String), content, mediaUrl, thumbnailUrl, duration, fileSize, fileName, replyToMessageId, status (String), createdAt (String), updatedAt (String?), deletedAt (String?)
  - _Requirements: 4.1, 4.2, 8.2_

- [ ] 20.2 Create ConversationDto
  - Create `lib/features/chat/data/models/conversation_dto.dart`
  - Use `@freezed` and `@JsonSerializable`
  - Fields: id, conversationType (String), name, avatarUrl, participantIds, lastMessageId, lastMessageContent, lastMessageTime (String?), unreadCount, createdAt (String), updatedAt (String?)
  - _Requirements: 4.1, 4.2, 8.2_

- [ ] 20.3 Create SearchUserDto
  - Create `lib/features/chat/data/models/search_user_dto.dart`
  - Use `@freezed` and `@JsonSerializable`
  - Fields: id, username, fullName, avatarUrl, online
  - _Requirements: 4.1, 4.2, 8.2_

- [ ] 20.4 Create MessageMapper
  - Create `lib/features/chat/data/mappers/message_mapper.dart`
  - Extension `MessageDtoMapper` with `toEntity()` method
  - Convert messageType: String ↔ MessageType enum
  - Convert status: String ↔ MessageStatus enum
  - Convert dates: String ↔ DateTime
  - _Requirements: 4.4, 4.7, 4.8, 8.3_

- [ ] 20.5 Create ConversationMapper
  - Create `lib/features/chat/data/mappers/conversation_mapper.dart`
  - Extension `ConversationDtoMapper` with `toEntity()` method
  - Convert conversationType: String ↔ ConversationType enum
  - Convert dates: String ↔ DateTime
  - _Requirements: 4.4, 4.7, 4.8, 8.3_

- [ ] 20.6 Create SearchUserMapper
  - Create `lib/features/chat/data/mappers/search_user_mapper.dart`
  - Extension `SearchUserDtoMapper` with `toEntity()` method
  - _Requirements: 4.4, 8.3_

- [ ] 20.7 Run code generation for Chat DTOs
  - Execute `dart run build_runner build --delete-conflicting-outputs`
  - Verify all .freezed.dart and .g.dart files are generated
  - _Requirements: 4.2_

### 21. Refactor Chat Data Layer

- [ ] 21.1 Update ChatRepositoryImpl to extend BaseRepository
  - Extend BaseRepository abstract class
  - Use `executeApiCall()` wrapper for all API calls
  - Remove manual try-catch blocks
  - Use MessageMapper, ConversationMapper, SearchUserMapper
  - _Requirements: 1.1, 8.1_

- [ ] 21.2 Update ChatApiService to return ApiResponse
  - Wrap all responses in ApiResponse
  - Handle success and error cases
  - _Requirements: 8.1_

### 22. Refactor Chat Domain Layer

- [ ] 22.1 Update Message, Conversation, SearchUser entities
  - Remove `abstract class` keyword (optional for single factory)
  - Verify no json_annotation imports
  - Use proper Dart types (DateTime, enums)
  - _Requirements: 5.1-5.7, 8.4_

- [ ] 22.2 Update ChatRepository interface to use fpdart
  - Change imports from `dartz` to `fpdart`
  - Update all method signatures
  - _Requirements: 2.1, 2.3, 8.1_

- [ ] 22.3 Update all Chat usecases to use fpdart
  - GetConversationsUseCase
  - GetMessagesUseCase
  - SendMessageUseCase
  - SendImageMessageUseCase
  - SendVoiceMessageUseCase
  - SendVideoMessageUseCase
  - MarkMessageAsReadUseCase
  - DeleteMessageUseCase
  - SearchUsersUseCase
  - CreateConversationUseCase
  - Change imports from `dartz` to `fpdart`
  - Use lowercase `right()` and `left()` functions
  - _Requirements: 2.1, 2.2, 8.5_

### 23. Refactor Chat Presentation Layer

- [ ] 23.1 Update Chat providers to use 7 exception types
  - Update `_mapFailureToException()` to handle 7 Failure types
  - _Requirements: 11.1-11.7, 8.6_

- [ ] 23.2 Update Chat UI error handling
  - Update error display widgets
  - _Requirements: 14.1-14.10_

### 24. Test Chat Feature

- [ ] 24.1 Manual testing of Chat feature
  - Test get conversations
  - Test get messages
  - Test send text message
  - Test send image message
  - Test send voice message
  - Test send video message
  - Test mark message as read
  - Test delete message
  - Test search users
  - Test create conversation
  - Test error scenarios
  - _Requirements: 12.1, 12.3, 12.4, 8.8_

- [ ] 24.2 Verify all 26 Chat errors are resolved
  - Run `flutter analyze`
  - Confirm zero errors in Chat feature
  - _Requirements: 8.7_

---

## Final Verification

### 25. Remove dartz Dependency

- [ ] 25.1 Search codebase for dartz imports
  - Run `grep -r "package:dartz" lib/`
  - Verify zero results
  - _Requirements: 13.1, 13.2_

- [ ] 25.2 Search codebase for Right/Left constructors
  - Run `grep -r "Right(" lib/`
  - Run `grep -r "Left(" lib/`
  - Verify zero results (should use lowercase `right()` and `left()`)
  - _Requirements: 13.3, 13.4_

- [ ] 25.3 Remove dartz from pubspec.yaml
  - Remove `dartz` from dependencies
  - Run `flutter pub get`
  - _Requirements: 13.5_

### 26. Final Build and Test

- [ ] 26.1 Run full code generation
  - Execute `dart run build_runner build --delete-conflicting-outputs`
  - Verify no errors
  - _Requirements: 1.4_

- [ ] 26.2 Run flutter analyze
  - Execute `flutter analyze`
  - Verify zero errors across all features
  - Confirm all 96 errors are resolved
  - _Requirements: 1.8_

- [ ] 26.3 Format all code
  - Execute `dart format lib/`
  - Ensure consistent code style
  - _Requirements: 1.8_

- [ ] 26.4 Run all tests
  - Execute `flutter test`
  - Verify all tests pass
  - _Requirements: 15.5_

### 27. Documentation

- [ ] 27.1 Create completion summary
  - Document what was accomplished
  - List any known issues
  - Provide migration guide for future features
  - _Requirements: 1.9_

- [ ] 27.2 Update README if needed
  - Document new architecture patterns
  - Update dependency list
  - _Requirements: 1.9_

---

## Summary

**Total Tasks**: 27 main tasks with 100+ subtasks

**Estimated Timeline**:
- Profile Feature: 1 day
- Notes Feature: 1 day
- Contacts Feature: 2 days
- Call Feature: 2 days
- Chat Feature: 3 days
- Final Verification: 2 days

**Total**: ~11 days

**Success Criteria**:
- ✅ Zero dartz imports
- ✅ All 96 errors resolved
- ✅ BaseRepository used by all features
- ✅ All features tested and working
- ✅ Build succeeds without warnings
- ✅ All tests pass
