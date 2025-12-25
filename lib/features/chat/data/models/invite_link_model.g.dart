// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'invite_link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InviteLinkModel _$InviteLinkModelFromJson(Map<String, dynamic> json) =>
    _InviteLinkModel(
      id: (json['id'] as num).toInt(),
      token: json['token'] as String,
      conversationId: (json['conversationId'] as num).toInt(),
      createdBy: (json['createdBy'] as num).toInt(),
      createdByUsername: json['createdByUsername'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      maxUses: (json['maxUses'] as num?)?.toInt(),
      currentUses: (json['currentUses'] as num?)?.toInt() ?? 0,
      revoked: json['revoked'] as bool? ?? false,
      revokedAt: json['revokedAt'] == null
          ? null
          : DateTime.parse(json['revokedAt'] as String),
      revokedBy: (json['revokedBy'] as num?)?.toInt(),
      valid: json['valid'] as bool? ?? true,
    );

Map<String, dynamic> _$InviteLinkModelToJson(_InviteLinkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'conversationId': instance.conversationId,
      'createdBy': instance.createdBy,
      'createdByUsername': instance.createdByUsername,
      'createdAt': instance.createdAt.toIso8601String(),
      'maxUses': instance.maxUses,
      'currentUses': instance.currentUses,
      'revoked': instance.revoked,
      'revokedAt': instance.revokedAt?.toIso8601String(),
      'revokedBy': instance.revokedBy,
      'valid': instance.valid,
    };

_CreateInviteLinkRequest _$CreateInviteLinkRequestFromJson(
  Map<String, dynamic> json,
) => _CreateInviteLinkRequest(
  expiresInDays: (json['expiresInDays'] as num?)?.toInt(),
  maxUses: (json['maxUses'] as num?)?.toInt(),
);

Map<String, dynamic> _$CreateInviteLinkRequestToJson(
  _CreateInviteLinkRequest instance,
) => <String, dynamic>{
  'expiresInDays': instance.expiresInDays,
  'maxUses': instance.maxUses,
};

_InviteLinkInfoModel _$InviteLinkInfoModelFromJson(Map<String, dynamic> json) =>
    _InviteLinkInfoModel(
      token: json['token'] as String,
      groupId: (json['groupId'] as num).toInt(),
      memberCount: (json['memberCount'] as num).toInt(),
      valid: json['valid'] as bool,
      createdBy: (json['createdBy'] as num).toInt(),
      createdByUsername: json['createdByUsername'] as String,
      createdByFullName: json['createdByFullName'] as String,
    );

Map<String, dynamic> _$InviteLinkInfoModelToJson(
  _InviteLinkInfoModel instance,
) => <String, dynamic>{
  'token': instance.token,
  'groupId': instance.groupId,
  'memberCount': instance.memberCount,
  'valid': instance.valid,
  'createdBy': instance.createdBy,
  'createdByUsername': instance.createdByUsername,
  'createdByFullName': instance.createdByFullName,
};

_JoinViaInviteLinkResponse _$JoinViaInviteLinkResponseFromJson(
  Map<String, dynamic> json,
) => _JoinViaInviteLinkResponse(
  success: json['success'] as bool,
  conversationId: (json['conversationId'] as num).toInt(),
  message: json['message'] as String,
);

Map<String, dynamic> _$JoinViaInviteLinkResponseToJson(
  _JoinViaInviteLinkResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'conversationId': instance.conversationId,
  'message': instance.message,
};
