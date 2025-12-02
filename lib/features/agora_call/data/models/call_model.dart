import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/call_entity.dart';

part 'call_model.freezed.dart';
part 'call_model.g.dart';

/// Data Transfer Object for Call with JSON serialization
@freezed
abstract class CallModel with _$CallModel {
  const CallModel._();

  const factory CallModel({
    required String id,
    required String channelId,
    required String status,
    required String callType,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required int calleeId,
    required String calleeName,
    String? calleeAvatar,
    required String createdAt,
    int? durationSeconds,
  }) = _CallModel;

  factory CallModel.fromJson(Map<String, dynamic> json) => _$CallModelFromJson(json);
}

/// Extension to convert CallModel to CallEntity
extension CallModelX on CallModel {
  CallEntity toEntity() {
    return CallEntity(
      id: id,
      channelId: channelId,
      status: _parseStatus(status),
      callType: _parseCallType(callType),
      callerId: callerId,
      callerName: callerName,
      callerAvatar: callerAvatar,
      calleeId: calleeId,
      calleeName: calleeName,
      calleeAvatar: calleeAvatar,
      createdAt: DateTime.parse(createdAt),
      durationSeconds: durationSeconds,
    );
  }

  CallStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'initiating':
        return CallStatus.initiating;
      case 'ringing':
        return CallStatus.ringing;
      case 'connecting':
        return CallStatus.connecting;
      case 'connected':
        return CallStatus.connected;
      case 'rejected':
        return CallStatus.rejected;
      case 'ended':
        return CallStatus.ended;
      default:
        return CallStatus.ended;
    }
  }

  CallType _parseCallType(String callType) {
    switch (callType.toLowerCase()) {
      case 'audio':
        return CallType.audio;
      case 'video':
        return CallType.video;
      default:
        return CallType.audio;
    }
  }
}
