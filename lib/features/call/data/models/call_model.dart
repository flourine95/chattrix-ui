import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';

part 'call_model.freezed.dart';
part 'call_model.g.dart';

@freezed
abstract class CallModel with _$CallModel {
  const CallModel._();

  const factory CallModel({
    required String callId,
    required String channelId,
    required String localUserId,
    required String remoteUserId,
    required String callType,
    required String status,
    required String startTime,
    String? endTime,
    required bool isLocalAudioMuted,
    required bool isLocalVideoMuted,
    required String cameraFacing,
    String? networkQuality,
  }) = _CallModel;

  factory CallModel.fromJson(Map<String, dynamic> json) => _$CallModelFromJson(json);

  factory CallModel.fromEntity(CallEntity entity) {
    return CallModel(
      callId: entity.callId,
      channelId: entity.channelId,
      localUserId: entity.localUserId,
      remoteUserId: entity.remoteUserId,
      callType: entity.callType.name,
      status: entity.status.name,
      startTime: entity.startTime.toIso8601String(),
      endTime: entity.endTime?.toIso8601String(),
      isLocalAudioMuted: entity.isLocalAudioMuted,
      isLocalVideoMuted: entity.isLocalVideoMuted,
      cameraFacing: entity.cameraFacing.name,
      networkQuality: entity.networkQuality?.name,
    );
  }

  CallEntity toEntity() {
    return CallEntity(
      callId: callId,
      channelId: channelId,
      localUserId: localUserId,
      remoteUserId: remoteUserId,
      callType: CallType.values.firstWhere((e) => e.name == callType, orElse: () => CallType.audio),
      status: CallStatus.values.firstWhere((e) => e.name == status, orElse: () => CallStatus.failed),
      startTime: DateTime.parse(startTime),
      endTime: endTime != null ? DateTime.parse(endTime!) : null,
      isLocalAudioMuted: isLocalAudioMuted,
      isLocalVideoMuted: isLocalVideoMuted,
      cameraFacing: CameraFacing.values.firstWhere((e) => e.name == cameraFacing, orElse: () => CameraFacing.front),
      networkQuality: networkQuality != null
          ? NetworkQuality.values.firstWhere((e) => e.name == networkQuality, orElse: () => NetworkQuality.unknown)
          : null,
    );
  }
}
