// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'conversation_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConversationSettingsModel _$ConversationSettingsModelFromJson(
  Map<String, dynamic> json,
) => _ConversationSettingsModel(
  conversationId: (json['conversationId'] as num).toInt(),
  muted: json['muted'] as bool? ?? false,
  blocked: json['blocked'] as bool? ?? false,
  notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
  pinned: json['pinned'] as bool? ?? false,
  pinOrder: (json['pinOrder'] as num?)?.toInt(),
  archived: json['archived'] as bool? ?? false,
  hidden: json['hidden'] as bool? ?? false,
  customNickname: json['customNickname'] as String?,
  theme: json['theme'] as String?,
);

Map<String, dynamic> _$ConversationSettingsModelToJson(
  _ConversationSettingsModel instance,
) => <String, dynamic>{
  'conversationId': instance.conversationId,
  'muted': instance.muted,
  'blocked': instance.blocked,
  'notificationsEnabled': instance.notificationsEnabled,
  'pinned': instance.pinned,
  'pinOrder': instance.pinOrder,
  'archived': instance.archived,
  'hidden': instance.hidden,
  'customNickname': instance.customNickname,
  'theme': instance.theme,
};

_UpdateConversationSettingsRequest _$UpdateConversationSettingsRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateConversationSettingsRequest(
  notificationsEnabled: json['notificationsEnabled'] as bool?,
  customNickname: json['customNickname'] as String?,
  theme: json['theme'] as String?,
);

Map<String, dynamic> _$UpdateConversationSettingsRequestToJson(
  _UpdateConversationSettingsRequest instance,
) => <String, dynamic>{
  'notificationsEnabled': instance.notificationsEnabled,
  'customNickname': instance.customNickname,
  'theme': instance.theme,
};

_ConversationPermissionsModel _$ConversationPermissionsModelFromJson(
  Map<String, dynamic> json,
) => _ConversationPermissionsModel(
  conversationId: (json['conversationId'] as num).toInt(),
  sendMessages: json['sendMessages'] as String? ?? 'ALL',
  addMembers: json['addMembers'] as String? ?? 'ADMIN_ONLY',
  removeMembers: json['removeMembers'] as String? ?? 'ADMIN_ONLY',
  editGroupInfo: json['editGroupInfo'] as String? ?? 'ADMIN_ONLY',
  pinMessages: json['pinMessages'] as String? ?? 'ADMIN_ONLY',
  deleteMessages: json['deleteMessages'] as String? ?? 'ADMIN_ONLY',
  createPolls: json['createPolls'] as String? ?? 'ALL',
);

Map<String, dynamic> _$ConversationPermissionsModelToJson(
  _ConversationPermissionsModel instance,
) => <String, dynamic>{
  'conversationId': instance.conversationId,
  'sendMessages': instance.sendMessages,
  'addMembers': instance.addMembers,
  'removeMembers': instance.removeMembers,
  'editGroupInfo': instance.editGroupInfo,
  'pinMessages': instance.pinMessages,
  'deleteMessages': instance.deleteMessages,
  'createPolls': instance.createPolls,
};

_UpdateConversationPermissionsRequest
_$UpdateConversationPermissionsRequestFromJson(Map<String, dynamic> json) =>
    _UpdateConversationPermissionsRequest(
      sendMessages: json['sendMessages'] as String?,
      addMembers: json['addMembers'] as String?,
      removeMembers: json['removeMembers'] as String?,
      editGroupInfo: json['editGroupInfo'] as String?,
      pinMessages: json['pinMessages'] as String?,
      deleteMessages: json['deleteMessages'] as String?,
      createPolls: json['createPolls'] as String?,
    );

Map<String, dynamic> _$UpdateConversationPermissionsRequestToJson(
  _UpdateConversationPermissionsRequest instance,
) => <String, dynamic>{
  'sendMessages': instance.sendMessages,
  'addMembers': instance.addMembers,
  'removeMembers': instance.removeMembers,
  'editGroupInfo': instance.editGroupInfo,
  'pinMessages': instance.pinMessages,
  'deleteMessages': instance.deleteMessages,
  'createPolls': instance.createPolls,
};

_MuteMemberRequest _$MuteMemberRequestFromJson(Map<String, dynamic> json) =>
    _MuteMemberRequest(duration: (json['duration'] as num).toInt());

Map<String, dynamic> _$MuteMemberRequestToJson(_MuteMemberRequest instance) =>
    <String, dynamic>{'duration': instance.duration};

_MutedMemberModel _$MutedMemberModelFromJson(Map<String, dynamic> json) =>
    _MutedMemberModel(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      muted: json['muted'] as bool,
      mutedUntil: json['mutedUntil'] == null
          ? null
          : DateTime.parse(json['mutedUntil'] as String),
      mutedAt: json['mutedAt'] == null
          ? null
          : DateTime.parse(json['mutedAt'] as String),
      mutedBy: (json['mutedBy'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MutedMemberModelToJson(_MutedMemberModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'fullName': instance.fullName,
      'muted': instance.muted,
      'mutedUntil': instance.mutedUntil?.toIso8601String(),
      'mutedAt': instance.mutedAt?.toIso8601String(),
      'mutedBy': instance.mutedBy,
    };
