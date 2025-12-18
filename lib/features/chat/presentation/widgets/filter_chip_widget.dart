import 'package:flutter/material.dart';

/// Custom filter chip widget with animated transitions
///
/// Features:
/// - Animated background/text color transitions (200ms)
/// - Rounded corners (BorderRadius.circular(20))
/// - Tap feedback with InkWell
class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipWidget({super.key, required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Build semantic label
    final semanticLabel = isSelected ? '$label filter selected' : '$label filter. Double tap to select.';

    return Semantics(
      label: semanticLabel,
      button: true,
      enabled: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary
                : (isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black87),
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
