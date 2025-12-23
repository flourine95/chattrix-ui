# Design Document: Inline Attachment Picker

## Overview

This design replaces the modal bottom sheet attachment picker with an inline attachment picker that appears below the message input bar, matching the design pattern of the emoji/sticker picker. The implementation leverages the existing `AttachmentPicker` widget and integrates it into the chat view's state management system.

## Architecture

### Component Structure

```
ChatViewPage
├── _MessageList (messages display)
├── _InputBar (message composition)
│   ├── TextField (message input)
│   ├── + Button (attachment picker toggle)
│   ├── 😊 Button (emoji picker toggle)
│   └── Send/Voice Button
├── AnimatedContainer (Gallery Picker - existing)
├── AnimatedContainer (Emoji Picker - existing)
└── AnimatedContainer (Attachment Picker - NEW)
```

### State Management

The chat view manages three mutually exclusive pickers:
- `showGallery` - Media gallery picker
- `showEmojiPicker` - Emoji/sticker picker
- `showAttachmentPicker` - Attachment type picker (NEW)

Only one picker can be visible at a time.

## Components and Interfaces

### 1. AttachmentPicker Widget (Existing - No Changes)

**Location**: `lib/features/chat/presentation/widgets/attachment_picker.dart`

**Interface**:
```dart
class AttachmentPicker extends StatelessWidget {
  final Function(AttachmentType) onAttachmentSelected;
  final Color? backgroundColor;
  final Color? iconColor;
  
  const AttachmentPicker({
    super.key,
    required this.onAttachmentSelected,
    this.backgroundColor,
    this.iconColor,
  });
}

enum AttachmentType {
  camera,
  gallery,
  video,
  audio,
  document,
  location,
  schedule,
}
```

**Features**:
- Grid layout (4 columns)
- 7 attachment options with icons and labels
- Theme-aware colors
- Consistent with emoji picker design

### 2. ChatViewPage State (Modified)

**New State Variable**:
```dart
final showAttachmentPicker = useState(false);
```

**State Transitions**:
```
+ Button Tap → Toggle showAttachmentPicker
                ↓
                Set showEmojiPicker = false
                Set showGallery = false

😊 Button Tap → Toggle showEmojiPicker
                 ↓
                 Set showAttachmentPicker = false
                 Set showGallery = false

Gallery Button → Toggle showGallery
                 ↓
                 Set showAttachmentPicker = false
                 Set showEmojiPicker = false

Keyboard Focus → Set showAttachmentPicker = false
                 Set showEmojiPicker = false
```

### 3. _InputBar Widget (Modified)

**Changes**:
- Replace `showModalBottomSheet` call with state toggle
- Update `onAttachmentTap` handler to toggle `showAttachmentPicker`

**Before**:
```dart
IconButton(
  icon: Icon(Icons.add_circle_outline),
  onPressed: () async {
    final result = await AttachmentPickerBottomSheet.show(context);
    if (result != null) {
      // Handle attachment type
    }
  },
)
```

**After**:
```dart
IconButton(
  icon: Icon(Icons.add_circle_outline),
  onPressed: onToggleAttachmentPicker,
)
```

### 4. Inline Attachment Picker Container (New)

**Implementation**:
```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 250),
  curve: Curves.easeOutQuad,
  height: showAttachmentPicker.value ? 350 : 0,
  clipBehavior: Clip.hardEdge,
  decoration: BoxDecoration(
    color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
  ),
  child: showAttachmentPicker.value
      ? AttachmentPicker(
          onAttachmentSelected: handleAttachmentSelection,
          backgroundColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
          iconColor: primaryColor,
        )
      : const SizedBox.shrink(),
)
```

## Data Models

No new data models required. Uses existing `AttachmentType` enum from `attachment_picker.dart`.

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: Mutual Exclusivity of Pickers

*For any* chat view state, at most one picker (gallery, emoji, attachment) should be visible at any given time.

**Validates: Requirements 1.2, 1.3**

### Property 2: Picker State Consistency

*For any* picker toggle action, the system should ensure that opening one picker closes all other pickers before displaying the new one.

**Validates: Requirements 1.2, 1.3, 4.3, 4.4**

### Property 3: Keyboard Dismissal on Picker Open

*For any* picker that opens (emoji or attachment), the keyboard should be dismissed (text field unfocused) before the picker animates in.

**Validates: Requirements 6.1, 6.2**

### Property 4: Picker Closure on Keyboard Show

*For any* keyboard focus event, all pickers (gallery, emoji, attachment) should be closed.

**Validates: Requirements 6.2, 6.3**

### Property 5: Attachment Selection Closes Picker

*For any* attachment type selection, the attachment picker should close immediately after the selection is made.

**Validates: Requirements 2.3**

