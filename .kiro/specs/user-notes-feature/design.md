# Design Document - User Notes/Stories Feature

## Overview

This document outlines the design for implementing user notes/stories feature with mock data. The feature allows users to create short status updates that appear above their avatars in the online users list, similar to Instagram/Facebook Stories.

---

## Architecture

### Component Hierarchy

```
ChatListPage
├── OnlineUsersList
│   ├── MyStoryItem (Your story)
│   │   ├── Avatar (with + icon or note text)
│   │   └── onTap → NoteDialog
│   │
│   └── OnlineUserItem (Other users)
│       ├── Avatar
│       ├── Note text (if exists)
│       └── onTap → Navigate to conversation
│
└── NoteDialog (Modal)
    ├── TextField (note input)
    ├── Character counter
    ├── Save button
    ├── Cancel button
    └── Delete button (if note exists)
```

### State Management

```
┌─────────────────────────────────────────────────────────┐
│                   UserNotesProvider                     │
│                  (StateNotifier)                        │
│                                                          │
│  State: Map<String, UserNote>                          │
│  - Current user's note                                  │
│  - Other users' notes (mock data)                      │
│                                                          │
│  Methods:                                               │
│  - createOrUpdateNote(String content)                  │
│  - deleteNote()                                         │
│  - getNoteForUser(String userId)                       │
│  - initializeMockData()                                │
└─────────────────────────────────────────────────────────┘
```

---

## Data Models

### UserNote Entity

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_note_entity.freezed.dart';

/// User note/story entity
/// 
/// Represents a short status update that appears above user's avatar
@freezed
class UserNoteEntity with _$UserNoteEntity {
  const factory UserNoteEntity({
    required String userId,
    required String content,
    required DateTime createdAt,
    DateTime? expiresAt,
  }) = _UserNoteEntity;
}
```

### Mock Data Provider

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_notes_provider.g.dart';

@riverpod
class UserNotes extends _$UserNotes {
  @override
  Map<String, UserNoteEntity> build() {
    // Initialize with mock data
    return _initializeMockData();
  }

  Map<String, UserNoteEntity> _initializeMockData() {
    return {
      // Mock notes for other users
      'user-123': UserNoteEntity(
        userId: 'user-123',
        content: 'Coding 💻',
        createdAt: DateTime.now(),
      ),
      'user-456': UserNoteEntity(
        userId: 'user-456',
        content: 'At the gym 💪',
        createdAt: DateTime.now(),
      ),
      'user-789': UserNoteEntity(
        userId: 'user-789',
        content: 'Lunch break 🍜',
        createdAt: DateTime.now(),
      ),
    };
  }

  /// Create or update current user's note
  void createOrUpdateNote(String userId, String content) {
    state = {
      ...state,
      userId: UserNoteEntity(
        userId: userId,
        content: content,
        createdAt: DateTime.now(),
      ),
    };
  }

  /// Delete current user's note
  void deleteNote(String userId) {
    final newState = Map<String, UserNoteEntity>.from(state);
    newState.remove(userId);
    state = newState;
  }

  /// Get note for specific user
  UserNoteEntity? getNoteForUser(String userId) {
    return state[userId];
  }
}
```

---

## UI Components

### 1. MyStoryItem Widget (Updated)

```dart
class _MyStoryItem extends StatefulWidget {
  final String currentUserId;
  final String? avatarUrl;
  final UserNoteEntity? note;
  final VoidCallback onTap;

  const _MyStoryItem({
    required this.currentUserId,
    this.avatarUrl,
    this.note,
    required this.onTap,
  });

  @override
  State<_MyStoryItem> createState() => _MyStoryItemState();
}

class _MyStoryItemState extends State<_MyStoryItem> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasNote = widget.note != null;
    
    return Semantics(
      label: hasNote
          ? 'Your story: ${widget.note!.content}. Double tap to edit.'
          : 'Your story. Double tap to add a note.',
      button: true,
      enabled: true,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap();
        },
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: 70,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Note text (if exists)
                if (hasNote) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.note!.content,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                
                // Avatar with + icon or border
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: hasNote
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primary
                              .withValues(alpha: 0.2),
                      child: widget.avatarUrl != null
                          ? ClipOval(
                              child: Image.network(
                                widget.avatarUrl!,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              hasNote ? Icons.edit : Icons.add,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30,
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Your story',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

### 2. OnlineUserItem Widget (Updated)

```dart
class OnlineUserItem extends StatelessWidget {
  final UserDto user;
  final UserNoteEntity? note;
  final VoidCallback onTap;

