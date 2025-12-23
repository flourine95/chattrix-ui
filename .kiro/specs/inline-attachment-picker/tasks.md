# Implementation Plan: Inline Attachment Picker

## Overview

Replace the modal bottom sheet attachment picker with an inline attachment picker that appears below the message input bar, matching the emoji picker design pattern. This implementation leverages the existing `AttachmentPicker` widget and integrates it into ChatViewPage's state management.

## Tasks

- [ ] 1. Add attachment picker state management to ChatViewPage
  - Add `showAttachmentPicker` state variable using `useState(false)`
  - Implement `toggleAttachmentPicker()` handler that toggles state and closes other pickers
  - Implement `handleAttachmentSelection(AttachmentType type)` handler that processes selection and closes picker
  - Update existing picker toggle handlers to close attachment picker when opening other pickers
  - _Requirements: 1.1, 1.2, 1.3, 4.1, 4.2, 4.3, 4.4_

- [ ] 2. Add inline attachment picker container to ChatViewPage
  - Add `AnimatedContainer` below emoji picker container with same animation properties
  - Set height: `showAttachmentPicker.value ? 350 : 0`
  - Set duration: `Duration(milliseconds: 250)` with `Curves.easeOutQuad`
  - Set background color matching emoji picker (dark: #1C1C1E, light: white)
  - Use `Clip.hardEdge` for clipBehavior
  - Conditionally render `AttachmentPicker` widget when visible
  - _Requirements: 1.1, 3.1, 3.2, 3.3, 7.1, 7.2, 7.3, 7.4_

- [ ] 3. Update _InputBar to use inline attachment picker
  - Modify + button `onPressed` to call `onToggleAttachmentPicker` callback
  - Remove `showModalBottomSheet` call
  - Pass `onToggleAttachmentPicker` callback from ChatViewPage to _InputBar
  - _Requirements: 1.1, 5.2, 5.3_

- [ ] 4. Implement attachment selection handlers
  - Update `handleCamera()` to be called from attachment picker
  - Update `handleGallery()` to be called from attachment picker
  - Update `handleVideo()` to be called from attachment picker
  - Update `handleAudio()` to be called from attachment picker
  - Update `handleFilePicker()` to be called from attachment picker
  - Ensure picker closes after successful selection
  - Ensure picker stays open on error
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5_

- [ ] 5. Update keyboard and focus handling
  - Modify `toggleAttachmentPicker()` to unfocus text field when opening picker
  - Update focus listener to close attachment picker when keyboard shows
  - Update `toggleEmojiPicker()` to close attachment picker
  - Update `toggleGallery()` to close attachment picker
  - _Requirements: 6.1, 6.2, 6.3, 6.4_

- [ ] 6. Enhance error handling for attachment operations
  - Add permission denied error messages with Settings link
  - Add network error messages with retry option
  - Add file size error messages
  - Ensure picker remains open on all errors
  - _Requirements: 2.5, 8.1, 8.2, 8.3_

- [ ] 7. Remove bottom sheet implementation
  - Delete `lib/features/chat/presentation/widgets/attachment_picker_bottom_sheet.dart` file
  - Remove all imports of `AttachmentPickerBottomSheet`
  - Remove `_showMenu()` method from _InputBar if it exists
  - Verify no broken imports remain
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

- [ ] 8. Checkpoint - Manual testing
  - Test opening attachment picker with + button
  - Test all attachment types (camera, gallery, video, audio, files)
  - Test picker closes after selection
  - Test mutual exclusivity with emoji picker
  - Test keyboard interaction
  - Test error scenarios
  - Ensure all tests pass, ask the user if questions arise.

- [ ]* 9. Write unit tests for AttachmentPicker widget
  - Test widget renders all 7 attachment options
  - Test correct icons and labels are displayed
  - Test theme-aware colors (light/dark mode)
  - Test tapping each option calls onAttachmentSelected with correct type
  - _Requirements: 3.4, 3.5, 8.4, 8.5_

- [ ]* 10. Write unit tests for ChatViewPage state management
  - Test showAttachmentPicker toggles correctly
  - Test opening attachment picker closes emoji picker
  - Test opening emoji picker closes attachment picker
  - Test keyboard focus closes attachment picker
  - _Requirements: 4.1, 4.2, 4.3, 4.4, 6.2_

- [ ]* 11. Write property test for mutual exclusivity
  - **Property 1: Mutual Exclusivity of Pickers**
  - **Validates: Requirements 1.2, 1.3**
  - Test that at most one picker is visible at any time across all state combinations

- [ ]* 12. Write property test for picker state consistency
  - **Property 2: Picker State Consistency**
  - **Validates: Requirements 1.2, 1.3, 4.3, 4.4**
  - Test that opening one picker always closes all other pickers

- [ ]* 13. Write property test for animation consistency
  - **Property 6: Animation Consistency**
  - **Validates: Requirements 7.1, 7.2, 7.3**
  - Test that all picker animations use 250ms duration with easeOutQuad curve

- [ ]* 14. Write property test for visual consistency
  - **Property 7: Visual Consistency with Emoji Picker**
  - **Validates: Requirements 3.1, 3.2**
  - Test that attachment picker colors match emoji picker colors in both themes

- [ ] 15. Final checkpoint - Verify implementation
  - Run all tests and ensure they pass
  - Verify no regressions in existing functionality
  - Verify attachment picker works on all platforms (iOS, Android, Web)
  - Verify accessibility (touch targets, color contrast, screen readers)
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- The existing `AttachmentPicker` widget requires no modifications
- Focus on maintaining consistency with emoji picker behavior
- Ensure proper error handling to keep picker open on failures
- Test thoroughly on all platforms (iOS, Android, Web)
