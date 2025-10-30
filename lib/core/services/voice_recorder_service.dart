import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

/// Service for recording voice messages
class VoiceRecorderService {
  final AudioRecorder _recorder = AudioRecorder();
  
  String? _currentRecordingPath;
  DateTime? _recordingStartTime;
  Timer? _durationTimer;
  final StreamController<Duration> _durationController = StreamController<Duration>.broadcast();
  
  /// Stream of recording duration
  Stream<Duration> get durationStream => _durationController.stream;
  
  /// Check if currently recording
  Future<bool> isRecording() async {
    return await _recorder.isRecording();
  }
  
  /// Request microphone permission
  Future<bool> requestPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }
  
  /// Start recording
  Future<String?> startRecording() async {
    try {
      // Check permission
      final hasPermission = await requestPermission();
      if (!hasPermission) {
        return null;
      }

      // Check if already recording
      if (await _recorder.isRecording()) {
        return null;
      }
      
      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '${tempDir.path}/voice_$timestamp.m4a';
      
      // Start recording
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: path,
      );
      
      _currentRecordingPath = path;
      _recordingStartTime = DateTime.now();
      
      // Start duration timer
      _startDurationTimer();

      return path;
    } catch (e) {
      return null;
    }
  }
  
  /// Stop recording and return the file
  Future<File?> stopRecording() async {
    try {
      if (!await _recorder.isRecording()) {
        return null;
      }

      final path = await _recorder.stop();
      _stopDurationTimer();

      if (path == null) {
        return null;
      }

      final file = File(path);
      if (!await file.exists()) {
        return null;
      }

      _currentRecordingPath = null;
      _recordingStartTime = null;

      return file;
    } catch (e) {
      return null;
    }
  }
  
  /// Cancel recording and delete the file
  Future<void> cancelRecording() async {
    try {
      if (await _recorder.isRecording()) {
        await _recorder.stop();
      }
      
      _stopDurationTimer();
      
      // Delete the recording file
      if (_currentRecordingPath != null) {
        final file = File(_currentRecordingPath!);
        if (await file.exists()) {
          await file.delete();
        }
      }

      _currentRecordingPath = null;
      _recordingStartTime = null;
    } catch (e) {
      // Silently handle error
    }
  }
  
  /// Pause recording
  Future<void> pauseRecording() async {
    try {
      if (await _recorder.isRecording()) {
        await _recorder.pause();
        _stopDurationTimer();
      }
    } catch (e) {
      // Silently handle error
    }
  }
  
  /// Resume recording
  Future<void> resumeRecording() async {
    try {
      if (await _recorder.isPaused()) {
        await _recorder.resume();
        _startDurationTimer();
      }
    } catch (e) {
      // Silently handle error
    }
  }
  
  /// Get current recording duration
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
  
  /// Dispose resources
  void dispose() {
    _durationTimer?.cancel();
    _durationController.close();
    _recorder.dispose();
  }
}

