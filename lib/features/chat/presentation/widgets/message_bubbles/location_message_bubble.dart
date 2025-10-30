import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Location message bubble
class LocationMessageBubble extends StatelessWidget {
  const LocationMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onReply,
    this.onReactionTap,
    this.onAddReaction,
    this.currentUserId,
    this.replyToMessage,
  });

  final Message message;
  final bool isMe;
  final VoidCallback? onReply;
  final Function(String emoji)? onReactionTap;
  final VoidCallback? onAddReaction;
  final int? currentUserId;
  final Message? replyToMessage;

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
      // Silently handle error
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
        message: message,
        onReply: onReply,
        onReactionTap: onReactionTap,
        onAddReaction: onAddReaction,
        currentUserId: currentUserId,
        replyToMessage: replyToMessage,
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
                  // Static map image from Google Maps with caching
                  if (message.latitude != null && message.longitude != null)
                    Builder(
                      builder: (context) {
                        final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
                        final mapUrl = 'https://maps.googleapis.com/maps/api/staticmap?'
                            'center=${message.latitude},${message.longitude}'
                            '&zoom=15'
                            '&size=280x150'
                            '&markers=color:red%7C${message.latitude},${message.longitude}'
                            '&key=$apiKey';

                        return CachedNetworkImage(
                          imageUrl: mapUrl,
                          width: 280,
                          height: 150,
                          fit: BoxFit.cover,
                          memCacheWidth: 560,
                          maxWidthDiskCache: 560,
                          placeholder: (context, url) => Container(
                            width: 280,
                            height: 150,
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) {
                            return Container(
                              width: 280,
                              height: 150,
                              color: Colors.grey.shade300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.mapLocationDot,
                                    size: 48,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Map load failed',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
