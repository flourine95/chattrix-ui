// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_history_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallHistoryEntity {

 String get id; String get remoteUserId; String get remoteUserName; CallType get callType; CallStatus get status; DateTime get timestamp; int? get durationSeconds;
/// Create a copy of CallHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallHistoryEntityCopyWith<CallHistoryEntity> get copyWith => _$CallHistoryEntityCopyWithImpl<CallHistoryEntity>(this as CallHistoryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallHistoryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteUserId, remoteUserId) || other.remoteUserId == remoteUserId)&&(identical(other.remoteUserName, remoteUserName) || other.remoteUserName == remoteUserName)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,id,remoteUserId,remoteUserName,callType,status,timestamp,durationSeconds);

@override
String toString() {
  return 'CallHistoryEntity(id: $id, remoteUserId: $remoteUserId, remoteUserName: $remoteUserName, callType: $callType, status: $status, timestamp: $timestamp, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class $CallHistoryEntityCopyWith<$Res>  {
  factory $CallHistoryEntityCopyWith(CallHistoryEntity value, $Res Function(CallHistoryEntity) _then) = _$CallHistoryEntityCopyWithImpl;
@useResult
$Res call({
 String id, String remoteUserId, String remoteUserName, CallType callType, CallStatus status, DateTime timestamp, int? durationSeconds
});




}
/// @nodoc
class _$CallHistoryEntityCopyWithImpl<$Res>
    implements $CallHistoryEntityCopyWith<$Res> {
  _$CallHistoryEntityCopyWithImpl(this._self, this._then);

  final CallHistoryEntity _self;
  final $Res Function(CallHistoryEntity) _then;

/// Create a copy of CallHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? remoteUserId = null,Object? remoteUserName = null,Object? callType = null,Object? status = null,Object? timestamp = null,Object? durationSeconds = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteUserId: null == remoteUserId ? _self.remoteUserId : remoteUserId // ignore: cast_nullable_to_non_nullable
as String,remoteUserName: null == remoteUserName ? _self.remoteUserName : remoteUserName // ignore: cast_nullable_to_non_nullable
as String,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallStatus,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallHistoryEntity].
extension CallHistoryEntityPatterns on CallHistoryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallHistoryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallHistoryEntity value)  $default,){
final _that = this;
switch (_that) {
case _CallHistoryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallHistoryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CallHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String remoteUserId,  String remoteUserName,  CallType callType,  CallStatus status,  DateTime timestamp,  int? durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallHistoryEntity() when $default != null:
return $default(_that.id,_that.remoteUserId,_that.remoteUserName,_that.callType,_that.status,_that.timestamp,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String remoteUserId,  String remoteUserName,  CallType callType,  CallStatus status,  DateTime timestamp,  int? durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _CallHistoryEntity():
return $default(_that.id,_that.remoteUserId,_that.remoteUserName,_that.callType,_that.status,_that.timestamp,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String remoteUserId,  String remoteUserName,  CallType callType,  CallStatus status,  DateTime timestamp,  int? durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _CallHistoryEntity() when $default != null:
return $default(_that.id,_that.remoteUserId,_that.remoteUserName,_that.callType,_that.status,_that.timestamp,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc


class _CallHistoryEntity implements CallHistoryEntity {
  const _CallHistoryEntity({required this.id, required this.remoteUserId, required this.remoteUserName, required this.callType, required this.status, required this.timestamp, this.durationSeconds});
  

@override final  String id;
@override final  String remoteUserId;
@override final  String remoteUserName;
@override final  CallType callType;
@override final  CallStatus status;
@override final  DateTime timestamp;
@override final  int? durationSeconds;

/// Create a copy of CallHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallHistoryEntityCopyWith<_CallHistoryEntity> get copyWith => __$CallHistoryEntityCopyWithImpl<_CallHistoryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallHistoryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteUserId, remoteUserId) || other.remoteUserId == remoteUserId)&&(identical(other.remoteUserName, remoteUserName) || other.remoteUserName == remoteUserName)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,id,remoteUserId,remoteUserName,callType,status,timestamp,durationSeconds);

@override
String toString() {
  return 'CallHistoryEntity(id: $id, remoteUserId: $remoteUserId, remoteUserName: $remoteUserName, callType: $callType, status: $status, timestamp: $timestamp, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$CallHistoryEntityCopyWith<$Res> implements $CallHistoryEntityCopyWith<$Res> {
  factory _$CallHistoryEntityCopyWith(_CallHistoryEntity value, $Res Function(_CallHistoryEntity) _then) = __$CallHistoryEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String remoteUserId, String remoteUserName, CallType callType, CallStatus status, DateTime timestamp, int? durationSeconds
});




}
/// @nodoc
class __$CallHistoryEntityCopyWithImpl<$Res>
    implements _$CallHistoryEntityCopyWith<$Res> {
  __$CallHistoryEntityCopyWithImpl(this._self, this._then);

  final _CallHistoryEntity _self;
  final $Res Function(_CallHistoryEntity) _then;

/// Create a copy of CallHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? remoteUserId = null,Object? remoteUserName = null,Object? callType = null,Object? status = null,Object? timestamp = null,Object? durationSeconds = freezed,}) {
  return _then(_CallHistoryEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteUserId: null == remoteUserId ? _self.remoteUserId : remoteUserId // ignore: cast_nullable_to_non_nullable
as String,remoteUserName: null == remoteUserName ? _self.remoteUserName : remoteUserName // ignore: cast_nullable_to_non_nullable
as String,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallStatus,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
