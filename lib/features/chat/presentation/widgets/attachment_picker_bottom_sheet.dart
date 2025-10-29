import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Bottom sheet for selecting attachment type
/// Shows options: Camera, Gallery, Video, Audio, Document, Location
class AttachmentPickerBottomSheet extends StatelessWidget {
  const AttachmentPickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Title
            Text(
              'Send Attachment',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Grid of options
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _AttachmentOption(
                  icon: FontAwesomeIcons.camera,
                  label: 'Camera',
                  color: Colors.pink,
                  onTap: () => Navigator.pop(context, AttachmentType.camera),
                ),
                _AttachmentOption(
                  icon: FontAwesomeIcons.image,
                  label: 'Gallery',
                  color: Colors.purple,
                  onTap: () => Navigator.pop(context, AttachmentType.gallery),
                ),
                _AttachmentOption(
                  icon: FontAwesomeIcons.video,
                  label: 'Video',
                  color: Colors.red,
                  onTap: () => Navigator.pop(context, AttachmentType.video),
                ),
                _AttachmentOption(
                  icon: FontAwesomeIcons.microphone,
                  label: 'Audio',
                  color: Colors.orange,
                  onTap: () => Navigator.pop(context, AttachmentType.audio),
                ),
                _AttachmentOption(
                  icon: FontAwesomeIcons.fileLines,
                  label: 'Document',
                  color: Colors.blue,
                  onTap: () => Navigator.pop(context, AttachmentType.document),
                ),
                _AttachmentOption(
                  icon: FontAwesomeIcons.locationDot,
                  label: 'Location',
                  color: Colors.green,
                  onTap: () => Navigator.pop(context, AttachmentType.location),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// Show the attachment picker bottom sheet
  static Future<AttachmentType?> show(BuildContext context) {
    return showModalBottomSheet<AttachmentType>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const AttachmentPickerBottomSheet(),
    );
  }
}

/// Individual attachment option widget
class _AttachmentOption extends StatelessWidget {
  const _AttachmentOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Enum for attachment types
enum AttachmentType {
  camera,
  gallery,
  video,
  audio,
  document,
  location,
}

