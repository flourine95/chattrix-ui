// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchUserModel _$SearchUserModelFromJson(Map<String, dynamic> json) =>
    _SearchUserModel(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      isOnline: json['isOnline'] as bool,
      lastSeen: json['lastSeen'] as String?,
      isContact: json['isContact'] as bool,
      hasConversation: json['hasConversation'] as bool,
      conversationId: (json['conversationId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchUserModelToJson(_SearchUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'isOnline': instance.isOnline,
      'lastSeen': instance.lastSeen,
      'isContact': instance.isContact,
      'hasConversation': instance.hasConversation,
      'conversationId': instance.conversationId,
    };
