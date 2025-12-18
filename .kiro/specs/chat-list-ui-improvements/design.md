# Design Document - Chat List UI Improvements

## Overview

This design document outlines the implementation approach for improving the chat list UI, focusing on three key areas: alignment consistency for the "Your story" item, a pinned header with shadow effects, and a Messenger-inspired search bar design.

## Architecture

### Component Structure

```
ChatListPage (HookConsumerWidget)
├── Scaffold
│   └── CustomScrollView
│       ├── SliverAppBar (pinned with shadow)
│       │   ├── FlexibleSpaceBar (title)
│       │   └── Actions (new chat button)
│       ├── SliverToBoxAdapter (search bar)
│       ├── SliverToBoxAdapter (filter chips)
│       ├── SliverToBoxAdapter (online users)
│       │   ├── _MyStoryItem (aligned)
│       │   └── OnlineUserItem (multiple)
│       └── SliverAnimatedList (conversations)
```

## Components and Interfaces

### 1. Pinned Header with Shadow

**Implementation Approach:**

The `SliverAppBar` will be configured with:
- `pinned: true` - keeps header visible during scroll
- `elevation: 0` - removes default Material elevation
- Custom shadow using `BoxDecoration` with `boxShadow`

**Shadow Specifications:**

```dart
// Light mode shadow
BoxShadow(
  color: Colors.black.withOpacity(0.08),
  blurRadius: 8,
  offset: Offset(0, 2),
)

// Dark mode shadow
BoxShadow(
  color: Colors.black.withOpacity(0.3),
  blurRadius: 8,
  offset: Offset(0, 2),
)
```

**Header Structure:**
- Height: 80 (expandedHeight)
- Title: "Chats" - 30px, FontWeight.w800
- Actions: IconButton with SVG icon
- Background: Theme scaffold background color
- Shadow: Applied via Container wrapper

### 2. Your Story Alignment Fix

**Problem Analysis:**

The `_MyStoryItem` and `OnlineUserItem` have inconsistent spacing values causing misalignment.

**Solution:**

Standardize all spacing values between both widgets:

| Element | Current (MyStory) | Current (OnlineUser) | Standardized |
|---------|-------------------|----------------------|--------------|
| Note padding | 6x3 | 6x3 | 6x3 ✓ |
| Note font size | 9 | 9 | 9 ✓ |
| Note to avatar gap | 3 | 3 | 3 ✓ |
| Avatar radius | 30 | 30 | 30 ✓ |
| Avatar to label gap | 4 | 4 | 4 ✓ |
| Label font size | 12 | 12 | 12 ✓ |

**Additional Alignment:**
- Ensure both use `mainAxisSize: MainAxisSize.min`
- Ensure both use `mainAxisAlignment: MainAxisAlignment.start`
- Verify container width is identical (70)
- Verify margin is identical (right: 12)

### 3. Messenger-Style Search Bar

**Design Specifications:**

```dart
Container(
  height: 44,
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    color: theme.brightness == Brightness.dark
        ? Color(0xFF2C2C2E)  // Dark mode
        : Color(0xFFF3F4F6),  // Light mode
    borderRadius: BorderRadius.circular(22),  // Pill shape
  ),
  child: Row(
    children: [
      // Search icon
      Padding(
        padding: EdgeInsets.only(left: 16, right: 12),
        child: Icon(
          Icons.search,
          size: 20,
          color: theme.brightness == Brightness.dark
              ? Colors.grey[400]
              : Colors.grey[600],
        ),
      ),
      // Placeholder text
      Expanded(
        child: Text(
          'Search conversations',
          style: TextStyle(
            fontSize: 16,
            color: theme.brightness == Brightness.dark
                ? Colors.grey[400]
                : Colors.grey[600],
          ),
        ),
      ),
    ],
  ),
)
```

**Interaction:**
- Wrapped in `GestureDetector` with `onTap: () => context.push('/search-conversations')`
- Wrapped in `Semantics` with label: "Search conversations. Double tap to open search."
- No border, only background color differentiation
- Smooth tap feedback (optional: scale animation 1.0 → 0.98)

**Visual Characteristics:**
- Height: 44 (comfortable touch target)
- Border radius: 22 (perfect pill)
- Horizontal margin: 16
- Vertical margin: 8
- Icon size: 20
- Icon left padding: 16
- Icon right padding: 12
- Text size: 16

