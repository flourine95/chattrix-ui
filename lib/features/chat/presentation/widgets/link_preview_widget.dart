import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget to display link preview with image, domain, and URL
class LinkPreviewWidget extends StatelessWidget {
  const LinkPreviewWidget({
    super.key,
    required this.url,
    this.imageUrl,
    this.title,
    this.description,
    required this.textColor,
    required this.isDark,
  });

  final String url;
  final String? imageUrl;
  final String? title;
  final String? description;
  final Color textColor;
  final bool isDark;

  Future<void> _openUrl() async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final uri = Uri.tryParse(url);
    final domain = uri?.host ?? '';

    return InkWell(
      onTap: _openUrl,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isDark ? Colors.white24 : Colors.black12,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview image (if available)
            if (imageUrl != null && imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 160,
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 160,
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    child: Icon(
                      Icons.link,
                      size: 48,
                      color: textColor.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),

            // Link info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Domain with icon
                  Row(
                    children: [
                      Icon(
                        Icons.link,
                        size: 16,
                        color: textColor.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          domain,
                          style: textTheme.bodySmall?.copyWith(
                            color: textColor.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // Title (if available)
                  if (title != null && title!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      title!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // Description (if available)
                  if (description != null && description!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      description!,
                      style: textTheme.bodySmall?.copyWith(
                        color: textColor.withValues(alpha: 0.8),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // URL (always show)
                  const SizedBox(height: 8),
                  Text(
                    url,
                    style: textTheme.bodySmall?.copyWith(
                      color: textColor.withValues(alpha: 0.6),
                      decoration: TextDecoration.underline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
