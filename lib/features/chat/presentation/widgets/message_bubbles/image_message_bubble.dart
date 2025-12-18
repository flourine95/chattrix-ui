import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/format_utils.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/lazy_media_loader.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

/// Image message bubble with full screen viewer
class ImageMessageBubble extends StatelessWidget {
  const ImageMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onReply,
    this.onReactionTap,
    this.onAddReaction,
    this.currentUserId,
    this.replyToMessage,
    this.onEdit,
    this.onDelete,
  });

  final Message message;
  final bool isMe;
  final VoidCallback? onReply;
  final Function(String emoji)? onReactionTap;
  final VoidCallback? onAddReaction;
  final int? currentUserId;
  final Message? replyToMessage;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  void _openFullScreenImage(BuildContext context) {
    if (message.mediaUrl == null) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _FullScreenImageViewer(imageUrl: message.mediaUrl!, caption: message.content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = FormatUtils.getTextColor(context, isMe);
    final textTheme = Theme.of(context).textTheme;
    final hasCaption = message.content.isNotEmpty;

    return BaseBubbleContainer(
      isMe: isMe,
      maxWidth: 280,
      message: message,
      onReply: onReply,
      onReactionTap: onReactionTap,
      onAddReaction: onAddReaction,
      currentUserId: currentUserId,
      replyToMessage: replyToMessage,
      onEdit: onEdit,
      onDelete: onDelete,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with lazy loading and caching
          if (message.mediaUrl != null)
            LazyMediaLoader(
              key: ValueKey('image_${message.id}'),
              placeholder: Container(
                width: 280,
                height: 200,
                color: Colors.grey.shade300,
                child: const Center(child: Icon(Icons.image, size: 48, color: Colors.grey)),
              ),
              child: GestureDetector(
                onTap: () => _openFullScreenImage(context),
                child: ClipRRect(
                  // Bo tròn tất cả các góc nếu không có caption, chỉ bo trên nếu có caption
                  borderRadius: hasCaption
                      ? const BorderRadius.vertical(top: Radius.circular(16))
                      : BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: message.mediaUrl!,
                    width: 280,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 280,
                      height: 200,
                      color: Colors.grey.shade300,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) {
                      return Container(
                        width: 280,
                        height: 200,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image, size: 48),
                      );
                    },
                    // Performance optimizations
                    memCacheWidth: 560, // 2x for retina displays
                    maxWidthDiskCache: 560,
                    fadeInDuration: const Duration(milliseconds: 200),
                    fadeOutDuration: const Duration(milliseconds: 100),
                  ),
                ),
              ),
            ),

          // Caption (if any)
          if (hasCaption)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(message.content, style: textTheme.bodyMedium?.copyWith(color: textColor)),
            ),
        ],
      ),
    );
  }
}

/// Full screen image viewer with zoom and pan
class _FullScreenImageViewer extends StatelessWidget {
  const _FullScreenImageViewer({required this.imageUrl, this.caption});

  final String imageUrl;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: caption != null && caption!.isNotEmpty
            ? Text(caption!, style: const TextStyle(color: Colors.white))
            : null,
      ),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white)),
            errorWidget: (context, url, error) => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.broken_image, size: 64, color: Colors.white),
                  SizedBox(height: 16),
                  Text('Failed to load image', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