### Property 6: Animation Consistency

*For any* picker animation (open or close), the animation duration should be 250 milliseconds with easeOutQuad curve.

**Validates: Requirements 7.1, 7.2, 7.3**

### Property 7: Visual Consistency with Emoji Picker

*For any* theme mode (dark or light), the attachment picker background color should match the emoji picker background color.

**Validates: Requirements 3.1, 3.2**

### Property 8: Error Handling Preserves Picker State

*For any* attachment operation that fails, the attachment picker should remain open to allow retry.

**Validates: Requirements 2.5**

## Error Handling

### Permission Errors

**Camera Permission Denied**:
```dart
if (permissionDenied) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Camera permission denied. Please enable in Settings.'),
      action: SnackBarAction(
        label: 'Settings',
        onPressed: () => openAppSettings(),
      ),
    ),
  );
  // Keep picker open for retry
}
```

**Storage Permission Denied**:
```dart
if (permissionDenied) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Storage permission denied. Please enable in Settings.'),
      action: SnackBarAction(
        label: 'Settings',
        onPressed: () => openAppSettings(),
      ),
    ),
  );
  // Keep picker open for retry
}
```

### Upload Errors

**Network Error**:
```dart
catch (e) {
  if (e is DioException && e.type == DioExceptionType.connectionError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No internet connection. Please check your network.'),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () => retryUpload(),
        ),
      ),
    );
  }
  // Keep picker open for retry
}
```

**File Size Error**:
```dart
if (fileSize > maxSize) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('File too large. Maximum size is ${maxSize}MB.'),
    ),
  );
  // Keep picker open to select different file
}
```

### Picker Operation Errors

**File Picker Cancelled**:
```dart
if (result == null) {
  // User cancelled - no error message needed
  // Keep picker open
  return;
}
```

**Unsupported File Type**:
```dart
if (!supportedTypes.contains(fileExtension)) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Unsupported file type: $fileExtension'),
    ),
  );
  // Keep picker open for retry
}
```

## Testing Strategy

### Unit Tests

**Test File**: `test/features/chat/presentation/widgets/attachment_picker_test.dart`

1. **Widget Rendering Tests**:
   - Test AttachmentPicker renders all 7 attachment options
   - Test correct icons and labels are displayed
   - Test theme-aware colors (light/dark mode)
   - Test grid layout (4 columns)

2. **Interaction Tests**:
   - Test tapping each attachment option calls onAttachmentSelected
   - Test correct AttachmentType is passed for each option
   - Test touch targets are at least 48x48

3. **Visual Tests**:
   - Test background color matches emoji picker
   - Test icon colors use theme primary color
   - Test proper spacing and padding

**Test File**: `test/features/chat/presentation/pages/chat_view_page_test.dart`

1. **State Management Tests**:
   - Test showAttachmentPicker toggles correctly
   - Test opening attachment picker closes emoji picker
   - Test opening emoji picker closes attachment picker
   - Test keyboard focus closes attachment picker

2. **Animation Tests**:
   - Test AnimatedContainer height transitions (0 ↔ 350)
   - Test animation duration is 250ms
   - Test animation curve is easeOutQuad

3. **Integration Tests**:
   - Test + button toggles attachment picker
   - Test attachment selection closes picker
   - Test attachment selection triggers correct handler

### Property-Based Tests

**Test File**: `test/features/chat/presentation/pages/chat_view_page_pbt_test.dart`

**Configuration**: Minimum 100 iterations per test

1. **Property Test: Mutual Exclusivity**
   ```dart
   // Feature: inline-attachment-picker, Property 1: Mutual Exclusivity of Pickers
   test('at most one picker visible at any time', () {
     fc.assert(
       fc.property(
         fc.boolean(), // showGallery
         fc.boolean(), // showEmojiPicker
         fc.boolean(), // showAttachmentPicker
         (gallery, emoji, attachment) {
           // After any state transition, count visible pickers
           final visibleCount = [gallery, emoji, attachment]
               .where((visible) => visible)
               .length;
           expect(visibleCount, lessThanOrEqualTo(1));
         },
       ),
       numRuns: 100,
     );
   });
   ```

2. **Property Test: Picker Toggle Consistency**
   ```dart
   // Feature: inline-attachment-picker, Property 2: Picker State Consistency
   test('opening one picker closes others', () {
     fc.assert(
       fc.property(
         fc.constantFrom('gallery', 'emoji', 'attachment'),
         (pickerToOpen) {
           // Simulate opening a picker
           final state = togglePicker(pickerToOpen);
           
           // Verify only the opened picker is visible
           expect(state[pickerToOpen], isTrue);
           expect(
             state.entries.where((e) => e.key != pickerToOpen && e.value).length,
             equals(0),
           );
         },
       ),
       numRuns: 100,
     );
   });
   ```

