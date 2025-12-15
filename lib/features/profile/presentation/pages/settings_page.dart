import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/profile_shared_components.dart';

// Simple Notifier classes for settings state
class ThemeModeNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;

  void set(bool value) => state = value;
}

class NotificationNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void toggle() => state = !state;

  void set(bool value) => state = value;
}

class VisibilityNotifier extends Notifier<ProfileVisibility> {
  @override
  ProfileVisibility build() => ProfileVisibility.public;

  void set(ProfileVisibility value) => state = value;
}

class LanguageNotifier extends Notifier<String> {
  @override
  String build() => 'English';

  void set(String value) => state = value;
}

// PROVIDERS
final themeModeProvider = NotifierProvider<ThemeModeNotifier, bool>(() {
  return ThemeModeNotifier();
});

final notificationProvider = NotifierProvider<NotificationNotifier, bool>(() {
  return NotificationNotifier();
});

final visibilityProvider = NotifierProvider<VisibilityNotifier, ProfileVisibility>(() {
  return VisibilityNotifier();
});

final languageProvider = NotifierProvider<LanguageNotifier, String>(() {
  return LanguageNotifier();
});

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    // Watch state
    final isDarkMode = ref.watch(themeModeProvider);
    final isNotifEnabled = ref.watch(notificationProvider);
    final currentVisibility = ref.watch(visibilityProvider);
    final currentLanguage = ref.watch(languageProvider);

    return Scaffold(
      backgroundColor: colors.surfaceContainerLow,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        scrolledUnderElevation: 0.5,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // --- GROUP 1: GENERAL ---
            const ProfileSectionLabel(title: 'General'),
            ProfileSectionCard(
              children: [
                ProfileToggleTile(
                  icon: isDarkMode ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
                  iconColor: Colors.orange,
                  label: 'Dark Mode',
                  value: isDarkMode,
                  onChanged: (val) => ref.read(themeModeProvider.notifier).set(val),
                ),
                ProfileToggleTile(
                  icon: FontAwesomeIcons.bell,
                  iconColor: Colors.purple,
                  label: 'Notifications',
                  value: isNotifEnabled,
                  onChanged: (val) => ref.read(notificationProvider.notifier).set(val),
                ),
                ProfileNavigationTile(
                  icon: FontAwesomeIcons.globe,
                  iconColor: Colors.blue,
                  label: 'Language',
                  valueLabel: currentLanguage,
                  onTap: () => _showLanguagePicker(context, ref, currentLanguage),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- GROUP 2: PRIVACY ---
            const ProfileSectionLabel(title: 'Privacy'),
            ProfileSectionCard(
              children: [
                ProfileNavigationTile(
                  icon: FontAwesomeIcons.eye,
                  iconColor: Colors.teal,
                  label: 'Profile Visibility',
                  valueLabel: currentVisibility.label,
                  onTap: () => _showVisibilityPicker(context, ref, currentVisibility),
                ),
                ProfileNavigationTile(
                  icon: FontAwesomeIcons.userShield,
                  iconColor: Colors.indigo,
                  label: 'Blocked Users',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- GROUP 3: ACCOUNT & SECURITY ---
            const ProfileSectionLabel(title: 'Account & Security'),
            ProfileSectionCard(
              children: [
                ProfileNavigationTile(
                  icon: FontAwesomeIcons.key,
                  iconColor: colors.primary,
                  label: 'Change Password',
                  onTap: () => _showChangePasswordDialog(context),
                ),
                ProfileNavigationTile(
                  icon: FontAwesomeIcons.trashCan,
                  iconColor: colors.error,
                  label: 'Delete Account',
                  onTap: () => _showDeleteConfirmDialog(context, colors),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // --- LOGIC: LANGUAGE PICKER ---
  void _showLanguagePicker(BuildContext context, WidgetRef ref, String current) {
    final languages = ['English', 'Vietnamese', 'Spanish', 'French'];

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select Language', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              ...languages.map(
                (lang) => ListTile(
                  leading: lang == current ? const Icon(Icons.check, color: Colors.blue) : const SizedBox(width: 24),
                  title: Text(lang),
                  onTap: () {
                    ref.read(languageProvider.notifier).set(lang);
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // --- LOGIC: VISIBILITY PICKER ---
  void _showVisibilityPicker(BuildContext context, WidgetRef ref, ProfileVisibility current) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Who can see your profile?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              ...ProfileVisibility.values.map(
                (visibility) => ListTile(
                  leading: Icon(
                    visibility == current ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: visibility == current ? Theme.of(context).colorScheme.primary : Colors.grey,
                  ),
                  title: Text(visibility.label),
                  onTap: () {
                    ref.read(visibilityProvider.notifier).set(visibility);
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // --- LOGIC: CHANGE PASSWORD DIALOG ---
  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: InputDecoration(labelText: 'Current Password')),
            TextField(decoration: InputDecoration(labelText: 'New Password')),
            TextField(decoration: InputDecoration(labelText: 'Confirm New Password')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Update')),
        ],
      ),
    );
  }

  // --- LOGIC: DELETE ACCOUNT ---
  void _showDeleteConfirmDialog(BuildContext context, ColorScheme colors) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: colors.error),
            onPressed: () => Navigator.pop(context),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

