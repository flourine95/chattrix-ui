# Requirements Document - Chat List UI Improvements

## Introduction

This document outlines the requirements for improving the chat list user interface, focusing on visual consistency, header behavior, and search functionality redesign inspired by Messenger's design patterns.

## Glossary

- **Chat List Page**: The main screen displaying conversations and online users
- **Header**: The top section containing the "Chats" title and action buttons
- **Online Users Section**: Horizontal scrollable list showing online users with their stories/notes
- **Your Story Item**: The first item in the online users list representing the current user
- **Search Bar**: The input field for searching conversations
- **Shadow**: Visual depth effect applied to UI elements
- **Pinned Header**: A header that remains visible at the top when scrolling

## Requirements

### Requirement 1: Your Story Alignment

**User Story:** As a user, I want the "Your story" item to be visually aligned with other online user items, so that the interface looks consistent and professional.

#### Acceptance Criteria

1. WHEN the online users section is displayed THEN the "Your story" item SHALL have the same vertical alignment as other user items
2. WHEN a note is present on "Your story" THEN the note container SHALL have the same height and padding as notes on other user items
3. WHEN the avatar is displayed THEN the "Your story" avatar SHALL be positioned at the same vertical level as other user avatars
4. WHEN the label text is displayed THEN the "Your story" label SHALL align with other user name labels
5. WHEN measuring spacing THEN all spacing values (margins, padding, gaps) SHALL be identical between "Your story" and other user items

### Requirement 2: Pinned Header with Shadow

**User Story:** As a user, I want the header to remain visible and elevated when I scroll through conversations, so that I can always access the title and action buttons while maintaining visual hierarchy.

#### Acceptance Criteria

1. WHEN the user scrolls down the conversation list THEN the header SHALL remain fixed at the top of the screen
2. WHEN the header is pinned THEN the system SHALL apply a subtle shadow effect to indicate elevation
3. WHEN the shadow is applied THEN it SHALL use a soft gradient with appropriate opacity for the current theme (light/dark)
4. WHEN in light mode THEN the shadow SHALL be dark with low opacity (e.g., black at 0.05-0.1)
5. WHEN in dark mode THEN the shadow SHALL be slightly lighter to maintain visibility
6. WHEN the user scrolls THEN the header SHALL maintain its height and content layout
7. WHEN the header is displayed THEN the "Chats" title and action buttons SHALL remain accessible

### Requirement 3: Messenger-Style Search Bar

**User Story:** As a user, I want a modern, intuitive search interface similar to Messenger but customized to match the app's design language, so that I can quickly find conversations with a familiar and polished experience.

#### Acceptance Criteria

1. WHEN the search bar is displayed THEN it SHALL feature a rounded pill shape with consistent border radius
2. WHEN the search bar is rendered THEN it SHALL include a search icon on the left side with appropriate spacing
3. WHEN the search bar is in idle state THEN it SHALL display placeholder text "Search conversations" or similar
4. WHEN the user taps the search bar THEN it SHALL navigate to a dedicated search screen
5. WHEN the search bar is displayed THEN it SHALL use theme-appropriate background colors (light gray for light mode, dark gray for dark mode)
6. WHEN the search bar is rendered THEN it SHALL have subtle padding and margins that match the app's spacing system
7. WHEN the search icon is displayed THEN it SHALL use the theme's secondary color or a muted variant
8. WHEN the search bar is displayed THEN it SHALL have a minimum touch target size of 48x48 dp for accessibility
9. WHEN the search bar is positioned THEN it SHALL be placed below the header and above the filter chips
10. WHEN the search bar is styled THEN it SHALL NOT have a visible border, only background color differentiation

### Requirement 4: Visual Consistency

**User Story:** As a user, I want all UI elements to follow consistent design patterns, so that the interface feels cohesive and professional.

#### Acceptance Criteria

1. WHEN any spacing is applied THEN it SHALL use values from a consistent spacing scale (4, 8, 12, 16, 24, 32, etc.)
2. WHEN any border radius is applied THEN it SHALL use values from a consistent radius scale (8, 12, 16, 20, 24, 30)
3. WHEN any shadow is applied THEN it SHALL use predefined elevation levels with consistent blur and opacity
4. WHEN colors are applied THEN they SHALL come from the theme's color palette
5. WHEN typography is used THEN it SHALL follow the app's text style system

### Requirement 5: Accessibility

**User Story:** As a user with accessibility needs, I want all interactive elements to be properly labeled and sized, so that I can navigate the interface using assistive technologies.

#### Acceptance Criteria

1. WHEN the search bar is rendered THEN it SHALL have a semantic label describing its purpose
2. WHEN the search bar is displayed THEN it SHALL have a minimum touch target of 48x48 dp
3. WHEN the header actions are displayed THEN they SHALL have descriptive tooltips and semantic labels
4. WHEN screen reader is active THEN all interactive elements SHALL announce their purpose and state
5. WHEN using high contrast mode THEN all elements SHALL maintain sufficient contrast ratios (WCAG AA minimum)
