import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Location message bubble
class LocationMessageBubble extends StatelessWidget {
  const LocationMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final textColor = getTextColor(context, isMe);
    final textTheme = Theme.of(context).textTheme;

    return BaseBubbleContainer(
      isMe: isMe,
      maxWidth: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Map preview
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Map image (placeholder - you can use actual map service)
                Container(
                  width: 280,
                  height: 150,
                  color: Colors.grey.shade300,
                  child: const Icon(
                    FontAwesomeIcons.mapLocationDot,
                    size: 48,
                    color: Colors.red,
                  ),
                ),
                // Pin icon overlay
                const Icon(
                  FontAwesomeIcons.locationDot,
                  color: Colors.red,
                  size: 36,
                ),
              ],
            ),
          ),
          
          // Location info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location name
                if (message.locationName != null)
                  Text(
                    message.locationName!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                const SizedBox(height: 4),
                
                // Coordinates
                Text(
                  '${message.latitude?.toStringAsFixed(6)}, ${message.longitude?.toStringAsFixed(6)}',
                  style: textTheme.bodySmall?.copyWith(
                    color: textColor.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 8),
                
                // View on map button
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.mapPin,
                      size: 14,
                      color: textColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'View on map',
                      style: textTheme.bodySmall?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
