// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_connection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallConnectionModel _$CallConnectionModelFromJson(Map<String, dynamic> json) =>
    _CallConnectionModel(
      callData: CallModel.fromJson(json['callData'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$CallConnectionModelToJson(
  _CallConnectionModel instance,
) => <String, dynamic>{'callData': instance.callData, 'token': instance.token};
