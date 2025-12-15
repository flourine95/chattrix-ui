// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reply_to_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReplyToMessageModel {

 int get id; String get content; int get senderId; String get senderUsername;
/// Create a copy of ReplyToMessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplyToMessageModelCopyWith<ReplyToMessageModel> get copyWith => _$ReplyToMessageModelCopyWithImpl<ReplyToMessageModel>(this as ReplyToMessageModel, _$identity);

  /// Serializes this ReplyToMessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplyToMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,senderId,senderUsername);

@override
String toString() {
  return 'ReplyToMessageModel(id: $id, content: $content, senderId: $senderId, senderUsername: $senderUsername)';
}


}

/// @nodoc
abstract mixin class $ReplyToMessageModelCopyWith<$Res>  {
  factory $ReplyToMessageModelCopyWith(ReplyToMessageModel value, $Res Function(ReplyToMessageModel) _then) = _$ReplyToMessageModelCopyWithImpl;
@useResult
$Res call({
 int id, String content, int senderId, String senderUsername
});




}
/// @nodoc
class _$ReplyToMessageModelCopyWithImpl<$Res>
    implements $ReplyToMessageModelCopyWith<$Res> {
  _$ReplyToMessageModelCopyWithImpl(this._self, this._then);

  final ReplyToMessageModel _self;
  final $Res Function(ReplyToMessageModel) _then;

/// Create a copy of ReplyToMessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? senderId = null,Object? senderUsername = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: null == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplyToMessageModel].
extension ReplyToMessageModelPatterns on ReplyToMessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplyToMessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplyToMessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplyToMessageModel value)  $default,){
final _that = this;
switch (_that) {
case _ReplyToMessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplyToMessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReplyToMessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String content,  int senderId,  String senderUsername)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplyToMessageModel() when $default != null:
return $default(_that.id,_that.content,_that.senderId,_that.senderUsername);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String content,  int senderId,  String senderUsername)  $default,) {final _that = this;
switch (_that) {
case _ReplyToMessageModel():
return $default(_that.id,_that.content,_that.senderId,_that.senderUsername);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String content,  int senderId,  String senderUsername)?  $default,) {final _that = this;
switch (_that) {
case _ReplyToMessageModel() when $default != null:
return $default(_that.id,_that.content,_that.senderId,_that.senderUsername);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplyToMessageModel extends ReplyToMessageModel {
  const _ReplyToMessageModel({required this.id, required this.content, required this.senderId, required this.senderUsername}): super._();
  factory _ReplyToMessageModel.fromJson(Map<String, dynamic> json) => _$ReplyToMessageModelFromJson(json);

@override final  int id;
@override final  String content;
@override final  int senderId;
@override final  String senderUsername;

/// Create a copy of ReplyToMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplyToMessageModelCopyWith<_ReplyToMessageModel> get copyWith => __$ReplyToMessageModelCopyWithImpl<_ReplyToMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplyToMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplyToMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,senderId,senderUsername);

@override
String toString() {
  return 'ReplyToMessageModel(id: $id, content: $content, senderId: $senderId, senderUsername: $senderUsername)';
}


}

/// @nodoc
abstract mixin class _$ReplyToMessageModelCopyWith<$Res> implements $ReplyToMessageModelCopyWith<$Res> {
  factory _$ReplyToMessageModelCopyWith(_ReplyToMessageModel value, $Res Function(_ReplyToMessageModel) _then) = __$ReplyToMessageModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String content, int senderId, String senderUsername
});




}
/// @nodoc
class __$ReplyToMessageModelCopyWithImpl<$Res>
    implements _$ReplyToMessageModelCopyWith<$Res> {
  __$ReplyToMessageModelCopyWithImpl(this._self, this._then);

  final _ReplyToMessageModel _self;
  final $Res Function(_ReplyToMessageModel) _then;

/// Create a copy of ReplyToMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? senderId = null,Object? senderUsername = null,}) {
  return _then(_ReplyToMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: null == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
