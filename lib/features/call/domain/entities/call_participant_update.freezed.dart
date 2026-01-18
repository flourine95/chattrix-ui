// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_participant_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallParticipantUpdate {

 String get callId; int get userId; String get fullName; String? get avatarUrl; CallParticipantStatus get status;
/// Create a copy of CallParticipantUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallParticipantUpdateCopyWith<CallParticipantUpdate> get copyWith => _$CallParticipantUpdateCopyWithImpl<CallParticipantUpdate>(this as CallParticipantUpdate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallParticipantUpdate&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,callId,userId,fullName,avatarUrl,status);

@override
String toString() {
  return 'CallParticipantUpdate(callId: $callId, userId: $userId, fullName: $fullName, avatarUrl: $avatarUrl, status: $status)';
}


}

/// @nodoc
abstract mixin class $CallParticipantUpdateCopyWith<$Res>  {
  factory $CallParticipantUpdateCopyWith(CallParticipantUpdate value, $Res Function(CallParticipantUpdate) _then) = _$CallParticipantUpdateCopyWithImpl;
@useResult
$Res call({
 String callId, int userId, String fullName, String? avatarUrl, CallParticipantStatus status
});




}
/// @nodoc
class _$CallParticipantUpdateCopyWithImpl<$Res>
    implements $CallParticipantUpdateCopyWith<$Res> {
  _$CallParticipantUpdateCopyWithImpl(this._self, this._then);

  final CallParticipantUpdate _self;
  final $Res Function(CallParticipantUpdate) _then;

/// Create a copy of CallParticipantUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? userId = null,Object? fullName = null,Object? avatarUrl = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallParticipantStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [CallParticipantUpdate].
extension CallParticipantUpdatePatterns on CallParticipantUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallParticipantUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallParticipantUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallParticipantUpdate value)  $default,){
final _that = this;
switch (_that) {
case _CallParticipantUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallParticipantUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _CallParticipantUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  int userId,  String fullName,  String? avatarUrl,  CallParticipantStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallParticipantUpdate() when $default != null:
return $default(_that.callId,_that.userId,_that.fullName,_that.avatarUrl,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  int userId,  String fullName,  String? avatarUrl,  CallParticipantStatus status)  $default,) {final _that = this;
switch (_that) {
case _CallParticipantUpdate():
return $default(_that.callId,_that.userId,_that.fullName,_that.avatarUrl,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  int userId,  String fullName,  String? avatarUrl,  CallParticipantStatus status)?  $default,) {final _that = this;
switch (_that) {
case _CallParticipantUpdate() when $default != null:
return $default(_that.callId,_that.userId,_that.fullName,_that.avatarUrl,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _CallParticipantUpdate implements CallParticipantUpdate {
  const _CallParticipantUpdate({required this.callId, required this.userId, required this.fullName, this.avatarUrl, required this.status});
  

@override final  String callId;
@override final  int userId;
@override final  String fullName;
@override final  String? avatarUrl;
@override final  CallParticipantStatus status;

/// Create a copy of CallParticipantUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallParticipantUpdateCopyWith<_CallParticipantUpdate> get copyWith => __$CallParticipantUpdateCopyWithImpl<_CallParticipantUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallParticipantUpdate&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,callId,userId,fullName,avatarUrl,status);

@override
String toString() {
  return 'CallParticipantUpdate(callId: $callId, userId: $userId, fullName: $fullName, avatarUrl: $avatarUrl, status: $status)';
}


}

/// @nodoc
abstract mixin class _$CallParticipantUpdateCopyWith<$Res> implements $CallParticipantUpdateCopyWith<$Res> {
  factory _$CallParticipantUpdateCopyWith(_CallParticipantUpdate value, $Res Function(_CallParticipantUpdate) _then) = __$CallParticipantUpdateCopyWithImpl;
@override @useResult
$Res call({
 String callId, int userId, String fullName, String? avatarUrl, CallParticipantStatus status
});




}
/// @nodoc
class __$CallParticipantUpdateCopyWithImpl<$Res>
    implements _$CallParticipantUpdateCopyWith<$Res> {
  __$CallParticipantUpdateCopyWithImpl(this._self, this._then);

  final _CallParticipantUpdate _self;
  final $Res Function(_CallParticipantUpdate) _then;

/// Create a copy of CallParticipantUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? userId = null,Object? fullName = null,Object? avatarUrl = freezed,Object? status = null,}) {
  return _then(_CallParticipantUpdate(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallParticipantStatus,
  ));
}


}

// dart format on
