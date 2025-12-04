
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

/// Performance monitoring service for tracking and logging performance metrics
///
/// This service provides:
/// - Execution time logging for operations exceeding 16ms
/// - Isolate creation and message passing overhead logging
/// - Frame timing measurements
class PerformanceMonitor {
  static const String _tag = 'PerformanceMonitor';
  static const int _frameThresholdMs = 0; // 60 FPS = 16.67ms per frame

  /// Measure and log execution time of an operation
  /// Logs a warning if execution exceeds 16ms
  static Future<T> measureAsync<T>(String operationName, Future<T> Function() operation) async {
    final stopwatch = Stopwatch()..start();
    try {
      final result = await operation();
      stopwatch.stop();
      _logExecutionTime(operationName, stopwatch.elapsedMilliseconds);
      return result;
    } catch (e) {
      stopwatch.stop();
      _logExecutionTime(operationName, stopwatch.elapsedMilliseconds, error: e);
      rethrow;
    }
  }

  /// Measure and log execution time of a synchronous operation
  /// Logs a warning if execution exceeds 16ms
  static T measureSync<T>(String operationName, T Function() operation) {
    final stopwatch = Stopwatch()..start();
    try {
      final result = operation();
      stopwatch.stop();
      _logExecutionTime(operationName, stopwatch.elapsedMilliseconds);
      return result;
    } catch (e) {
      stopwatch.stop();
      _logExecutionTime(operationName, stopwatch.elapsedMilliseconds, error: e);
      rethrow;
    }
  }

  /// Log isolate creation overhead
  static void logIsolateCreation(String operationName, int durationMs) {
    if (kDebugMode) {
      developer.log(
        'Isolate created for $operationName in ${durationMs}ms',
        name: _tag,
        level: durationMs > _frameThresholdMs ? 900 : 800, // WARNING if > 16ms
      );
    }
  }

  /// Log message passing overhead between isolates
  static void logMessagePassing(String operationName, int durationMs) {
    if (kDebugMode) {
      developer.log(
        'Message passing for $operationName took ${durationMs}ms',
        name: _tag,
        level: durationMs > _frameThresholdMs ? 900 : 800,
      );
    }
  }

  /// Start frame timing measurements
  /// Returns a callback to stop measurements
  static VoidCallback startFrameTimingMeasurement(String scenario) {
    if (!kDebugMode) return () {};

    final frameTimings = <int>[];
    final observer = _FrameTimingObserver(
      scenario: scenario,
      onFrameTiming: (durationMs) {
        frameTimings.add(durationMs);
      },
    );

    SchedulerBinding.instance.addTimingsCallback(observer.callback);

    return () {
      SchedulerBinding.instance.removeTimingsCallback(observer.callback);
      _logFrameTimingStats(scenario, frameTimings);
    };
  }

  /// Log frame timing statistics
  static void _logFrameTimingStats(String scenario, List<int> frameTimings) {
    if (frameTimings.isEmpty) return;

    frameTimings.sort();
    final avg = frameTimings.reduce((a, b) => a + b) / frameTimings.length;
    final p95Index = (frameTimings.length * 0.95).floor();
    final p95 = frameTimings[p95Index];
    final max = frameTimings.last;
    final droppedFrames = frameTimings.where((t) => t > _frameThresholdMs).length;
    final droppedPercentage = (droppedFrames / frameTimings.length * 100).toStringAsFixed(1);

    developer.log(
      'Frame timing for "$scenario":\n'
      '  Total frames: ${frameTimings.length}\n'
      '  Average: ${avg.toStringAsFixed(2)}ms\n'
      '  P95: ${p95}ms\n'
      '  Max: ${max}ms\n'
      '  Dropped frames (>16ms): $droppedFrames ($droppedPercentage%)',
      name: _tag,
      level: droppedFrames > 0 ? 900 : 800,
    );
  }

  /// Log execution time with appropriate level
  static void _logExecutionTime(String operationName, int durationMs, {Object? error}) {
    // Nếu bạn muốn check kDebugMode thì giữ dòng này, không thì bỏ đi cũng được
    if (!kDebugMode) return;

    // Logic lọc: Vì bạn đang test nên để > -1 để in tất cả (hoặc > 0)
    if (durationMs > _frameThresholdMs || error != null) {
      final message = error != null
          ? '$operationName took ${durationMs}ms (ERROR: $error)'
          : '$operationName took ${durationMs}ms'; // Bỏ đoạn text warning đi cho gọn

      // SỬA Ở ĐÂY: Dùng debugPrint để hiện lên Terminal
      debugPrint('[$_tag] $message');
    }
  }}

/// Internal class for observing frame timings
class _FrameTimingObserver {
  final String scenario;
  final void Function(int durationMs) onFrameTiming;

  _FrameTimingObserver({required this.scenario, required this.onFrameTiming});

  void callback(List<FrameTiming> timings) {
    for (final timing in timings) {
      final buildDuration = timing.buildDuration.inMilliseconds;
      final rasterDuration = timing.rasterDuration.inMilliseconds;
      final totalDuration = buildDuration + rasterDuration;
      onFrameTiming(totalDuration);
    }
  }
}
