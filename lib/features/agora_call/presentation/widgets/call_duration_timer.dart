import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Widget displaying elapsed call duration
/// Shows a timer that updates every second
/// Requirement 5.2: Display call duration timer
class CallDurationTimer extends HookWidget {
  final DateTime startTime;

  const CallDurationTimer({super.key, required this.startTime});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final duration = useState<Duration>(Duration.zero);

    useEffect(() {
      // Update duration every second
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        duration.value = DateTime.now().difference(startTime);
      });

      // Initial duration
      duration.value = DateTime.now().difference(startTime);

      return timer.cancel;
    }, [startTime]);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(16)),
      child: Text(
        _formatDuration(duration.value),
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          shadows: [const Shadow(offset: Offset(0, 1), blurRadius: 2, color: Colors.black45)],
        ),
      ),
    );
  }

  /// Format duration as MM:SS or HH:MM:SS
  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
  }
}
