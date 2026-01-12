// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_note_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserNoteEntity {

 String get userId; String get content; DateTime get createdAt; DateTime? get expiresAt;
/// Create a copy of UserNoteEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserNoteEntityCopyWith<UserNoteEntity> get copyWith => _$UserNoteEntityCopyWithImpl<UserNoteEntity>(this as UserNoteEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserNoteEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,userId,content,createdAt,expiresAt);

@override
String toString() {
  return 'UserNoteEntity(userId: $userId, content: $content, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $UserNoteEntityCopyWith<$Res>  {
  factory $UserNoteEntityCopyWith(UserNoteEntity value, $Res Function(UserNoteEntity) _then) = _$UserNoteEntityCopyWithImpl;
@useResult
$Res call({
 String userId, String content, DateTime createdAt, DateTime? expiresAt
});




}
/// @nodoc
class _$UserNoteEntityCopyWithImpl<$Res>
    implements $UserNoteEntityCopyWith<$Res> {
  _$UserNoteEntityCopyWithImpl(this._self, this._then);

  final UserNoteEntity _self;
  final $Res Function(UserNoteEntity) _then;

/// Create a copy of UserNoteEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? content = null,Object? createdAt = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserNoteEntity].
extension UserNoteEntityPatterns on UserNoteEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserNoteEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserNoteEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserNoteEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserNoteEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserNoteEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserNoteEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String content,  DateTime createdAt,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserNoteEntity() when $default != null:
return $default(_that.userId,_that.content,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String content,  DateTime createdAt,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _UserNoteEntity():
return $default(_that.userId,_that.content,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String content,  DateTime createdAt,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _UserNoteEntity() when $default != null:
return $default(_that.userId,_that.content,_that.createdAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc


class _UserNoteEntity implements UserNoteEntity {
  const _UserNoteEntity({required this.userId, required this.content, required this.createdAt, this.expiresAt});
  

@override final  String userId;
@override final  String content;
@override final  DateTime createdAt;
@override final  DateTime? expiresAt;

/// Create a copy of UserNoteEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserNoteEntityCopyWith<_UserNoteEntity> get copyWith => __$UserNoteEntityCopyWithImpl<_UserNoteEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserNoteEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,userId,content,createdAt,expiresAt);

@override
String toString() {
  return 'UserNoteEntity(userId: $userId, content: $content, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$UserNoteEntityCopyWith<$Res> implements $UserNoteEntityCopyWith<$Res> {
  factory _$UserNoteEntityCopyWith(_UserNoteEntity value, $Res Function(_UserNoteEntity) _then) = __$UserNoteEntityCopyWithImpl;
@override @useResult
$Res call({
 String userId, String content, DateTime createdAt, DateTime? expiresAt
});




}
/// @nodoc
class __$UserNoteEntityCopyWithImpl<$Res>
    implements _$UserNoteEntityCopyWith<$Res> {
  __$UserNoteEntityCopyWithImpl(this._self, this._then);

  final _UserNoteEntity _self;
  final $Res Function(_UserNoteEntity) _then;

/// Create a copy of UserNoteEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? content = null,Object? createdAt = null,Object? expiresAt = freezed,}) {
  return _then(_UserNoteEntity(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
