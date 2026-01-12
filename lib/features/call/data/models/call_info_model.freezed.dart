// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallInfoModel {

 String get id; String get channelId; CallStatus get status; CallType get callType; int get callerId; String get callerName; String? get callerAvatar; int get calleeId; String get calleeName; String? get calleeAvatar; String get createdAt; int? get durationSeconds;
/// Create a copy of CallInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallInfoModelCopyWith<CallInfoModel> get copyWith => _$CallInfoModelCopyWithImpl<CallInfoModel>(this as CallInfoModel, _$identity);

  /// Serializes this CallInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.status, status) || other.status == status)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.calleeName, calleeName) || other.calleeName == calleeName)&&(identical(other.calleeAvatar, calleeAvatar) || other.calleeAvatar == calleeAvatar)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,channelId,status,callType,callerId,callerName,callerAvatar,calleeId,calleeName,calleeAvatar,createdAt,durationSeconds);

@override
String toString() {
  return 'CallInfoModel(id: $id, channelId: $channelId, status: $status, callType: $callType, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, calleeId: $calleeId, calleeName: $calleeName, calleeAvatar: $calleeAvatar, createdAt: $createdAt, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class $CallInfoModelCopyWith<$Res>  {
  factory $CallInfoModelCopyWith(CallInfoModel value, $Res Function(CallInfoModel) _then) = _$CallInfoModelCopyWithImpl;
@useResult
$Res call({
 String id, String channelId, CallStatus status, CallType callType, int callerId, String callerName, String? callerAvatar, int calleeId, String calleeName, String? calleeAvatar, String createdAt, int? durationSeconds
});




}
/// @nodoc
class _$CallInfoModelCopyWithImpl<$Res>
    implements $CallInfoModelCopyWith<$Res> {
  _$CallInfoModelCopyWithImpl(this._self, this._then);

  final CallInfoModel _self;
  final $Res Function(CallInfoModel) _then;

/// Create a copy of CallInfoModel
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
as String,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallInfoModel].
extension CallInfoModelPatterns on CallInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _CallInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _CallInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String channelId,  CallStatus status,  CallType callType,  int callerId,  String callerName,  String? callerAvatar,  int calleeId,  String calleeName,  String? calleeAvatar,  String createdAt,  int? durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallInfoModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String channelId,  CallStatus status,  CallType callType,  int callerId,  String callerName,  String? callerAvatar,  int calleeId,  String calleeName,  String? calleeAvatar,  String createdAt,  int? durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _CallInfoModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String channelId,  CallStatus status,  CallType callType,  int callerId,  String callerName,  String? callerAvatar,  int calleeId,  String calleeName,  String? calleeAvatar,  String createdAt,  int? durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _CallInfoModel() when $default != null:
return $default(_that.id,_that.channelId,_that.status,_that.callType,_that.callerId,_that.callerName,_that.callerAvatar,_that.calleeId,_that.calleeName,_that.calleeAvatar,_that.createdAt,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallInfoModel extends CallInfoModel {
  const _CallInfoModel({required this.id, required this.channelId, required this.status, required this.callType, required this.callerId, required this.callerName, this.callerAvatar, required this.calleeId, required this.calleeName, this.calleeAvatar, required this.createdAt, this.durationSeconds}): super._();
  factory _CallInfoModel.fromJson(Map<String, dynamic> json) => _$CallInfoModelFromJson(json);

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
@override final  String createdAt;
@override final  int? durationSeconds;

/// Create a copy of CallInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallInfoModelCopyWith<_CallInfoModel> get copyWith => __$CallInfoModelCopyWithImpl<_CallInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.status, status) || other.status == status)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.calleeName, calleeName) || other.calleeName == calleeName)&&(identical(other.calleeAvatar, calleeAvatar) || other.calleeAvatar == calleeAvatar)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,channelId,status,callType,callerId,callerName,callerAvatar,calleeId,calleeName,calleeAvatar,createdAt,durationSeconds);

@override
String toString() {
  return 'CallInfoModel(id: $id, channelId: $channelId, status: $status, callType: $callType, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, calleeId: $calleeId, calleeName: $calleeName, calleeAvatar: $calleeAvatar, createdAt: $createdAt, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$CallInfoModelCopyWith<$Res> implements $CallInfoModelCopyWith<$Res> {
  factory _$CallInfoModelCopyWith(_CallInfoModel value, $Res Function(_CallInfoModel) _then) = __$CallInfoModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String channelId, CallStatus status, CallType callType, int callerId, String callerName, String? callerAvatar, int calleeId, String calleeName, String? calleeAvatar, String createdAt, int? durationSeconds
});




}
/// @nodoc
class __$CallInfoModelCopyWithImpl<$Res>
    implements _$CallInfoModelCopyWith<$Res> {
  __$CallInfoModelCopyWithImpl(this._self, this._then);

  final _CallInfoModel _self;
  final $Res Function(_CallInfoModel) _then;

/// Create a copy of CallInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? channelId = null,Object? status = null,Object? callType = null,Object? callerId = null,Object? callerName = null,Object? callerAvatar = freezed,Object? calleeId = null,Object? calleeName = null,Object? calleeAvatar = freezed,Object? createdAt = null,Object? durationSeconds = freezed,}) {
  return _then(_CallInfoModel(
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
as String,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
