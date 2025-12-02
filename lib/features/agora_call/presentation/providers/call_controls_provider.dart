import 'package:chattrix_ui/features/agora_call/presentation/providers/agora_call_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'call_controls_provider.freezed.dart';
part 'call_controls_provider.g.dart';

/// State class for call controls
///
/// Manages the state of audio/video controls during an active call
@freezed
abstract class CallControlsState with _$CallControlsState {
  const factory CallControlsState({
    /// Whether the microphone is muted
    @Default(false) bool isMuted,

    /// Whether the video is enabled (for video calls)
    @Default(true) bool isVideoEnabled,

    /// Whether the speaker is on (true) or earpiece (false)
    @Default(true) bool isSpeakerOn,
  }) = _CallControlsState;
}

/// Call controls state management provider
///
/// Manages the state of call controls (mute, video, speaker, camera)
/// and integrates with AgoraEngineService for actual control actions
@riverpod
class CallControls extends _$CallControls {
  @override
  CallControlsState build() {
    // Initial state: unmuted, video enabled, speaker on
    return const CallControlsState(isMuted: false, isVideoEnabled: true, isSpeakerOn: true);
  }

  /// Toggles the microphone mute state
  ///
  /// Mutes or unmutes the local audio stream through Agora SDK
  Future<void> toggleMute() async {
    try {
      final newMuteState = !state.isMuted;
      final agoraService = ref.read(agoraEngineServiceProvider);

      // Update Agora SDK
      await agoraService.muteLocalAudio(newMuteState);

      // Update state
      state = state.copyWith(isMuted: newMuteState);

      debugPrint('CallControls: Microphone ${newMuteState ? 'muted' : 'unmuted'}');
    } catch (e) {
      debugPrint('CallControls: Failed to toggle mute: $e');
      // Revert state on error
      rethrow;
    }
  }

  /// Toggles the video enable state
  ///
  /// Enables or disables the local video stream through Agora SDK
  /// Only applicable for video calls
  Future<void> toggleVideo() async {
    try {
      final newVideoState = !state.isVideoEnabled;
      final agoraService = ref.read(agoraEngineServiceProvider);

      // Update Agora SDK (mute = disable, so we invert the state)
      await agoraService.muteLocalVideo(!newVideoState);

      // Update state
      state = state.copyWith(isVideoEnabled: newVideoState);

      debugPrint('CallControls: Video ${newVideoState ? 'enabled' : 'disabled'}');
    } catch (e) {
      debugPrint('CallControls: Failed to toggle video: $e');
      // Revert state on error
      rethrow;
    }
  }

  /// Toggles the speaker state
  ///
  /// Switches between speaker (true) and earpiece (false)
  /// Note: This is a UI state toggle. Actual audio routing should be
  /// handled by the platform's audio session management
  void toggleSpeaker() {
    final newSpeakerState = !state.isSpeakerOn;

    // Update state
    state = state.copyWith(isSpeakerOn: newSpeakerState);

    debugPrint('CallControls: Speaker ${newSpeakerState ? 'on' : 'off'}');

    // Note: Actual speaker/earpiece routing would typically be handled
    // by platform-specific audio session configuration or a separate
    // audio routing service. This is just the UI state.
  }

  /// Switches between front and rear camera
  ///
  /// Only applicable for video calls on mobile devices
  Future<void> switchCamera() async {
    try {
      final agoraService = ref.read(agoraEngineServiceProvider);

      // Switch camera through Agora SDK
      await agoraService.switchCamera();

      debugPrint('CallControls: Camera switched');
    } catch (e) {
      debugPrint('CallControls: Failed to switch camera: $e');
      rethrow;
    }
  }

  /// Resets all controls to their default state
  ///
  /// Called when a call ends to prepare for the next call
  void reset() {
    state = const CallControlsState(isMuted: false, isVideoEnabled: true, isSpeakerOn: true);
    debugPrint('CallControls: Reset to default state');
  }
}
