// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallEntity {

 String get callId; String get channelId; String get localUserId; String get remoteUserId; CallType get callType; CallStatus get status; DateTime get startTime; DateTime? get endTime; bool get isLocalAudioMuted; bool get isLocalVideoMuted; CameraFacing get cameraFacing; NetworkQuality? get networkQuality;
/// Create a copy of CallEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallEntityCopyWith<CallEntity> get copyWith => _$CallEntityCopyWithImpl<CallEntity>(this as CallEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallEntity&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.localUserId, localUserId) || other.localUserId == localUserId)&&(identical(other.remoteUserId, remoteUserId) || other.remoteUserId == remoteUserId)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.status, status) || other.status == status)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isLocalAudioMuted, isLocalAudioMuted) || other.isLocalAudioMuted == isLocalAudioMuted)&&(identical(other.isLocalVideoMuted, isLocalVideoMuted) || other.isLocalVideoMuted == isLocalVideoMuted)&&(identical(other.cameraFacing, cameraFacing) || other.cameraFacing == cameraFacing)&&(identical(other.networkQuality, networkQuality) || other.networkQuality == networkQuality));
}


@override
int get hashCode => Object.hash(runtimeType,callId,channelId,localUserId,remoteUserId,callType,status,startTime,endTime,isLocalAudioMuted,isLocalVideoMuted,cameraFacing,networkQuality);

@override
String toString() {
  return 'CallEntity(callId: $callId, channelId: $channelId, localUserId: $localUserId, remoteUserId: $remoteUserId, callType: $callType, status: $status, startTime: $startTime, endTime: $endTime, isLocalAudioMuted: $isLocalAudioMuted, isLocalVideoMuted: $isLocalVideoMuted, cameraFacing: $cameraFacing, networkQuality: $networkQuality)';
}


}

/// @nodoc
abstract mixin class $CallEntityCopyWith<$Res>  {
  factory $CallEntityCopyWith(CallEntity value, $Res Function(CallEntity) _then) = _$CallEntityCopyWithImpl;
@useResult
$Res call({
 String callId, String channelId, String localUserId, String remoteUserId, CallType callType, CallStatus status, DateTime startTime, DateTime? endTime, bool isLocalAudioMuted, bool isLocalVideoMuted, CameraFacing cameraFacing, NetworkQuality? networkQuality
});




}
/// @nodoc
class _$CallEntityCopyWithImpl<$Res>
    implements $CallEntityCopyWith<$Res> {
  _$CallEntityCopyWithImpl(this._self, this._then);

  final CallEntity _self;
  final $Res Function(CallEntity) _then;

/// Create a copy of CallEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? channelId = null,Object? localUserId = null,Object? remoteUserId = null,Object? callType = null,Object? status = null,Object? startTime = null,Object? endTime = freezed,Object? isLocalAudioMuted = null,Object? isLocalVideoMuted = null,Object? cameraFacing = null,Object? networkQuality = freezed,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,localUserId: null == localUserId ? _self.localUserId : localUserId // ignore: cast_nullable_to_non_nullable
as String,remoteUserId: null == remoteUserId ? _self.remoteUserId : remoteUserId // ignore: cast_nullable_to_non_nullable
as String,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallStatus,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isLocalAudioMuted: null == isLocalAudioMuted ? _self.isLocalAudioMuted : isLocalAudioMuted // ignore: cast_nullable_to_non_nullable
as bool,isLocalVideoMuted: null == isLocalVideoMuted ? _self.isLocalVideoMuted : isLocalVideoMuted // ignore: cast_nullable_to_non_nullable
as bool,cameraFacing: null == cameraFacing ? _self.cameraFacing : cameraFacing // ignore: cast_nullable_to_non_nullable
as CameraFacing,networkQuality: freezed == networkQuality ? _self.networkQuality : networkQuality // ignore: cast_nullable_to_non_nullable
as NetworkQuality?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallEntity].
extension CallEntityPatterns on CallEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallEntity value)  $default,){
final _that = this;
switch (_that) {
case _CallEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CallEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  String channelId,  String localUserId,  String remoteUserId,  CallType callType,  CallStatus status,  DateTime startTime,  DateTime? endTime,  bool isLocalAudioMuted,  bool isLocalVideoMuted,  CameraFacing cameraFacing,  NetworkQuality? networkQuality)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallEntity() when $default != null:
return $default(_that.callId,_that.channelId,_that.localUserId,_that.remoteUserId,_that.callType,_that.status,_that.startTime,_that.endTime,_that.isLocalAudioMuted,_that.isLocalVideoMuted,_that.cameraFacing,_that.networkQuality);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  String channelId,  String localUserId,  String remoteUserId,  CallType callType,  CallStatus status,  DateTime startTime,  DateTime? endTime,  bool isLocalAudioMuted,  bool isLocalVideoMuted,  CameraFacing cameraFacing,  NetworkQuality? networkQuality)  $default,) {final _that = this;
switch (_that) {
case _CallEntity():
return $default(_that.callId,_that.channelId,_that.localUserId,_that.remoteUserId,_that.callType,_that.status,_that.startTime,_that.endTime,_that.isLocalAudioMuted,_that.isLocalVideoMuted,_that.cameraFacing,_that.networkQuality);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  String channelId,  String localUserId,  String remoteUserId,  CallType callType,  CallStatus status,  DateTime startTime,  DateTime? endTime,  bool isLocalAudioMuted,  bool isLocalVideoMuted,  CameraFacing cameraFacing,  NetworkQuality? networkQuality)?  $default,) {final _that = this;
switch (_that) {
case _CallEntity() when $default != null:
return $default(_that.callId,_that.channelId,_that.localUserId,_that.remoteUserId,_that.callType,_that.status,_that.startTime,_that.endTime,_that.isLocalAudioMuted,_that.isLocalVideoMuted,_that.cameraFacing,_that.networkQuality);case _:
  return null;

}
}

}

