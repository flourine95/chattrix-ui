import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:flutter/foundation.dart';

class VoiceRecorderService {
  final AudioRecorder _recorder = AudioRecorder();

  String? _currentRecordingPath;
  DateTime? _recordingStartTime;
  Timer? _durationTimer;
  final StreamController<Duration> _durationController = StreamController<Duration>.broadcast();

  Stream<Duration> get durationStream => _durationController.stream;

  Future<bool> isRecording() async {
    return await _recorder.isRecording();
  }

  Future<bool> requestPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<String?> startRecording() async {
    try {
      final hasPermission = await requestPermission();
      if (!hasPermission) {
        debugPrint('❌ Microphone permission denied.');
        return null;
      }

      if (await _recorder.isRecording()) {
        debugPrint('⚠️ Recorder is already active.');
        return null;
      }

      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '${tempDir.path}/voice_$timestamp.m4a';

      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000, sampleRate: 44100),
        path: path,
      );

      _currentRecordingPath = path;
      _recordingStartTime = DateTime.now();
      _startDurationTimer();

      debugPrint('🎙️ Recording started → $path');
      return path;
    } catch (e, stack) {
      debugPrint('❌ startRecording error: $e\n$stack');
      return null;
    }
  }

  Future<File?> stopRecording() async {
    try {
      if (!await _recorder.isRecording()) {
        debugPrint('⚠️ stopRecording called but no active recording.');
        return null;
      }

      final path = await _recorder.stop();
      _stopDurationTimer();

      if (path == null) {
        debugPrint('⚠️ Recorder stopped but path is null.');
        return null;
      }

      final file = File(path);
      if (!await file.exists()) {
        debugPrint('⚠️ Recorded file not found at $path.');
        return null;
      }

      debugPrint('✅ Recording saved: $path');

      _currentRecordingPath = null;
      _recordingStartTime = null;

      return file;
    } catch (e, stack) {
      debugPrint('❌ stopRecording error: $e\n$stack');
      return null;
    }
  }

  Future<void> cancelRecording() async {
    try {
      if (await _recorder.isRecording()) {
        await _recorder.stop();
      }

      _stopDurationTimer();

      if (_currentRecordingPath != null) {
        final file = File(_currentRecordingPath!);
        if (await file.exists()) {
          await file.delete();
          debugPrint('🗑️ Recording cancelled and deleted.');
        }
      }

      _currentRecordingPath = null;
      _recordingStartTime = null;
    } catch (e, stack) {
      debugPrint('❌ cancelRecording error: $e\n$stack');
    }
  }

  Future<void> pauseRecording() async {
    try {
      if (await _recorder.isRecording()) {
        await _recorder.pause();
        _stopDurationTimer();
        debugPrint('⏸️ Recording paused.');
      }
    } catch (e, stack) {
      debugPrint('❌ pauseRecording error: $e\n$stack');
    }
  }

  Future<void> resumeRecording() async {
    try {
      if (await _recorder.isPaused()) {
        await _recorder.resume();
        _startDurationTimer();
        debugPrint('▶️ Recording resumed.');
      }
    } catch (e, stack) {
      debugPrint('❌ resumeRecording error: $e\n$stack');
    }
  }

  Duration getCurrentDuration() {
    if (_recordingStartTime == null) {
      return Duration.zero;
    }
    return DateTime.now().difference(_recordingStartTime!);
  }

  void _startDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_recordingStartTime != null) {
        final duration = getCurrentDuration();
        _durationController.add(duration);
      }
    });
  }

  void _stopDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = null;
  }

  void dispose() {
    _durationTimer?.cancel();
    _durationController.close();
    _recorder.dispose();
  }
}