## Data Models

No new data models required. This is purely a UI/presentation layer change.

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: Vertical Alignment Consistency

*For any* online users section rendering, the vertical center of the "Your story" avatar should be at the same Y-coordinate as the vertical center of other user avatars.

**Validates: Requirements 1.1, 1.3**

### Property 2: Spacing Uniformity

*For any* pair of adjacent user items (including "Your story"), the spacing between elements (note-to-avatar, avatar-to-label) should be identical.

**Validates: Requirements 1.2, 1.4, 1.5**

### Property 3: Header Visibility Persistence

*For any* scroll position in the conversation list, the header should remain visible at the top of the viewport.

**Validates: Requirements 2.1, 2.6**

### Property 4: Shadow Presence on Scroll

*For any* scroll position greater than 0, the header should display a shadow effect.

**Validates: Requirements 2.2, 2.3**

### Property 5: Theme-Appropriate Shadow

*For any* theme mode (light or dark), the shadow color and opacity should match the specified values for that theme.

**Validates: Requirements 2.4, 2.5**

### Property 6: Search Bar Shape Consistency

*For any* screen width, the search bar should maintain its pill shape with border radius equal to half its height.

**Validates: Requirements 3.1**

### Property 7: Search Bar Touch Target

*For any* search bar rendering, the minimum touch target height should be at least 44dp.

**Validates: Requirements 3.8**

### Property 8: Theme-Appropriate Colors

*For any* UI element (search bar, shadow, icons), the colors used should come from the theme's color palette and adjust based on brightness mode.

**Validates: Requirements 3.5, 3.7, 4.4**

### Property 9: Accessibility Label Presence

*For any* interactive element (search bar, header actions), a semantic label should be present for screen readers.

**Validates: Requirements 5.1, 5.3, 5.4**

## Error Handling

No error handling changes required. This is a UI-only update.

## Testing Strategy

### Visual Regression Testing

1. **Alignment Tests:**
   - Capture screenshots of online users section
   - Verify "Your story" avatar center aligns with other avatars
   - Measure spacing values programmatically

2. **Header Tests:**
   - Scroll to various positions
   - Verify header remains visible
   - Verify shadow appears when scrolled

3. **Search Bar Tests:**
   - Verify pill shape in light/dark modes
   - Verify touch target size
   - Verify tap navigation works

### Manual Testing Checklist

- [ ] "Your story" aligns with other users
- [ ] Header stays pinned when scrolling
- [ ] Shadow appears on header when scrolled
- [ ] Shadow looks good in light mode
- [ ] Shadow looks good in dark mode
- [ ] Search bar has pill shape
- [ ] Search bar colors match theme
- [ ] Search bar navigates on tap
- [ ] All spacing is consistent
- [ ] Accessibility labels work with screen reader

### Widget Tests

```dart
testWidgets('Search bar should have minimum touch target', (tester) async {
  await tester.pumpWidget(ChatListPage());
  
  final searchBar = find.byType(GestureDetector);
  final size = tester.getSize(searchBar);
  
  expect(size.height, greaterThanOrEqualTo(44));
});

testWidgets('Header should be pinned', (tester) async {
  await tester.pumpWidget(ChatListPage());
  
  final appBar = find.byType(SliverAppBar);
  final widget = tester.widget<SliverAppBar>(appBar);
  
  expect(widget.pinned, isTrue);
});
```

## Implementation Notes

### Order of Implementation

1. Fix "Your story" alignment (quick win)
2. Add pinned header with shadow (medium complexity)
3. Redesign search bar (straightforward)
4. Test and refine

### Performance Considerations

- Shadow rendering is lightweight (single BoxShadow)
- No additional state management needed
- No impact on scroll performance
- Search bar is a simple Container, no performance concerns

### Theme Integration

All colors and styles should use theme values:
```dart
final theme = Theme.of(context);
final isDark = theme.brightness == Brightness.dark;
```

### Accessibility

- Maintain semantic labels on all interactive elements
- Ensure minimum touch targets (48x48 or 44x44 for iOS-style)
- Test with TalkBack/VoiceOver
- Verify contrast ratios in both themes