/// @nodoc


class _CallEntity implements CallEntity {
  const _CallEntity({required this.callId, required this.channelId, required this.localUserId, required this.remoteUserId, required this.callType, required this.status, required this.startTime, this.endTime, required this.isLocalAudioMuted, required this.isLocalVideoMuted, required this.cameraFacing, this.networkQuality});
  

@override final  String callId;
@override final  String channelId;
@override final  String localUserId;
@override final  String remoteUserId;
@override final  CallType callType;
@override final  CallStatus status;
@override final  DateTime startTime;
@override final  DateTime? endTime;
@override final  bool isLocalAudioMuted;
@override final  bool isLocalVideoMuted;
@override final  CameraFacing cameraFacing;
@override final  NetworkQuality? networkQuality;

/// Create a copy of CallEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallEntityCopyWith<_CallEntity> get copyWith => __$CallEntityCopyWithImpl<_CallEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallEntity&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.localUserId, localUserId) || other.localUserId == localUserId)&&(identical(other.remoteUserId, remoteUserId) || other.remoteUserId == remoteUserId)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.status, status) || other.status == status)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isLocalAudioMuted, isLocalAudioMuted) || other.isLocalAudioMuted == isLocalAudioMuted)&&(identical(other.isLocalVideoMuted, isLocalVideoMuted) || other.isLocalVideoMuted == isLocalVideoMuted)&&(identical(other.cameraFacing, cameraFacing) || other.cameraFacing == cameraFacing)&&(identical(other.networkQuality, networkQuality) || other.networkQuality == networkQuality));
}


@override
int get hashCode => Object.hash(runtimeType,callId,channelId,localUserId,remoteUserId,callType,status,startTime,endTime,isLocalAudioMuted,isLocalVideoMuted,cameraFacing,networkQuality);

@override
String toString() {
  return 'CallEntity(callId: $callId, channelId: $channelId, localUserId: $localUserId, remoteUserId: $remoteUserId, callType: $callType, status: $status, startTime: $startTime, endTime: $endTime, isLocalAudioMuted: $isLocalAudioMuted, isLocalVideoMuted: $isLocalVideoMuted, cameraFacing: $cameraFacing, networkQuality: $networkQuality)';
}


}

/// @nodoc
abstract mixin class _$CallEntityCopyWith<$Res> implements $CallEntityCopyWith<$Res> {
  factory _$CallEntityCopyWith(_CallEntity value, $Res Function(_CallEntity) _then) = __$CallEntityCopyWithImpl;
@override @useResult
$Res call({
 String callId, String channelId, String localUserId, String remoteUserId, CallType callType, CallStatus status, DateTime startTime, DateTime? endTime, bool isLocalAudioMuted, bool isLocalVideoMuted, CameraFacing cameraFacing, NetworkQuality? networkQuality
});




}
/// @nodoc
class __$CallEntityCopyWithImpl<$Res>
    implements _$CallEntityCopyWith<$Res> {
  __$CallEntityCopyWithImpl(this._self, this._then);

  final _CallEntity _self;
  final $Res Function(_CallEntity) _then;

/// Create a copy of CallEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? channelId = null,Object? localUserId = null,Object? remoteUserId = null,Object? callType = null,Object? status = null,Object? startTime = null,Object? endTime = freezed,Object? isLocalAudioMuted = null,Object? isLocalVideoMuted = null,Object? cameraFacing = null,Object? networkQuality = freezed,}) {
  return _then(_CallEntity(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,localUserId: null == localUserId ? _self.localUserId : localUserId // ignore: cast_nullable_to_non_nullable
as String,remoteUserId: null == remoteUserId ? _self.remoteUserId : remoteUserId // ignore: cast_nullable_to_non_nullable
as String,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallStatus,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isLocalAudioMuted: null == isLocalAudioMuted ? _self.isLocalAudioMuted : isLocalAudioMuted // ignore: cast_nullable_to_non_nullable
as bool,isLocalVideoMuted: null == isLocalVideoMuted ? _self.isLocalVideoMuted : isLocalVideoMuted // ignore: cast_nullable_to_non_nullable
as bool,cameraFacing: null == cameraFacing ? _self.cameraFacing : cameraFacing // ignore: cast_nullable_to_non_nullable
as CameraFacing,networkQuality: freezed == networkQuality ? _self.networkQuality : networkQuality // ignore: cast_nullable_to_non_nullable
as NetworkQuality?,
  ));
}


}

// dart format on
