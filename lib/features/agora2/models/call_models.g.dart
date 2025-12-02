// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallResponse _$CallResponseFromJson(Map<String, dynamic> json) =>
    _CallResponse(
      id: json['id'] as String,
      channelId: json['channelId'] as String,
      status: $enumDecode(_$CallStatusEnumMap, json['status']),
      callType: $enumDecode(_$CallTypeEnumMap, json['callType']),
      callerId: (json['callerId'] as num).toInt(),
      callerName: json['callerName'] as String,
      callerAvatar: json['callerAvatar'] as String?,
      calleeId: (json['calleeId'] as num).toInt(),
      calleeName: json['calleeName'] as String,
      calleeAvatar: json['calleeAvatar'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CallResponseToJson(_CallResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channelId': instance.channelId,
      'status': _$CallStatusEnumMap[instance.status]!,
      'callType': _$CallTypeEnumMap[instance.callType]!,
      'callerId': instance.callerId,
      'callerName': instance.callerName,
      'callerAvatar': instance.callerAvatar,
      'calleeId': instance.calleeId,
      'calleeName': instance.calleeName,
      'calleeAvatar': instance.calleeAvatar,
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

_CallConnectionResponse _$CallConnectionResponseFromJson(
  Map<String, dynamic> json,
) => _CallConnectionResponse(
  id: json['id'] as String,
  channelId: json['channelId'] as String,
  status: $enumDecode(_$CallStatusEnumMap, json['status']),
  callType: $enumDecode(_$CallTypeEnumMap, json['callType']),
  callerId: (json['callerId'] as num).toInt(),
  callerName: json['callerName'] as String,
  callerAvatar: json['callerAvatar'] as String?,
  calleeId: (json['calleeId'] as num).toInt(),
  calleeName: json['calleeName'] as String,
  calleeAvatar: json['calleeAvatar'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
  token: json['token'] as String,
);

Map<String, dynamic> _$CallConnectionResponseToJson(
  _CallConnectionResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'channelId': instance.channelId,
  'status': _$CallStatusEnumMap[instance.status]!,
  'callType': _$CallTypeEnumMap[instance.callType]!,
  'callerId': instance.callerId,
  'callerName': instance.callerName,
  'callerAvatar': instance.callerAvatar,
  'calleeId': instance.calleeId,
  'calleeName': instance.calleeName,
  'calleeAvatar': instance.calleeAvatar,
  'createdAt': instance.createdAt.toIso8601String(),
  'durationSeconds': instance.durationSeconds,
  'token': instance.token,
};

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
    _EndCallRequest(
      reason:
          $enumDecodeNullable(_$EndReasonEnumMap, json['reason']) ??
          EndReason.hangup,
    );

Map<String, dynamic> _$EndCallRequestToJson(_EndCallRequest instance) =>
    <String, dynamic>{'reason': _$EndReasonEnumMap[instance.reason]!};

const _$EndReasonEnumMap = {
  EndReason.hangup: 'hangup',
  EndReason.networkError: 'network error',
  EndReason.deviceError: 'device error',
  EndReason.timeout: 'timeout',
};

_ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _ApiResponse<T>(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
);

Map<String, dynamic> _$ApiResponseToJson<T>(
  _ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

_CallInvitationDto _$CallInvitationDtoFromJson(Map<String, dynamic> json) =>
    _CallInvitationDto(
      callId: json['callId'] as String,
      channelId: json['channelId'] as String,
      callerId: (json['callerId'] as num).toInt(),
      callerName: json['callerName'] as String,
      callerAvatar: json['callerAvatar'] as String?,
      callType: $enumDecode(_$CallTypeEnumMap, json['callType']),
    );

Map<String, dynamic> _$CallInvitationDtoToJson(_CallInvitationDto instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'channelId': instance.channelId,
      'callerId': instance.callerId,
      'callerName': instance.callerName,
      'callerAvatar': instance.callerAvatar,
      'callType': _$CallTypeEnumMap[instance.callType]!,
    };

_CallAcceptDto _$CallAcceptDtoFromJson(Map<String, dynamic> json) =>
    _CallAcceptDto(
      callId: json['callId'] as String,
      acceptedBy: (json['acceptedBy'] as num).toInt(),
    );

Map<String, dynamic> _$CallAcceptDtoToJson(_CallAcceptDto instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'acceptedBy': instance.acceptedBy,
    };

_CallRejectDto _$CallRejectDtoFromJson(Map<String, dynamic> json) =>
    _CallRejectDto(
      callId: json['callId'] as String,
      rejectedBy: (json['rejectedBy'] as num).toInt(),
      reason: $enumDecode(_$RejectReasonEnumMap, json['reason']),
    );

Map<String, dynamic> _$CallRejectDtoToJson(_CallRejectDto instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'rejectedBy': instance.rejectedBy,
      'reason': _$RejectReasonEnumMap[instance.reason]!,
    };

_CallEndDto _$CallEndDtoFromJson(Map<String, dynamic> json) => _CallEndDto(
  callId: json['callId'] as String,
  endedBy: (json['endedBy'] as num).toInt(),
  durationSeconds: (json['durationSeconds'] as num).toInt(),
);

Map<String, dynamic> _$CallEndDtoToJson(_CallEndDto instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'endedBy': instance.endedBy,
      'durationSeconds': instance.durationSeconds,
    };

_CallTimeoutDto _$CallTimeoutDtoFromJson(Map<String, dynamic> json) =>
    _CallTimeoutDto(
      callId: json['callId'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$CallTimeoutDtoToJson(_CallTimeoutDto instance) =>
    <String, dynamic>{'callId': instance.callId, 'reason': instance.reason};

_WebSocketMessage _$WebSocketMessageFromJson(Map<String, dynamic> json) =>
    _WebSocketMessage(
      type: json['type'] as String,
      payload: json['payload'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$WebSocketMessageToJson(_WebSocketMessage instance) =>
    <String, dynamic>{'type': instance.type, 'payload': instance.payload};
