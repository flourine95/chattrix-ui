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
      link: json['link'] as String?,
      conversationId: (json['conversationId'] as num).toInt(),
      createdBy: (json['createdBy'] as num).toInt(),
      createdByUsername: json['createdByUsername'] as String?,
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
      'link': instance.link,
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

_InviteLinkUserDto _$InviteLinkUserDtoFromJson(Map<String, dynamic> json) =>
    _InviteLinkUserDto(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      lastSeen: json['lastSeen'] as String?,
    );

Map<String, dynamic> _$InviteLinkUserDtoToJson(_InviteLinkUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'lastSeen': instance.lastSeen,
    };

_InviteLinkHistoryItemDto _$InviteLinkHistoryItemDtoFromJson(
  Map<String, dynamic> json,
) => _InviteLinkHistoryItemDto(
  token: json['token'] as String,
  link: json['link'] as String?,
  createdBy: InviteLinkUserDto.fromJson(
    json['createdBy'] as Map<String, dynamic>,
  ),
  createdAt: json['createdAt'] as String,
  maxUses: (json['maxUses'] as num).toInt(),
  currentUses: (json['currentUses'] as num).toInt(),
  isActive: json['isActive'] as bool,
  isRevoked: json['isRevoked'] as bool,
  isExpired: json['isExpired'] as bool,
  status: json['status'] as String,
);

Map<String, dynamic> _$InviteLinkHistoryItemDtoToJson(
  _InviteLinkHistoryItemDto instance,
) => <String, dynamic>{
  'token': instance.token,
  'link': instance.link,
  'createdBy': instance.createdBy,
  'createdAt': instance.createdAt,
  'maxUses': instance.maxUses,
  'currentUses': instance.currentUses,
  'isActive': instance.isActive,
  'isRevoked': instance.isRevoked,
  'isExpired': instance.isExpired,
  'status': instance.status,
};

_InviteLinksMetaDto _$InviteLinksMetaDtoFromJson(Map<String, dynamic> json) =>
    _InviteLinksMetaDto(
      nextCursor: json['nextCursor'] as String?,
      hasNextPage: json['hasNextPage'] as bool,
      itemsPerPage: (json['itemsPerPage'] as num).toInt(),
    );

Map<String, dynamic> _$InviteLinksMetaDtoToJson(_InviteLinksMetaDto instance) =>
    <String, dynamic>{
      'nextCursor': instance.nextCursor,
      'hasNextPage': instance.hasNextPage,
      'itemsPerPage': instance.itemsPerPage,
    };

_InviteLinksHistoryDto _$InviteLinksHistoryDtoFromJson(
  Map<String, dynamic> json,
) => _InviteLinksHistoryDto(
  items: (json['items'] as List<dynamic>)
      .map((e) => InviteLinkHistoryItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  meta: InviteLinksMetaDto.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InviteLinksHistoryDtoToJson(
  _InviteLinksHistoryDto instance,
) => <String, dynamic>{'items': instance.items, 'meta': instance.meta};
