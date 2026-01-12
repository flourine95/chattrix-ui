// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_delete_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageDeleteDto {

 int get messageId; int get conversationId;
/// Create a copy of MessageDeleteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageDeleteDtoCopyWith<MessageDeleteDto> get copyWith => _$MessageDeleteDtoCopyWithImpl<MessageDeleteDto>(this as MessageDeleteDto, _$identity);

  /// Serializes this MessageDeleteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageDeleteDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,conversationId);

@override
String toString() {
  return 'MessageDeleteDto(messageId: $messageId, conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class $MessageDeleteDtoCopyWith<$Res>  {
  factory $MessageDeleteDtoCopyWith(MessageDeleteDto value, $Res Function(MessageDeleteDto) _then) = _$MessageDeleteDtoCopyWithImpl;
@useResult
$Res call({
 int messageId, int conversationId
});




}
/// @nodoc
class _$MessageDeleteDtoCopyWithImpl<$Res>
    implements $MessageDeleteDtoCopyWith<$Res> {
  _$MessageDeleteDtoCopyWithImpl(this._self, this._then);

  final MessageDeleteDto _self;
  final $Res Function(MessageDeleteDto) _then;

/// Create a copy of MessageDeleteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? conversationId = null,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageDeleteDto].
extension MessageDeleteDtoPatterns on MessageDeleteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageDeleteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageDeleteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageDeleteDto value)  $default,){
final _that = this;
switch (_that) {
case _MessageDeleteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageDeleteDto value)?  $default,){
final _that = this;
switch (_that) {
case _MessageDeleteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int messageId,  int conversationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageDeleteDto() when $default != null:
return $default(_that.messageId,_that.conversationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int messageId,  int conversationId)  $default,) {final _that = this;
switch (_that) {
case _MessageDeleteDto():
return $default(_that.messageId,_that.conversationId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int messageId,  int conversationId)?  $default,) {final _that = this;
switch (_that) {
case _MessageDeleteDto() when $default != null:
return $default(_that.messageId,_that.conversationId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageDeleteDto implements MessageDeleteDto {
  const _MessageDeleteDto({required this.messageId, required this.conversationId});
  factory _MessageDeleteDto.fromJson(Map<String, dynamic> json) => _$MessageDeleteDtoFromJson(json);

@override final  int messageId;
@override final  int conversationId;

/// Create a copy of MessageDeleteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageDeleteDtoCopyWith<_MessageDeleteDto> get copyWith => __$MessageDeleteDtoCopyWithImpl<_MessageDeleteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageDeleteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageDeleteDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,conversationId);

@override
String toString() {
  return 'MessageDeleteDto(messageId: $messageId, conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class _$MessageDeleteDtoCopyWith<$Res> implements $MessageDeleteDtoCopyWith<$Res> {
  factory _$MessageDeleteDtoCopyWith(_MessageDeleteDto value, $Res Function(_MessageDeleteDto) _then) = __$MessageDeleteDtoCopyWithImpl;
@override @useResult
$Res call({
 int messageId, int conversationId
});




}
/// @nodoc
class __$MessageDeleteDtoCopyWithImpl<$Res>
    implements _$MessageDeleteDtoCopyWith<$Res> {
  __$MessageDeleteDtoCopyWithImpl(this._self, this._then);

  final _MessageDeleteDto _self;
  final $Res Function(_MessageDeleteDto) _then;

/// Create a copy of MessageDeleteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? conversationId = null,}) {
  return _then(_MessageDeleteDto(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
