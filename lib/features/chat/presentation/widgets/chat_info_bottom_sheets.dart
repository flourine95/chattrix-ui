import 'package:flutter/material.dart';

/// Change Nickname Bottom Sheet
void showChangeNicknameBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
  final controller = TextEditingController();
  
  showModalBottomSheet(
    context: context,
    backgroundColor: colors.surface,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: colors.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Text(
            'Change Nickname',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // Text field (rounded)
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter nickname',
              filled: true,
              fillColor: colors.surfaceContainerHighest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),

          const SizedBox(height: 20),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: Save nickname
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

/// Block User Bottom Sheet
void showBlockUserBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
  showModalBottomSheet(
    context: context,
    backgroundColor: colors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: colors.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Warning icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.block, color: Colors.red, size: 32),
          ),

          const SizedBox(height: 20),

          // Title
          Text(
            'Block User?',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            'Blocked users won\'t be able to send you messages or see your online status.',
            style: textTheme.bodyMedium?.copyWith(
              color: colors.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: Block user
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Block'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

/// Wallpaper Options Bottom Sheet
void showWallpaperOptions(BuildContext context, ColorScheme colors, TextTheme textTheme) {
  showModalBottomSheet(
    context: context,
    backgroundColor: colors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: colors.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Text(
            'Change Wallpaper',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // Options
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.photo_library, color: colors.onPrimaryContainer),
            ),
            title: const Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Choose from gallery
            },
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.wallpaper, color: colors.onSecondaryContainer),
            ),
            title: const Text('Choose from Presets'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Choose from presets
            },
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.tertiaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.color_lens, color: colors.onTertiaryContainer),
            ),
            title: const Text('Solid Color'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Choose solid color
            },
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delete, color: Colors.red),
            ),
            title: const Text('Remove Wallpaper', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              // TODO: Remove wallpaper
            },
          ),

          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

