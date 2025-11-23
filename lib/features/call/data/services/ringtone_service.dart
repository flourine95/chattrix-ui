import 'package:audioplayers/audioplayers.dart';
import 'package:chattrix_ui/features/call/data/services/call_logger.dart';

/// Service for managing ringtone playback during incoming calls
class RingtoneService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  /// Play the ringtone in a loop
  Future<void> playRingtone() async {
    if (_isPlaying) {
      CallLogger.logInfo('Ringtone already playing, skipping');
      return;
    }

    try {
      // Set release mode to loop
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);

      // Set volume to maximum
      await _audioPlayer.setVolume(1.0);

      // Play the ringtone from assets
      await _audioPlayer.play(AssetSource('sounds/ringtone.mp3'));

      _isPlaying = true;
      CallLogger.logInfo('Ringtone playback started');
    } catch (e, stackTrace) {
      CallLogger.logError('Failed to play ringtone', error: e, stackTrace: stackTrace);
    }
  }

  /// Stop the ringtone playback
  Future<void> stopRingtone() async {
    if (!_isPlaying) {
      return;
    }

    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      CallLogger.logInfo('Ringtone playback stopped');
    } catch (e, stackTrace) {
      CallLogger.logError('Failed to stop ringtone', error: e, stackTrace: stackTrace);
    }
  }

  /// Check if ringtone is currently playing
  bool get isPlaying => _isPlaying;

  /// Dispose the audio player
  Future<void> dispose() async {
    await stopRingtone();
    await _audioPlayer.dispose();
  }
}
