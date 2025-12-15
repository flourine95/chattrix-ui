import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../widgets/profile_shared_components.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: colors.surfaceContainerLow,
      appBar: AppBar(
        title: Text('Profile', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        scrolledUnderElevation: 0.5,
        actions: [
          if (profileAsync.hasValue)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton.filledTonal(
                onPressed: () async {
                  final result = await context.push<bool>('/profile/edit');
                  if (result == true && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('✓ Profile updated successfully'),
                        backgroundColor: Colors.green.shade600,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.edit, size: 20),
                tooltip: 'Edit',
                style: IconButton.styleFrom(
                  backgroundColor: colors.surfaceContainerHighest.withValues(alpha: 0.5),
                  foregroundColor: colors.onSurface,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton.filledTonal(
              onPressed: () => context.push('/settings'),
              icon: const Icon(Icons.settings, size: 20),
              tooltip: 'Settings',
              style: IconButton.styleFrom(
                backgroundColor: colors.surfaceContainerHighest.withValues(alpha: 0.5),
                foregroundColor: colors.onSurface,
              ),
            ),
          ),
        ],
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error.toString().replaceAll('Exception: ', ''), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(profileControllerProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (profile) => RefreshIndicator(
          onRefresh: () => ref.refresh(profileControllerProvider.future),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  color: colors.surface,
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 24, top: 10),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.4), width: 1),
                            ),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: colors.primaryContainer,
                              backgroundImage: profile.avatarUrl != null ? NetworkImage(profile.avatarUrl!) : null,
                              child: profile.avatarUrl == null
                                  ? Text(
                                      profile.fullName.isNotEmpty
                                          ? profile.fullName[0].toUpperCase()
                                          : profile.username[0].toUpperCase(),
                                      style: textTheme.displaySmall?.copyWith(
                                        color: colors.onPrimaryContainer,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: profile.online ? Colors.green : colors.outlineVariant,
                                shape: BoxShape.circle,
                                border: Border.all(color: colors.surface, width: 3),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(profile.fullName, style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        '@${profile.username}',
                        style: textTheme.bodyLarge?.copyWith(color: colors.onSurfaceVariant),
                      ),
                      if (profile.bio != null && profile.bio!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                          child: Text(
                            profile.bio!,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(color: colors.onSurface, height: 1.5),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // --- INFO GROUPS ---
                const ProfileSectionLabel(title: 'Personal Info'),
                ProfileSectionCard(
                  children: [
                    ProfileInfoTile(
                      icon: FontAwesomeIcons.envelope,
                      label: 'Email',
                      value: profile.email,
                      isVerified: profile.emailVerified,
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: profile.email));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Email copied to clipboard'),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        );
                      },
                    ),
                    if (profile.phone != null)
                      ProfileInfoTile(
                        icon: FontAwesomeIcons.phone,
                        label: 'Phone',
                        value: profile.phone!,
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: profile.phone!));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Phone number copied to clipboard'),
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          );
                        },
                      ),
                    if (profile.gender != null)
                      ProfileInfoTile(
                        icon: FontAwesomeIcons.venusMars,
                        label: 'Gender',
                        value: profile.gender!, // Already String: MALE, FEMALE, OTHER
                      ),
                    if (profile.dateOfBirth != null)
                      ProfileInfoTile(
                        icon: FontAwesomeIcons.cakeCandles,
                        label: 'Birthday',
                        value: DateFormat('dd MMM, yyyy').format(profile.dateOfBirth!),
                      ),
                    if (profile.location != null)
                      ProfileInfoTile(
                        icon: FontAwesomeIcons.locationDot,
                        label: 'Location',
                        value: profile.location!,
                      ),
                  ],
                ),

                const SizedBox(height: 24),

                const ProfileSectionLabel(title: 'Settings'),
                ProfileSectionCard(
                  children: [
                    ProfileInfoTile(
                      icon: FontAwesomeIcons.lock,
                      label: 'Privacy',
                      value: profile.profileVisibility ?? 'PUBLIC', // Already String
                      showArrow: false,
                    ),
                    ProfileNavigationTile(
                      icon: FontAwesomeIcons.rightFromBracket,
                      iconColor: colors.error,
                      label: 'Logout',
                      showArrow: false,
                      onTap: () => _showLogoutBottomSheet(context, ref, colors, textTheme),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Show logout confirmation dialog (changed from bottom sheet to avoid being covered)
  void _showLogoutBottomSheet(
    BuildContext context,
    WidgetRef ref,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                FontAwesomeIcons.rightFromBracket,
                color: colors.error,
                size: 32,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Logout',
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Are you sure you want to logout from your account?',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: colors.outline, width: 1.5),
                    ),
                    child: const Text('Cancel', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      Navigator.pop(context); // Close dialog
                      // Show loading
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(child: CircularProgressIndicator()),
                      );

                      await ref.read(authNotifierProvider.notifier).logout();

                      if (context.mounted) {
                        Navigator.pop(context); // Close loading
                        context.go('/login');
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: colors.error,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Logout', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
