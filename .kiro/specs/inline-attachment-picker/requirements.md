# Requirements Document

## Introduction

This feature replaces the attachment picker bottom sheet with an inline attachment picker that matches the design pattern of the emoji/sticker picker. This creates a consistent user experience where both emoji and attachment pickers appear in the same inline style below the message input area.

## Glossary

- **Attachment_Picker**: A UI component that allows users to select different types of attachments (camera, gallery, video, audio, files)
- **Inline_Picker**: A picker that appears as an animated container below the input bar, similar to the emoji picker
- **Bottom_Sheet**: A modal sheet that slides up from the bottom (current implementation, to be replaced)
- **Input_Bar**: The message composition area containing the text field and action buttons
- **Chat_View_Page**: The main chat screen where messages are displayed and composed

## Requirements

### Requirement 1: Replace Bottom Sheet with Inline Picker

**User Story:** As a user, I want the attachment picker to appear inline below the input bar (like the emoji picker), so that the UI feels consistent and predictable.

#### Acceptance Criteria

1. WHEN a user taps the "+" button in the input bar, THEN the System SHALL display the attachment picker inline below the input bar
2. WHEN the attachment picker is displayed, THEN the System SHALL hide the emoji picker if it is currently open
3. WHEN the emoji picker is displayed, THEN the System SHALL hide the attachment picker if it is currently open
4. WHEN the attachment picker is displayed, THEN the System SHALL use the same animation style (duration, curve) as the emoji picker
5. WHEN a user taps outside the attachment picker, THEN the System SHALL close the attachment picker

### Requirement 2: Maintain Attachment Options

**User Story:** As a user, I want to access all attachment types from the inline picker, so that I don't lose any functionality.

#### Acceptance Criteria

1. WHEN the attachment picker is displayed, THEN the System SHALL show options for Camera, Gallery, Video, Audio, and Files
2. WHEN a user selects an attachment option, THEN the System SHALL execute the corresponding action (camera, gallery, video, audio, file picker)
3. WHEN a user selects an attachment option, THEN the System SHALL close the attachment picker automatically
4. WHEN an attachment action completes successfully, THEN the System SHALL send the attachment message
5. WHEN an attachment action fails, THEN the System SHALL display an error message and keep the picker open

### Requirement 3: Visual Consistency

**User Story:** As a user, I want the attachment picker to look and feel like the emoji picker, so that the interface is cohesive.

#### Acceptance Criteria

1. WHEN the attachment picker is displayed, THEN the System SHALL use the same background color as the emoji picker (dark mode: #1C1C1E, light mode: white)
2. WHEN the attachment picker is displayed, THEN the System SHALL use the same height as the emoji picker (350px)
3. WHEN the attachment picker is displayed, THEN the System SHALL use the same border radius and styling as the emoji picker
4. WHEN the attachment picker is displayed, THEN the System SHALL use theme-aware icon colors matching the primary color
5. WHEN the attachment picker is displayed, THEN the System SHALL display attachment options in a grid layout similar to emoji categories

### Requirement 4: State Management

**User Story:** As a developer, I want proper state management for the attachment picker, so that it integrates cleanly with existing chat state.

#### Acceptance Criteria

1. WHEN the chat view initializes, THEN the System SHALL create a state variable for attachment picker visibility (showAttachmentPicker)
2. WHEN the "+" button is tapped, THEN the System SHALL toggle the showAttachmentPicker state
3. WHEN the attachment picker opens, THEN the System SHALL set showEmojiPicker to false
4. WHEN the emoji picker opens, THEN the System SHALL set showAttachmentPicker to false
5. WHEN the keyboard shows, THEN the System SHALL set showAttachmentPicker to false

### Requirement 5: Remove Bottom Sheet Implementation

**User Story:** As a developer, I want to remove the old bottom sheet implementation, so that the codebase stays clean and maintainable.

#### Acceptance Criteria

1. WHEN the inline attachment picker is implemented, THEN the System SHALL remove the AttachmentPickerBottomSheet widget
2. WHEN the inline attachment picker is implemented, THEN the System SHALL remove all references to showModalBottomSheet for attachments
3. WHEN the inline attachment picker is implemented, THEN the System SHALL update the _InputBar to use the inline picker
4. WHEN the inline attachment picker is implemented, THEN the System SHALL remove the attachment_picker_bottom_sheet.dart file
5. WHEN the inline attachment picker is implemented, THEN the System SHALL ensure no broken imports remain

### Requirement 6: Keyboard and Focus Handling

**User Story:** As a user, I want the attachment picker to properly handle keyboard interactions, so that the UI doesn't conflict with the keyboard.

#### Acceptance Criteria

1. WHEN the attachment picker opens, THEN the System SHALL dismiss the keyboard (unfocus the text field)
2. WHEN the keyboard shows, THEN the System SHALL close the attachment picker
3. WHEN a user taps the text field while the attachment picker is open, THEN the System SHALL close the attachment picker and show the keyboard
4. WHEN the attachment picker closes, THEN the System SHALL optionally refocus the text field (based on user action)
5. WHEN the user navigates away from the chat, THEN the System SHALL close the attachment picker

### Requirement 7: Animation and Transitions

**User Story:** As a user, I want smooth animations when the attachment picker opens and closes, so that the experience feels polished.

#### Acceptance Criteria

1. WHEN the attachment picker opens, THEN the System SHALL animate the height from 0 to 350px over 250 milliseconds
2. WHEN the attachment picker closes, THEN the System SHALL animate the height from 350px to 0 over 250 milliseconds
3. WHEN the attachment picker animates, THEN the System SHALL use the easeOutQuad curve
4. WHEN the attachment picker is hidden, THEN the System SHALL use Clip.hardEdge to prevent overflow
5. WHEN switching between emoji and attachment pickers, THEN the System SHALL animate both transitions smoothly

### Requirement 8: Accessibility and Error Handling

**User Story:** As a user, I want clear feedback when attachment operations fail, so that I understand what went wrong.

#### Acceptance Criteria

1. WHEN a camera permission is denied, THEN the System SHALL display a message explaining how to grant permission
2. WHEN a file picker operation fails, THEN the System SHALL display a user-friendly error message
3. WHEN an upload fails, THEN the System SHALL display an error message with retry option
4. WHEN the attachment picker is displayed, THEN the System SHALL ensure all buttons have proper touch targets (minimum 48x48)
5. WHEN the attachment picker is displayed, THEN the System SHALL ensure proper color contrast for accessibility
