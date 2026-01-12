import 'package:freezed_annotation/freezed_annotation.dart';
import 'call_type.dart';

part 'call_invitation.freezed.dart';

@freezed
abstract class CallInvitation with _$CallInvitation {
  const factory CallInvitation({
    required String callId,
    required String channelId,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required CallType callType,
  }) = _CallInvitation;
}
