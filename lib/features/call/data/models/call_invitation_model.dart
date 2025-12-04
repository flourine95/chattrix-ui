import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';

part 'call_invitation_model.freezed.dart';
part 'call_invitation_model.g.dart';

@freezed
abstract class CallInvitationModel with _$CallInvitationModel {
  const CallInvitationModel._();

  const factory CallInvitationModel({
    required String callId,
    required String channelId,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required CallType callType,
  }) = _CallInvitationModel;

  factory CallInvitationModel.fromJson(Map<String, dynamic> json) =>
      _$CallInvitationModelFromJson(json);

  CallInvitation toEntity() {
    return CallInvitation(
      callId: callId,
      channelId: channelId,
      callerId: callerId,
      callerName: callerName,
      callerAvatar: callerAvatar,
      callType: callType,
    );
  }
}
