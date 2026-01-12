import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'call_timer_provider.g.dart';

@Riverpod(keepAlive: true)
class CallTimer extends _$CallTimer {
  Timer? _timer;
  DateTime? _startTime;

  @override
  String build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return '00:00';
  }

  void start() {
    _startTime = DateTime.now();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_startTime != null) {
        final duration = DateTime.now().difference(_startTime!);
        state = _formatDuration(duration);
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _startTime = null;
    state = '00:00';
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
