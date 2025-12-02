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

 String get id; String get channelId; CallStatus get status; CallType get callType; int get callerId; String get callerName; String? get callerAvatar; int get calleeId; String get calleeName; String? get calleeAvatar; DateTime get createdAt; int? get durationSeconds;
/// Create a copy of CallEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallEntityCopyWith<CallEntity> get copyWith => _$CallEntityCopyWithImpl<CallEntity>(this as CallEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.status, status) || other.status == status)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.calleeName, calleeName) || other.calleeName == calleeName)&&(identical(other.calleeAvatar, calleeAvatar) || other.calleeAvatar == calleeAvatar)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,id,channelId,status,callType,callerId,callerName,callerAvatar,calleeId,calleeName,calleeAvatar,createdAt,durationSeconds);

@override
String toString() {
  return 'CallEntity(id: $id, channelId: $channelId, status: $status, callType: $callType, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, calleeId: $calleeId, calleeName: $calleeName, calleeAvatar: $calleeAvatar, createdAt: $createdAt, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class $CallEntityCopyWith<$Res>  {
  factory $CallEntityCopyWith(CallEntity value, $Res Function(CallEntity) _then) = _$CallEntityCopyWithImpl;
@useResult
$Res call({
 String id, String channelId, CallStatus status, CallType callType, int callerId, String callerName, String? callerAvatar, int calleeId, String calleeName, String? calleeAvatar, DateTime createdAt, int? durationSeconds
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? channelId = null,Object? status = null,Object? callType = null,Object? callerId = null,Object? callerName = null,Object? callerAvatar = freezed,Object? calleeId = null,Object? calleeName = null,Object? calleeAvatar = freezed,Object? createdAt = null,Object? durationSeconds = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallStatus,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,callerId: null == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as int,callerName: null == callerName ? _self.callerName : callerName // ignore: cast_nullable_to_non_nullable
as String,callerAvatar: freezed == callerAvatar ? _self.callerAvatar : callerAvatar // ignore: cast_nullable_to_non_nullable
as String?,calleeId: null == calleeId ? _self.calleeId : calleeId // ignore: cast_nullable_to_non_nullable
as int,calleeName: null == calleeName ? _self.calleeName : calleeName // ignore: cast_nullable_to_non_nullable
as String,calleeAvatar: freezed == calleeAvatar ? _self.calleeAvatar : calleeAvatar // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String channelId,  CallStatus status,  CallType callType,  int callerId,  String callerName,  String? callerAvatar,  int calleeId,  String calleeName,  String? calleeAvatar,  DateTime createdAt,  int? durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallEntity() when $default != null:
return $default(_that.id,_that.channelId,_that.status,_that.callType,_that.callerId,_that.callerName,_that.callerAvatar,_that.calleeId,_that.calleeName,_that.calleeAvatar,_that.createdAt,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String channelId,  CallStatus status,  CallType callType,  int callerId,  String callerName,  String? callerAvatar,  int calleeId,  String calleeName,  String? calleeAvatar,  DateTime createdAt,  int? durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _CallEntity():
return $default(_that.id,_that.channelId,_that.status,_that.callType,_that.callerId,_that.callerName,_that.callerAvatar,_that.calleeId,_that.calleeName,_that.calleeAvatar,_that.createdAt,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String channelId,  CallStatus status,  CallType callType,  int callerId,  String callerName,  String? callerAvatar,  int calleeId,  String calleeName,  String? calleeAvatar,  DateTime createdAt,  int? durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _CallEntity() when $default != null:
return $default(_that.id,_that.channelId,_that.status,_that.callType,_that.callerId,_that.callerName,_that.callerAvatar,_that.calleeId,_that.calleeName,_that.calleeAvatar,_that.createdAt,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc


class _CallEntity implements CallEntity {
  const _CallEntity({required this.id, required this.channelId, required this.status, required this.callType, required this.callerId, required this.callerName, this.callerAvatar, required this.calleeId, required this.calleeName, this.calleeAvatar, required this.createdAt, this.durationSeconds});
  

@override final  String id;
@override final  String channelId;
@override final  CallStatus status;
@override final  CallType callType;
@override final  int callerId;
@override final  String callerName;
@override final  String? callerAvatar;
@override final  int calleeId;
@override final  String calleeName;
@override final  String? calleeAvatar;
@override final  DateTime createdAt;
@override final  int? durationSeconds;

/// Create a copy of CallEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallEntityCopyWith<_CallEntity> get copyWith => __$CallEntityCopyWithImpl<_CallEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.status, status) || other.status == status)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.calleeName, calleeName) || other.calleeName == calleeName)&&(identical(other.calleeAvatar, calleeAvatar) || other.calleeAvatar == calleeAvatar)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,id,channelId,status,callType,callerId,callerName,callerAvatar,calleeId,calleeName,calleeAvatar,createdAt,durationSeconds);

@override
String toString() {
  return 'CallEntity(id: $id, channelId: $channelId, status: $status, callType: $callType, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, calleeId: $calleeId, calleeName: $calleeName, calleeAvatar: $calleeAvatar, createdAt: $createdAt, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$CallEntityCopyWith<$Res> implements $CallEntityCopyWith<$Res> {
  factory _$CallEntityCopyWith(_CallEntity value, $Res Function(_CallEntity) _then) = __$CallEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String channelId, CallStatus status, CallType callType, int callerId, String callerName, String? callerAvatar, int calleeId, String calleeName, String? calleeAvatar, DateTime createdAt, int? durationSeconds
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? channelId = null,Object? status = null,Object? callType = null,Object? callerId = null,Object? callerName = null,Object? callerAvatar = freezed,Object? calleeId = null,Object? calleeName = null,Object? calleeAvatar = freezed,Object? createdAt = null,Object? durationSeconds = freezed,}) {
  return _then(_CallEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallStatus,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,callerId: null == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as int,callerName: null == callerName ? _self.callerName : callerName // ignore: cast_nullable_to_non_nullable
as String,callerAvatar: freezed == callerAvatar ? _self.callerAvatar : callerAvatar // ignore: cast_nullable_to_non_nullable
as String?,calleeId: null == calleeId ? _self.calleeId : calleeId // ignore: cast_nullable_to_non_nullable
as int,calleeName: null == calleeName ? _self.calleeName : calleeName // ignore: cast_nullable_to_non_nullable
as String,calleeAvatar: freezed == calleeAvatar ? _self.calleeAvatar : calleeAvatar // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
