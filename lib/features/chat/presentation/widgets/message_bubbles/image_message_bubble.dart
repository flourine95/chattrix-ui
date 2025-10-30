import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

/// Image message bubble with full screen viewer
class ImageMessageBubble extends StatelessWidget {
  const ImageMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  final Message message;
  final bool isMe;

  void _openFullScreenImage(BuildContext context) {
    if (message.mediaUrl == null) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _FullScreenImageViewer(
          imageUrl: message.mediaUrl!,
          caption: message.content,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🖼️ [ImageMessageBubble] Building for message ${message.id}');
    debugPrint('   mediaUrl: ${message.mediaUrl}');
    debugPrint('   content: ${message.content}');

    final textColor = getTextColor(context, isMe);
    final textTheme = Theme.of(context).textTheme;

    return BaseBubbleContainer(
      isMe: isMe,
      maxWidth: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          if (message.mediaUrl != null)
            GestureDetector(
              onTap: () => _openFullScreenImage(context),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  message.mediaUrl!,
                  width: 280,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      debugPrint('✅ [ImageMessageBubble] Image loaded: ${message.mediaUrl}');
                      return child;
                    }
                    debugPrint('⏳ [ImageMessageBubble] Loading image: ${message.mediaUrl}');
                    return Container(
                      width: 280,
                      height: 200,
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('❌ [ImageMessageBubble] Failed to load image: ${message.mediaUrl}');
                    debugPrint('   Error: $error');
                    return Container(
                      width: 280,
                      height: 200,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 48),
                    );
                  },
                ),
              ),
            ),

          // Caption (if any)
          if (message.content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                message.content,
                style: textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ),
        ],
      ),
    );
  }
}

/// Full screen image viewer with zoom and pan
class _FullScreenImageViewer extends StatelessWidget {
  const _FullScreenImageViewer({
    required this.imageUrl,
    this.caption,
  });

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
            ? Text(
                caption!,
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: Center(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image, size: 64, color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'Failed to load image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

