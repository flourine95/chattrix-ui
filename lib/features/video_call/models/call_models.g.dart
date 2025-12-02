// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallUser _$CallUserFromJson(Map<String, dynamic> json) => _CallUser(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$CallUserToJson(_CallUser instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'avatarUrl': instance.avatarUrl,
};

_CallInfo _$CallInfoFromJson(Map<String, dynamic> json) => _CallInfo(
  id: json['id'] as String,
  channelId: json['channelId'] as String,
  status: $enumDecode(_$CallStatusEnumMap, json['status']),
  callType: $enumDecode(_$CallTypeEnumMap, json['callType']),
  caller: CallUser.fromJson(json['caller'] as Map<String, dynamic>),
  callee: CallUser.fromJson(json['callee'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
  durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
);

Map<String, dynamic> _$CallInfoToJson(_CallInfo instance) => <String, dynamic>{
  'id': instance.id,
  'channelId': instance.channelId,
  'status': _$CallStatusEnumMap[instance.status]!,
  'callType': _$CallTypeEnumMap[instance.callType]!,
  'caller': instance.caller,
  'callee': instance.callee,
  'createdAt': instance.createdAt.toIso8601String(),
  'durationSeconds': instance.durationSeconds,
};

const _$CallStatusEnumMap = {
  CallStatus.ringing: 'RINGING',
  CallStatus.connecting: 'CONNECTING',
  CallStatus.connected: 'CONNECTED',
  CallStatus.rejected: 'REJECTED',
  CallStatus.ended: 'ENDED',
  CallStatus.initiating: 'INITIATING',
};

const _$CallTypeEnumMap = {CallType.audio: 'AUDIO', CallType.video: 'VIDEO'};

_CallConnection _$CallConnectionFromJson(Map<String, dynamic> json) =>
    _CallConnection(
      callInfo: CallInfo.fromJson(json['callInfo'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$CallConnectionToJson(_CallConnection instance) =>
    <String, dynamic>{'callInfo': instance.callInfo, 'token': instance.token};

_InitiateCallRequest _$InitiateCallRequestFromJson(Map<String, dynamic> json) =>
    _InitiateCallRequest(
      calleeId: (json['calleeId'] as num).toInt(),
      callType: $enumDecode(_$CallTypeEnumMap, json['callType']),
    );

Map<String, dynamic> _$InitiateCallRequestToJson(
  _InitiateCallRequest instance,
) => <String, dynamic>{
  'calleeId': instance.calleeId,
  'callType': _$CallTypeEnumMap[instance.callType]!,
};

_RejectCallRequest _$RejectCallRequestFromJson(Map<String, dynamic> json) =>
    _RejectCallRequest(
      reason: $enumDecode(_$RejectReasonEnumMap, json['reason']),
    );

Map<String, dynamic> _$RejectCallRequestToJson(_RejectCallRequest instance) =>
    <String, dynamic>{'reason': _$RejectReasonEnumMap[instance.reason]!};

const _$RejectReasonEnumMap = {
  RejectReason.busy: 'busy',
  RejectReason.declined: 'declined',
  RejectReason.unavailable: 'unavailable',
};

_EndCallRequest _$EndCallRequestFromJson(Map<String, dynamic> json) =>
    _EndCallRequest(reason: json['reason'] as String? ?? 'hangup');

Map<String, dynamic> _$EndCallRequestToJson(_EndCallRequest instance) =>
    <String, dynamic>{'reason': instance.reason};

_CallInvitation _$CallInvitationFromJson(Map<String, dynamic> json) =>
    _CallInvitation(
      callId: json['callId'] as String,
      channelId: json['channelId'] as String,
      callerId: (json['callerId'] as num).toInt(),
      callerName: json['callerName'] as String,
      callerAvatar: json['callerAvatar'] as String?,
      callType: $enumDecode(_$CallTypeEnumMap, json['callType']),
    );

Map<String, dynamic> _$CallInvitationToJson(_CallInvitation instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'channelId': instance.channelId,
      'callerId': instance.callerId,
      'callerName': instance.callerName,
      'callerAvatar': instance.callerAvatar,
      'callType': _$CallTypeEnumMap[instance.callType]!,
    };

_CallAccept _$CallAcceptFromJson(Map<String, dynamic> json) => _CallAccept(
  callId: json['callId'] as String,
  acceptedBy: (json['acceptedBy'] as num).toInt(),
);

Map<String, dynamic> _$CallAcceptToJson(_CallAccept instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'acceptedBy': instance.acceptedBy,
    };

_CallReject _$CallRejectFromJson(Map<String, dynamic> json) => _CallReject(
  callId: json['callId'] as String,
  rejectedBy: (json['rejectedBy'] as num).toInt(),
  reason: $enumDecode(_$RejectReasonEnumMap, json['reason']),
);

Map<String, dynamic> _$CallRejectToJson(_CallReject instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'rejectedBy': instance.rejectedBy,
      'reason': _$RejectReasonEnumMap[instance.reason]!,
    };

_CallEnd _$CallEndFromJson(Map<String, dynamic> json) => _CallEnd(
  callId: json['callId'] as String,
  endedBy: (json['endedBy'] as num).toInt(),
  durationSeconds: (json['durationSeconds'] as num).toInt(),
);

Map<String, dynamic> _$CallEndToJson(_CallEnd instance) => <String, dynamic>{
  'callId': instance.callId,
  'endedBy': instance.endedBy,
  'durationSeconds': instance.durationSeconds,
};

_CallTimeout _$CallTimeoutFromJson(Map<String, dynamic> json) => _CallTimeout(
  callId: json['callId'] as String,
  reason: json['reason'] as String,
);

Map<String, dynamic> _$CallTimeoutToJson(_CallTimeout instance) =>
    <String, dynamic>{'callId': instance.callId, 'reason': instance.reason};
