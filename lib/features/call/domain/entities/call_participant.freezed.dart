// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_participant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallParticipant {

 int get userId; String get fullName; String? get avatar; CallParticipantStatus get status; DateTime? get joinedAt;
/// Create a copy of CallParticipant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallParticipantCopyWith<CallParticipant> get copyWith => _$CallParticipantCopyWithImpl<CallParticipant>(this as CallParticipant, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallParticipant&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.status, status) || other.status == status)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}


@override
int get hashCode => Object.hash(runtimeType,userId,fullName,avatar,status,joinedAt);

@override
String toString() {
  return 'CallParticipant(userId: $userId, fullName: $fullName, avatar: $avatar, status: $status, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class $CallParticipantCopyWith<$Res>  {
  factory $CallParticipantCopyWith(CallParticipant value, $Res Function(CallParticipant) _then) = _$CallParticipantCopyWithImpl;
@useResult
$Res call({
 int userId, String fullName, String? avatar, CallParticipantStatus status, DateTime? joinedAt
});




}
/// @nodoc
class _$CallParticipantCopyWithImpl<$Res>
    implements $CallParticipantCopyWith<$Res> {
  _$CallParticipantCopyWithImpl(this._self, this._then);

  final CallParticipant _self;
  final $Res Function(CallParticipant) _then;

/// Create a copy of CallParticipant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? fullName = null,Object? avatar = freezed,Object? status = null,Object? joinedAt = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallParticipantStatus,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallParticipant].
extension CallParticipantPatterns on CallParticipant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallParticipant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallParticipant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallParticipant value)  $default,){
final _that = this;
switch (_that) {
case _CallParticipant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallParticipant value)?  $default,){
final _that = this;
switch (_that) {
case _CallParticipant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String fullName,  String? avatar,  CallParticipantStatus status,  DateTime? joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallParticipant() when $default != null:
return $default(_that.userId,_that.fullName,_that.avatar,_that.status,_that.joinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String fullName,  String? avatar,  CallParticipantStatus status,  DateTime? joinedAt)  $default,) {final _that = this;
switch (_that) {
case _CallParticipant():
return $default(_that.userId,_that.fullName,_that.avatar,_that.status,_that.joinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String fullName,  String? avatar,  CallParticipantStatus status,  DateTime? joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _CallParticipant() when $default != null:
return $default(_that.userId,_that.fullName,_that.avatar,_that.status,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CallParticipant implements CallParticipant {
  const _CallParticipant({required this.userId, required this.fullName, this.avatar, required this.status, this.joinedAt});
  

@override final  int userId;
@override final  String fullName;
@override final  String? avatar;
@override final  CallParticipantStatus status;
@override final  DateTime? joinedAt;

/// Create a copy of CallParticipant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallParticipantCopyWith<_CallParticipant> get copyWith => __$CallParticipantCopyWithImpl<_CallParticipant>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallParticipant&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.status, status) || other.status == status)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}


@override
int get hashCode => Object.hash(runtimeType,userId,fullName,avatar,status,joinedAt);

@override
String toString() {
  return 'CallParticipant(userId: $userId, fullName: $fullName, avatar: $avatar, status: $status, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$CallParticipantCopyWith<$Res> implements $CallParticipantCopyWith<$Res> {
  factory _$CallParticipantCopyWith(_CallParticipant value, $Res Function(_CallParticipant) _then) = __$CallParticipantCopyWithImpl;
@override @useResult
$Res call({
 int userId, String fullName, String? avatar, CallParticipantStatus status, DateTime? joinedAt
});




}
/// @nodoc
class __$CallParticipantCopyWithImpl<$Res>
    implements _$CallParticipantCopyWith<$Res> {
  __$CallParticipantCopyWithImpl(this._self, this._then);

  final _CallParticipant _self;
  final $Res Function(_CallParticipant) _then;

/// Create a copy of CallParticipant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? fullName = null,Object? avatar = freezed,Object? status = null,Object? joinedAt = freezed,}) {
  return _then(_CallParticipant(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallParticipantStatus,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
