import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:chattrix_ui/features/profile/domain/entities/gender.dart';
import 'package:chattrix_ui/features/profile/domain/entities/profile_visibility.dart';
import 'package:chattrix_ui/features/profile/domain/entities/update_profile_params.dart';
import 'package:chattrix_ui/features/profile/presentation/providers/profile_providers.dart';
import 'package:chattrix_ui/features/profile/presentation/widgets/profile_picker_widgets.dart';
import 'package:chattrix_ui/features/profile/presentation/widgets/profile_ui_components.dart';
import 'package:chattrix_ui/features/profile/presentation/widgets/single_field_editor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final profileAsync = ref.watch(profileControllerProvider);

    final username = useState('');
    final fullName = useState('');
    final bio = useState('');
    final phone = useState('');
    final email = useState('');
    final location = useState('');
    final gender = useState<Gender?>(null);
    final dob = useState<DateTime?>(null);
    final visibility = useState<ProfileVisibility>(ProfileVisibility.public);
    final avatarPath = useState<String?>(null);
    final avatarUrl = useState<String?>(null);
    final isInitialized = useState(false);
    final hasUnsavedChanges = useState(false);

    useEffect(() {
      final currentProfile = profileAsync.asData?.value;
      if (!isInitialized.value && currentProfile != null) {
        username.value = currentProfile.username;
        fullName.value = currentProfile.fullName;
        bio.value = currentProfile.bio ?? '';
        phone.value = currentProfile.phone ?? '';
        email.value = currentProfile.email;
        location.value = currentProfile.location ?? '';
        gender.value = currentProfile.gender;
        dob.value = currentProfile.dateOfBirth;
        visibility.value = currentProfile.profileVisibility ?? ProfileVisibility.public;
        avatarUrl.value = currentProfile.avatarUrl;
        isInitialized.value = true;
      }
      return null;
    }, [profileAsync.asData?.value]);

    useEffect(
      () {
        if (isInitialized.value) {
          final currentProfile = profileAsync.asData?.value;
          if (currentProfile != null) {
            final changed =
                username.value != currentProfile.username ||
                fullName.value != currentProfile.fullName ||
                bio.value != (currentProfile.bio ?? '') ||
                phone.value != (currentProfile.phone ?? '') ||
                email.value != currentProfile.email ||
                location.value != (currentProfile.location ?? '') ||
                gender.value != currentProfile.gender ||
                dob.value != currentProfile.dateOfBirth ||
                visibility.value != (currentProfile.profileVisibility ?? ProfileVisibility.public) ||
                avatarPath.value != null;
            hasUnsavedChanges.value = changed;
          }
        }
        return null;
      },
      [
        username.value,
        fullName.value,
        bio.value,
        phone.value,
        email.value,
        location.value,
        gender.value,
        dob.value,
        visibility.value,
        avatarPath.value,
        isInitialized.value,
      ],
    );

    Future<bool> onWillPop() async {
      if (!hasUnsavedChanges.value) return true;

      final shouldPop = await showModalBottomSheet<bool>(
        context: context,
        backgroundColor: colors.surface,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: colors.errorContainer, borderRadius: BorderRadius.circular(12)),
                      child: Icon(Icons.warning_rounded, color: colors.error, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Discard changes?',
                        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'You have unsaved changes. Are you sure you want to leave without saving?',
                  style: textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant, height: 1.4),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          side: BorderSide(color: colors.outline, width: 1.5),
                        ),
                        child: const Text('Keep Editing', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: FilledButton.styleFrom(
                          backgroundColor: colors.error,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Discard', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      return shouldPop ?? false;
    }

    Future<void> saveProfile() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        final params = UpdateProfileParams(
          username: username.value,
          email: email.value,
          fullName: fullName.value,
          phone: phone.value.isNotEmpty ? phone.value : null,
          bio: bio.value.isNotEmpty ? bio.value : null,
          dateOfBirth: dob.value,
          gender: gender.value,
          location: location.value.isNotEmpty ? location.value : null,
          profileVisibility: visibility.value,
          avatarUrl: avatarPath.value != null ? null : avatarUrl.value,
        );

        File? newImageFile;
        if (avatarPath.value != null) {
          newImageFile = File(avatarPath.value!);
        }

        await ref.read(profileControllerProvider.notifier).updateProfile(params: params, newAvatarFile: newImageFile);

        if (context.mounted) {
          Navigator.pop(context);

          final currentState = ref.read(profileControllerProvider);

          if (currentState.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Update failed: ${currentState.error.toString().replaceAll('Exception: ', '')}'),
                backgroundColor: colors.error,
              ),
            );
          } else {
            hasUnsavedChanges.value = false;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully!')));
            context.pop();
          }
        }
      } catch (e) {
        if (context.mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: colors.error,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        }
      }
    }

    void openEditor({
      required String title,
      required String label,
      required String currentValue,
      required ValueNotifier<String> notifier,
      required int maxLength,
      int maxLines = 1,
      TextInputType inputType = TextInputType.text,
      String? helperText,
    }) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SingleFieldEditor(
            title: title,
            label: label,
            initialValue: currentValue,
            maxLength: maxLength,
            maxLines: maxLines,
            inputType: inputType,
            helperText: helperText,
            onSave: (val) {
              notifier.value = val;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('$title updated'), duration: const Duration(seconds: 1)));
            },
          ),
        ),
      );
    }

    void showAvatarPicker() {
      final picker = ImagePicker();
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PickerOption(
                icon: Icons.camera_alt_rounded,
                label: 'Take a photo',
                onTap: () async {
                  Navigator.pop(context);
                  final img = await picker.pickImage(source: ImageSource.camera);
                  if (img != null) avatarPath.value = img.path;
                },
              ),
              const SizedBox(height: 12),
              PickerOption(
                icon: Icons.photo_library_rounded,
                label: 'Choose from gallery',
                onTap: () async {
                  Navigator.pop(context);
                  final img = await picker.pickImage(source: ImageSource.gallery);
                  if (img != null) avatarPath.value = img.path;
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
    }

    void showDatePickerDialog() {
      BottomPicker.date(
        pickerTitle: const Text('Select Birthday', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        dateOrder: DatePickerDateOrder.dmy,
        initialDateTime: dob.value ?? DateTime(2000),
        maxDateTime: DateTime.now(),
        minDateTime: DateTime(1900),
        bottomPickerTheme: BottomPickerTheme.blue,
        buttonSingleColor: colors.primary,
        backgroundColor: colors.surface,
        onSubmit: (date) {
          if (date is DateTime) dob.value = date;
        },
        buttonContent: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              'Confirm',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        buttonWidth: 200,
        displaySubmitButton: true,
      ).show(context);
    }

    void showGenderPicker() {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Gender', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              GenderOption(
                gender: Gender.male,
                selectedGender: gender.value,
                onSelect: (g) {
                  gender.value = g;
                  Navigator.pop(context);
                },
              ),
              GenderOption(
                gender: Gender.female,
                selectedGender: gender.value,
                onSelect: (g) {
                  gender.value = g;
                  Navigator.pop(context);
                },
              ),
              GenderOption(
                gender: Gender.other,
                selectedGender: gender.value,
                onSelect: (g) {
                  gender.value = g;
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }

    void showVisibilityPicker() {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Profile Visibility', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ...ProfileVisibility.values.map(
                  (v) => ListTile(
                    leading: Icon(
                      visibility.value == v ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: visibility.value == v ? colors.primary : colors.onSurfaceVariant,
                    ),
                    title: Text(v.label),
                    onTap: () {
                      visibility.value = v;
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    }
    if (profileAsync.isLoading && !isInitialized.value) {
      return Scaffold(
        backgroundColor: colors.surfaceContainerLow,
        appBar: AppBar(title: const Text('Edit Profile'), backgroundColor: colors.surface),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: colors.surfaceContainerLow,
        appBar: AppBar(
          title: const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: colors.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0.5,
          shadowColor: Colors.black.withValues(alpha: 0.1),
          scrolledUnderElevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              final shouldPop = await onWillPop();
              if (shouldPop && context.mounted) {
                context.pop();
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: saveProfile,
              child: Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colors.primary),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: [
            Center(
              child: GestureDetector(
                onTap: showAvatarPicker,
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.4), width: 1),
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: colors.surfaceContainerHighest,
                          backgroundImage: avatarPath.value != null
                              ? FileImage(File(avatarPath.value!))
                              : (avatarUrl.value != null ? NetworkImage(avatarUrl.value!) : null) as ImageProvider?,
                          child: avatarPath.value == null && avatarUrl.value == null
                              ? Text(
                                  fullName.value.isNotEmpty ? fullName.value[0].toUpperCase() : '?',
                                  style: textTheme.displayMedium?.copyWith(
                                    color: colors.onSurfaceVariant,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: colors.surface, width: 3),
                          ),
                          child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Change Photo',
                style: textTheme.labelMedium?.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 32),

            const SectionHeader(title: 'PERSONAL INFORMATION'),
            MenuCard(
              children: [
                ProfileMenuItem(
                  label: 'Username',
                  value: '@${username.value}',
                  icon: FontAwesomeIcons.at,
                  onTap: () => openEditor(
                    title: 'Username',
                    label: 'Unique ID',
                    currentValue: username.value,
                    notifier: username,
                    maxLength: 20,
                    helperText: 'Only letters, numbers, dot and underscore.',
                  ),
                ),
                ProfileMenuItem(
                  label: 'Name',
                  value: fullName.value,
                  icon: FontAwesomeIcons.user,
                  onTap: () => openEditor(
                    title: 'Name',
                    label: 'Full Name',
                    currentValue: fullName.value,
                    notifier: fullName,
                    maxLength: 100,
                  ),
                ),
                ProfileMenuItem(
                  label: 'Gender',
                  value: gender.value?.label ?? 'Not set',
                  icon: FontAwesomeIcons.venusMars,
                  onTap: showGenderPicker,
                ),
                ProfileMenuItem(
                  label: 'Birthday',
                  value: dob.value != null ? DateFormat('dd MMM, yyyy').format(dob.value!) : 'Not set',
                  icon: FontAwesomeIcons.cakeCandles,
                  onTap: showDatePickerDialog,
                ),
                ProfileMenuItem(
                  label: 'Location',
                  value: location.value.isNotEmpty ? location.value : 'Not set',
                  icon: FontAwesomeIcons.locationDot,
                  onTap: () => openEditor(
                    title: 'Location',
                    label: 'Current City',
                    currentValue: location.value,
                    notifier: location,
                    maxLength: 100,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const SectionHeader(title: 'CONTACT INFO'),
            MenuCard(
              children: [
                ProfileMenuItem(
                  label: 'Email',
                  value: email.value,
                  icon: FontAwesomeIcons.envelope,
                  isVerified: profileAsync.asData?.value.isEmailVerified ?? false,
                  onTap: () => openEditor(
                    title: 'Email',
                    label: 'Email Address',
                    currentValue: email.value,
                    notifier: email,
                    maxLength: 50,
                    inputType: TextInputType.emailAddress,
                    helperText: 'Changing email will require re-verification.',
                  ),
                ),
                ProfileMenuItem(
                  label: 'Phone',
                  value: phone.value.isNotEmpty ? phone.value : 'Not set',
                  icon: FontAwesomeIcons.phone,
                  onTap: () => openEditor(
                    title: 'Phone',
                    label: 'Phone Number',
                    currentValue: phone.value,
                    notifier: phone,
                    maxLength: 20,
                    inputType: TextInputType.phone,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const SectionHeader(title: 'ABOUT'),
            MenuCard(
              children: [
                ProfileMenuItem(
                  label: 'Bio',
                  value: bio.value.isNotEmpty ? bio.value : 'Not set',
                  icon: FontAwesomeIcons.penToSquare,
                  onTap: () => openEditor(
                    title: 'Bio',
                    label: 'About yourself',
                    currentValue: bio.value,
                    notifier: bio,
                    maxLength: 500,
                    maxLines: 5,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const SectionHeader(title: 'PRIVACY'),
            MenuCard(
              children: [
                ProfileMenuItem(
                  label: 'Profile Visibility',
                  value: visibility.value.label,
                  icon: visibility.value == ProfileVisibility.private
                      ? FontAwesomeIcons.lock
                      : visibility.value == ProfileVisibility.friendsOnly
                      ? FontAwesomeIcons.userGroup
                      : FontAwesomeIcons.globe,
                  onTap: showVisibilityPicker,
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
