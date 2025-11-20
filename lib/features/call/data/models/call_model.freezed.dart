// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallModel {

 String get callId; String get channelId; String get localUserId; String get remoteUserId; String get callType; String get status; String get startTime; String? get endTime; bool get isLocalAudioMuted; bool get isLocalVideoMuted; String get cameraFacing; String? get networkQuality;
/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallModelCopyWith<CallModel> get copyWith => _$CallModelCopyWithImpl<CallModel>(this as CallModel, _$identity);

  /// Serializes this CallModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallModel&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.localUserId, localUserId) || other.localUserId == localUserId)&&(identical(other.remoteUserId, remoteUserId) || other.remoteUserId == remoteUserId)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.status, status) || other.status == status)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isLocalAudioMuted, isLocalAudioMuted) || other.isLocalAudioMuted == isLocalAudioMuted)&&(identical(other.isLocalVideoMuted, isLocalVideoMuted) || other.isLocalVideoMuted == isLocalVideoMuted)&&(identical(other.cameraFacing, cameraFacing) || other.cameraFacing == cameraFacing)&&(identical(other.networkQuality, networkQuality) || other.networkQuality == networkQuality));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,channelId,localUserId,remoteUserId,callType,status,startTime,endTime,isLocalAudioMuted,isLocalVideoMuted,cameraFacing,networkQuality);

@override
String toString() {
  return 'CallModel(callId: $callId, channelId: $channelId, localUserId: $localUserId, remoteUserId: $remoteUserId, callType: $callType, status: $status, startTime: $startTime, endTime: $endTime, isLocalAudioMuted: $isLocalAudioMuted, isLocalVideoMuted: $isLocalVideoMuted, cameraFacing: $cameraFacing, networkQuality: $networkQuality)';
}


}

/// @nodoc
abstract mixin class $CallModelCopyWith<$Res>  {
  factory $CallModelCopyWith(CallModel value, $Res Function(CallModel) _then) = _$CallModelCopyWithImpl;
@useResult
$Res call({
 String callId, String channelId, String localUserId, String remoteUserId, String callType, String status, String startTime, String? endTime, bool isLocalAudioMuted, bool isLocalVideoMuted, String cameraFacing, String? networkQuality
});




}
/// @nodoc
class _$CallModelCopyWithImpl<$Res>
    implements $CallModelCopyWith<$Res> {
  _$CallModelCopyWithImpl(this._self, this._then);

  final CallModel _self;
  final $Res Function(CallModel) _then;

/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? channelId = null,Object? localUserId = null,Object? remoteUserId = null,Object? callType = null,Object? status = null,Object? startTime = null,Object? endTime = freezed,Object? isLocalAudioMuted = null,Object? isLocalVideoMuted = null,Object? cameraFacing = null,Object? networkQuality = freezed,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,localUserId: null == localUserId ? _self.localUserId : localUserId // ignore: cast_nullable_to_non_nullable
as String,remoteUserId: null == remoteUserId ? _self.remoteUserId : remoteUserId // ignore: cast_nullable_to_non_nullable
as String,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,isLocalAudioMuted: null == isLocalAudioMuted ? _self.isLocalAudioMuted : isLocalAudioMuted // ignore: cast_nullable_to_non_nullable
as bool,isLocalVideoMuted: null == isLocalVideoMuted ? _self.isLocalVideoMuted : isLocalVideoMuted // ignore: cast_nullable_to_non_nullable
as bool,cameraFacing: null == cameraFacing ? _self.cameraFacing : cameraFacing // ignore: cast_nullable_to_non_nullable
as String,networkQuality: freezed == networkQuality ? _self.networkQuality : networkQuality // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallModel].
extension CallModelPatterns on CallModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallModel value)  $default,){
final _that = this;
switch (_that) {
case _CallModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallModel value)?  $default,){
final _that = this;
switch (_that) {
case _CallModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  String channelId,  String localUserId,  String remoteUserId,  String callType,  String status,  String startTime,  String? endTime,  bool isLocalAudioMuted,  bool isLocalVideoMuted,  String cameraFacing,  String? networkQuality)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  String channelId,  String localUserId,  String remoteUserId,  String callType,  String status,  String startTime,  String? endTime,  bool isLocalAudioMuted,  bool isLocalVideoMuted,  String cameraFacing,  String? networkQuality)  $default,) {final _that = this;
switch (_that) {
case _CallModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  String channelId,  String localUserId,  String remoteUserId,  String callType,  String status,  String startTime,  String? endTime,  bool isLocalAudioMuted,  bool isLocalVideoMuted,  String cameraFacing,  String? networkQuality)?  $default,) {final _that = this;
switch (_that) {
case _CallModel() when $default != null:
return $default(_that.callId,_that.channelId,_that.localUserId,_that.remoteUserId,_that.callType,_that.status,_that.startTime,_that.endTime,_that.isLocalAudioMuted,_that.isLocalVideoMuted,_that.cameraFacing,_that.networkQuality);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallModel extends CallModel {
  const _CallModel({required this.callId, required this.channelId, required this.localUserId, required this.remoteUserId, required this.callType, required this.status, required this.startTime, this.endTime, required this.isLocalAudioMuted, required this.isLocalVideoMuted, required this.cameraFacing, this.networkQuality}): super._();
  factory _CallModel.fromJson(Map<String, dynamic> json) => _$CallModelFromJson(json);

@override final  String callId;
@override final  String channelId;
@override final  String localUserId;
@override final  String remoteUserId;
@override final  String callType;
@override final  String status;
@override final  String startTime;
@override final  String? endTime;
@override final  bool isLocalAudioMuted;
@override final  bool isLocalVideoMuted;
@override final  String cameraFacing;
@override final  String? networkQuality;

/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallModelCopyWith<_CallModel> get copyWith => __$CallModelCopyWithImpl<_CallModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallModel&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.localUserId, localUserId) || other.localUserId == localUserId)&&(identical(other.remoteUserId, remoteUserId) || other.remoteUserId == remoteUserId)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.status, status) || other.status == status)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isLocalAudioMuted, isLocalAudioMuted) || other.isLocalAudioMuted == isLocalAudioMuted)&&(identical(other.isLocalVideoMuted, isLocalVideoMuted) || other.isLocalVideoMuted == isLocalVideoMuted)&&(identical(other.cameraFacing, cameraFacing) || other.cameraFacing == cameraFacing)&&(identical(other.networkQuality, networkQuality) || other.networkQuality == networkQuality));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,channelId,localUserId,remoteUserId,callType,status,startTime,endTime,isLocalAudioMuted,isLocalVideoMuted,cameraFacing,networkQuality);

