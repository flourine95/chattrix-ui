# Implementation Plan - Chat List UI Improvements

- [x] 1. Fix "Your story" alignment with other user items





  - Review and standardize all spacing values between `_MyStoryItem` and `OnlineUserItem`
  - Ensure identical padding, margins, and gaps
  - Verify vertical alignment of avatars
  - Test with and without notes present
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5_


- [x] 2. Implement pinned header with shadow effect



  - [x] 2.1 Configure SliverAppBar with pinned behavior


    - Set `pinned: true` on SliverAppBar
    - Set `elevation: 0` to remove default Material shadow
    - Maintain existing expandedHeight and title styling
    - _Requirements: 2.1, 2.6, 2.7_

  - [x] 2.2 Add custom shadow to header


    - Wrap header content in Container with BoxDecoration
    - Implement theme-aware shadow (light mode: black 0.08 opacity, dark mode: black 0.3 opacity)
    - Use blur radius of 8 and offset of (0, 2)
    - Test shadow visibility in both light and dark themes
    - _Requirements: 2.2, 2.3, 2.4, 2.5_

- [x] 3. Redesign search bar with Messenger-style UI




  - [x] 3.1 Update search bar container styling


    - Change height to 44
    - Set border radius to 22 (pill shape)
    - Update background colors (light: 0xFFF3F4F6, dark: 0xFF2C2C2E)
    - Remove any existing borders
    - Adjust margins to 16 horizontal, 8 vertical
    - _Requirements: 3.1, 3.5, 3.6, 3.10_

  - [x] 3.2 Update search bar content layout

    - Position search icon with 16 left padding, 12 right padding
    - Set icon size to 20
    - Update icon color (light: grey[600], dark: grey[400])
    - Update placeholder text to "Search conversations"
    - Set text size to 16
    - Update text color to match icon color
    - _Requirements: 3.2, 3.3, 3.7_

  - [x] 3.3 Ensure search bar accessibility


    - Verify semantic label is present and descriptive
    - Confirm minimum touch target of 44 height
    - Test tap navigation to search screen
    - Test with screen reader (TalkBack/VoiceOver)
    - _Requirements: 3.4, 3.8, 3.9, 5.1, 5.2_

- [x] 4. Verify visual consistency across all changes





  - Check spacing scale consistency (4, 8, 12, 16, 24, 32)
  - Check border radius consistency (8, 12, 16, 20, 24, 30)
  - Verify all colors come from theme palette
  - Test in both light and dark modes
  - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_

- [x] 5. Final testing and accessibility verification




  - Test "Your story" alignment visually
  - Test header pinning by scrolling
  - Test shadow visibility in both themes
  - Test search bar appearance and interaction
  - Run accessibility audit
  - Test with screen reader
  - Verify contrast ratios meet WCAG AA
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_
