import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AttachmentPicker extends StatelessWidget {
  final Function(AttachmentType) onAttachmentSelected;
  final Color? backgroundColor;
  final Color? iconColor;

  const AttachmentPicker({super.key, required this.onAttachmentSelected, this.backgroundColor, this.iconColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = backgroundColor ?? (isDark ? const Color(0xFF1C1C1E) : Colors.white);

    return Container(
      decoration: BoxDecoration(color: bgColor),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Send Attachment',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey[200] : Colors.grey[800],
              ),
            ),
          ),

          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _AttachmentOption(
                icon: FontAwesomeIcons.camera,
                label: 'Camera',
                color: Colors.pink,
                onTap: () => onAttachmentSelected(AttachmentType.camera),
              ),
              _AttachmentOption(
                icon: FontAwesomeIcons.image,
                label: 'Gallery',
                color: Colors.purple,
                onTap: () => onAttachmentSelected(AttachmentType.gallery),
              ),
              _AttachmentOption(
                icon: FontAwesomeIcons.video,
                label: 'Video',
                color: Colors.red,
                onTap: () => onAttachmentSelected(AttachmentType.video),
              ),
              _AttachmentOption(
                icon: FontAwesomeIcons.fileLines,
                label: 'Document',
                color: Colors.blue,
                onTap: () => onAttachmentSelected(AttachmentType.document),
              ),
              _AttachmentOption(
                icon: FontAwesomeIcons.faceSmile,
                label: 'Emoji',
                color: Colors.amber,
                onTap: () => onAttachmentSelected(AttachmentType.emoji),
              ),
              _AttachmentOption(
                icon: FontAwesomeIcons.noteSticky,
                label: 'Sticker',
                color: Colors.teal,
                onTap: () => onAttachmentSelected(AttachmentType.sticker),
              ),
              _AttachmentOption(
                icon: FontAwesomeIcons.squarePollVertical,
                label: 'Poll',
                color: Colors.green,
                onTap: () => onAttachmentSelected(AttachmentType.poll),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Individual attachment option widget
class _AttachmentOption extends StatelessWidget {
  const _AttachmentOption({required this.icon, required this.label, required this.color, required this.onTap});

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
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 11),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Enum for attachment types
enum AttachmentType { camera, gallery, video, document, emoji, sticker, poll }
