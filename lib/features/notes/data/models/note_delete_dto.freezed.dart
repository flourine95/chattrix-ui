// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_delete_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoteDeleteDto {

 int get userId;
/// Create a copy of NoteDeleteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteDeleteDtoCopyWith<NoteDeleteDto> get copyWith => _$NoteDeleteDtoCopyWithImpl<NoteDeleteDto>(this as NoteDeleteDto, _$identity);

  /// Serializes this NoteDeleteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteDeleteDto&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'NoteDeleteDto(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $NoteDeleteDtoCopyWith<$Res>  {
  factory $NoteDeleteDtoCopyWith(NoteDeleteDto value, $Res Function(NoteDeleteDto) _then) = _$NoteDeleteDtoCopyWithImpl;
@useResult
$Res call({
 int userId
});




}
/// @nodoc
class _$NoteDeleteDtoCopyWithImpl<$Res>
    implements $NoteDeleteDtoCopyWith<$Res> {
  _$NoteDeleteDtoCopyWithImpl(this._self, this._then);

  final NoteDeleteDto _self;
  final $Res Function(NoteDeleteDto) _then;

/// Create a copy of NoteDeleteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteDeleteDto].
extension NoteDeleteDtoPatterns on NoteDeleteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteDeleteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteDeleteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteDeleteDto value)  $default,){
final _that = this;
switch (_that) {
case _NoteDeleteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteDeleteDto value)?  $default,){
final _that = this;
switch (_that) {
case _NoteDeleteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteDeleteDto() when $default != null:
return $default(_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId)  $default,) {final _that = this;
switch (_that) {
case _NoteDeleteDto():
return $default(_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId)?  $default,) {final _that = this;
switch (_that) {
case _NoteDeleteDto() when $default != null:
return $default(_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoteDeleteDto implements NoteDeleteDto {
  const _NoteDeleteDto({required this.userId});
  factory _NoteDeleteDto.fromJson(Map<String, dynamic> json) => _$NoteDeleteDtoFromJson(json);

@override final  int userId;

/// Create a copy of NoteDeleteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteDeleteDtoCopyWith<_NoteDeleteDto> get copyWith => __$NoteDeleteDtoCopyWithImpl<_NoteDeleteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoteDeleteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteDeleteDto&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'NoteDeleteDto(userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$NoteDeleteDtoCopyWith<$Res> implements $NoteDeleteDtoCopyWith<$Res> {
  factory _$NoteDeleteDtoCopyWith(_NoteDeleteDto value, $Res Function(_NoteDeleteDto) _then) = __$NoteDeleteDtoCopyWithImpl;
@override @useResult
$Res call({
 int userId
});




}
/// @nodoc
class __$NoteDeleteDtoCopyWithImpl<$Res>
    implements _$NoteDeleteDtoCopyWith<$Res> {
  __$NoteDeleteDtoCopyWithImpl(this._self, this._then);

  final _NoteDeleteDto _self;
  final $Res Function(_NoteDeleteDto) _then;

/// Create a copy of NoteDeleteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(_NoteDeleteDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