3. **Property Test: Animation Duration Consistency**
   ```dart
   // Feature: inline-attachment-picker, Property 6: Animation Consistency
   test('all picker animations use same duration', () {
     fc.assert(
       fc.property(
         fc.constantFrom('gallery', 'emoji', 'attachment'),
         (pickerType) {
           final animation = getPickerAnimation(pickerType);
           expect(animation.duration, equals(Duration(milliseconds: 250)));
           expect(animation.curve, equals(Curves.easeOutQuad));
         },
       ),
       numRuns: 100,
     );
   });
   ```

4. **Property Test: Visual Consistency**
   ```dart
   // Feature: inline-attachment-picker, Property 7: Visual Consistency
   test('attachment picker colors match emoji picker', () {
     fc.assert(
       fc.property(
         fc.boolean(), // isDark
         (isDark) {
           final emojiPickerColor = getEmojiPickerColor(isDark);
           final attachmentPickerColor = getAttachmentPickerColor(isDark);
           expect(attachmentPickerColor, equals(emojiPickerColor));
         },
       ),
       numRuns: 100,
     );
   });
   ```

### Integration Tests

**Test File**: `integration_test/chat_attachment_picker_test.dart`

1. **End-to-End Flow**:
   - Open chat view
   - Tap + button
   - Verify attachment picker appears
   - Select camera option
   - Verify camera opens
   - Verify picker closes

2. **Picker Switching**:
   - Open attachment picker
   - Tap emoji button
   - Verify attachment picker closes
   - Verify emoji picker opens

3. **Error Handling**:
   - Open attachment picker
   - Select file with denied permission
   - Verify error message appears
   - Verify picker remains open

## Implementation Notes

### Files to Modify

1. **`lib/features/chat/presentation/pages/chat_view_page.dart`**:
   - Add `showAttachmentPicker` state variable
   - Add `toggleAttachmentPicker()` handler
   - Add `handleAttachmentSelection()` handler
   - Add inline attachment picker AnimatedContainer
   - Update picker state management logic
   - Update keyboard focus handlers

2. **`lib/features/chat/presentation/widgets/attachment_picker.dart`**:
   - No changes needed (already exists and works)

### Files to Delete

1. **`lib/features/chat/presentation/widgets/attachment_picker_bottom_sheet.dart`**:
   - Remove entire file
   - Remove all imports of this file

### Migration Steps

1. Add `showAttachmentPicker` state to ChatViewPage
2. Implement `toggleAttachmentPicker()` handler
3. Implement `handleAttachmentSelection()` handler
4. Add inline attachment picker AnimatedContainer
5. Update + button to call `toggleAttachmentPicker()`
6. Update picker state management (mutual exclusivity)
7. Test all attachment types work correctly
8. Remove `AttachmentPickerBottomSheet` file
9. Remove all imports and references to bottom sheet
10. Run tests to verify no regressions

### Code Reuse

The existing `AttachmentPicker` widget requires no modifications. It already:
- Has the correct interface (`onAttachmentSelected` callback)
- Supports theme-aware colors
- Has proper grid layout
- Matches emoji picker design

This design maximizes code reuse and minimizes changes.

## Performance Considerations

### Animation Performance

- Use `AnimatedContainer` for smooth height transitions
- Use `Clip.hardEdge` to prevent overflow during animation
- Use `const` constructors where possible
- Avoid rebuilding picker widget unnecessarily

### Memory Management

- Dispose controllers properly
- Use `const` for static widgets
- Avoid creating new widget instances on every build
- Reuse existing `AttachmentPicker` widget

### State Management

- Use `useState` for local UI state (picker visibility)
- Avoid unnecessary state updates
- Batch state updates when toggling pickers
- Use `ValueNotifier` for efficient rebuilds

## Accessibility

### Touch Targets

- All attachment options have 50x50 icon containers
- Minimum touch target: 48x48 (meets WCAG guidelines)
- Proper spacing between options (16px)

### Color Contrast

- Icon colors use theme primary color (sufficient contrast)
- Background colors use theme-aware values
- Text labels use theme text colors

### Screen Readers

- All attachment options have semantic labels
- Picker has descriptive title ("Send Attachment")
- Error messages are announced to screen readers

## Platform Considerations

### Web Platform

- File picker works on web
- Camera may require browser permissions
- Location picker may require browser geolocation API

### Mobile Platforms

- Camera requires camera permission
- Gallery requires storage permission
- Location requires location permission
- Audio requires microphone permission

### Permission Handling

All permission requests should:
1. Check permission status first
2. Request permission if not granted
3. Show error message if denied
4. Provide link to app settings
5. Keep picker open for retry
