// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    _ConversationModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      type: json['type'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => ParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConversationModelToJson(_ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'participants': instance.participants,
    };
