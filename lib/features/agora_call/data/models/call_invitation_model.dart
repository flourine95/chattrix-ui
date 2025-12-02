import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/call_entity.dart';
import '../../domain/entities/call_invitation_entity.dart';

part 'call_invitation_model.freezed.dart';
part 'call_invitation_model.g.dart';

/// Data Transfer Object for Call Invitation with JSON serialization
@freezed
abstract class CallInvitationModel with _$CallInvitationModel {
  const CallInvitationModel._();

  const factory CallInvitationModel({
    required String callId,
    required String channelId,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required String callType,
  }) = _CallInvitationModel;

  factory CallInvitationModel.fromJson(Map<String, dynamic> json) => _$CallInvitationModelFromJson(json);
}

/// Extension to convert CallInvitationModel to CallInvitationEntity
extension CallInvitationModelX on CallInvitationModel {
  CallInvitationEntity toEntity() {
    return CallInvitationEntity(
      callId: callId,
      channelId: channelId,
      callerId: callerId,
      callerName: callerName,
      callerAvatar: callerAvatar,
      callType: _parseCallType(callType),
    );
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
