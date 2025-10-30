import 'dart:async';
import 'dart:io';
import 'package:chattrix_ui/core/services/voice_recorder_provider.dart';
import 'package:chattrix_ui/core/services/voice_recorder_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Widget for recording voice messages
class VoiceRecorderWidget extends HookConsumerWidget {
  const VoiceRecorderWidget({
    super.key,
    required this.onRecordingComplete,
    required this.onCancel,
  });

  final Function(File audioFile, Duration duration) onRecordingComplete;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recorderService = ref.watch(voiceRecorderServiceProvider);
    final isRecording = useState(false);
    final isPaused = useState(false);
    final duration = useState(Duration.zero);
    final durationSubscription = useRef<StreamSubscription?>(null);

    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    useEffect(() {
      // Subscribe to duration stream
      durationSubscription.value = recorderService.durationStream.listen((d) {
        duration.value = d;
      });

      // Start recording immediately
      _startRecording(recorderService, isRecording);

      return () {
        durationSubscription.value?.cancel();
      };
    }, []);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Recording indicator
          Row(
            children: [
              // Animated recording dot
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isPaused.value ? colors.error.withValues(alpha: 0.5) : colors.error,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              // Duration
              Text(
                _formatDuration(duration.value),
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFeatures: [const FontFeature.tabularFigures()],
                ),
              ),
              const Spacer(),
              // Status text
              Text(
                isPaused.value ? 'Paused' : 'Recording...',
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Waveform visualization (simplified)
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: _WaveformVisualizer(
                isRecording: isRecording.value && !isPaused.value,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Cancel button
              _RecorderButton(
                icon: Icons.close,
                label: 'Cancel',
                color: colors.error,
                onPressed: () async {
                  await recorderService.cancelRecording();
                  onCancel();
                },
              ),
              // Pause/Resume button
              _RecorderButton(
                icon: isPaused.value ? Icons.play_arrow : Icons.pause,
                label: isPaused.value ? 'Resume' : 'Pause',
                color: colors.primary,
                onPressed: () async {
                  if (isPaused.value) {
                    await recorderService.resumeRecording();
                    isPaused.value = false;
                  } else {
                    await recorderService.pauseRecording();
                    isPaused.value = true;
                  }
                },
              ),
              // Send button
              _RecorderButton(
                icon: Icons.send,
                label: 'Send',
                color: colors.primary,
                onPressed: () async {
                  final file = await recorderService.stopRecording();
                  if (file != null) {
                    onRecordingComplete(file, duration.value);
                  } else {
                    onCancel();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _startRecording(
    VoiceRecorderService service,
    ValueNotifier<bool> isRecording,
  ) async {
    final path = await service.startRecording();
    if (path != null) {
      isRecording.value = true;
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

/// Button for recorder controls
class _RecorderButton extends StatelessWidget {
  const _RecorderButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.filled(
          icon: Icon(icon),
          onPressed: onPressed,
          style: IconButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: textTheme.labelSmall,
        ),
      ],
    );
  }
}

/// Simplified waveform visualizer
class _WaveformVisualizer extends StatefulWidget {
  const _WaveformVisualizer({
    required this.isRecording,
  });

  final bool isRecording;

  @override
  State<_WaveformVisualizer> createState() => _WaveformVisualizerState();
}

class _WaveformVisualizerState extends State<_WaveformVisualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (!widget.isRecording) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(20, (index) {
          return Container(
            width: 3,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: colors.onSurfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(20, (index) {
            final progress = (_controller.value + index / 20) % 1.0;
            final height = 20 + (30 * (0.5 + 0.5 * (progress * 2 - 1).abs()));
            
            return Container(
              width: 3,
              height: height,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }
}
