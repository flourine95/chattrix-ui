// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reply_to_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReplyToMessage {

 int get id; String get content; int get senderId; String get senderUsername; String? get senderFullName; String get type; String? get createdAt; String? get fileName; String? get locationName;
/// Create a copy of ReplyToMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplyToMessageCopyWith<ReplyToMessage> get copyWith => _$ReplyToMessageCopyWithImpl<ReplyToMessage>(this as ReplyToMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplyToMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.locationName, locationName) || other.locationName == locationName));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,senderId,senderUsername,senderFullName,type,createdAt,fileName,locationName);

@override
String toString() {
  return 'ReplyToMessage(id: $id, content: $content, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, type: $type, createdAt: $createdAt, fileName: $fileName, locationName: $locationName)';
}


}

/// @nodoc
abstract mixin class $ReplyToMessageCopyWith<$Res>  {
  factory $ReplyToMessageCopyWith(ReplyToMessage value, $Res Function(ReplyToMessage) _then) = _$ReplyToMessageCopyWithImpl;
@useResult
$Res call({
 int id, String content, int senderId, String senderUsername, String? senderFullName, String type, String? createdAt, String? fileName, String? locationName
});




}
/// @nodoc
class _$ReplyToMessageCopyWithImpl<$Res>
    implements $ReplyToMessageCopyWith<$Res> {
  _$ReplyToMessageCopyWithImpl(this._self, this._then);

  final ReplyToMessage _self;
  final $Res Function(ReplyToMessage) _then;

/// Create a copy of ReplyToMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? senderId = null,Object? senderUsername = null,Object? senderFullName = freezed,Object? type = null,Object? createdAt = freezed,Object? fileName = freezed,Object? locationName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: null == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String,senderFullName: freezed == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplyToMessage].
extension ReplyToMessagePatterns on ReplyToMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplyToMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplyToMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplyToMessage value)  $default,){
final _that = this;
switch (_that) {
case _ReplyToMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplyToMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ReplyToMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String content,  int senderId,  String senderUsername,  String? senderFullName,  String type,  String? createdAt,  String? fileName,  String? locationName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplyToMessage() when $default != null:
return $default(_that.id,_that.content,_that.senderId,_that.senderUsername,_that.senderFullName,_that.type,_that.createdAt,_that.fileName,_that.locationName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String content,  int senderId,  String senderUsername,  String? senderFullName,  String type,  String? createdAt,  String? fileName,  String? locationName)  $default,) {final _that = this;
switch (_that) {
case _ReplyToMessage():
return $default(_that.id,_that.content,_that.senderId,_that.senderUsername,_that.senderFullName,_that.type,_that.createdAt,_that.fileName,_that.locationName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String content,  int senderId,  String senderUsername,  String? senderFullName,  String type,  String? createdAt,  String? fileName,  String? locationName)?  $default,) {final _that = this;
switch (_that) {
case _ReplyToMessage() when $default != null:
return $default(_that.id,_that.content,_that.senderId,_that.senderUsername,_that.senderFullName,_that.type,_that.createdAt,_that.fileName,_that.locationName);case _:
  return null;

}
}

}

/// @nodoc


class _ReplyToMessage implements ReplyToMessage {
  const _ReplyToMessage({required this.id, required this.content, required this.senderId, required this.senderUsername, this.senderFullName, required this.type, this.createdAt, this.fileName, this.locationName});
  

@override final  int id;
@override final  String content;
@override final  int senderId;
@override final  String senderUsername;
@override final  String? senderFullName;
@override final  String type;
@override final  String? createdAt;
@override final  String? fileName;
@override final  String? locationName;

/// Create a copy of ReplyToMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplyToMessageCopyWith<_ReplyToMessage> get copyWith => __$ReplyToMessageCopyWithImpl<_ReplyToMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplyToMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.locationName, locationName) || other.locationName == locationName));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,senderId,senderUsername,senderFullName,type,createdAt,fileName,locationName);

@override
String toString() {
  return 'ReplyToMessage(id: $id, content: $content, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, type: $type, createdAt: $createdAt, fileName: $fileName, locationName: $locationName)';
}


}

/// @nodoc
abstract mixin class _$ReplyToMessageCopyWith<$Res> implements $ReplyToMessageCopyWith<$Res> {
  factory _$ReplyToMessageCopyWith(_ReplyToMessage value, $Res Function(_ReplyToMessage) _then) = __$ReplyToMessageCopyWithImpl;
@override @useResult
$Res call({
 int id, String content, int senderId, String senderUsername, String? senderFullName, String type, String? createdAt, String? fileName, String? locationName
});




}
/// @nodoc
class __$ReplyToMessageCopyWithImpl<$Res>
    implements _$ReplyToMessageCopyWith<$Res> {
  __$ReplyToMessageCopyWithImpl(this._self, this._then);

  final _ReplyToMessage _self;
  final $Res Function(_ReplyToMessage) _then;

/// Create a copy of ReplyToMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? senderId = null,Object? senderUsername = null,Object? senderFullName = freezed,Object? type = null,Object? createdAt = freezed,Object? fileName = freezed,Object? locationName = freezed,}) {
  return _then(_ReplyToMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: null == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String,senderFullName: freezed == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
