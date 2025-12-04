import 'dart:async';
import 'dart:io';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

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
        AppLogger.warning('Microphone permission denied', tag: 'VoiceRecorder');
        return null;
      }

      if (await _recorder.isRecording()) {
        AppLogger.warning('Recorder is already active', tag: 'VoiceRecorder');
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

      AppLogger.info('Recording started → $path', tag: 'VoiceRecorder');
      return path;
    } catch (e, stack) {
      AppLogger.error('startRecording error', error: e, stackTrace: stack, tag: 'VoiceRecorder');
      return null;
    }
  }

  Future<File?> stopRecording() async {
    try {
      if (!await _recorder.isRecording()) {
        AppLogger.warning('stopRecording called but no active recording', tag: 'VoiceRecorder');
        return null;
      }

      final path = await _recorder.stop();
      _stopDurationTimer();

      if (path == null) {
        AppLogger.warning('Recorder stopped but path is null', tag: 'VoiceRecorder');
        return null;
      }

      final file = File(path);
      if (!await file.exists()) {
        AppLogger.warning('Recorded file not found at $path', tag: 'VoiceRecorder');
        return null;
      }

      AppLogger.success('Recording saved: $path', tag: 'VoiceRecorder');

      _currentRecordingPath = null;
      _recordingStartTime = null;

      return file;
    } catch (e, stack) {
      AppLogger.error('stopRecording error', error: e, stackTrace: stack, tag: 'VoiceRecorder');
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
          AppLogger.info('Recording cancelled and deleted', tag: 'VoiceRecorder');
        }
      }

      _currentRecordingPath = null;
      _recordingStartTime = null;
    } catch (e, stack) {
      AppLogger.error('cancelRecording error', error: e, stackTrace: stack, tag: 'VoiceRecorder');
    }
  }

  Future<void> pauseRecording() async {
    try {
      if (await _recorder.isRecording()) {
        await _recorder.pause();
        _stopDurationTimer();
        AppLogger.debug('Recording paused', tag: 'VoiceRecorder');
      }
    } catch (e, stack) {
      AppLogger.error('pauseRecording error', error: e, stackTrace: stack, tag: 'VoiceRecorder');
    }
  }

  Future<void> resumeRecording() async {
    try {
      if (await _recorder.isPaused()) {
        await _recorder.resume();
        _startDurationTimer();
        AppLogger.debug('Recording resumed', tag: 'VoiceRecorder');
      }
    } catch (e, stack) {
      AppLogger.error('resumeRecording error', error: e, stackTrace: stack, tag: 'VoiceRecorder');
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
