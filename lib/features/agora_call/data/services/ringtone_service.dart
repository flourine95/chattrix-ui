import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Service for managing ringtone playback during incoming calls
///
/// Handles playing and stopping ringtone sounds with looping functionality
class RingtoneService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  /// Gets whether the ringtone is currently playing
  bool get isPlaying => _isPlaying;

  /// Plays the ringtone with looping
  ///
  /// The ringtone will continue playing until [stop] is called
  /// Uses the ringtone asset from assets/sounds/ringtone.mp3
  Future<void> play() async {
    if (_isPlaying) {
      debugPrint('RingtoneService: Ringtone already playing');
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
      debugPrint('RingtoneService: Ringtone started playing');
    } catch (e) {
      debugPrint('RingtoneService: Failed to play ringtone: $e');
      rethrow;
    }
  }

  /// Stops the ringtone playback
  ///
  /// This should be called when the user accepts, rejects, or the call times out
  Future<void> stop() async {
    if (!_isPlaying) {
      debugPrint('RingtoneService: Ringtone not playing');
      return;
    }

    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      debugPrint('RingtoneService: Ringtone stopped');
    } catch (e) {
      debugPrint('RingtoneService: Failed to stop ringtone: $e');
      rethrow;
    }
  }

  /// Disposes the audio player and releases resources
  ///
  /// This should be called when the service is no longer needed
  Future<void> dispose() async {
    try {
      await stop();
      await _audioPlayer.dispose();
      debugPrint('RingtoneService: Disposed successfully');
    } catch (e) {
      debugPrint('RingtoneService: Error during disposal: $e');
    }
  }
}
