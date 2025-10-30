import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Location message bubble
class LocationMessageBubble extends StatelessWidget {
  const LocationMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  final Message message;
  final bool isMe;

  /// Open location in Google Maps
  Future<void> _openInMaps() async {
    if (message.latitude == null || message.longitude == null) return;

    final lat = message.latitude!;
    final lng = message.longitude!;

    // Try Google Maps app first, fallback to web
    final googleMapsUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');

    try {
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('❌ Failed to open maps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = getTextColor(context, isMe);
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: _openInMaps,
      child: BaseBubbleContainer(
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
                  // Static map image from Google Maps
                  if (message.latitude != null && message.longitude != null)
                    Image.network(
                      'https://maps.googleapis.com/maps/api/staticmap?'
                      'center=${message.latitude},${message.longitude}'
                      '&zoom=15'
                      '&size=280x150'
                      '&markers=color:red%7C${message.latitude},${message.longitude}'
                      '&key=YOUR_GOOGLE_MAPS_API_KEY', // TODO: Add your API key
                      width: 280,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 280,
                          height: 150,
                          color: Colors.grey.shade300,
                          child: const Icon(
                            FontAwesomeIcons.mapLocationDot,
                            size: 48,
                            color: Colors.red,
                          ),
                        );
                      },
                    )
                  else
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
    ),
    );
  }
}
