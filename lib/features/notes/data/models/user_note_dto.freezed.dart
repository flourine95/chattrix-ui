// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_note_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserNoteDto {

 int get id; int get userId; String get noteText; String? get emoji; String get createdAt; String get expiresAt;
/// Create a copy of UserNoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserNoteDtoCopyWith<UserNoteDto> get copyWith => _$UserNoteDtoCopyWithImpl<UserNoteDto>(this as UserNoteDto, _$identity);

  /// Serializes this UserNoteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserNoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.noteText, noteText) || other.noteText == noteText)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,noteText,emoji,createdAt,expiresAt);

@override
String toString() {
  return 'UserNoteDto(id: $id, userId: $userId, noteText: $noteText, emoji: $emoji, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $UserNoteDtoCopyWith<$Res>  {
  factory $UserNoteDtoCopyWith(UserNoteDto value, $Res Function(UserNoteDto) _then) = _$UserNoteDtoCopyWithImpl;
@useResult
$Res call({
 int id, int userId, String noteText, String? emoji, String createdAt, String expiresAt
});




}
/// @nodoc
class _$UserNoteDtoCopyWithImpl<$Res>
    implements $UserNoteDtoCopyWith<$Res> {
  _$UserNoteDtoCopyWithImpl(this._self, this._then);

  final UserNoteDto _self;
  final $Res Function(UserNoteDto) _then;

/// Create a copy of UserNoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? noteText = null,Object? emoji = freezed,Object? createdAt = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,noteText: null == noteText ? _self.noteText : noteText // ignore: cast_nullable_to_non_nullable
as String,emoji: freezed == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserNoteDto].
extension UserNoteDtoPatterns on UserNoteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserNoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserNoteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserNoteDto value)  $default,){
final _that = this;
switch (_that) {
case _UserNoteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserNoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserNoteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int userId,  String noteText,  String? emoji,  String createdAt,  String expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserNoteDto() when $default != null:
return $default(_that.id,_that.userId,_that.noteText,_that.emoji,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int userId,  String noteText,  String? emoji,  String createdAt,  String expiresAt)  $default,) {final _that = this;
switch (_that) {
case _UserNoteDto():
return $default(_that.id,_that.userId,_that.noteText,_that.emoji,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int userId,  String noteText,  String? emoji,  String createdAt,  String expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _UserNoteDto() when $default != null:
return $default(_that.id,_that.userId,_that.noteText,_that.emoji,_that.createdAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserNoteDto implements UserNoteDto {
  const _UserNoteDto({required this.id, required this.userId, required this.noteText, this.emoji, required this.createdAt, required this.expiresAt});
  factory _UserNoteDto.fromJson(Map<String, dynamic> json) => _$UserNoteDtoFromJson(json);

@override final  int id;
@override final  int userId;
@override final  String noteText;
@override final  String? emoji;
@override final  String createdAt;
@override final  String expiresAt;

/// Create a copy of UserNoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserNoteDtoCopyWith<_UserNoteDto> get copyWith => __$UserNoteDtoCopyWithImpl<_UserNoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserNoteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserNoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.noteText, noteText) || other.noteText == noteText)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,noteText,emoji,createdAt,expiresAt);

@override
String toString() {
  return 'UserNoteDto(id: $id, userId: $userId, noteText: $noteText, emoji: $emoji, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$UserNoteDtoCopyWith<$Res> implements $UserNoteDtoCopyWith<$Res> {
  factory _$UserNoteDtoCopyWith(_UserNoteDto value, $Res Function(_UserNoteDto) _then) = __$UserNoteDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int userId, String noteText, String? emoji, String createdAt, String expiresAt
});




}
/// @nodoc
class __$UserNoteDtoCopyWithImpl<$Res>
    implements _$UserNoteDtoCopyWith<$Res> {
  __$UserNoteDtoCopyWithImpl(this._self, this._then);

  final _UserNoteDto _self;
  final $Res Function(_UserNoteDto) _then;

/// Create a copy of UserNoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? noteText = null,Object? emoji = freezed,Object? createdAt = null,Object? expiresAt = null,}) {
  return _then(_UserNoteDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,noteText: null == noteText ? _self.noteText : noteText // ignore: cast_nullable_to_non_nullable
as String,emoji: freezed == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
