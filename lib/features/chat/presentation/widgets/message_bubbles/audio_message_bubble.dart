import 'package:audioplayers/audioplayers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

/// Audio/Voice message bubble with audio player
class AudioMessageBubble extends StatefulWidget {
  const AudioMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  final Message message;
  final bool isMe;

  @override
  State<AudioMessageBubble> createState() => _AudioMessageBubbleState();
}

class _AudioMessageBubbleState extends State<AudioMessageBubble>
    with AutomaticKeepAliveClientMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  bool get wantKeepAlive => true; // Keep audio player state when scrolling

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    if (widget.message.mediaUrl == null) return;

    try {
      // Set up listeners
      _audioPlayer.onPlayerStateChanged.listen((state) {
        if (mounted) {
          setState(() {
            _isPlaying = state == PlayerState.playing;
          });
        }
      });

      _audioPlayer.onPositionChanged.listen((position) {
        if (mounted) {
          setState(() {
            _currentPosition = position;
          });
        }
      });

      _audioPlayer.onDurationChanged.listen((duration) {
        if (mounted) {
          setState(() {
            _totalDuration = duration;
          });
        }
      });

      // Auto-stop when completed
      _audioPlayer.onPlayerComplete.listen((_) {
        if (mounted) {
          setState(() {
            _isPlaying = false;
            _currentPosition = Duration.zero;
          });
        }
      });
    } catch (e) {
      debugPrint('❌ Failed to initialize audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    if (widget.message.mediaUrl == null) return;

    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        if (_currentPosition == Duration.zero) {
          await _audioPlayer.play(UrlSource(widget.message.mediaUrl!));
        } else {
          await _audioPlayer.resume();
        }
      }
    } catch (e) {
      debugPrint('❌ Failed to play/pause audio: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to play audio: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    debugPrint('🎵 [AudioMessageBubble] Building for message ${widget.message.id}');
    debugPrint('   mediaUrl: ${widget.message.mediaUrl}');
    debugPrint('   duration: ${widget.message.duration}');

    final textColor = getTextColor(context, widget.isMe);
    final textTheme = Theme.of(context).textTheme;

    // Use actual duration if available, otherwise use message duration
    final displayDuration = _totalDuration.inSeconds > 0
        ? _totalDuration
        : (widget.message.duration != null
            ? Duration(seconds: widget.message.duration!)
            : Duration.zero);

    return BaseBubbleContainer(
      isMe: widget.isMe,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Play/Pause button
            GestureDetector(
              onTap: _togglePlayPause,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: textColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: textColor,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Waveform and duration
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Waveform visualization (simplified)
                  Row(
                    children: List.generate(
                      20,
                      (index) {
                        // Calculate progress for visual feedback
                        final progress = displayDuration.inSeconds > 0
                            ? _currentPosition.inSeconds / displayDuration.inSeconds
                            : 0.0;
                        final isActive = (index / 20) <= progress;

                        return Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            height: (index % 3 + 1) * 8.0,
                            decoration: BoxDecoration(
                              color: textColor.withValues(
                                alpha: isActive ? 0.8 : 0.3,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Duration display
                  Text(
                    _isPlaying
                        ? '${formatDuration(_currentPosition.inSeconds)} / ${formatDuration(displayDuration.inSeconds)}'
                        : formatDuration(displayDuration.inSeconds),
                    style: textTheme.bodySmall?.copyWith(
                      color: textColor.withValues(alpha: 0.7),
                    ),
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

