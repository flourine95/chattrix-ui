// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'mutual_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MutualGroupModel _$MutualGroupModelFromJson(Map<String, dynamic> json) =>
    _MutualGroupModel(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      participants:
          (json['participants'] as List<dynamic>?)
              ?.map((e) => ParticipantModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MutualGroupModelToJson(_MutualGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'participants': instance.participants,
    };
