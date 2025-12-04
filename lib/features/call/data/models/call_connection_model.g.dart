// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_connection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallConnectionModel _$CallConnectionModelFromJson(Map<String, dynamic> json) =>
    _CallConnectionModel(
      callInfo: CallInfoModel.fromJson(
        json['callInfo'] as Map<String, dynamic>,
      ),
      token: json['token'] as String,
    );

Map<String, dynamic> _$CallConnectionModelToJson(
  _CallConnectionModel instance,
) => <String, dynamic>{'callInfo': instance.callInfo, 'token': instance.token};
