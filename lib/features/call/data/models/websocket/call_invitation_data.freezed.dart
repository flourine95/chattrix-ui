// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_invitation_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallInvitationData {

 String get callId; String get channelId; String get callerId; String get callerName; String? get callerAvatar; String get callType;
/// Create a copy of CallInvitationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallInvitationDataCopyWith<CallInvitationData> get copyWith => _$CallInvitationDataCopyWithImpl<CallInvitationData>(this as CallInvitationData, _$identity);

  /// Serializes this CallInvitationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallInvitationData&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.callType, callType) || other.callType == callType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,channelId,callerId,callerName,callerAvatar,callType);

@override
String toString() {
  return 'CallInvitationData(callId: $callId, channelId: $channelId, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, callType: $callType)';
}


}

/// @nodoc
abstract mixin class $CallInvitationDataCopyWith<$Res>  {
  factory $CallInvitationDataCopyWith(CallInvitationData value, $Res Function(CallInvitationData) _then) = _$CallInvitationDataCopyWithImpl;
@useResult
$Res call({
 String callId, String channelId, String callerId, String callerName, String? callerAvatar, String callType
});




}
/// @nodoc
class _$CallInvitationDataCopyWithImpl<$Res>
    implements $CallInvitationDataCopyWith<$Res> {
  _$CallInvitationDataCopyWithImpl(this._self, this._then);

  final CallInvitationData _self;
  final $Res Function(CallInvitationData) _then;

/// Create a copy of CallInvitationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? channelId = null,Object? callerId = null,Object? callerName = null,Object? callerAvatar = freezed,Object? callType = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,callerId: null == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as String,callerName: null == callerName ? _self.callerName : callerName // ignore: cast_nullable_to_non_nullable
as String,callerAvatar: freezed == callerAvatar ? _self.callerAvatar : callerAvatar // ignore: cast_nullable_to_non_nullable
as String?,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CallInvitationData].
extension CallInvitationDataPatterns on CallInvitationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallInvitationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallInvitationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallInvitationData value)  $default,){
final _that = this;
switch (_that) {
case _CallInvitationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallInvitationData value)?  $default,){
final _that = this;
switch (_that) {
case _CallInvitationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  String channelId,  String callerId,  String callerName,  String? callerAvatar,  String callType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallInvitationData() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  String channelId,  String callerId,  String callerName,  String? callerAvatar,  String callType)  $default,) {final _that = this;
switch (_that) {
case _CallInvitationData():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  String channelId,  String callerId,  String callerName,  String? callerAvatar,  String callType)?  $default,) {final _that = this;
switch (_that) {
case _CallInvitationData() when $default != null:
return $default(_that.callId,_that.channelId,_that.callerId,_that.callerName,_that.callerAvatar,_that.callType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallInvitationData implements CallInvitationData {
  const _CallInvitationData({required this.callId, required this.channelId, required this.callerId, required this.callerName, this.callerAvatar, required this.callType});
  factory _CallInvitationData.fromJson(Map<String, dynamic> json) => _$CallInvitationDataFromJson(json);

@override final  String callId;
@override final  String channelId;
@override final  String callerId;
@override final  String callerName;
@override final  String? callerAvatar;
@override final  String callType;

/// Create a copy of CallInvitationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallInvitationDataCopyWith<_CallInvitationData> get copyWith => __$CallInvitationDataCopyWithImpl<_CallInvitationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallInvitationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallInvitationData&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.callType, callType) || other.callType == callType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,channelId,callerId,callerName,callerAvatar,callType);

@override
String toString() {
  return 'CallInvitationData(callId: $callId, channelId: $channelId, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, callType: $callType)';
}


}

/// @nodoc
abstract mixin class _$CallInvitationDataCopyWith<$Res> implements $CallInvitationDataCopyWith<$Res> {
  factory _$CallInvitationDataCopyWith(_CallInvitationData value, $Res Function(_CallInvitationData) _then) = __$CallInvitationDataCopyWithImpl;
@override @useResult
$Res call({
 String callId, String channelId, String callerId, String callerName, String? callerAvatar, String callType
});




}
/// @nodoc
class __$CallInvitationDataCopyWithImpl<$Res>
    implements _$CallInvitationDataCopyWith<$Res> {
  __$CallInvitationDataCopyWithImpl(this._self, this._then);

  final _CallInvitationData _self;
  final $Res Function(_CallInvitationData) _then;

/// Create a copy of CallInvitationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? channelId = null,Object? callerId = null,Object? callerName = null,Object? callerAvatar = freezed,Object? callType = null,}) {
  return _then(_CallInvitationData(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,callerId: null == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as String,callerName: null == callerName ? _self.callerName : callerName // ignore: cast_nullable_to_non_nullable
as String,callerAvatar: freezed == callerAvatar ? _self.callerAvatar : callerAvatar // ignore: cast_nullable_to_non_nullable
as String?,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
