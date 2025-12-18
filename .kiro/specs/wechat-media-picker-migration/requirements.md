# Requirements Document

## Introduction

This document outlines the requirements for migrating the Chattrix UI chat feature from using `image_picker` and `file_picker` packages to the more feature-rich WeChat-style media pickers: `wechat_assets_picker` (v10.0.0) and `wechat_camera_picker` (v4.4.0). These packages provide a native WeChat-like experience with better UI/UX, multi-selection capabilities, and more granular control over media selection.

## Glossary

- **MediaPickerService**: The service class responsible for handling all media selection operations (images, videos, documents, audio)
- **wechat_assets_picker**: A Flutter package that provides a WeChat-style asset picker for selecting images and videos from the device gallery with advanced features like multi-selection, preview, and filtering
- **wechat_camera_picker**: A Flutter package that provides a WeChat-style camera interface for capturing photos and videos
- **AssetEntity**: The data model used by wechat_assets_picker to represent media assets (images, videos, audio)
- **AssetPicker**: The main widget provided by wechat_assets_picker for displaying the asset selection interface
- **CameraPicker**: The main widget provided by wechat_camera_picker for displaying the camera interface
- **Chat Feature**: The messaging functionality where users can send text, images, videos, voice messages, and documents
- **Multi-selection**: The ability to select multiple media items (images/videos) at once from the gallery
- **Asset Preview**: The ability to preview selected media before confirming the selection

## Requirements

### Requirement 1

**User Story:** As a chat user, I want to select multiple images from my gallery using a WeChat-style interface, so that I can share multiple photos efficiently in a single action.

#### Acceptance Criteria

1. WHEN a user taps the gallery button in the chat input area THEN the system SHALL display the wechat_assets_picker interface for image selection
2. WHEN the asset picker is displayed THEN the system SHALL configure it to allow selection of up to 9 images at once
3. WHEN a user selects multiple images THEN the system SHALL display a preview of all selected images with selection indicators
4. WHEN a user confirms the selection THEN the system SHALL return all selected AssetEntity objects to the MediaPickerService
5. WHEN the MediaPickerService receives AssetEntity objects THEN the system SHALL convert them to File objects for upload

### Requirement 2

**User Story:** As a chat user, I want to capture photos using a WeChat-style camera interface, so that I can take and send photos with a familiar and intuitive experience.

#### Acceptance Criteria

1. WHEN a user taps the camera button in the chat input area THEN the system SHALL display the wechat_camera_picker interface
2. WHEN the camera picker is displayed THEN the system SHALL configure it for photo capture mode with appropriate quality settings
3. WHEN a user captures a photo THEN the system SHALL display a preview of the captured photo with options to retake or confirm
4. WHEN a user confirms the captured photo THEN the system SHALL return the AssetEntity to the MediaPickerService
5. WHEN the MediaPickerService receives the captured photo AssetEntity THEN the system SHALL convert it to a File object for upload

### Requirement 3

**User Story:** As a chat user, I want to select videos from my gallery using the same WeChat-style interface, so that I can share video content with consistent UX.

#### Acceptance Criteria

1. WHEN a user taps the video selection option THEN the system SHALL display the wechat_assets_picker interface configured for video selection
2. WHEN the video picker is displayed THEN the system SHALL filter to show only video assets
3. WHEN a user selects a video THEN the system SHALL validate that the video duration does not exceed 5 minutes
4. WHEN a video exceeds the duration limit THEN the system SHALL display an error message and prevent selection
5. WHEN a user confirms a valid video selection THEN the system SHALL return the video AssetEntity to the MediaPickerService

### Requirement 4

**User Story:** As a chat user, I want to record videos using the WeChat-style camera interface, so that I can capture and send video messages directly from the chat.

#### Acceptance Criteria

1. WHEN a user taps the video recording option THEN the system SHALL display the wechat_camera_picker interface in video recording mode
2. WHEN the camera picker is in video mode THEN the system SHALL configure a maximum recording duration of 5 minutes
3. WHEN a user records a video THEN the system SHALL display real-time recording duration feedback
4. WHEN the recording reaches the maximum duration THEN the system SHALL automatically stop recording and show the preview
5. WHEN a user confirms the recorded video THEN the system SHALL return the video AssetEntity to the MediaPickerService

