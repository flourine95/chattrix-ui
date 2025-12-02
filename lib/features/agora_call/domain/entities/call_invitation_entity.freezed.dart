// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_invitation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallInvitationEntity {

 String get callId; String get channelId; int get callerId; String get callerName; String? get callerAvatar; CallType get callType;
/// Create a copy of CallInvitationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallInvitationEntityCopyWith<CallInvitationEntity> get copyWith => _$CallInvitationEntityCopyWithImpl<CallInvitationEntity>(this as CallInvitationEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallInvitationEntity&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.callType, callType) || other.callType == callType));
}


@override
int get hashCode => Object.hash(runtimeType,callId,channelId,callerId,callerName,callerAvatar,callType);

@override
String toString() {
  return 'CallInvitationEntity(callId: $callId, channelId: $channelId, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, callType: $callType)';
}


}

/// @nodoc
abstract mixin class $CallInvitationEntityCopyWith<$Res>  {
  factory $CallInvitationEntityCopyWith(CallInvitationEntity value, $Res Function(CallInvitationEntity) _then) = _$CallInvitationEntityCopyWithImpl;
@useResult
$Res call({
 String callId, String channelId, int callerId, String callerName, String? callerAvatar, CallType callType
});




}
/// @nodoc
class _$CallInvitationEntityCopyWithImpl<$Res>
    implements $CallInvitationEntityCopyWith<$Res> {
  _$CallInvitationEntityCopyWithImpl(this._self, this._then);

  final CallInvitationEntity _self;
  final $Res Function(CallInvitationEntity) _then;

/// Create a copy of CallInvitationEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? channelId = null,Object? callerId = null,Object? callerName = null,Object? callerAvatar = freezed,Object? callType = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,callerId: null == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as int,callerName: null == callerName ? _self.callerName : callerName // ignore: cast_nullable_to_non_nullable
as String,callerAvatar: freezed == callerAvatar ? _self.callerAvatar : callerAvatar // ignore: cast_nullable_to_non_nullable
as String?,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,
  ));
}

}


/// Adds pattern-matching-related methods to [CallInvitationEntity].
extension CallInvitationEntityPatterns on CallInvitationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallInvitationEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallInvitationEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallInvitationEntity value)  $default,){
final _that = this;
switch (_that) {
case _CallInvitationEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallInvitationEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CallInvitationEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  String channelId,  int callerId,  String callerName,  String? callerAvatar,  CallType callType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallInvitationEntity() when $default != null:
return $default(_that.callId,_that.channelId,_that.callerId,_that.callerName,_that.callerAvatar,_that.callType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  String channelId,  int callerId,  String callerName,  String? callerAvatar,  CallType callType)  $default,) {final _that = this;
switch (_that) {
case _CallInvitationEntity():
return $default(_that.callId,_that.channelId,_that.callerId,_that.callerName,_that.callerAvatar,_that.callType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  String channelId,  int callerId,  String callerName,  String? callerAvatar,  CallType callType)?  $default,) {final _that = this;
switch (_that) {
case _CallInvitationEntity() when $default != null:
return $default(_that.callId,_that.channelId,_that.callerId,_that.callerName,_that.callerAvatar,_that.callType);case _:
  return null;

}
}

}

/// @nodoc


class _CallInvitationEntity implements CallInvitationEntity {
  const _CallInvitationEntity({required this.callId, required this.channelId, required this.callerId, required this.callerName, this.callerAvatar, required this.callType});
  

@override final  String callId;
@override final  String channelId;
@override final  int callerId;
@override final  String callerName;
@override final  String? callerAvatar;
@override final  CallType callType;

/// Create a copy of CallInvitationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallInvitationEntityCopyWith<_CallInvitationEntity> get copyWith => __$CallInvitationEntityCopyWithImpl<_CallInvitationEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallInvitationEntity&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.callType, callType) || other.callType == callType));
}


@override
int get hashCode => Object.hash(runtimeType,callId,channelId,callerId,callerName,callerAvatar,callType);

@override
String toString() {
  return 'CallInvitationEntity(callId: $callId, channelId: $channelId, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, callType: $callType)';
}


}

/// @nodoc
abstract mixin class _$CallInvitationEntityCopyWith<$Res> implements $CallInvitationEntityCopyWith<$Res> {
  factory _$CallInvitationEntityCopyWith(_CallInvitationEntity value, $Res Function(_CallInvitationEntity) _then) = __$CallInvitationEntityCopyWithImpl;
@override @useResult
$Res call({
 String callId, String channelId, int callerId, String callerName, String? callerAvatar, CallType callType
});




}
/// @nodoc
class __$CallInvitationEntityCopyWithImpl<$Res>
    implements _$CallInvitationEntityCopyWith<$Res> {
  __$CallInvitationEntityCopyWithImpl(this._self, this._then);

  final _CallInvitationEntity _self;
  final $Res Function(_CallInvitationEntity) _then;

/// Create a copy of CallInvitationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? channelId = null,Object? callerId = null,Object? callerName = null,Object? callerAvatar = freezed,Object? callType = null,}) {
  return _then(_CallInvitationEntity(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,callerId: null == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as int,callerName: null == callerName ? _self.callerName : callerName // ignore: cast_nullable_to_non_nullable
as String,callerAvatar: freezed == callerAvatar ? _self.callerAvatar : callerAvatar // ignore: cast_nullable_to_non_nullable
as String?,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,
  ));
}


}

// dart format on