  const OnlineUserItem({
    super.key,
    required this.user,
    this.note,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasNote = note != null;
    
    return Semantics(
      label: hasNote
          ? '${user.username}. Note: ${note!.content}. Double tap to open conversation.'
          : '${user.username}. Double tap to open conversation.',
      button: true,
      enabled: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 70,
          margin: const EdgeInsets.only(right: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Note text (if exists)
              if (hasNote) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    note!.content,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 4),
              ],
              
              // Avatar with online indicator
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: user.avatarUrl != null
                        ? NetworkImage(user.avatarUrl!)
                        : null,
                    child: user.avatarUrl == null
                        ? Text(
                            user.username[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  // Online indicator
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                user.username,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 3. NoteDialog Widget (New)

```dart
class NoteDialog extends HookConsumerWidget {
  final String currentUserId;
  final UserNoteEntity? existingNote;

  const NoteDialog({
    super.key,
    required this.currentUserId,
    this.existingNote,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(
      text: existingNote?.content ?? '',
    );
    final characterCount = useState(existingNote?.content.length ?? 0);
    final maxCharacters = 60;

    useEffect(() {
      void listener() {
        characterCount.value = controller.text.length;
      }
      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Text(
              existingNote != null ? 'Edit your note' : 'Add a note',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            
            // Text field
            TextField(
              controller: controller,
              autofocus: true,
              maxLength: maxCharacters,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                counterText: '${characterCount.value}/$maxCharacters',
              ),
              onChanged: (value) {
                if (value.length >= maxCharacters) {
                  // Announce to screen readers
                  SemanticsService.announce(
                    'Character limit reached',
                    TextDirection.ltr,
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Delete button (if editing)
                if (existingNote != null) ...[
                  TextButton(
                    onPressed: () {
                      ref.read(userNotesProvider.notifier)
                          .deleteNote(currentUserId);
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text('Delete'),
                  ),
                  const Spacer(),
                ],
                
                // Cancel button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                
                // Save button
                ElevatedButton(
                  onPressed: controller.text.trim().isEmpty
                      ? null
                      : () {
                          ref.read(userNotesProvider.notifier)
                              .createOrUpdateNote(
                                currentUserId,
                                controller.text.trim(),
                              );
                          Navigator.of(context).pop();
                        },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Integration with ChatListPage

### Updated Online Users Section

```dart
// In ChatListPage build method
if (currentFilter == ConversationFilter.all)
  SliverToBoxAdapter(
    child: onlineUsersAsync.when(
      data: (onlineUsers) {
        if (onlineUsers.isEmpty) {
          return const SizedBox.shrink();
        }

        // Get notes from provider
        final notes = ref.watch(userNotesProvider);
        final currentUserId = me?.id ?? '';

        return Semantics(
          label: 'Online users. ${onlineUsers.length} ${onlineUsers.length == 1 ? 'user' : 'users'} online.',
          child: Container(
            height: 110,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: onlineUsers.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // "Your story" item
                  return _MyStoryItem(
                    currentUserId: currentUserId,
                    avatarUrl: me?.avatarUrl,
                    note: notes[currentUserId],
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => NoteDialog(
                          currentUserId: currentUserId,
                          existingNote: notes[currentUserId],
                        ),
                      );
                    },
                  );
                }

                final user = onlineUsers[index - 1];
                return OnlineUserItem(
                  user: user,
                  note: notes[user.id],
                  onTap: () {
                    // TODO: Navigate to conversation with user
                    // (create if needed)
                    debugPrint('Online user ${user.username} tapped');
                  },
                );
              },
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
    ),
  ),
```

---

## Visual Design

### Note Badge

```
┌─────────────────┐
│  Coding 💻      │  ← Note text (10px, bold)
└─────────────────┘
       ↓
   ┌───────┐
   │       │         ← Avatar (60px diameter)
   │   👤  │
   │       │
   └───────┘
       ↓
   Your story        ← Label (12px)
```

### Color Scheme

```dart
// Your story (with note)
- Note background: Primary color
- Note text: White
- Avatar border: Primary color (2px)

// Your story (without note)
- Avatar background: Primary color with 20% opacity
- Icon: Primary color
- No border

// Other users' notes
- Note background: Grey[300]
- Note text: Grey[800]
- No special avatar styling
```

### Dialog Design

```
┌─────────────────────────────────────┐
│  Add a note                         │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ What's on your mind?          │ │
│  │                               │ │
│  │                               │ │
│  └───────────────────────────────┘ │
│                          45/60      │
│                                     │
│              [Cancel]  [Save]       │
└─────────────────────────────────────┘
```

---

## Animations

### My Story Item
```dart
// Scale animation on tap
Duration: 100ms
Curve: Curves.easeInOut
Scale: 1.0 → 0.95 → 1.0
```

### Dialog
```dart
// Fade in
Duration: 200ms
Curve: Curves.easeOut
Opacity: 0.0 → 1.0

// Scale in
Duration: 200ms
Curve: Curves.easeOut
Scale: 0.9 → 1.0
```

---

## Error Handling

### Validation

```dart
// Character limit
if (content.length > 60) {
  // Prevent input
  // Show error message
  return;
}

// Empty content
if (content.trim().isEmpty) {
  // Disable save button
  return;
}
```

### Mock Data Errors

```dart
// No errors expected with mock data
// But add defensive checks:

UserNoteEntity? getNoteForUser(String userId) {
  try {
    return state[userId];
  } catch (e) {
    debugPrint('Error getting note for user $userId: $e');
    return null;
  }
}
```

---

## Testing Strategy

### Unit Tests

```dart
test('should create note with valid content', () {
  final notifier = UserNotesNotifier();
  notifier.createOrUpdateNote('user-1', 'Test note');
  
  final note = notifier.getNoteForUser('user-1');
  expect(note?.content, 'Test note');
});

test('should delete note', () {
  final notifier = UserNotesNotifier();
  notifier.createOrUpdateNote('user-1', 'Test note');
  notifier.deleteNote('user-1');
  
  final note = notifier.getNoteForUser('user-1');
  expect(note, null);
});

test('should update existing note', () {
  final notifier = UserNotesNotifier();
  notifier.createOrUpdateNote('user-1', 'First note');
  notifier.createOrUpdateNote('user-1', 'Updated note');
  
  final note = notifier.getNoteForUser('user-1');
  expect(note?.content, 'Updated note');
});
```

### Widget Tests

```dart
testWidgets('should show note dialog when tapping Your story', (tester) async {
  await tester.pumpWidget(MyApp());
  
  // Find and tap "Your story"
  await tester.tap(find.text('Your story'));
  await tester.pumpAndSettle();
  
  // Verify dialog is shown
  expect(find.text('Add a note'), findsOneWidget);
  expect(find.byType(TextField), findsOneWidget);
});

testWidgets('should save note when tapping Save', (tester) async {
  await tester.pumpWidget(MyApp());
  
  // Open dialog
  await tester.tap(find.text('Your story'));
  await tester.pumpAndSettle();
  
  // Enter text
  await tester.enterText(find.byType(TextField), 'Test note');
  
  // Tap Save
  await tester.tap(find.text('Save'));
  await tester.pumpAndSettle();
  
  // Verify note is displayed
  expect(find.text('Test note'), findsOneWidget);
});
```

---

## Future API Migration

### Step 1: Create API Service

```dart
class UserNotesApiService {
  final Dio _dio;

  Future<UserNoteDto> createOrUpdateNote(String content) async {
    final response = await _dio.post(
      '/v1/users/me/note',
      data: {'content': content},
    );
    return UserNoteDto.fromJson(response.data['data']);
  }

  Future<void> deleteNote() async {
    await _dio.delete('/v1/users/me/note');
  }

  Future<UserNoteDto?> getUserNote(String userId) async {
    final response = await _dio.get('/v1/users/$userId/note');
    return UserNoteDto.fromJson(response.data['data']);
  }
}
```

### Step 2: Update Provider

```dart
@riverpod
class UserNotes extends _$UserNotes {
  @override
  Future<Map<String, UserNoteEntity>> build() async {
    // TODO: Replace with API call
    // final notes = await _apiService.getOnlineUsersNotes();
    // return notes;
    
    return _initializeMockData();
  }

  Future<void> createOrUpdateNote(String userId, String content) async {
    // TODO: Replace with API call
    // await _apiService.createOrUpdateNote(content);
    
    state = AsyncValue.data({
      ...state.value!,
      userId: UserNoteEntity(
        userId: userId,
        content: content,
        createdAt: DateTime.now(),
      ),
    });
  }
}
```

---

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system-essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: Note content length constraint
*For any* note content string, the length should be less than or equal to 60 characters
**Validates: Requirements 2.4**

### Property 2: Note creation updates state
*For any* valid note content, creating a note should result in the note being retrievable for that user
**Validates: Requirements 4.2**

### Property 3: Note deletion removes state
*For any* user with an existing note, deleting the note should result in no note being retrievable for that user
**Validates: Requirements 4.3**

### Property 4: Empty content validation
*For any* note content that is empty or whitespace-only, the save button should be disabled
**Validates: Requirements 2.5**

---

## Conclusion

This design provides a complete implementation of the user notes/stories feature using mock data. The architecture is designed for easy migration to API-based data when the backend is ready. The UI matches the demo design and provides a polished, accessible user experience.
