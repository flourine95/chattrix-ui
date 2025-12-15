// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'read_receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadReceiptModel _$ReadReceiptModelFromJson(Map<String, dynamic> json) =>
    _ReadReceiptModel(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      readAt: DateTime.parse(json['readAt'] as String),
    );

Map<String, dynamic> _$ReadReceiptModelToJson(_ReadReceiptModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'readAt': instance.readAt.toIso8601String(),
    };
