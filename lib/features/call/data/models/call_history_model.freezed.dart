// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallHistoryModel {

 String get id; String get remoteUserId; String get remoteUserName; String get callType; String get status; String get timestamp; int? get durationSeconds;
/// Create a copy of CallHistoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallHistoryModelCopyWith<CallHistoryModel> get copyWith => _$CallHistoryModelCopyWithImpl<CallHistoryModel>(this as CallHistoryModel, _$identity);

  /// Serializes this CallHistoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteUserId, remoteUserId) || other.remoteUserId == remoteUserId)&&(identical(other.remoteUserName, remoteUserName) || other.remoteUserName == remoteUserName)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteUserId,remoteUserName,callType,status,timestamp,durationSeconds);

@override
String toString() {
  return 'CallHistoryModel(id: $id, remoteUserId: $remoteUserId, remoteUserName: $remoteUserName, callType: $callType, status: $status, timestamp: $timestamp, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class $CallHistoryModelCopyWith<$Res>  {
  factory $CallHistoryModelCopyWith(CallHistoryModel value, $Res Function(CallHistoryModel) _then) = _$CallHistoryModelCopyWithImpl;
@useResult
$Res call({
 String id, String remoteUserId, String remoteUserName, String callType, String status, String timestamp, int? durationSeconds
});




}
/// @nodoc
class _$CallHistoryModelCopyWithImpl<$Res>
    implements $CallHistoryModelCopyWith<$Res> {
  _$CallHistoryModelCopyWithImpl(this._self, this._then);

  final CallHistoryModel _self;
  final $Res Function(CallHistoryModel) _then;

/// Create a copy of CallHistoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? remoteUserId = null,Object? remoteUserName = null,Object? callType = null,Object? status = null,Object? timestamp = null,Object? durationSeconds = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteUserId: null == remoteUserId ? _self.remoteUserId : remoteUserId // ignore: cast_nullable_to_non_nullable
as String,remoteUserName: null == remoteUserName ? _self.remoteUserName : remoteUserName // ignore: cast_nullable_to_non_nullable
as String,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallHistoryModel].
extension CallHistoryModelPatterns on CallHistoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallHistoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallHistoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallHistoryModel value)  $default,){
final _that = this;
switch (_that) {
case _CallHistoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallHistoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _CallHistoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String remoteUserId,  String remoteUserName,  String callType,  String status,  String timestamp,  int? durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallHistoryModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String remoteUserId,  String remoteUserName,  String callType,  String status,  String timestamp,  int? durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _CallHistoryModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String remoteUserId,  String remoteUserName,  String callType,  String status,  String timestamp,  int? durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _CallHistoryModel() when $default != null:
return $default(_that.id,_that.remoteUserId,_that.remoteUserName,_that.callType,_that.status,_that.timestamp,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallHistoryModel extends CallHistoryModel {
  const _CallHistoryModel({required this.id, required this.remoteUserId, required this.remoteUserName, required this.callType, required this.status, required this.timestamp, this.durationSeconds}): super._();
  factory _CallHistoryModel.fromJson(Map<String, dynamic> json) => _$CallHistoryModelFromJson(json);

@override final  String id;
@override final  String remoteUserId;
@override final  String remoteUserName;
@override final  String callType;
@override final  String status;
@override final  String timestamp;
@override final  int? durationSeconds;

/// Create a copy of CallHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallHistoryModelCopyWith<_CallHistoryModel> get copyWith => __$CallHistoryModelCopyWithImpl<_CallHistoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallHistoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteUserId, remoteUserId) || other.remoteUserId == remoteUserId)&&(identical(other.remoteUserName, remoteUserName) || other.remoteUserName == remoteUserName)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,remoteUserId,remoteUserName,callType,status,timestamp,durationSeconds);

@override
String toString() {
  return 'CallHistoryModel(id: $id, remoteUserId: $remoteUserId, remoteUserName: $remoteUserName, callType: $callType, status: $status, timestamp: $timestamp, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$CallHistoryModelCopyWith<$Res> implements $CallHistoryModelCopyWith<$Res> {
  factory _$CallHistoryModelCopyWith(_CallHistoryModel value, $Res Function(_CallHistoryModel) _then) = __$CallHistoryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String remoteUserId, String remoteUserName, String callType, String status, String timestamp, int? durationSeconds
});




}
/// @nodoc
class __$CallHistoryModelCopyWithImpl<$Res>
    implements _$CallHistoryModelCopyWith<$Res> {
  __$CallHistoryModelCopyWithImpl(this._self, this._then);

  final _CallHistoryModel _self;
  final $Res Function(_CallHistoryModel) _then;

/// Create a copy of CallHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? remoteUserId = null,Object? remoteUserName = null,Object? callType = null,Object? status = null,Object? timestamp = null,Object? durationSeconds = freezed,}) {
  return _then(_CallHistoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteUserId: null == remoteUserId ? _self.remoteUserId : remoteUserId // ignore: cast_nullable_to_non_nullable
as String,remoteUserName: null == remoteUserName ? _self.remoteUserName : remoteUserName // ignore: cast_nullable_to_non_nullable
as String,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
