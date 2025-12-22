// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scheduled_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduledMessage {

 int get id; int get conversationId; int get senderId; String? get senderUsername; String? get senderFullName; String get content; String get type; String? get mediaUrl; String? get thumbnailUrl; String? get fileName; int? get fileSize; int? get duration; int? get replyToMessageId; DateTime? get sentAt; DateTime get createdAt; DateTime get updatedAt;// These fields only available in list response
 DateTime? get scheduledTime; String? get scheduledStatus;
/// Create a copy of ScheduledMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduledMessageCopyWith<ScheduledMessage> get copyWith => _$ScheduledMessageCopyWithImpl<ScheduledMessage>(this as ScheduledMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduledMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.scheduledStatus, scheduledStatus) || other.scheduledStatus == scheduledStatus));
}


@override
int get hashCode => Object.hash(runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,mediaUrl,thumbnailUrl,fileName,fileSize,duration,replyToMessageId,sentAt,createdAt,updatedAt,scheduledTime,scheduledStatus);

@override
String toString() {
  return 'ScheduledMessage(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, duration: $duration, replyToMessageId: $replyToMessageId, sentAt: $sentAt, createdAt: $createdAt, updatedAt: $updatedAt, scheduledTime: $scheduledTime, scheduledStatus: $scheduledStatus)';
}


}

/// @nodoc
abstract mixin class $ScheduledMessageCopyWith<$Res>  {
  factory $ScheduledMessageCopyWith(ScheduledMessage value, $Res Function(ScheduledMessage) _then) = _$ScheduledMessageCopyWithImpl;
@useResult
$Res call({
 int id, int conversationId, int senderId, String? senderUsername, String? senderFullName, String content, String type, String? mediaUrl, String? thumbnailUrl, String? fileName, int? fileSize, int? duration, int? replyToMessageId, DateTime? sentAt, DateTime createdAt, DateTime updatedAt, DateTime? scheduledTime, String? scheduledStatus
});




}
/// @nodoc
class _$ScheduledMessageCopyWithImpl<$Res>
    implements $ScheduledMessageCopyWith<$Res> {
  _$ScheduledMessageCopyWithImpl(this._self, this._then);

  final ScheduledMessage _self;
  final $Res Function(ScheduledMessage) _then;

/// Create a copy of ScheduledMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = freezed,Object? senderFullName = freezed,Object? content = null,Object? type = null,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? fileName = freezed,Object? fileSize = freezed,Object? duration = freezed,Object? replyToMessageId = freezed,Object? sentAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? scheduledTime = freezed,Object? scheduledStatus = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: freezed == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String?,senderFullName: freezed == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as int?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledStatus: freezed == scheduledStatus ? _self.scheduledStatus : scheduledStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduledMessage].
extension ScheduledMessagePatterns on ScheduledMessage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduledMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduledMessage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduledMessage value)  $default,){
final _that = this;
switch (_that) {
case _ScheduledMessage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduledMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduledMessage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  int? replyToMessageId,  DateTime? sentAt,  DateTime createdAt,  DateTime updatedAt,  DateTime? scheduledTime,  String? scheduledStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduledMessage() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.replyToMessageId,_that.sentAt,_that.createdAt,_that.updatedAt,_that.scheduledTime,_that.scheduledStatus);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  int? replyToMessageId,  DateTime? sentAt,  DateTime createdAt,  DateTime updatedAt,  DateTime? scheduledTime,  String? scheduledStatus)  $default,) {final _that = this;
switch (_that) {
case _ScheduledMessage():
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.replyToMessageId,_that.sentAt,_that.createdAt,_that.updatedAt,_that.scheduledTime,_that.scheduledStatus);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  int? replyToMessageId,  DateTime? sentAt,  DateTime createdAt,  DateTime updatedAt,  DateTime? scheduledTime,  String? scheduledStatus)?  $default,) {final _that = this;
switch (_that) {
case _ScheduledMessage() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.replyToMessageId,_that.sentAt,_that.createdAt,_that.updatedAt,_that.scheduledTime,_that.scheduledStatus);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduledMessage implements ScheduledMessage {
  const _ScheduledMessage({required this.id, required this.conversationId, required this.senderId, this.senderUsername, this.senderFullName, required this.content, required this.type, this.mediaUrl, this.thumbnailUrl, this.fileName, this.fileSize, this.duration, this.replyToMessageId, this.sentAt, required this.createdAt, required this.updatedAt, this.scheduledTime, this.scheduledStatus});
  

@override final  int id;
@override final  int conversationId;
@override final  int senderId;
@override final  String? senderUsername;
@override final  String? senderFullName;
@override final  String content;
@override final  String type;
@override final  String? mediaUrl;
@override final  String? thumbnailUrl;
@override final  String? fileName;
@override final  int? fileSize;
@override final  int? duration;
@override final  int? replyToMessageId;
@override final  DateTime? sentAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
// These fields only available in list response
@override final  DateTime? scheduledTime;
@override final  String? scheduledStatus;

/// Create a copy of ScheduledMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduledMessageCopyWith<_ScheduledMessage> get copyWith => __$ScheduledMessageCopyWithImpl<_ScheduledMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduledMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.scheduledStatus, scheduledStatus) || other.scheduledStatus == scheduledStatus));
}


@override
int get hashCode => Object.hash(runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,mediaUrl,thumbnailUrl,fileName,fileSize,duration,replyToMessageId,sentAt,createdAt,updatedAt,scheduledTime,scheduledStatus);

@override
String toString() {
  return 'ScheduledMessage(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, duration: $duration, replyToMessageId: $replyToMessageId, sentAt: $sentAt, createdAt: $createdAt, updatedAt: $updatedAt, scheduledTime: $scheduledTime, scheduledStatus: $scheduledStatus)';
}


}

/// @nodoc
abstract mixin class _$ScheduledMessageCopyWith<$Res> implements $ScheduledMessageCopyWith<$Res> {
  factory _$ScheduledMessageCopyWith(_ScheduledMessage value, $Res Function(_ScheduledMessage) _then) = __$ScheduledMessageCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversationId, int senderId, String? senderUsername, String? senderFullName, String content, String type, String? mediaUrl, String? thumbnailUrl, String? fileName, int? fileSize, int? duration, int? replyToMessageId, DateTime? sentAt, DateTime createdAt, DateTime updatedAt, DateTime? scheduledTime, String? scheduledStatus
});




}
/// @nodoc
class __$ScheduledMessageCopyWithImpl<$Res>
    implements _$ScheduledMessageCopyWith<$Res> {
  __$ScheduledMessageCopyWithImpl(this._self, this._then);

  final _ScheduledMessage _self;
  final $Res Function(_ScheduledMessage) _then;

/// Create a copy of ScheduledMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = freezed,Object? senderFullName = freezed,Object? content = null,Object? type = null,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? fileName = freezed,Object? fileSize = freezed,Object? duration = freezed,Object? replyToMessageId = freezed,Object? sentAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? scheduledTime = freezed,Object? scheduledStatus = freezed,}) {
  return _then(_ScheduledMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: freezed == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String?,senderFullName: freezed == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as int?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledStatus: freezed == scheduledStatus ? _self.scheduledStatus : scheduledStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
