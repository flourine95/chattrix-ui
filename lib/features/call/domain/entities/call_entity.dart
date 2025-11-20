import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_entity.freezed.dart';

@freezed
abstract class CallEntity with _$CallEntity {
  const factory CallEntity({
    required String callId,
    required String channelId,
    required String localUserId,
    required String remoteUserId,
    required CallType callType,
    required CallStatus status,
    required DateTime startTime,
    DateTime? endTime,
    required bool isLocalAudioMuted,
    required bool isLocalVideoMuted,
    required CameraFacing cameraFacing,
    NetworkQuality? networkQuality,
  }) = _CallEntity;
}

enum CallType { audio, video }

enum CallStatus { initiating, ringing, connecting, connected, disconnecting, ended, missed, rejected, failed }

enum CameraFacing { front, rear }

enum NetworkQuality { excellent, good, poor, bad, veryBad, unknown }
