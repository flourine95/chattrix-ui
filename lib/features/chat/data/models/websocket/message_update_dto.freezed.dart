// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_update_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageUpdateDto {

 int get messageId; int get conversationId; String get content; bool get edited; DateTime get updatedAt;
/// Create a copy of MessageUpdateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageUpdateDtoCopyWith<MessageUpdateDto> get copyWith => _$MessageUpdateDtoCopyWithImpl<MessageUpdateDto>(this as MessageUpdateDto, _$identity);

  /// Serializes this MessageUpdateDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageUpdateDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.content, content) || other.content == content)&&(identical(other.edited, edited) || other.edited == edited)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,conversationId,content,edited,updatedAt);

@override
String toString() {
  return 'MessageUpdateDto(messageId: $messageId, conversationId: $conversationId, content: $content, edited: $edited, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MessageUpdateDtoCopyWith<$Res>  {
  factory $MessageUpdateDtoCopyWith(MessageUpdateDto value, $Res Function(MessageUpdateDto) _then) = _$MessageUpdateDtoCopyWithImpl;
@useResult
$Res call({
 int messageId, int conversationId, String content, bool edited, DateTime updatedAt
});




}
/// @nodoc
class _$MessageUpdateDtoCopyWithImpl<$Res>
    implements $MessageUpdateDtoCopyWith<$Res> {
  _$MessageUpdateDtoCopyWithImpl(this._self, this._then);

  final MessageUpdateDto _self;
  final $Res Function(MessageUpdateDto) _then;

/// Create a copy of MessageUpdateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? conversationId = null,Object? content = null,Object? edited = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageUpdateDto].
extension MessageUpdateDtoPatterns on MessageUpdateDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageUpdateDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageUpdateDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageUpdateDto value)  $default,){
final _that = this;
switch (_that) {
case _MessageUpdateDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageUpdateDto value)?  $default,){
final _that = this;
switch (_that) {
case _MessageUpdateDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int messageId,  int conversationId,  String content,  bool edited,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageUpdateDto() when $default != null:
return $default(_that.messageId,_that.conversationId,_that.content,_that.edited,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int messageId,  int conversationId,  String content,  bool edited,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MessageUpdateDto():
return $default(_that.messageId,_that.conversationId,_that.content,_that.edited,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int messageId,  int conversationId,  String content,  bool edited,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MessageUpdateDto() when $default != null:
return $default(_that.messageId,_that.conversationId,_that.content,_that.edited,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageUpdateDto implements MessageUpdateDto {
  const _MessageUpdateDto({required this.messageId, required this.conversationId, required this.content, required this.edited, required this.updatedAt});
  factory _MessageUpdateDto.fromJson(Map<String, dynamic> json) => _$MessageUpdateDtoFromJson(json);

@override final  int messageId;
@override final  int conversationId;
@override final  String content;
@override final  bool edited;
@override final  DateTime updatedAt;

/// Create a copy of MessageUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageUpdateDtoCopyWith<_MessageUpdateDto> get copyWith => __$MessageUpdateDtoCopyWithImpl<_MessageUpdateDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageUpdateDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageUpdateDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.content, content) || other.content == content)&&(identical(other.edited, edited) || other.edited == edited)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,conversationId,content,edited,updatedAt);

@override
String toString() {
  return 'MessageUpdateDto(messageId: $messageId, conversationId: $conversationId, content: $content, edited: $edited, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MessageUpdateDtoCopyWith<$Res> implements $MessageUpdateDtoCopyWith<$Res> {
  factory _$MessageUpdateDtoCopyWith(_MessageUpdateDto value, $Res Function(_MessageUpdateDto) _then) = __$MessageUpdateDtoCopyWithImpl;
@override @useResult
$Res call({
 int messageId, int conversationId, String content, bool edited, DateTime updatedAt
});




}
/// @nodoc
class __$MessageUpdateDtoCopyWithImpl<$Res>
    implements _$MessageUpdateDtoCopyWith<$Res> {
  __$MessageUpdateDtoCopyWithImpl(this._self, this._then);

  final _MessageUpdateDto _self;
  final $Res Function(_MessageUpdateDto) _then;

/// Create a copy of MessageUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? conversationId = null,Object? content = null,Object? edited = null,Object? updatedAt = null,}) {
  return _then(_MessageUpdateDto(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
