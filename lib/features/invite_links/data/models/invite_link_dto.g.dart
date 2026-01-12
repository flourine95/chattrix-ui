// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'invite_link_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateInviteLinkRequestDto _$CreateInviteLinkRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CreateInviteLinkRequestDto(
  expiresIn: (json['expiresIn'] as num?)?.toInt(),
  maxUses: (json['maxUses'] as num?)?.toInt(),
);

Map<String, dynamic> _$CreateInviteLinkRequestDtoToJson(
  _CreateInviteLinkRequestDto instance,
) => <String, dynamic>{
  'expiresIn': instance.expiresIn,
  'maxUses': instance.maxUses,
};

_InviteLinkDto _$InviteLinkDtoFromJson(Map<String, dynamic> json) =>
    _InviteLinkDto(
      id: (json['id'] as num).toInt(),
      token: json['token'] as String,
      conversationId: (json['conversationId'] as num).toInt(),
      createdBy: (json['createdBy'] as num).toInt(),
      createdByUsername: json['createdByUsername'] as String,
      createdAt: json['createdAt'] as String,
      expiresAt: json['expiresAt'] as String?,
      maxUses: (json['maxUses'] as num?)?.toInt(),
      currentUses: (json['currentUses'] as num).toInt(),
      revoked: json['revoked'] as bool,
      revokedAt: json['revokedAt'] as String?,
      revokedBy: (json['revokedBy'] as num?)?.toInt(),
      valid: json['valid'] as bool,
    );

Map<String, dynamic> _$InviteLinkDtoToJson(_InviteLinkDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'conversationId': instance.conversationId,
      'createdBy': instance.createdBy,
      'createdByUsername': instance.createdByUsername,
      'createdAt': instance.createdAt,
      'expiresAt': instance.expiresAt,
      'maxUses': instance.maxUses,
      'currentUses': instance.currentUses,
      'revoked': instance.revoked,
      'revokedAt': instance.revokedAt,
      'revokedBy': instance.revokedBy,
      'valid': instance.valid,
    };

_InviteLinkInfoDto _$InviteLinkInfoDtoFromJson(Map<String, dynamic> json) =>
    _InviteLinkInfoDto(
      token: json['token'] as String,
      groupId: (json['groupId'] as num).toInt(),
      groupName: json['groupName'] as String,
      memberCount: (json['memberCount'] as num).toInt(),
      valid: json['valid'] as bool,
      expiresAt: json['expiresAt'] as String?,
      createdBy: (json['createdBy'] as num).toInt(),
      createdByUsername: json['createdByUsername'] as String,
      createdByFullName: json['createdByFullName'] as String,
      maxUses: (json['maxUses'] as num?)?.toInt(),
      usesCount: (json['usesCount'] as num?)?.toInt() ?? 0,
      revoked: json['revoked'] as bool? ?? false,
      groupAvatar: json['groupAvatar'] as String?,
    );

Map<String, dynamic> _$InviteLinkInfoDtoToJson(_InviteLinkInfoDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'memberCount': instance.memberCount,
      'valid': instance.valid,
      'expiresAt': instance.expiresAt,
      'createdBy': instance.createdBy,
      'createdByUsername': instance.createdByUsername,
      'createdByFullName': instance.createdByFullName,
      'maxUses': instance.maxUses,
      'usesCount': instance.usesCount,
      'revoked': instance.revoked,
      'groupAvatar': instance.groupAvatar,
    };

_JoinGroupResponseDto _$JoinGroupResponseDtoFromJson(
  Map<String, dynamic> json,
) => _JoinGroupResponseDto(
  success: json['success'] as bool,
  conversationId: (json['conversationId'] as num).toInt(),
  message: json['message'] as String,
  groupName: json['groupName'] as String?,
);

Map<String, dynamic> _$JoinGroupResponseDtoToJson(
  _JoinGroupResponseDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'conversationId': instance.conversationId,
  'message': instance.message,
  'groupName': instance.groupName,
};