### Requirement 5

**User Story:** As a developer, I want the MediaPickerService to maintain backward compatibility with existing code, so that the migration does not break existing functionality.

#### Acceptance Criteria

1. WHEN the MediaPickerService methods are called THEN the system SHALL maintain the same method signatures as the current implementation
2. WHEN any picker method returns data THEN the system SHALL return File objects (not AssetEntity objects) to maintain compatibility
3. WHEN an AssetEntity needs conversion THEN the system SHALL use the AssetEntity.file() or AssetEntity.originFile() method to obtain the File object
4. WHEN a picker operation is cancelled THEN the system SHALL return null (for single selection) or empty list (for multi-selection)
5. WHEN an error occurs during asset conversion THEN the system SHALL log the error and rethrow it for upstream handling

### Requirement 6

**User Story:** As a chat user, I want proper permission handling for camera and gallery access, so that I understand why permissions are needed and can grant them appropriately.

#### Acceptance Criteria

1. WHEN the system needs camera access THEN the system SHALL request camera permission using the permission_handler package
2. WHEN the system needs photo library access THEN the system SHALL request photos permission using the permission_handler package
3. WHEN a permission is denied THEN the system SHALL return null and log the permission denial
4. WHEN a permission is permanently denied THEN the system SHALL provide guidance to the user on how to enable it in settings
5. WHEN all required permissions are granted THEN the system SHALL proceed with the media picker operation

### Requirement 7

**User Story:** As a developer, I want to configure the WeChat pickers with appropriate settings, so that they provide optimal user experience and meet app requirements.

#### Acceptance Criteria

1. WHEN configuring wechat_assets_picker THEN the system SHALL set maxAssets to 9 for multi-image selection
2. WHEN configuring wechat_assets_picker THEN the system SHALL set requestType to RequestType.image or RequestType.video based on the operation
3. WHEN configuring wechat_assets_picker THEN the system SHALL enable textDelegate for localization support
4. WHEN configuring wechat_camera_picker THEN the system SHALL set enableRecording to true for video mode and false for photo mode
5. WHEN configuring wechat_camera_picker THEN the system SHALL set maximumRecordingDuration to 5 minutes for video recording

### Requirement 8

**User Story:** As a chat user, I want image quality optimization during selection, so that uploaded images are appropriately sized without excessive file sizes.

#### Acceptance Criteria

1. WHEN selecting images from gallery THEN the system SHALL configure maximum dimensions of 1920x1920 pixels
2. WHEN capturing photos with camera THEN the system SHALL configure maximum dimensions of 1920x1920 pixels
3. WHEN converting AssetEntity to File THEN the system SHALL preserve the quality settings configured in the picker
4. WHEN images exceed maximum dimensions THEN the system SHALL automatically scale them down while maintaining aspect ratio
5. WHEN quality optimization is applied THEN the system SHALL maintain acceptable visual quality for chat purposes

### Requirement 9

**User Story:** As a developer, I want to remove deprecated dependencies, so that the codebase uses actively maintained packages and follows best practices.

#### Acceptance Criteria

1. WHEN the migration is complete THEN the system SHALL remove image_picker dependency from pubspec.yaml
2. WHEN the migration is complete THEN the system SHALL remove file_picker dependency from pubspec.yaml (for image/video operations only)
3. WHEN dependencies are removed THEN the system SHALL verify that no other features depend on these packages
4. WHEN the profile feature uses image_picker THEN the system SHALL keep image_picker only if profile feature is not migrated
5. WHEN all imports are updated THEN the system SHALL ensure no unused imports remain in the codebase

### Requirement 10

**User Story:** As a chat user, I want error handling for media selection failures, so that I receive clear feedback when something goes wrong.

#### Acceptance Criteria

1. WHEN an asset conversion fails THEN the system SHALL log the error with appropriate context using AppLogger
2. WHEN a picker operation throws an exception THEN the system SHALL catch it and rethrow with context
3. WHEN the user cancels a picker operation THEN the system SHALL handle it gracefully without showing error messages
4. WHEN a file cannot be accessed THEN the system SHALL return null and log the access failure
5. WHEN multiple operations fail in sequence THEN the system SHALL ensure each failure is logged independently
