import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Video message bubble with video player
class VideoMessageBubble extends StatefulWidget {
  const VideoMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  final Message message;
  final bool isMe;

  @override
  State<VideoMessageBubble> createState() => _VideoMessageBubbleState();
}

class _VideoMessageBubbleState extends State<VideoMessageBubble> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    if (widget.message.mediaUrl == null) return;

    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.message.mediaUrl!),
      );

      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }

      _controller!.addListener(() {
        if (mounted) {
          setState(() {
            _isPlaying = _controller!.value.isPlaying;
          });
        }
      });
    } catch (e) {
      debugPrint('❌ Failed to initialize video: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller == null || !_isInitialized) return;

    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = getTextColor(context, widget.isMe);
    final textTheme = Theme.of(context).textTheme;

    return BaseBubbleContainer(
      isMe: widget.isMe,
      maxWidth: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video player or thumbnail
          if (widget.message.mediaUrl != null)
            GestureDetector(
              onTap: _togglePlayPause,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: _isInitialized && _controller != null
                        ? AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          )
                        : widget.message.thumbnailUrl != null
                            ? Image.network(
                                widget.message.thumbnailUrl!,
                                width: 280,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 280,
                                    height: 200,
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.videocam, size: 48),
                                  );
                                },
                              )
                            : Container(
                                width: 280,
                                height: 200,
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                  ),
                  // Play/Pause button overlay
                  if (!_isPlaying)
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  // Duration badge
                  if (widget.message.duration != null && !_isPlaying)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          formatDuration(widget.message.duration!),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  // Video progress indicator
                  if (_isInitialized && _controller != null)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: VideoProgressIndicator(
                        _controller!,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                          playedColor: Colors.blue,
                          bufferedColor: Colors.grey,
                          backgroundColor: Colors.black26,
                        ),
                      ),
                    ),
                ],
              ),
            ),

          // Caption (if any)
          if (widget.message.content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                widget.message.content,
                style: textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ),
        ],
      ),
    );
  }
}

