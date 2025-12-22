// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scheduled_msg_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScheduledMessageModel {

 int get id; int get conversationId; int get senderId; String? get senderUsername; String? get senderFullName; String get content; String get type; String? get mediaUrl; DateTime? get sentAt; DateTime get createdAt; DateTime get updatedAt;@DateTimeUtcConverter() DateTime? get scheduledTime; String? get scheduledStatus;
/// Create a copy of ScheduledMessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduledMessageModelCopyWith<ScheduledMessageModel> get copyWith => _$ScheduledMessageModelCopyWithImpl<ScheduledMessageModel>(this as ScheduledMessageModel, _$identity);

  /// Serializes this ScheduledMessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduledMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.scheduledStatus, scheduledStatus) || other.scheduledStatus == scheduledStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,mediaUrl,sentAt,createdAt,updatedAt,scheduledTime,scheduledStatus);

@override
String toString() {
  return 'ScheduledMessageModel(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, mediaUrl: $mediaUrl, sentAt: $sentAt, createdAt: $createdAt, updatedAt: $updatedAt, scheduledTime: $scheduledTime, scheduledStatus: $scheduledStatus)';
}


}

/// @nodoc
abstract mixin class $ScheduledMessageModelCopyWith<$Res>  {
  factory $ScheduledMessageModelCopyWith(ScheduledMessageModel value, $Res Function(ScheduledMessageModel) _then) = _$ScheduledMessageModelCopyWithImpl;
@useResult
$Res call({
 int id, int conversationId, int senderId, String? senderUsername, String? senderFullName, String content, String type, String? mediaUrl, DateTime? sentAt, DateTime createdAt, DateTime updatedAt,@DateTimeUtcConverter() DateTime? scheduledTime, String? scheduledStatus
});




}
/// @nodoc
class _$ScheduledMessageModelCopyWithImpl<$Res>
    implements $ScheduledMessageModelCopyWith<$Res> {
  _$ScheduledMessageModelCopyWithImpl(this._self, this._then);

  final ScheduledMessageModel _self;
  final $Res Function(ScheduledMessageModel) _then;

/// Create a copy of ScheduledMessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = freezed,Object? senderFullName = freezed,Object? content = null,Object? type = null,Object? mediaUrl = freezed,Object? sentAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? scheduledTime = freezed,Object? scheduledStatus = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: freezed == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String?,senderFullName: freezed == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledStatus: freezed == scheduledStatus ? _self.scheduledStatus : scheduledStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduledMessageModel].
extension ScheduledMessageModelPatterns on ScheduledMessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduledMessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduledMessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduledMessageModel value)  $default,){
final _that = this;
switch (_that) {
case _ScheduledMessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduledMessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduledMessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  String? mediaUrl,  DateTime? sentAt,  DateTime createdAt,  DateTime updatedAt, @DateTimeUtcConverter()  DateTime? scheduledTime,  String? scheduledStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduledMessageModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.mediaUrl,_that.sentAt,_that.createdAt,_that.updatedAt,_that.scheduledTime,_that.scheduledStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  String? mediaUrl,  DateTime? sentAt,  DateTime createdAt,  DateTime updatedAt, @DateTimeUtcConverter()  DateTime? scheduledTime,  String? scheduledStatus)  $default,) {final _that = this;
switch (_that) {
case _ScheduledMessageModel():
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.mediaUrl,_that.sentAt,_that.createdAt,_that.updatedAt,_that.scheduledTime,_that.scheduledStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  String? mediaUrl,  DateTime? sentAt,  DateTime createdAt,  DateTime updatedAt, @DateTimeUtcConverter()  DateTime? scheduledTime,  String? scheduledStatus)?  $default,) {final _that = this;
switch (_that) {
case _ScheduledMessageModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.mediaUrl,_that.sentAt,_that.createdAt,_that.updatedAt,_that.scheduledTime,_that.scheduledStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduledMessageModel extends ScheduledMessageModel {
  const _ScheduledMessageModel({required this.id, required this.conversationId, required this.senderId, this.senderUsername, this.senderFullName, required this.content, required this.type, this.mediaUrl, this.sentAt, required this.createdAt, required this.updatedAt, @DateTimeUtcConverter() this.scheduledTime, this.scheduledStatus}): super._();
  factory _ScheduledMessageModel.fromJson(Map<String, dynamic> json) => _$ScheduledMessageModelFromJson(json);

@override final  int id;
@override final  int conversationId;
@override final  int senderId;
@override final  String? senderUsername;
@override final  String? senderFullName;
@override final  String content;
@override final  String type;
@override final  String? mediaUrl;
@override final  DateTime? sentAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@DateTimeUtcConverter() final  DateTime? scheduledTime;
@override final  String? scheduledStatus;

/// Create a copy of ScheduledMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduledMessageModelCopyWith<_ScheduledMessageModel> get copyWith => __$ScheduledMessageModelCopyWithImpl<_ScheduledMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduledMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduledMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.scheduledStatus, scheduledStatus) || other.scheduledStatus == scheduledStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,mediaUrl,sentAt,createdAt,updatedAt,scheduledTime,scheduledStatus);

@override
String toString() {
  return 'ScheduledMessageModel(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, mediaUrl: $mediaUrl, sentAt: $sentAt, createdAt: $createdAt, updatedAt: $updatedAt, scheduledTime: $scheduledTime, scheduledStatus: $scheduledStatus)';
}


}

/// @nodoc
abstract mixin class _$ScheduledMessageModelCopyWith<$Res> implements $ScheduledMessageModelCopyWith<$Res> {
  factory _$ScheduledMessageModelCopyWith(_ScheduledMessageModel value, $Res Function(_ScheduledMessageModel) _then) = __$ScheduledMessageModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversationId, int senderId, String? senderUsername, String? senderFullName, String content, String type, String? mediaUrl, DateTime? sentAt, DateTime createdAt, DateTime updatedAt,@DateTimeUtcConverter() DateTime? scheduledTime, String? scheduledStatus
});




}
/// @nodoc
class __$ScheduledMessageModelCopyWithImpl<$Res>
    implements _$ScheduledMessageModelCopyWith<$Res> {
  __$ScheduledMessageModelCopyWithImpl(this._self, this._then);

  final _ScheduledMessageModel _self;
  final $Res Function(_ScheduledMessageModel) _then;

/// Create a copy of ScheduledMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = freezed,Object? senderFullName = freezed,Object? content = null,Object? type = null,Object? mediaUrl = freezed,Object? sentAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? scheduledTime = freezed,Object? scheduledStatus = freezed,}) {
  return _then(_ScheduledMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: freezed == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String?,senderFullName: freezed == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledStatus: freezed == scheduledStatus ? _self.scheduledStatus : scheduledStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ScheduleMessageRequest {

 String get content; String get type;@DateTimeUtcConverter() DateTime get scheduledTime; String? get mediaUrl; String? get thumbnailUrl; String? get fileName; int? get fileSize; int? get duration; int? get replyToMessageId;
/// Create a copy of ScheduleMessageRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleMessageRequestCopyWith<ScheduleMessageRequest> get copyWith => _$ScheduleMessageRequestCopyWithImpl<ScheduleMessageRequest>(this as ScheduleMessageRequest, _$identity);

  /// Serializes this ScheduleMessageRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleMessageRequest&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,type,scheduledTime,mediaUrl,thumbnailUrl,fileName,fileSize,duration,replyToMessageId);

@override
String toString() {
  return 'ScheduleMessageRequest(content: $content, type: $type, scheduledTime: $scheduledTime, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, duration: $duration, replyToMessageId: $replyToMessageId)';
}


}

/// @nodoc
abstract mixin class $ScheduleMessageRequestCopyWith<$Res>  {
  factory $ScheduleMessageRequestCopyWith(ScheduleMessageRequest value, $Res Function(ScheduleMessageRequest) _then) = _$ScheduleMessageRequestCopyWithImpl;
@useResult
$Res call({
 String content, String type,@DateTimeUtcConverter() DateTime scheduledTime, String? mediaUrl, String? thumbnailUrl, String? fileName, int? fileSize, int? duration, int? replyToMessageId
});




}
/// @nodoc
class _$ScheduleMessageRequestCopyWithImpl<$Res>
    implements $ScheduleMessageRequestCopyWith<$Res> {
  _$ScheduleMessageRequestCopyWithImpl(this._self, this._then);

  final ScheduleMessageRequest _self;
  final $Res Function(ScheduleMessageRequest) _then;

/// Create a copy of ScheduleMessageRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? type = null,Object? scheduledTime = null,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? fileName = freezed,Object? fileSize = freezed,Object? duration = freezed,Object? replyToMessageId = freezed,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,scheduledTime: null == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleMessageRequest].
extension ScheduleMessageRequestPatterns on ScheduleMessageRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleMessageRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleMessageRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleMessageRequest value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleMessageRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleMessageRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleMessageRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content,  String type, @DateTimeUtcConverter()  DateTime scheduledTime,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  int? replyToMessageId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleMessageRequest() when $default != null:
return $default(_that.content,_that.type,_that.scheduledTime,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.replyToMessageId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content,  String type, @DateTimeUtcConverter()  DateTime scheduledTime,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  int? replyToMessageId)  $default,) {final _that = this;
switch (_that) {
case _ScheduleMessageRequest():
return $default(_that.content,_that.type,_that.scheduledTime,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.replyToMessageId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content,  String type, @DateTimeUtcConverter()  DateTime scheduledTime,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  int? replyToMessageId)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleMessageRequest() when $default != null:
return $default(_that.content,_that.type,_that.scheduledTime,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.replyToMessageId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduleMessageRequest extends ScheduleMessageRequest {
  const _ScheduleMessageRequest({required this.content, this.type = 'TEXT', @DateTimeUtcConverter() required this.scheduledTime, this.mediaUrl, this.thumbnailUrl, this.fileName, this.fileSize, this.duration, this.replyToMessageId}): super._();
  factory _ScheduleMessageRequest.fromJson(Map<String, dynamic> json) => _$ScheduleMessageRequestFromJson(json);

@override final  String content;
@override@JsonKey() final  String type;
@override@DateTimeUtcConverter() final  DateTime scheduledTime;
@override final  String? mediaUrl;
@override final  String? thumbnailUrl;
@override final  String? fileName;
@override final  int? fileSize;
@override final  int? duration;
@override final  int? replyToMessageId;

/// Create a copy of ScheduleMessageRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleMessageRequestCopyWith<_ScheduleMessageRequest> get copyWith => __$ScheduleMessageRequestCopyWithImpl<_ScheduleMessageRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleMessageRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleMessageRequest&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,type,scheduledTime,mediaUrl,thumbnailUrl,fileName,fileSize,duration,replyToMessageId);

@override
String toString() {
  return 'ScheduleMessageRequest(content: $content, type: $type, scheduledTime: $scheduledTime, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, duration: $duration, replyToMessageId: $replyToMessageId)';
}


}

/// @nodoc
abstract mixin class _$ScheduleMessageRequestCopyWith<$Res> implements $ScheduleMessageRequestCopyWith<$Res> {
  factory _$ScheduleMessageRequestCopyWith(_ScheduleMessageRequest value, $Res Function(_ScheduleMessageRequest) _then) = __$ScheduleMessageRequestCopyWithImpl;
@override @useResult
$Res call({
 String content, String type,@DateTimeUtcConverter() DateTime scheduledTime, String? mediaUrl, String? thumbnailUrl, String? fileName, int? fileSize, int? duration, int? replyToMessageId
});




}
/// @nodoc
class __$ScheduleMessageRequestCopyWithImpl<$Res>
    implements _$ScheduleMessageRequestCopyWith<$Res> {
  __$ScheduleMessageRequestCopyWithImpl(this._self, this._then);

  final _ScheduleMessageRequest _self;
  final $Res Function(_ScheduleMessageRequest) _then;

/// Create a copy of ScheduleMessageRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? type = null,Object? scheduledTime = null,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? fileName = freezed,Object? fileSize = freezed,Object? duration = freezed,Object? replyToMessageId = freezed,}) {
  return _then(_ScheduleMessageRequest(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,scheduledTime: null == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ScheduledMessageListItemModel {

 int get id; int get conversationId; int get senderId; String get content; String get type;@DateTimeUtcConverter() DateTime? get scheduledTime; String? get scheduledStatus; DateTime get createdAt;
/// Create a copy of ScheduledMessageListItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduledMessageListItemModelCopyWith<ScheduledMessageListItemModel> get copyWith => _$ScheduledMessageListItemModelCopyWithImpl<ScheduledMessageListItemModel>(this as ScheduledMessageListItemModel, _$identity);

  /// Serializes this ScheduledMessageListItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduledMessageListItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.scheduledStatus, scheduledStatus) || other.scheduledStatus == scheduledStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,senderId,content,type,scheduledTime,scheduledStatus,createdAt);

@override
String toString() {
  return 'ScheduledMessageListItemModel(id: $id, conversationId: $conversationId, senderId: $senderId, content: $content, type: $type, scheduledTime: $scheduledTime, scheduledStatus: $scheduledStatus, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ScheduledMessageListItemModelCopyWith<$Res>  {
  factory $ScheduledMessageListItemModelCopyWith(ScheduledMessageListItemModel value, $Res Function(ScheduledMessageListItemModel) _then) = _$ScheduledMessageListItemModelCopyWithImpl;
@useResult
$Res call({
 int id, int conversationId, int senderId, String content, String type,@DateTimeUtcConverter() DateTime? scheduledTime, String? scheduledStatus, DateTime createdAt
});




}
/// @nodoc
class _$ScheduledMessageListItemModelCopyWithImpl<$Res>
    implements $ScheduledMessageListItemModelCopyWith<$Res> {
  _$ScheduledMessageListItemModelCopyWithImpl(this._self, this._then);

  final ScheduledMessageListItemModel _self;
  final $Res Function(ScheduledMessageListItemModel) _then;

/// Create a copy of ScheduledMessageListItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? content = null,Object? type = null,Object? scheduledTime = freezed,Object? scheduledStatus = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledStatus: freezed == scheduledStatus ? _self.scheduledStatus : scheduledStatus // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduledMessageListItemModel].
extension ScheduledMessageListItemModelPatterns on ScheduledMessageListItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduledMessageListItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduledMessageListItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduledMessageListItemModel value)  $default,){
final _that = this;
switch (_that) {
case _ScheduledMessageListItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduledMessageListItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduledMessageListItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String content,  String type, @DateTimeUtcConverter()  DateTime? scheduledTime,  String? scheduledStatus,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduledMessageListItemModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.content,_that.type,_that.scheduledTime,_that.scheduledStatus,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String content,  String type, @DateTimeUtcConverter()  DateTime? scheduledTime,  String? scheduledStatus,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ScheduledMessageListItemModel():
return $default(_that.id,_that.conversationId,_that.senderId,_that.content,_that.type,_that.scheduledTime,_that.scheduledStatus,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int conversationId,  int senderId,  String content,  String type, @DateTimeUtcConverter()  DateTime? scheduledTime,  String? scheduledStatus,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ScheduledMessageListItemModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.content,_that.type,_that.scheduledTime,_that.scheduledStatus,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduledMessageListItemModel extends ScheduledMessageListItemModel {
  const _ScheduledMessageListItemModel({required this.id, required this.conversationId, required this.senderId, required this.content, required this.type, @DateTimeUtcConverter() this.scheduledTime, this.scheduledStatus, required this.createdAt}): super._();
  factory _ScheduledMessageListItemModel.fromJson(Map<String, dynamic> json) => _$ScheduledMessageListItemModelFromJson(json);

@override final  int id;
@override final  int conversationId;
@override final  int senderId;
@override final  String content;
@override final  String type;
@override@DateTimeUtcConverter() final  DateTime? scheduledTime;
@override final  String? scheduledStatus;
@override final  DateTime createdAt;

/// Create a copy of ScheduledMessageListItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduledMessageListItemModelCopyWith<_ScheduledMessageListItemModel> get copyWith => __$ScheduledMessageListItemModelCopyWithImpl<_ScheduledMessageListItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduledMessageListItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduledMessageListItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.scheduledStatus, scheduledStatus) || other.scheduledStatus == scheduledStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,senderId,content,type,scheduledTime,scheduledStatus,createdAt);

@override
String toString() {
  return 'ScheduledMessageListItemModel(id: $id, conversationId: $conversationId, senderId: $senderId, content: $content, type: $type, scheduledTime: $scheduledTime, scheduledStatus: $scheduledStatus, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ScheduledMessageListItemModelCopyWith<$Res> implements $ScheduledMessageListItemModelCopyWith<$Res> {
  factory _$ScheduledMessageListItemModelCopyWith(_ScheduledMessageListItemModel value, $Res Function(_ScheduledMessageListItemModel) _then) = __$ScheduledMessageListItemModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversationId, int senderId, String content, String type,@DateTimeUtcConverter() DateTime? scheduledTime, String? scheduledStatus, DateTime createdAt
});




}
/// @nodoc
class __$ScheduledMessageListItemModelCopyWithImpl<$Res>
    implements _$ScheduledMessageListItemModelCopyWith<$Res> {
  __$ScheduledMessageListItemModelCopyWithImpl(this._self, this._then);

  final _ScheduledMessageListItemModel _self;
  final $Res Function(_ScheduledMessageListItemModel) _then;

/// Create a copy of ScheduledMessageListItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? content = null,Object? type = null,Object? scheduledTime = freezed,Object? scheduledStatus = freezed,Object? createdAt = null,}) {
  return _then(_ScheduledMessageListItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledStatus: freezed == scheduledStatus ? _self.scheduledStatus : scheduledStatus // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ScheduledMessagesPaginationResponse {

@JsonKey(name: 'data') List<ScheduledMessageListItemModel> get messages;@JsonKey(name: 'total') int get totalElements; int get totalPages;@JsonKey(name: 'page') int get currentPage;@JsonKey(name: 'size') int get pageSize;
/// Create a copy of ScheduledMessagesPaginationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduledMessagesPaginationResponseCopyWith<ScheduledMessagesPaginationResponse> get copyWith => _$ScheduledMessagesPaginationResponseCopyWithImpl<ScheduledMessagesPaginationResponse>(this as ScheduledMessagesPaginationResponse, _$identity);

  /// Serializes this ScheduledMessagesPaginationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduledMessagesPaginationResponse&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),totalElements,totalPages,currentPage,pageSize);

@override
String toString() {
  return 'ScheduledMessagesPaginationResponse(messages: $messages, totalElements: $totalElements, totalPages: $totalPages, currentPage: $currentPage, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $ScheduledMessagesPaginationResponseCopyWith<$Res>  {
  factory $ScheduledMessagesPaginationResponseCopyWith(ScheduledMessagesPaginationResponse value, $Res Function(ScheduledMessagesPaginationResponse) _then) = _$ScheduledMessagesPaginationResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') List<ScheduledMessageListItemModel> messages,@JsonKey(name: 'total') int totalElements, int totalPages,@JsonKey(name: 'page') int currentPage,@JsonKey(name: 'size') int pageSize
});




}
/// @nodoc
class _$ScheduledMessagesPaginationResponseCopyWithImpl<$Res>
    implements $ScheduledMessagesPaginationResponseCopyWith<$Res> {
  _$ScheduledMessagesPaginationResponseCopyWithImpl(this._self, this._then);

  final ScheduledMessagesPaginationResponse _self;
  final $Res Function(ScheduledMessagesPaginationResponse) _then;

/// Create a copy of ScheduledMessagesPaginationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? totalElements = null,Object? totalPages = null,Object? currentPage = null,Object? pageSize = null,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ScheduledMessageListItemModel>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduledMessagesPaginationResponse].
extension ScheduledMessagesPaginationResponsePatterns on ScheduledMessagesPaginationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduledMessagesPaginationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduledMessagesPaginationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduledMessagesPaginationResponse value)  $default,){
final _that = this;
switch (_that) {
case _ScheduledMessagesPaginationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduledMessagesPaginationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduledMessagesPaginationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<ScheduledMessageListItemModel> messages, @JsonKey(name: 'total')  int totalElements,  int totalPages, @JsonKey(name: 'page')  int currentPage, @JsonKey(name: 'size')  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduledMessagesPaginationResponse() when $default != null:
return $default(_that.messages,_that.totalElements,_that.totalPages,_that.currentPage,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<ScheduledMessageListItemModel> messages, @JsonKey(name: 'total')  int totalElements,  int totalPages, @JsonKey(name: 'page')  int currentPage, @JsonKey(name: 'size')  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _ScheduledMessagesPaginationResponse():
return $default(_that.messages,_that.totalElements,_that.totalPages,_that.currentPage,_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  List<ScheduledMessageListItemModel> messages, @JsonKey(name: 'total')  int totalElements,  int totalPages, @JsonKey(name: 'page')  int currentPage, @JsonKey(name: 'size')  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _ScheduledMessagesPaginationResponse() when $default != null:
return $default(_that.messages,_that.totalElements,_that.totalPages,_that.currentPage,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduledMessagesPaginationResponse implements ScheduledMessagesPaginationResponse {
  const _ScheduledMessagesPaginationResponse({@JsonKey(name: 'data') final  List<ScheduledMessageListItemModel> messages = const [], @JsonKey(name: 'total') this.totalElements = 0, this.totalPages = 0, @JsonKey(name: 'page') this.currentPage = 0, @JsonKey(name: 'size') this.pageSize = 0}): _messages = messages;
  factory _ScheduledMessagesPaginationResponse.fromJson(Map<String, dynamic> json) => _$ScheduledMessagesPaginationResponseFromJson(json);

 final  List<ScheduledMessageListItemModel> _messages;
@override@JsonKey(name: 'data') List<ScheduledMessageListItemModel> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey(name: 'total') final  int totalElements;
@override@JsonKey() final  int totalPages;
@override@JsonKey(name: 'page') final  int currentPage;
@override@JsonKey(name: 'size') final  int pageSize;

/// Create a copy of ScheduledMessagesPaginationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduledMessagesPaginationResponseCopyWith<_ScheduledMessagesPaginationResponse> get copyWith => __$ScheduledMessagesPaginationResponseCopyWithImpl<_ScheduledMessagesPaginationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduledMessagesPaginationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduledMessagesPaginationResponse&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),totalElements,totalPages,currentPage,pageSize);

@override
String toString() {
  return 'ScheduledMessagesPaginationResponse(messages: $messages, totalElements: $totalElements, totalPages: $totalPages, currentPage: $currentPage, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$ScheduledMessagesPaginationResponseCopyWith<$Res> implements $ScheduledMessagesPaginationResponseCopyWith<$Res> {
  factory _$ScheduledMessagesPaginationResponseCopyWith(_ScheduledMessagesPaginationResponse value, $Res Function(_ScheduledMessagesPaginationResponse) _then) = __$ScheduledMessagesPaginationResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') List<ScheduledMessageListItemModel> messages,@JsonKey(name: 'total') int totalElements, int totalPages,@JsonKey(name: 'page') int currentPage,@JsonKey(name: 'size') int pageSize
});




}
/// @nodoc
class __$ScheduledMessagesPaginationResponseCopyWithImpl<$Res>
    implements _$ScheduledMessagesPaginationResponseCopyWith<$Res> {
  __$ScheduledMessagesPaginationResponseCopyWithImpl(this._self, this._then);

  final _ScheduledMessagesPaginationResponse _self;
  final $Res Function(_ScheduledMessagesPaginationResponse) _then;

/// Create a copy of ScheduledMessagesPaginationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? totalElements = null,Object? totalPages = null,Object? currentPage = null,Object? pageSize = null,}) {
  return _then(_ScheduledMessagesPaginationResponse(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ScheduledMessageListItemModel>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$UpdateScheduledMessageRequest {

 String? get content;@DateTimeUtcConverter() DateTime? get scheduledTime; String? get mediaUrl; String? get thumbnailUrl; String? get fileName;
/// Create a copy of UpdateScheduledMessageRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateScheduledMessageRequestCopyWith<UpdateScheduledMessageRequest> get copyWith => _$UpdateScheduledMessageRequestCopyWithImpl<UpdateScheduledMessageRequest>(this as UpdateScheduledMessageRequest, _$identity);

  /// Serializes this UpdateScheduledMessageRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateScheduledMessageRequest&&(identical(other.content, content) || other.content == content)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,scheduledTime,mediaUrl,thumbnailUrl,fileName);

@override
String toString() {
  return 'UpdateScheduledMessageRequest(content: $content, scheduledTime: $scheduledTime, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, fileName: $fileName)';
}


}

/// @nodoc
abstract mixin class $UpdateScheduledMessageRequestCopyWith<$Res>  {
  factory $UpdateScheduledMessageRequestCopyWith(UpdateScheduledMessageRequest value, $Res Function(UpdateScheduledMessageRequest) _then) = _$UpdateScheduledMessageRequestCopyWithImpl;
@useResult
$Res call({
 String? content,@DateTimeUtcConverter() DateTime? scheduledTime, String? mediaUrl, String? thumbnailUrl, String? fileName
});




}
/// @nodoc
class _$UpdateScheduledMessageRequestCopyWithImpl<$Res>
    implements $UpdateScheduledMessageRequestCopyWith<$Res> {
  _$UpdateScheduledMessageRequestCopyWithImpl(this._self, this._then);

  final UpdateScheduledMessageRequest _self;
  final $Res Function(UpdateScheduledMessageRequest) _then;

/// Create a copy of UpdateScheduledMessageRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = freezed,Object? scheduledTime = freezed,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? fileName = freezed,}) {
  return _then(_self.copyWith(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateScheduledMessageRequest].
extension UpdateScheduledMessageRequestPatterns on UpdateScheduledMessageRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateScheduledMessageRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateScheduledMessageRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateScheduledMessageRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateScheduledMessageRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateScheduledMessageRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateScheduledMessageRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? content, @DateTimeUtcConverter()  DateTime? scheduledTime,  String? mediaUrl,  String? thumbnailUrl,  String? fileName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateScheduledMessageRequest() when $default != null:
return $default(_that.content,_that.scheduledTime,_that.mediaUrl,_that.thumbnailUrl,_that.fileName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? content, @DateTimeUtcConverter()  DateTime? scheduledTime,  String? mediaUrl,  String? thumbnailUrl,  String? fileName)  $default,) {final _that = this;
switch (_that) {
case _UpdateScheduledMessageRequest():
return $default(_that.content,_that.scheduledTime,_that.mediaUrl,_that.thumbnailUrl,_that.fileName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? content, @DateTimeUtcConverter()  DateTime? scheduledTime,  String? mediaUrl,  String? thumbnailUrl,  String? fileName)?  $default,) {final _that = this;
switch (_that) {
case _UpdateScheduledMessageRequest() when $default != null:
return $default(_that.content,_that.scheduledTime,_that.mediaUrl,_that.thumbnailUrl,_that.fileName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateScheduledMessageRequest extends UpdateScheduledMessageRequest {
  const _UpdateScheduledMessageRequest({this.content, @DateTimeUtcConverter() this.scheduledTime, this.mediaUrl, this.thumbnailUrl, this.fileName}): super._();
  factory _UpdateScheduledMessageRequest.fromJson(Map<String, dynamic> json) => _$UpdateScheduledMessageRequestFromJson(json);

@override final  String? content;
@override@DateTimeUtcConverter() final  DateTime? scheduledTime;
@override final  String? mediaUrl;
@override final  String? thumbnailUrl;
@override final  String? fileName;

/// Create a copy of UpdateScheduledMessageRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateScheduledMessageRequestCopyWith<_UpdateScheduledMessageRequest> get copyWith => __$UpdateScheduledMessageRequestCopyWithImpl<_UpdateScheduledMessageRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateScheduledMessageRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateScheduledMessageRequest&&(identical(other.content, content) || other.content == content)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,scheduledTime,mediaUrl,thumbnailUrl,fileName);

@override
String toString() {
  return 'UpdateScheduledMessageRequest(content: $content, scheduledTime: $scheduledTime, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, fileName: $fileName)';
}


}

/// @nodoc
abstract mixin class _$UpdateScheduledMessageRequestCopyWith<$Res> implements $UpdateScheduledMessageRequestCopyWith<$Res> {
  factory _$UpdateScheduledMessageRequestCopyWith(_UpdateScheduledMessageRequest value, $Res Function(_UpdateScheduledMessageRequest) _then) = __$UpdateScheduledMessageRequestCopyWithImpl;
@override @useResult
$Res call({
 String? content,@DateTimeUtcConverter() DateTime? scheduledTime, String? mediaUrl, String? thumbnailUrl, String? fileName
});




}
/// @nodoc
class __$UpdateScheduledMessageRequestCopyWithImpl<$Res>
    implements _$UpdateScheduledMessageRequestCopyWith<$Res> {
  __$UpdateScheduledMessageRequestCopyWithImpl(this._self, this._then);

  final _UpdateScheduledMessageRequest _self;
  final $Res Function(_UpdateScheduledMessageRequest) _then;

/// Create a copy of UpdateScheduledMessageRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = freezed,Object? scheduledTime = freezed,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? fileName = freezed,}) {
  return _then(_UpdateScheduledMessageRequest(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BulkCancelRequest {

 List<int> get scheduledMessageIds;
/// Create a copy of BulkCancelRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BulkCancelRequestCopyWith<BulkCancelRequest> get copyWith => _$BulkCancelRequestCopyWithImpl<BulkCancelRequest>(this as BulkCancelRequest, _$identity);

  /// Serializes this BulkCancelRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BulkCancelRequest&&const DeepCollectionEquality().equals(other.scheduledMessageIds, scheduledMessageIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(scheduledMessageIds));

@override
String toString() {
  return 'BulkCancelRequest(scheduledMessageIds: $scheduledMessageIds)';
}


}

/// @nodoc
abstract mixin class $BulkCancelRequestCopyWith<$Res>  {
  factory $BulkCancelRequestCopyWith(BulkCancelRequest value, $Res Function(BulkCancelRequest) _then) = _$BulkCancelRequestCopyWithImpl;
@useResult
$Res call({
 List<int> scheduledMessageIds
});




}
/// @nodoc
class _$BulkCancelRequestCopyWithImpl<$Res>
    implements $BulkCancelRequestCopyWith<$Res> {
  _$BulkCancelRequestCopyWithImpl(this._self, this._then);

  final BulkCancelRequest _self;
  final $Res Function(BulkCancelRequest) _then;

/// Create a copy of BulkCancelRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scheduledMessageIds = null,}) {
  return _then(_self.copyWith(
scheduledMessageIds: null == scheduledMessageIds ? _self.scheduledMessageIds : scheduledMessageIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [BulkCancelRequest].
extension BulkCancelRequestPatterns on BulkCancelRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BulkCancelRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BulkCancelRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BulkCancelRequest value)  $default,){
final _that = this;
switch (_that) {
case _BulkCancelRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BulkCancelRequest value)?  $default,){
final _that = this;
switch (_that) {
case _BulkCancelRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<int> scheduledMessageIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BulkCancelRequest() when $default != null:
return $default(_that.scheduledMessageIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<int> scheduledMessageIds)  $default,) {final _that = this;
switch (_that) {
case _BulkCancelRequest():
return $default(_that.scheduledMessageIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<int> scheduledMessageIds)?  $default,) {final _that = this;
switch (_that) {
case _BulkCancelRequest() when $default != null:
return $default(_that.scheduledMessageIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BulkCancelRequest implements BulkCancelRequest {
  const _BulkCancelRequest({required final  List<int> scheduledMessageIds}): _scheduledMessageIds = scheduledMessageIds;
  factory _BulkCancelRequest.fromJson(Map<String, dynamic> json) => _$BulkCancelRequestFromJson(json);

 final  List<int> _scheduledMessageIds;
@override List<int> get scheduledMessageIds {
  if (_scheduledMessageIds is EqualUnmodifiableListView) return _scheduledMessageIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scheduledMessageIds);
}


/// Create a copy of BulkCancelRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BulkCancelRequestCopyWith<_BulkCancelRequest> get copyWith => __$BulkCancelRequestCopyWithImpl<_BulkCancelRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BulkCancelRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BulkCancelRequest&&const DeepCollectionEquality().equals(other._scheduledMessageIds, _scheduledMessageIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_scheduledMessageIds));

@override
String toString() {
  return 'BulkCancelRequest(scheduledMessageIds: $scheduledMessageIds)';
}


}

/// @nodoc
abstract mixin class _$BulkCancelRequestCopyWith<$Res> implements $BulkCancelRequestCopyWith<$Res> {
  factory _$BulkCancelRequestCopyWith(_BulkCancelRequest value, $Res Function(_BulkCancelRequest) _then) = __$BulkCancelRequestCopyWithImpl;
@override @useResult
$Res call({
 List<int> scheduledMessageIds
});




}
/// @nodoc
class __$BulkCancelRequestCopyWithImpl<$Res>
    implements _$BulkCancelRequestCopyWith<$Res> {
  __$BulkCancelRequestCopyWithImpl(this._self, this._then);

  final _BulkCancelRequest _self;
  final $Res Function(_BulkCancelRequest) _then;

/// Create a copy of BulkCancelRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scheduledMessageIds = null,}) {
  return _then(_BulkCancelRequest(
scheduledMessageIds: null == scheduledMessageIds ? _self._scheduledMessageIds : scheduledMessageIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$BulkCancelResponse {

 int get cancelledCount; List<int> get failedIds;
/// Create a copy of BulkCancelResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BulkCancelResponseCopyWith<BulkCancelResponse> get copyWith => _$BulkCancelResponseCopyWithImpl<BulkCancelResponse>(this as BulkCancelResponse, _$identity);

  /// Serializes this BulkCancelResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BulkCancelResponse&&(identical(other.cancelledCount, cancelledCount) || other.cancelledCount == cancelledCount)&&const DeepCollectionEquality().equals(other.failedIds, failedIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cancelledCount,const DeepCollectionEquality().hash(failedIds));

@override
String toString() {
  return 'BulkCancelResponse(cancelledCount: $cancelledCount, failedIds: $failedIds)';
}


}

/// @nodoc
abstract mixin class $BulkCancelResponseCopyWith<$Res>  {
  factory $BulkCancelResponseCopyWith(BulkCancelResponse value, $Res Function(BulkCancelResponse) _then) = _$BulkCancelResponseCopyWithImpl;
@useResult
$Res call({
 int cancelledCount, List<int> failedIds
});




}
/// @nodoc
class _$BulkCancelResponseCopyWithImpl<$Res>
    implements $BulkCancelResponseCopyWith<$Res> {
  _$BulkCancelResponseCopyWithImpl(this._self, this._then);

  final BulkCancelResponse _self;
  final $Res Function(BulkCancelResponse) _then;

/// Create a copy of BulkCancelResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cancelledCount = null,Object? failedIds = null,}) {
  return _then(_self.copyWith(
cancelledCount: null == cancelledCount ? _self.cancelledCount : cancelledCount // ignore: cast_nullable_to_non_nullable
as int,failedIds: null == failedIds ? _self.failedIds : failedIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [BulkCancelResponse].
extension BulkCancelResponsePatterns on BulkCancelResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BulkCancelResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BulkCancelResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BulkCancelResponse value)  $default,){
final _that = this;
switch (_that) {
case _BulkCancelResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BulkCancelResponse value)?  $default,){
final _that = this;
switch (_that) {
case _BulkCancelResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int cancelledCount,  List<int> failedIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BulkCancelResponse() when $default != null:
return $default(_that.cancelledCount,_that.failedIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int cancelledCount,  List<int> failedIds)  $default,) {final _that = this;
switch (_that) {
case _BulkCancelResponse():
return $default(_that.cancelledCount,_that.failedIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int cancelledCount,  List<int> failedIds)?  $default,) {final _that = this;
switch (_that) {
case _BulkCancelResponse() when $default != null:
return $default(_that.cancelledCount,_that.failedIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BulkCancelResponse implements BulkCancelResponse {
  const _BulkCancelResponse({required this.cancelledCount, required final  List<int> failedIds}): _failedIds = failedIds;
  factory _BulkCancelResponse.fromJson(Map<String, dynamic> json) => _$BulkCancelResponseFromJson(json);

@override final  int cancelledCount;
 final  List<int> _failedIds;
@override List<int> get failedIds {
  if (_failedIds is EqualUnmodifiableListView) return _failedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_failedIds);
}


/// Create a copy of BulkCancelResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BulkCancelResponseCopyWith<_BulkCancelResponse> get copyWith => __$BulkCancelResponseCopyWithImpl<_BulkCancelResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BulkCancelResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BulkCancelResponse&&(identical(other.cancelledCount, cancelledCount) || other.cancelledCount == cancelledCount)&&const DeepCollectionEquality().equals(other._failedIds, _failedIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cancelledCount,const DeepCollectionEquality().hash(_failedIds));

@override
String toString() {
  return 'BulkCancelResponse(cancelledCount: $cancelledCount, failedIds: $failedIds)';
}


}

/// @nodoc
abstract mixin class _$BulkCancelResponseCopyWith<$Res> implements $BulkCancelResponseCopyWith<$Res> {
  factory _$BulkCancelResponseCopyWith(_BulkCancelResponse value, $Res Function(_BulkCancelResponse) _then) = __$BulkCancelResponseCopyWithImpl;
@override @useResult
$Res call({
 int cancelledCount, List<int> failedIds
});




}
/// @nodoc
class __$BulkCancelResponseCopyWithImpl<$Res>
    implements _$BulkCancelResponseCopyWith<$Res> {
  __$BulkCancelResponseCopyWithImpl(this._self, this._then);

  final _BulkCancelResponse _self;
  final $Res Function(_BulkCancelResponse) _then;

/// Create a copy of BulkCancelResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cancelledCount = null,Object? failedIds = null,}) {
  return _then(_BulkCancelResponse(
cancelledCount: null == cancelledCount ? _self.cancelledCount : cancelledCount // ignore: cast_nullable_to_non_nullable
as int,failedIds: null == failedIds ? _self._failedIds : failedIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