@override
String toString() {
  return 'CallModel(callId: $callId, channelId: $channelId, localUserId: $localUserId, remoteUserId: $remoteUserId, callType: $callType, status: $status, startTime: $startTime, endTime: $endTime, isLocalAudioMuted: $isLocalAudioMuted, isLocalVideoMuted: $isLocalVideoMuted, cameraFacing: $cameraFacing, networkQuality: $networkQuality)';
}


}

/// @nodoc
abstract mixin class _$CallModelCopyWith<$Res> implements $CallModelCopyWith<$Res> {
  factory _$CallModelCopyWith(_CallModel value, $Res Function(_CallModel) _then) = __$CallModelCopyWithImpl;
@override @useResult
$Res call({
 String callId, String channelId, String localUserId, String remoteUserId, String callType, String status, String startTime, String? endTime, bool isLocalAudioMuted, bool isLocalVideoMuted, String cameraFacing, String? networkQuality
});




}
/// @nodoc
class __$CallModelCopyWithImpl<$Res>
    implements _$CallModelCopyWith<$Res> {
  __$CallModelCopyWithImpl(this._self, this._then);

  final _CallModel _self;
  final $Res Function(_CallModel) _then;

/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? channelId = null,Object? localUserId = null,Object? remoteUserId = null,Object? callType = null,Object? status = null,Object? startTime = null,Object? endTime = freezed,Object? isLocalAudioMuted = null,Object? isLocalVideoMuted = null,Object? cameraFacing = null,Object? networkQuality = freezed,}) {
  return _then(_CallModel(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,localUserId: null == localUserId ? _self.localUserId : localUserId // ignore: cast_nullable_to_non_nullable
as String,remoteUserId: null == remoteUserId ? _self.remoteUserId : remoteUserId // ignore: cast_nullable_to_non_nullable
as String,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,isLocalAudioMuted: null == isLocalAudioMuted ? _self.isLocalAudioMuted : isLocalAudioMuted // ignore: cast_nullable_to_non_nullable
as bool,isLocalVideoMuted: null == isLocalVideoMuted ? _self.isLocalVideoMuted : isLocalVideoMuted // ignore: cast_nullable_to_non_nullable
as bool,cameraFacing: null == cameraFacing ? _self.cameraFacing : cameraFacing // ignore: cast_nullable_to_non_nullable
as String,networkQuality: freezed == networkQuality ? _self.networkQuality : networkQuality // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
