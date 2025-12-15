// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentioned_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MentionedUser {

 int get userId; String get username; String get fullName;
/// Create a copy of MentionedUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentionedUserCopyWith<MentionedUser> get copyWith => _$MentionedUserCopyWithImpl<MentionedUser>(this as MentionedUser, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentionedUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName));
}


@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName);

@override
String toString() {
  return 'MentionedUser(userId: $userId, username: $username, fullName: $fullName)';
}


}

/// @nodoc
abstract mixin class $MentionedUserCopyWith<$Res>  {
  factory $MentionedUserCopyWith(MentionedUser value, $Res Function(MentionedUser) _then) = _$MentionedUserCopyWithImpl;
@useResult
$Res call({
 int userId, String username, String fullName
});




}
/// @nodoc
class _$MentionedUserCopyWithImpl<$Res>
    implements $MentionedUserCopyWith<$Res> {
  _$MentionedUserCopyWithImpl(this._self, this._then);

  final MentionedUser _self;
  final $Res Function(MentionedUser) _then;

/// Create a copy of MentionedUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? username = null,Object? fullName = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MentionedUser].
extension MentionedUserPatterns on MentionedUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentionedUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentionedUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentionedUser value)  $default,){
final _that = this;
switch (_that) {
case _MentionedUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentionedUser value)?  $default,){
final _that = this;
switch (_that) {
case _MentionedUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String username,  String fullName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentionedUser() when $default != null:
return $default(_that.userId,_that.username,_that.fullName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String username,  String fullName)  $default,) {final _that = this;
switch (_that) {
case _MentionedUser():
return $default(_that.userId,_that.username,_that.fullName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String username,  String fullName)?  $default,) {final _that = this;
switch (_that) {
case _MentionedUser() when $default != null:
return $default(_that.userId,_that.username,_that.fullName);case _:
  return null;

}
}

}

/// @nodoc


class _MentionedUser implements MentionedUser {
  const _MentionedUser({required this.userId, required this.username, required this.fullName});
  

@override final  int userId;
@override final  String username;
@override final  String fullName;

/// Create a copy of MentionedUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentionedUserCopyWith<_MentionedUser> get copyWith => __$MentionedUserCopyWithImpl<_MentionedUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentionedUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName));
}


@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName);

@override
String toString() {
  return 'MentionedUser(userId: $userId, username: $username, fullName: $fullName)';
}


}

/// @nodoc
abstract mixin class _$MentionedUserCopyWith<$Res> implements $MentionedUserCopyWith<$Res> {
  factory _$MentionedUserCopyWith(_MentionedUser value, $Res Function(_MentionedUser) _then) = __$MentionedUserCopyWithImpl;
@override @useResult
$Res call({
 int userId, String username, String fullName
});




}
/// @nodoc
class __$MentionedUserCopyWithImpl<$Res>
    implements _$MentionedUserCopyWith<$Res> {
  __$MentionedUserCopyWithImpl(this._self, this._then);

  final _MentionedUser _self;
  final $Res Function(_MentionedUser) _then;

/// Create a copy of MentionedUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,Object? fullName = null,}) {
  return _then(_MentionedUser(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
