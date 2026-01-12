// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_status_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserStatusUpdate {

 String get userId; String get username; String get displayName; bool get isOnline; String? get lastSeen;
/// Create a copy of UserStatusUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStatusUpdateCopyWith<UserStatusUpdate> get copyWith => _$UserStatusUpdateCopyWithImpl<UserStatusUpdate>(this as UserStatusUpdate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserStatusUpdate&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen));
}


@override
int get hashCode => Object.hash(runtimeType,userId,username,displayName,isOnline,lastSeen);

@override
String toString() {
  return 'UserStatusUpdate(userId: $userId, username: $username, displayName: $displayName, isOnline: $isOnline, lastSeen: $lastSeen)';
}


}

/// @nodoc
abstract mixin class $UserStatusUpdateCopyWith<$Res>  {
  factory $UserStatusUpdateCopyWith(UserStatusUpdate value, $Res Function(UserStatusUpdate) _then) = _$UserStatusUpdateCopyWithImpl;
@useResult
$Res call({
 String userId, String username, String displayName, bool isOnline, String? lastSeen
});




}
/// @nodoc
class _$UserStatusUpdateCopyWithImpl<$Res>
    implements $UserStatusUpdateCopyWith<$Res> {
  _$UserStatusUpdateCopyWithImpl(this._self, this._then);

  final UserStatusUpdate _self;
  final $Res Function(UserStatusUpdate) _then;

/// Create a copy of UserStatusUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? username = null,Object? displayName = null,Object? isOnline = null,Object? lastSeen = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,lastSeen: freezed == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserStatusUpdate].
extension UserStatusUpdatePatterns on UserStatusUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserStatusUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserStatusUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserStatusUpdate value)  $default,){
final _that = this;
switch (_that) {
case _UserStatusUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserStatusUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _UserStatusUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String username,  String displayName,  bool isOnline,  String? lastSeen)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserStatusUpdate() when $default != null:
return $default(_that.userId,_that.username,_that.displayName,_that.isOnline,_that.lastSeen);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String username,  String displayName,  bool isOnline,  String? lastSeen)  $default,) {final _that = this;
switch (_that) {
case _UserStatusUpdate():
return $default(_that.userId,_that.username,_that.displayName,_that.isOnline,_that.lastSeen);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String username,  String displayName,  bool isOnline,  String? lastSeen)?  $default,) {final _that = this;
switch (_that) {
case _UserStatusUpdate() when $default != null:
return $default(_that.userId,_that.username,_that.displayName,_that.isOnline,_that.lastSeen);case _:
  return null;

}
}

}

/// @nodoc


class _UserStatusUpdate extends UserStatusUpdate {
  const _UserStatusUpdate({required this.userId, required this.username, required this.displayName, required this.isOnline, this.lastSeen}): super._();
  

@override final  String userId;
@override final  String username;
@override final  String displayName;
@override final  bool isOnline;
@override final  String? lastSeen;

/// Create a copy of UserStatusUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStatusUpdateCopyWith<_UserStatusUpdate> get copyWith => __$UserStatusUpdateCopyWithImpl<_UserStatusUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserStatusUpdate&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen));
}


@override
int get hashCode => Object.hash(runtimeType,userId,username,displayName,isOnline,lastSeen);

@override
String toString() {
  return 'UserStatusUpdate(userId: $userId, username: $username, displayName: $displayName, isOnline: $isOnline, lastSeen: $lastSeen)';
}


}

/// @nodoc
abstract mixin class _$UserStatusUpdateCopyWith<$Res> implements $UserStatusUpdateCopyWith<$Res> {
  factory _$UserStatusUpdateCopyWith(_UserStatusUpdate value, $Res Function(_UserStatusUpdate) _then) = __$UserStatusUpdateCopyWithImpl;
@override @useResult
$Res call({
 String userId, String username, String displayName, bool isOnline, String? lastSeen
});




}
/// @nodoc
class __$UserStatusUpdateCopyWithImpl<$Res>
    implements _$UserStatusUpdateCopyWith<$Res> {
  __$UserStatusUpdateCopyWithImpl(this._self, this._then);

  final _UserStatusUpdate _self;
  final $Res Function(_UserStatusUpdate) _then;

/// Create a copy of UserStatusUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,Object? displayName = null,Object? isOnline = null,Object? lastSeen = freezed,}) {
  return _then(_UserStatusUpdate(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,lastSeen: freezed == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
