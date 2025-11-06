import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:flutter/material.dart';

class MediaGridItem extends StatelessWidget {
  const MediaGridItem({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        // TODO: Open media viewer
        _showMediaViewer(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colors.onSurface.withValues(alpha: 0.1),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _buildMediaPreview(context),
        ),
      ),
    );
  }

  Widget _buildMediaPreview(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    switch (message.type.toUpperCase()) {
      case 'IMAGE':
        return Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: message.thumbnailUrl ?? message.mediaUrl ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: colors.surface,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: colors.surface,
                child: Icon(
                  Icons.broken_image,
                  color: colors.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ),
          ],
        );

      case 'VIDEO':
        return Stack(
          fit: StackFit.expand,
          children: [
            if (message.thumbnailUrl != null)
              CachedNetworkImage(
                imageUrl: message.thumbnailUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: colors.surface,
                ),
                errorWidget: (context, url, error) => Container(
                  color: colors.surface,
                  child: Icon(
                    Icons.videocam,
                    color: colors.onSurface.withValues(alpha: 0.3),
                  ),
                ),
              )
            else
              Container(
                color: colors.surface,
                child: Icon(
                  Icons.videocam,
                  color: colors.onSurface.withValues(alpha: 0.3),
                ),
              ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            if (message.duration != null)
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _formatDuration(message.duration!),
                    style: textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        );

      case 'AUDIO':
        return Container(
          color: colors.primary.withValues(alpha: 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.audiotrack,
                color: colors.primary,
                size: 32,
              ),
              if (message.duration != null) ...[
                const SizedBox(height: 4),
                Text(
                  _formatDuration(message.duration!),
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.primary,
                  ),
                ),
              ],
            ],
          ),
        );

      case 'DOCUMENT':
        return Container(
          color: colors.surface,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.insert_drive_file,
                color: colors.primary,
                size: 32,
              ),
              const SizedBox(height: 4),
              Text(
                message.fileName ?? 'File',
                style: textTheme.labelSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );

      default:
        return Container(
          color: colors.surface,
          child: Icon(
            Icons.attachment,
            color: colors.onSurface.withValues(alpha: 0.3),
          ),
        );
    }
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _showMediaViewer(BuildContext context) {
    // TODO: Implement full-screen media viewer
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Media Viewer'),
        content: Text('View ${message.type}: ${message.mediaUrl}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

