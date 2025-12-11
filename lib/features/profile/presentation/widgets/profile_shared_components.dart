import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileSectionLabel extends StatelessWidget {
  final String title;

  const ProfileSectionLabel({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: colors.onSurfaceVariant,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}

class ProfileSectionCard extends StatelessWidget {
  final List<Widget> children;

  const ProfileSectionCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(children: children),
      ),
    );
  }
}

enum ProfileTileType { navigation, toggle, info }

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final String? value;
  final Color? textColor;
  final ProfileTileType type;

  final bool switchValue;
  final ValueChanged<bool>? onChanged;

  final VoidCallback? onTap;
  final bool showArrow;
  final bool isVerified;
  final bool isDestructive;

  const ProfileTile({
    super.key,
    required this.icon,
    this.iconColor,
    required this.label,
    this.value,
    this.textColor,
    this.type = ProfileTileType.navigation,
    this.switchValue = false,
    this.onChanged,
    this.onTap,
    this.showArrow = true,
    this.isVerified = false,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final effectiveIconColor = isDestructive ? colors.error : (iconColor ?? colors.primary);

    final effectiveTextColor = isDestructive ? colors.error : (textColor ?? colors.onSurface);

    return InkWell(
      onTap: type == ProfileTileType.toggle ? () => onChanged?.call(!switchValue) : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: effectiveIconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FaIcon(icon, size: 16, color: effectiveIconColor),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (value != null && value!.isNotEmpty) ...[
                    Text(label, style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            value!,
                            style: textTheme.bodyMedium?.copyWith(
                              color: effectiveTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.verified, color: Colors.blue, size: 16),
                        ],
                      ],
                    ),
                  ] else
                    Text(
                      label,
                      style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: effectiveTextColor),
                    ),
                ],
              ),
            ),

            if (type == ProfileTileType.toggle)
              Switch(
                value: switchValue,
                activeThumbColor: Colors.white,
                activeTrackColor: colors.primary,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: colors.outlineVariant,
                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                trackOutlineWidth: WidgetStateProperty.all(0),
                onChanged: onChanged,
              )
            else ...[
              if (value != null && value!.isNotEmpty && type == ProfileTileType.navigation)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    value!,
                    style: textTheme.bodySmall?.copyWith(color: colors.primary, fontWeight: FontWeight.bold),
                  ),
                ),
              if (showArrow) Icon(Icons.chevron_right, size: 20, color: colors.outlineVariant),
            ],
          ],
        ),
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isVerified;
  final bool isDestructive;
  final bool showArrow;
  final VoidCallback? onTap;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.isVerified = false,
    this.isDestructive = false,
    this.showArrow = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileTile(
      icon: icon,
      label: label,
      value: value,
      type: ProfileTileType.info,
      isVerified: isVerified,
      isDestructive: isDestructive,
      showArrow: showArrow,
      onTap: onTap,
    );
  }
}

class ProfileNavigationTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final String? valueLabel;
  final VoidCallback onTap;
  final bool showArrow;

  const ProfileNavigationTile({
    super.key,
    required this.icon,
    this.iconColor,
    required this.label,
    this.valueLabel,
    required this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileTile(
      icon: icon,
      iconColor: iconColor,
      label: label,
      value: valueLabel,
      type: ProfileTileType.navigation,
      showArrow: showArrow,
      onTap: onTap,
    );
  }
}

class ProfileToggleTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ProfileToggleTile({
    super.key,
    required this.icon,
    this.iconColor,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileTile(
      icon: icon,
      iconColor: iconColor,
      label: label,
      type: ProfileTileType.toggle,
      switchValue: value,
      onChanged: onChanged,
      showArrow: false,
    );
  }
}

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 56,
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3),
    );
  }
}

List<Widget> buildProfileItems(List<Widget> items) {
  if (items.isEmpty) return [];

  final result = <Widget>[];
  for (int i = 0; i < items.length; i++) {
    result.add(items[i]);
    if (i < items.length - 1) {
      result.add(const ProfileDivider());
    }
  }
  return result;
}
