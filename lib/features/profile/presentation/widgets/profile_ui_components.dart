// ==========================================
// FILE: profile_ui_components.dart
// Legacy file - now exports shared components
// ==========================================

import 'package:flutter/material.dart';

// Export shared components for backward compatibility
export 'profile_shared_components.dart';

// Legacy aliases for backward compatibility
import 'profile_shared_components.dart';

// SectionHeader is now ProfileSectionLabel
typedef SectionHeader = ProfileSectionLabel;

// MenuCard is now ProfileSectionCard
typedef MenuCard = ProfileSectionCard;

// ProfileMenuItem - Custom wrapper for edit profile page
class ProfileMenuItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isVerified;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.isVerified = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileInfoTile(
      icon: icon,
      label: label,
      value: value,
      isVerified: isVerified,
      showArrow: true,
      onTap: onTap,
    );
  }
}
