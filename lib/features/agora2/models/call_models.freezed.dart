// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallResponse {

 String get id; String get channelId; CallStatus get status; CallType get callType; int get callerId; String get callerName; String? get callerAvatar; int get calleeId; String get calleeName; String? get calleeAvatar; DateTime get createdAt; int? get durationSeconds;
/// Create a copy of CallResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallResponseCopyWith<CallResponse> get copyWith => _$CallResponseCopyWithImpl<CallResponse>(this as CallResponse, _$identity);

  /// Serializes this CallResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.status, status) || other.status == status)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.calleeName, calleeName) || other.calleeName == calleeName)&&(identical(other.calleeAvatar, calleeAvatar) || other.calleeAvatar == calleeAvatar)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,channelId,status,callType,callerId,callerName,callerAvatar,calleeId,calleeName,calleeAvatar,createdAt,durationSeconds);

@override
String toString() {
  return 'CallResponse(id: $id, channelId: $channelId, status: $status, callType: $callType, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, calleeId: $calleeId, calleeName: $calleeName, calleeAvatar: $calleeAvatar, createdAt: $createdAt, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class $CallResponseCopyWith<$Res>  {
  factory $CallResponseCopyWith(CallResponse value, $Res Function(CallResponse) _then) = _$CallResponseCopyWithImpl;
@useResult
$Res call({
 String id, String channelId, CallStatus status, CallType callType, int callerId, String callerName, String? callerAvatar, int calleeId, String calleeName, String? calleeAvatar, DateTime createdAt, int? durationSeconds
});




}
/// @nodoc
class _$CallResponseCopyWithImpl<$Res>
    implements $CallResponseCopyWith<$Res> {
  _$CallResponseCopyWithImpl(this._self, this._then);

  final CallResponse _self;
  final $Res Function(CallResponse) _then;

/// Create a copy of CallResponse
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


/// Adds pattern-matching-related methods to [CallResponse].
extension CallResponsePatterns on CallResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallResponse value)  $default,){
final _that = this;
switch (_that) {
case _CallResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CallResponse() when $default != null:
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
case _CallResponse() when $default != null:
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
case _CallResponse():
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
case _CallResponse() when $default != null:
return $default(_that.id,_that.channelId,_that.status,_that.callType,_that.callerId,_that.callerName,_that.callerAvatar,_that.calleeId,_that.calleeName,_that.calleeAvatar,_that.createdAt,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallResponse implements CallResponse {
  const _CallResponse({required this.id, required this.channelId, required this.status, required this.callType, required this.callerId, required this.callerName, this.callerAvatar, required this.calleeId, required this.calleeName, this.calleeAvatar, required this.createdAt, this.durationSeconds});
  factory _CallResponse.fromJson(Map<String, dynamic> json) => _$CallResponseFromJson(json);

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

/// Create a copy of CallResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallResponseCopyWith<_CallResponse> get copyWith => __$CallResponseCopyWithImpl<_CallResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.status, status) || other.status == status)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.calleeName, calleeName) || other.calleeName == calleeName)&&(identical(other.calleeAvatar, calleeAvatar) || other.calleeAvatar == calleeAvatar)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,channelId,status,callType,callerId,callerName,callerAvatar,calleeId,calleeName,calleeAvatar,createdAt,durationSeconds);

@override
String toString() {
  return 'CallResponse(id: $id, channelId: $channelId, status: $status, callType: $callType, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, calleeId: $calleeId, calleeName: $calleeName, calleeAvatar: $calleeAvatar, createdAt: $createdAt, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$CallResponseCopyWith<$Res> implements $CallResponseCopyWith<$Res> {
  factory _$CallResponseCopyWith(_CallResponse value, $Res Function(_CallResponse) _then) = __$CallResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String channelId, CallStatus status, CallType callType, int callerId, String callerName, String? callerAvatar, int calleeId, String calleeName, String? calleeAvatar, DateTime createdAt, int? durationSeconds
});




}
/// @nodoc
class __$CallResponseCopyWithImpl<$Res>
    implements _$CallResponseCopyWith<$Res> {
  __$CallResponseCopyWithImpl(this._self, this._then);

  final _CallResponse _self;
  final $Res Function(_CallResponse) _then;

/// Create a copy of CallResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? channelId = null,Object? status = null,Object? callType = null,Object? callerId = null,Object? callerName = null,Object? callerAvatar = freezed,Object? calleeId = null,Object? calleeName = null,Object? calleeAvatar = freezed,Object? createdAt = null,Object? durationSeconds = freezed,}) {
  return _then(_CallResponse(
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


/// @nodoc
mixin _$CallConnectionResponse {

 String get id; String get channelId; CallStatus get status; CallType get callType; int get callerId; String get callerName; String? get callerAvatar; int get calleeId; String get calleeName; String? get calleeAvatar; DateTime get createdAt; int? get durationSeconds; String get token;
/// Create a copy of CallConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallConnectionResponseCopyWith<CallConnectionResponse> get copyWith => _$CallConnectionResponseCopyWithImpl<CallConnectionResponse>(this as CallConnectionResponse, _$identity);

  /// Serializes this CallConnectionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallConnectionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.status, status) || other.status == status)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.calleeName, calleeName) || other.calleeName == calleeName)&&(identical(other.calleeAvatar, calleeAvatar) || other.calleeAvatar == calleeAvatar)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,channelId,status,callType,callerId,callerName,callerAvatar,calleeId,calleeName,calleeAvatar,createdAt,durationSeconds,token);

@override
String toString() {
  return 'CallConnectionResponse(id: $id, channelId: $channelId, status: $status, callType: $callType, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, calleeId: $calleeId, calleeName: $calleeName, calleeAvatar: $calleeAvatar, createdAt: $createdAt, durationSeconds: $durationSeconds, token: $token)';
}


}

/// @nodoc
abstract mixin class $CallConnectionResponseCopyWith<$Res>  {
  factory $CallConnectionResponseCopyWith(CallConnectionResponse value, $Res Function(CallConnectionResponse) _then) = _$CallConnectionResponseCopyWithImpl;
@useResult
$Res call({
 String id, String channelId, CallStatus status, CallType callType, int callerId, String callerName, String? callerAvatar, int calleeId, String calleeName, String? calleeAvatar, DateTime createdAt, int? durationSeconds, String token
});




}
/// @nodoc
class _$CallConnectionResponseCopyWithImpl<$Res>
    implements $CallConnectionResponseCopyWith<$Res> {
  _$CallConnectionResponseCopyWithImpl(this._self, this._then);

  final CallConnectionResponse _self;
  final $Res Function(CallConnectionResponse) _then;

/// Create a copy of CallConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? channelId = null,Object? status = null,Object? callType = null,Object? callerId = null,Object? callerName = null,Object? callerAvatar = freezed,Object? calleeId = null,Object? calleeName = null,Object? calleeAvatar = freezed,Object? createdAt = null,Object? durationSeconds = freezed,Object? token = null,}) {
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
as int?,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CallConnectionResponse].
extension CallConnectionResponsePatterns on CallConnectionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallConnectionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallConnectionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallConnectionResponse value)  $default,){
final _that = this;
switch (_that) {
case _CallConnectionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallConnectionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CallConnectionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String channelId,  CallStatus status,  CallType callType,  int callerId,  String callerName,  String? callerAvatar,  int calleeId,  String calleeName,  String? calleeAvatar,  DateTime createdAt,  int? durationSeconds,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallConnectionResponse() when $default != null:
return $default(_that.id,_that.channelId,_that.status,_that.callType,_that.callerId,_that.callerName,_that.callerAvatar,_that.calleeId,_that.calleeName,_that.calleeAvatar,_that.createdAt,_that.durationSeconds,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String channelId,  CallStatus status,  CallType callType,  int callerId,  String callerName,  String? callerAvatar,  int calleeId,  String calleeName,  String? calleeAvatar,  DateTime createdAt,  int? durationSeconds,  String token)  $default,) {final _that = this;
switch (_that) {
case _CallConnectionResponse():
return $default(_that.id,_that.channelId,_that.status,_that.callType,_that.callerId,_that.callerName,_that.callerAvatar,_that.calleeId,_that.calleeName,_that.calleeAvatar,_that.createdAt,_that.durationSeconds,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String channelId,  CallStatus status,  CallType callType,  int callerId,  String callerName,  String? callerAvatar,  int calleeId,  String calleeName,  String? calleeAvatar,  DateTime createdAt,  int? durationSeconds,  String token)?  $default,) {final _that = this;
switch (_that) {
case _CallConnectionResponse() when $default != null:
return $default(_that.id,_that.channelId,_that.status,_that.callType,_that.callerId,_that.callerName,_that.callerAvatar,_that.calleeId,_that.calleeName,_that.calleeAvatar,_that.createdAt,_that.durationSeconds,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallConnectionResponse implements CallConnectionResponse {
  const _CallConnectionResponse({required this.id, required this.channelId, required this.status, required this.callType, required this.callerId, required this.callerName, this.callerAvatar, required this.calleeId, required this.calleeName, this.calleeAvatar, required this.createdAt, this.durationSeconds, required this.token});
  factory _CallConnectionResponse.fromJson(Map<String, dynamic> json) => _$CallConnectionResponseFromJson(json);

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
@override final  String token;

/// Create a copy of CallConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallConnectionResponseCopyWith<_CallConnectionResponse> get copyWith => __$CallConnectionResponseCopyWithImpl<_CallConnectionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallConnectionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallConnectionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.status, status) || other.status == status)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.calleeName, calleeName) || other.calleeName == calleeName)&&(identical(other.calleeAvatar, calleeAvatar) || other.calleeAvatar == calleeAvatar)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,channelId,status,callType,callerId,callerName,callerAvatar,calleeId,calleeName,calleeAvatar,createdAt,durationSeconds,token);

@override
String toString() {
  return 'CallConnectionResponse(id: $id, channelId: $channelId, status: $status, callType: $callType, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, calleeId: $calleeId, calleeName: $calleeName, calleeAvatar: $calleeAvatar, createdAt: $createdAt, durationSeconds: $durationSeconds, token: $token)';
}


}

/// @nodoc
abstract mixin class _$CallConnectionResponseCopyWith<$Res> implements $CallConnectionResponseCopyWith<$Res> {
  factory _$CallConnectionResponseCopyWith(_CallConnectionResponse value, $Res Function(_CallConnectionResponse) _then) = __$CallConnectionResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String channelId, CallStatus status, CallType callType, int callerId, String callerName, String? callerAvatar, int calleeId, String calleeName, String? calleeAvatar, DateTime createdAt, int? durationSeconds, String token
});




}
/// @nodoc
class __$CallConnectionResponseCopyWithImpl<$Res>
    implements _$CallConnectionResponseCopyWith<$Res> {
  __$CallConnectionResponseCopyWithImpl(this._self, this._then);

  final _CallConnectionResponse _self;
  final $Res Function(_CallConnectionResponse) _then;

/// Create a copy of CallConnectionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? channelId = null,Object? status = null,Object? callType = null,Object? callerId = null,Object? callerName = null,Object? callerAvatar = freezed,Object? calleeId = null,Object? calleeName = null,Object? calleeAvatar = freezed,Object? createdAt = null,Object? durationSeconds = freezed,Object? token = null,}) {
  return _then(_CallConnectionResponse(
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
as int?,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$InitiateCallRequest {

 int get calleeId; CallType get callType;
/// Create a copy of InitiateCallRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitiateCallRequestCopyWith<InitiateCallRequest> get copyWith => _$InitiateCallRequestCopyWithImpl<InitiateCallRequest>(this as InitiateCallRequest, _$identity);

  /// Serializes this InitiateCallRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitiateCallRequest&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.callType, callType) || other.callType == callType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,calleeId,callType);

@override
String toString() {
  return 'InitiateCallRequest(calleeId: $calleeId, callType: $callType)';
}


}

/// @nodoc
abstract mixin class $InitiateCallRequestCopyWith<$Res>  {
  factory $InitiateCallRequestCopyWith(InitiateCallRequest value, $Res Function(InitiateCallRequest) _then) = _$InitiateCallRequestCopyWithImpl;
@useResult
$Res call({
 int calleeId, CallType callType
});




}
/// @nodoc
class _$InitiateCallRequestCopyWithImpl<$Res>
    implements $InitiateCallRequestCopyWith<$Res> {
  _$InitiateCallRequestCopyWithImpl(this._self, this._then);

  final InitiateCallRequest _self;
  final $Res Function(InitiateCallRequest) _then;

/// Create a copy of InitiateCallRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? calleeId = null,Object? callType = null,}) {
  return _then(_self.copyWith(
calleeId: null == calleeId ? _self.calleeId : calleeId // ignore: cast_nullable_to_non_nullable
as int,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,
  ));
}

}


/// Adds pattern-matching-related methods to [InitiateCallRequest].
extension InitiateCallRequestPatterns on InitiateCallRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InitiateCallRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitiateCallRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InitiateCallRequest value)  $default,){
final _that = this;
switch (_that) {
case _InitiateCallRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InitiateCallRequest value)?  $default,){
final _that = this;
switch (_that) {
case _InitiateCallRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int calleeId,  CallType callType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitiateCallRequest() when $default != null:
return $default(_that.calleeId,_that.callType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int calleeId,  CallType callType)  $default,) {final _that = this;
switch (_that) {
case _InitiateCallRequest():
return $default(_that.calleeId,_that.callType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int calleeId,  CallType callType)?  $default,) {final _that = this;
switch (_that) {
case _InitiateCallRequest() when $default != null:
return $default(_that.calleeId,_that.callType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InitiateCallRequest implements InitiateCallRequest {
  const _InitiateCallRequest({required this.calleeId, required this.callType});
  factory _InitiateCallRequest.fromJson(Map<String, dynamic> json) => _$InitiateCallRequestFromJson(json);

@override final  int calleeId;
@override final  CallType callType;

/// Create a copy of InitiateCallRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitiateCallRequestCopyWith<_InitiateCallRequest> get copyWith => __$InitiateCallRequestCopyWithImpl<_InitiateCallRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InitiateCallRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitiateCallRequest&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.callType, callType) || other.callType == callType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,calleeId,callType);

@override
String toString() {
  return 'InitiateCallRequest(calleeId: $calleeId, callType: $callType)';
}


}

/// @nodoc
abstract mixin class _$InitiateCallRequestCopyWith<$Res> implements $InitiateCallRequestCopyWith<$Res> {
  factory _$InitiateCallRequestCopyWith(_InitiateCallRequest value, $Res Function(_InitiateCallRequest) _then) = __$InitiateCallRequestCopyWithImpl;
@override @useResult
$Res call({
 int calleeId, CallType callType
});




}
/// @nodoc
class __$InitiateCallRequestCopyWithImpl<$Res>
    implements _$InitiateCallRequestCopyWith<$Res> {
  __$InitiateCallRequestCopyWithImpl(this._self, this._then);

  final _InitiateCallRequest _self;
  final $Res Function(_InitiateCallRequest) _then;

/// Create a copy of InitiateCallRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? calleeId = null,Object? callType = null,}) {
  return _then(_InitiateCallRequest(
calleeId: null == calleeId ? _self.calleeId : calleeId // ignore: cast_nullable_to_non_nullable
as int,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,
  ));
}


}


/// @nodoc
mixin _$RejectCallRequest {

 RejectReason get reason;
/// Create a copy of RejectCallRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RejectCallRequestCopyWith<RejectCallRequest> get copyWith => _$RejectCallRequestCopyWithImpl<RejectCallRequest>(this as RejectCallRequest, _$identity);

  /// Serializes this RejectCallRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RejectCallRequest&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'RejectCallRequest(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $RejectCallRequestCopyWith<$Res>  {
  factory $RejectCallRequestCopyWith(RejectCallRequest value, $Res Function(RejectCallRequest) _then) = _$RejectCallRequestCopyWithImpl;
@useResult
$Res call({
 RejectReason reason
});




}
/// @nodoc
class _$RejectCallRequestCopyWithImpl<$Res>
    implements $RejectCallRequestCopyWith<$Res> {
  _$RejectCallRequestCopyWithImpl(this._self, this._then);

  final RejectCallRequest _self;
  final $Res Function(RejectCallRequest) _then;

/// Create a copy of RejectCallRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reason = null,}) {
  return _then(_self.copyWith(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RejectReason,
  ));
}

}


/// Adds pattern-matching-related methods to [RejectCallRequest].
extension RejectCallRequestPatterns on RejectCallRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RejectCallRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RejectCallRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RejectCallRequest value)  $default,){
final _that = this;
switch (_that) {
case _RejectCallRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RejectCallRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RejectCallRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RejectReason reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RejectCallRequest() when $default != null:
return $default(_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RejectReason reason)  $default,) {final _that = this;
switch (_that) {
case _RejectCallRequest():
return $default(_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RejectReason reason)?  $default,) {final _that = this;
switch (_that) {
case _RejectCallRequest() when $default != null:
return $default(_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RejectCallRequest implements RejectCallRequest {
  const _RejectCallRequest({required this.reason});
  factory _RejectCallRequest.fromJson(Map<String, dynamic> json) => _$RejectCallRequestFromJson(json);

@override final  RejectReason reason;

/// Create a copy of RejectCallRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RejectCallRequestCopyWith<_RejectCallRequest> get copyWith => __$RejectCallRequestCopyWithImpl<_RejectCallRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RejectCallRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RejectCallRequest&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'RejectCallRequest(reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$RejectCallRequestCopyWith<$Res> implements $RejectCallRequestCopyWith<$Res> {
  factory _$RejectCallRequestCopyWith(_RejectCallRequest value, $Res Function(_RejectCallRequest) _then) = __$RejectCallRequestCopyWithImpl;
@override @useResult
$Res call({
 RejectReason reason
});




}
/// @nodoc
class __$RejectCallRequestCopyWithImpl<$Res>
    implements _$RejectCallRequestCopyWith<$Res> {
  __$RejectCallRequestCopyWithImpl(this._self, this._then);

  final _RejectCallRequest _self;
  final $Res Function(_RejectCallRequest) _then;

/// Create a copy of RejectCallRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(_RejectCallRequest(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RejectReason,
  ));
}


}


/// @nodoc
mixin _$EndCallRequest {

 EndReason get reason;
/// Create a copy of EndCallRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EndCallRequestCopyWith<EndCallRequest> get copyWith => _$EndCallRequestCopyWithImpl<EndCallRequest>(this as EndCallRequest, _$identity);

  /// Serializes this EndCallRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EndCallRequest&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'EndCallRequest(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $EndCallRequestCopyWith<$Res>  {
  factory $EndCallRequestCopyWith(EndCallRequest value, $Res Function(EndCallRequest) _then) = _$EndCallRequestCopyWithImpl;
@useResult
$Res call({
 EndReason reason
});




}
/// @nodoc
class _$EndCallRequestCopyWithImpl<$Res>
    implements $EndCallRequestCopyWith<$Res> {
  _$EndCallRequestCopyWithImpl(this._self, this._then);

  final EndCallRequest _self;
  final $Res Function(EndCallRequest) _then;

/// Create a copy of EndCallRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reason = null,}) {
  return _then(_self.copyWith(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as EndReason,
  ));
}

}


/// Adds pattern-matching-related methods to [EndCallRequest].
extension EndCallRequestPatterns on EndCallRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EndCallRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EndCallRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EndCallRequest value)  $default,){
final _that = this;
switch (_that) {
case _EndCallRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EndCallRequest value)?  $default,){
final _that = this;
switch (_that) {
case _EndCallRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EndReason reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EndCallRequest() when $default != null:
return $default(_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EndReason reason)  $default,) {final _that = this;
switch (_that) {
case _EndCallRequest():
return $default(_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EndReason reason)?  $default,) {final _that = this;
switch (_that) {
case _EndCallRequest() when $default != null:
return $default(_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EndCallRequest implements EndCallRequest {
  const _EndCallRequest({this.reason = EndReason.hangup});
  factory _EndCallRequest.fromJson(Map<String, dynamic> json) => _$EndCallRequestFromJson(json);

@override@JsonKey() final  EndReason reason;

/// Create a copy of EndCallRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EndCallRequestCopyWith<_EndCallRequest> get copyWith => __$EndCallRequestCopyWithImpl<_EndCallRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EndCallRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EndCallRequest&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'EndCallRequest(reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$EndCallRequestCopyWith<$Res> implements $EndCallRequestCopyWith<$Res> {
  factory _$EndCallRequestCopyWith(_EndCallRequest value, $Res Function(_EndCallRequest) _then) = __$EndCallRequestCopyWithImpl;
@override @useResult
$Res call({
 EndReason reason
});




}
/// @nodoc
class __$EndCallRequestCopyWithImpl<$Res>
    implements _$EndCallRequestCopyWith<$Res> {
  __$EndCallRequestCopyWithImpl(this._self, this._then);

  final _EndCallRequest _self;
  final $Res Function(_EndCallRequest) _then;

/// Create a copy of EndCallRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(_EndCallRequest(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as EndReason,
  ));
}


}


/// @nodoc
mixin _$ApiResponse<T> {

 bool get success; String get message; T? get data;
/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiResponseCopyWith<T, ApiResponse<T>> get copyWith => _$ApiResponseCopyWithImpl<T, ApiResponse<T>>(this as ApiResponse<T>, _$identity);

  /// Serializes this ApiResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiResponse<T>&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ApiResponse<$T>(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $ApiResponseCopyWith<T,$Res>  {
  factory $ApiResponseCopyWith(ApiResponse<T> value, $Res Function(ApiResponse<T>) _then) = _$ApiResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, T? data
});




}
/// @nodoc
class _$ApiResponseCopyWithImpl<T,$Res>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._self, this._then);

  final ApiResponse<T> _self;
  final $Res Function(ApiResponse<T>) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiResponse].
extension ApiResponsePatterns<T> on ApiResponse<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiResponse<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiResponse<T> value)  $default,){
final _that = this;
switch (_that) {
case _ApiResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiResponse<T> value)?  $default,){
final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  T? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  T? data)  $default,) {final _that = this;
switch (_that) {
case _ApiResponse():
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  T? data)?  $default,) {final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _ApiResponse<T> implements ApiResponse<T> {
  const _ApiResponse({required this.success, required this.message, this.data});
  factory _ApiResponse.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$ApiResponseFromJson(json,fromJsonT);

@override final  bool success;
@override final  String message;
@override final  T? data;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiResponseCopyWith<T, _ApiResponse<T>> get copyWith => __$ApiResponseCopyWithImpl<T, _ApiResponse<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$ApiResponseToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiResponse<T>&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ApiResponse<$T>(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ApiResponseCopyWith<T,$Res> implements $ApiResponseCopyWith<T, $Res> {
  factory _$ApiResponseCopyWith(_ApiResponse<T> value, $Res Function(_ApiResponse<T>) _then) = __$ApiResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, T? data
});




}
/// @nodoc
class __$ApiResponseCopyWithImpl<T,$Res>
    implements _$ApiResponseCopyWith<T, $Res> {
  __$ApiResponseCopyWithImpl(this._self, this._then);

  final _ApiResponse<T> _self;
  final $Res Function(_ApiResponse<T>) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = freezed,}) {
  return _then(_ApiResponse<T>(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}


}


/// @nodoc
mixin _$CallInvitationDto {

 String get callId; String get channelId; int get callerId; String get callerName; String? get callerAvatar; CallType get callType;
/// Create a copy of CallInvitationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallInvitationDtoCopyWith<CallInvitationDto> get copyWith => _$CallInvitationDtoCopyWithImpl<CallInvitationDto>(this as CallInvitationDto, _$identity);

  /// Serializes this CallInvitationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallInvitationDto&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.callType, callType) || other.callType == callType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,channelId,callerId,callerName,callerAvatar,callType);

@override
String toString() {
  return 'CallInvitationDto(callId: $callId, channelId: $channelId, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, callType: $callType)';
}


}

/// @nodoc
abstract mixin class $CallInvitationDtoCopyWith<$Res>  {
  factory $CallInvitationDtoCopyWith(CallInvitationDto value, $Res Function(CallInvitationDto) _then) = _$CallInvitationDtoCopyWithImpl;
@useResult
$Res call({
 String callId, String channelId, int callerId, String callerName, String? callerAvatar, CallType callType
});




}
/// @nodoc
class _$CallInvitationDtoCopyWithImpl<$Res>
    implements $CallInvitationDtoCopyWith<$Res> {
  _$CallInvitationDtoCopyWithImpl(this._self, this._then);

  final CallInvitationDto _self;
  final $Res Function(CallInvitationDto) _then;

/// Create a copy of CallInvitationDto
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


/// Adds pattern-matching-related methods to [CallInvitationDto].
extension CallInvitationDtoPatterns on CallInvitationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallInvitationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallInvitationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallInvitationDto value)  $default,){
final _that = this;
switch (_that) {
case _CallInvitationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallInvitationDto value)?  $default,){
final _that = this;
switch (_that) {
case _CallInvitationDto() when $default != null:
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
case _CallInvitationDto() when $default != null:
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
case _CallInvitationDto():
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
case _CallInvitationDto() when $default != null:
return $default(_that.callId,_that.channelId,_that.callerId,_that.callerName,_that.callerAvatar,_that.callType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallInvitationDto implements CallInvitationDto {
  const _CallInvitationDto({required this.callId, required this.channelId, required this.callerId, required this.callerName, this.callerAvatar, required this.callType});
  factory _CallInvitationDto.fromJson(Map<String, dynamic> json) => _$CallInvitationDtoFromJson(json);

@override final  String callId;
@override final  String channelId;
@override final  int callerId;
@override final  String callerName;
@override final  String? callerAvatar;
@override final  CallType callType;

/// Create a copy of CallInvitationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallInvitationDtoCopyWith<_CallInvitationDto> get copyWith => __$CallInvitationDtoCopyWithImpl<_CallInvitationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallInvitationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallInvitationDto&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.callType, callType) || other.callType == callType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,channelId,callerId,callerName,callerAvatar,callType);

@override
String toString() {
  return 'CallInvitationDto(callId: $callId, channelId: $channelId, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, callType: $callType)';
}


}

/// @nodoc
abstract mixin class _$CallInvitationDtoCopyWith<$Res> implements $CallInvitationDtoCopyWith<$Res> {
  factory _$CallInvitationDtoCopyWith(_CallInvitationDto value, $Res Function(_CallInvitationDto) _then) = __$CallInvitationDtoCopyWithImpl;
@override @useResult
$Res call({
 String callId, String channelId, int callerId, String callerName, String? callerAvatar, CallType callType
});




}
/// @nodoc
class __$CallInvitationDtoCopyWithImpl<$Res>
    implements _$CallInvitationDtoCopyWith<$Res> {
  __$CallInvitationDtoCopyWithImpl(this._self, this._then);

  final _CallInvitationDto _self;
  final $Res Function(_CallInvitationDto) _then;

/// Create a copy of CallInvitationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? channelId = null,Object? callerId = null,Object? callerName = null,Object? callerAvatar = freezed,Object? callType = null,}) {
  return _then(_CallInvitationDto(
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


/// @nodoc
mixin _$CallAcceptDto {

 String get callId; int get acceptedBy;
/// Create a copy of CallAcceptDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallAcceptDtoCopyWith<CallAcceptDto> get copyWith => _$CallAcceptDtoCopyWithImpl<CallAcceptDto>(this as CallAcceptDto, _$identity);

  /// Serializes this CallAcceptDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallAcceptDto&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.acceptedBy, acceptedBy) || other.acceptedBy == acceptedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,acceptedBy);

@override
String toString() {
  return 'CallAcceptDto(callId: $callId, acceptedBy: $acceptedBy)';
}


}

/// @nodoc
abstract mixin class $CallAcceptDtoCopyWith<$Res>  {
  factory $CallAcceptDtoCopyWith(CallAcceptDto value, $Res Function(CallAcceptDto) _then) = _$CallAcceptDtoCopyWithImpl;
@useResult
$Res call({
 String callId, int acceptedBy
});




}
/// @nodoc
class _$CallAcceptDtoCopyWithImpl<$Res>
    implements $CallAcceptDtoCopyWith<$Res> {
  _$CallAcceptDtoCopyWithImpl(this._self, this._then);

  final CallAcceptDto _self;
  final $Res Function(CallAcceptDto) _then;

/// Create a copy of CallAcceptDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? acceptedBy = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,acceptedBy: null == acceptedBy ? _self.acceptedBy : acceptedBy // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CallAcceptDto].
extension CallAcceptDtoPatterns on CallAcceptDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallAcceptDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallAcceptDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallAcceptDto value)  $default,){
final _that = this;
switch (_that) {
case _CallAcceptDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallAcceptDto value)?  $default,){
final _that = this;
switch (_that) {
case _CallAcceptDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  int acceptedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallAcceptDto() when $default != null:
return $default(_that.callId,_that.acceptedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  int acceptedBy)  $default,) {final _that = this;
switch (_that) {
case _CallAcceptDto():
return $default(_that.callId,_that.acceptedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  int acceptedBy)?  $default,) {final _that = this;
switch (_that) {
case _CallAcceptDto() when $default != null:
return $default(_that.callId,_that.acceptedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallAcceptDto implements CallAcceptDto {
  const _CallAcceptDto({required this.callId, required this.acceptedBy});
  factory _CallAcceptDto.fromJson(Map<String, dynamic> json) => _$CallAcceptDtoFromJson(json);

@override final  String callId;
@override final  int acceptedBy;

/// Create a copy of CallAcceptDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallAcceptDtoCopyWith<_CallAcceptDto> get copyWith => __$CallAcceptDtoCopyWithImpl<_CallAcceptDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallAcceptDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallAcceptDto&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.acceptedBy, acceptedBy) || other.acceptedBy == acceptedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,acceptedBy);

@override
String toString() {
  return 'CallAcceptDto(callId: $callId, acceptedBy: $acceptedBy)';
}


}

/// @nodoc
abstract mixin class _$CallAcceptDtoCopyWith<$Res> implements $CallAcceptDtoCopyWith<$Res> {
  factory _$CallAcceptDtoCopyWith(_CallAcceptDto value, $Res Function(_CallAcceptDto) _then) = __$CallAcceptDtoCopyWithImpl;
@override @useResult
$Res call({
 String callId, int acceptedBy
});




}
/// @nodoc
class __$CallAcceptDtoCopyWithImpl<$Res>
    implements _$CallAcceptDtoCopyWith<$Res> {
  __$CallAcceptDtoCopyWithImpl(this._self, this._then);

  final _CallAcceptDto _self;
  final $Res Function(_CallAcceptDto) _then;

/// Create a copy of CallAcceptDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? acceptedBy = null,}) {
  return _then(_CallAcceptDto(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,acceptedBy: null == acceptedBy ? _self.acceptedBy : acceptedBy // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CallRejectDto {

 String get callId; int get rejectedBy; RejectReason get reason;
/// Create a copy of CallRejectDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallRejectDtoCopyWith<CallRejectDto> get copyWith => _$CallRejectDtoCopyWithImpl<CallRejectDto>(this as CallRejectDto, _$identity);

  /// Serializes this CallRejectDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallRejectDto&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,rejectedBy,reason);

@override
String toString() {
  return 'CallRejectDto(callId: $callId, rejectedBy: $rejectedBy, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $CallRejectDtoCopyWith<$Res>  {
  factory $CallRejectDtoCopyWith(CallRejectDto value, $Res Function(CallRejectDto) _then) = _$CallRejectDtoCopyWithImpl;
@useResult
$Res call({
 String callId, int rejectedBy, RejectReason reason
});




}
/// @nodoc
class _$CallRejectDtoCopyWithImpl<$Res>
    implements $CallRejectDtoCopyWith<$Res> {
  _$CallRejectDtoCopyWithImpl(this._self, this._then);

  final CallRejectDto _self;
  final $Res Function(CallRejectDto) _then;

/// Create a copy of CallRejectDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? rejectedBy = null,Object? reason = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,rejectedBy: null == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RejectReason,
  ));
}

}


/// Adds pattern-matching-related methods to [CallRejectDto].
extension CallRejectDtoPatterns on CallRejectDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallRejectDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallRejectDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallRejectDto value)  $default,){
final _that = this;
switch (_that) {
case _CallRejectDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallRejectDto value)?  $default,){
final _that = this;
switch (_that) {
case _CallRejectDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  int rejectedBy,  RejectReason reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallRejectDto() when $default != null:
return $default(_that.callId,_that.rejectedBy,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  int rejectedBy,  RejectReason reason)  $default,) {final _that = this;
switch (_that) {
case _CallRejectDto():
return $default(_that.callId,_that.rejectedBy,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  int rejectedBy,  RejectReason reason)?  $default,) {final _that = this;
switch (_that) {
case _CallRejectDto() when $default != null:
return $default(_that.callId,_that.rejectedBy,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallRejectDto implements CallRejectDto {
  const _CallRejectDto({required this.callId, required this.rejectedBy, required this.reason});
  factory _CallRejectDto.fromJson(Map<String, dynamic> json) => _$CallRejectDtoFromJson(json);

@override final  String callId;
@override final  int rejectedBy;
@override final  RejectReason reason;

/// Create a copy of CallRejectDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallRejectDtoCopyWith<_CallRejectDto> get copyWith => __$CallRejectDtoCopyWithImpl<_CallRejectDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallRejectDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallRejectDto&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,rejectedBy,reason);

@override
String toString() {
  return 'CallRejectDto(callId: $callId, rejectedBy: $rejectedBy, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$CallRejectDtoCopyWith<$Res> implements $CallRejectDtoCopyWith<$Res> {
  factory _$CallRejectDtoCopyWith(_CallRejectDto value, $Res Function(_CallRejectDto) _then) = __$CallRejectDtoCopyWithImpl;
@override @useResult
$Res call({
 String callId, int rejectedBy, RejectReason reason
});




}
/// @nodoc
class __$CallRejectDtoCopyWithImpl<$Res>
    implements _$CallRejectDtoCopyWith<$Res> {
  __$CallRejectDtoCopyWithImpl(this._self, this._then);

  final _CallRejectDto _self;
  final $Res Function(_CallRejectDto) _then;

/// Create a copy of CallRejectDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? rejectedBy = null,Object? reason = null,}) {
  return _then(_CallRejectDto(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,rejectedBy: null == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RejectReason,
  ));
}


}


/// @nodoc
mixin _$CallEndDto {

 String get callId; int get endedBy; int get durationSeconds;
/// Create a copy of CallEndDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallEndDtoCopyWith<CallEndDto> get copyWith => _$CallEndDtoCopyWithImpl<CallEndDto>(this as CallEndDto, _$identity);

  /// Serializes this CallEndDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallEndDto&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.endedBy, endedBy) || other.endedBy == endedBy)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,endedBy,durationSeconds);

@override
String toString() {
  return 'CallEndDto(callId: $callId, endedBy: $endedBy, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class $CallEndDtoCopyWith<$Res>  {
  factory $CallEndDtoCopyWith(CallEndDto value, $Res Function(CallEndDto) _then) = _$CallEndDtoCopyWithImpl;
@useResult
$Res call({
 String callId, int endedBy, int durationSeconds
});




}
/// @nodoc
class _$CallEndDtoCopyWithImpl<$Res>
    implements $CallEndDtoCopyWith<$Res> {
  _$CallEndDtoCopyWithImpl(this._self, this._then);

  final CallEndDto _self;
  final $Res Function(CallEndDto) _then;

/// Create a copy of CallEndDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? endedBy = null,Object? durationSeconds = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,endedBy: null == endedBy ? _self.endedBy : endedBy // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CallEndDto].
extension CallEndDtoPatterns on CallEndDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallEndDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallEndDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallEndDto value)  $default,){
final _that = this;
switch (_that) {
case _CallEndDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallEndDto value)?  $default,){
final _that = this;
switch (_that) {
case _CallEndDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  int endedBy,  int durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallEndDto() when $default != null:
return $default(_that.callId,_that.endedBy,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  int endedBy,  int durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _CallEndDto():
return $default(_that.callId,_that.endedBy,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  int endedBy,  int durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _CallEndDto() when $default != null:
return $default(_that.callId,_that.endedBy,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallEndDto implements CallEndDto {
  const _CallEndDto({required this.callId, required this.endedBy, required this.durationSeconds});
  factory _CallEndDto.fromJson(Map<String, dynamic> json) => _$CallEndDtoFromJson(json);

@override final  String callId;
@override final  int endedBy;
@override final  int durationSeconds;

/// Create a copy of CallEndDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallEndDtoCopyWith<_CallEndDto> get copyWith => __$CallEndDtoCopyWithImpl<_CallEndDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallEndDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallEndDto&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.endedBy, endedBy) || other.endedBy == endedBy)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,endedBy,durationSeconds);

@override
String toString() {
  return 'CallEndDto(callId: $callId, endedBy: $endedBy, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$CallEndDtoCopyWith<$Res> implements $CallEndDtoCopyWith<$Res> {
  factory _$CallEndDtoCopyWith(_CallEndDto value, $Res Function(_CallEndDto) _then) = __$CallEndDtoCopyWithImpl;
@override @useResult
$Res call({
 String callId, int endedBy, int durationSeconds
});




}
/// @nodoc
class __$CallEndDtoCopyWithImpl<$Res>
    implements _$CallEndDtoCopyWith<$Res> {
  __$CallEndDtoCopyWithImpl(this._self, this._then);

  final _CallEndDto _self;
  final $Res Function(_CallEndDto) _then;

/// Create a copy of CallEndDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? endedBy = null,Object? durationSeconds = null,}) {
  return _then(_CallEndDto(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,endedBy: null == endedBy ? _self.endedBy : endedBy // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CallTimeoutDto {

 String get callId; String get reason;
/// Create a copy of CallTimeoutDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallTimeoutDtoCopyWith<CallTimeoutDto> get copyWith => _$CallTimeoutDtoCopyWithImpl<CallTimeoutDto>(this as CallTimeoutDto, _$identity);

  /// Serializes this CallTimeoutDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallTimeoutDto&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,reason);

@override
String toString() {
  return 'CallTimeoutDto(callId: $callId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $CallTimeoutDtoCopyWith<$Res>  {
  factory $CallTimeoutDtoCopyWith(CallTimeoutDto value, $Res Function(CallTimeoutDto) _then) = _$CallTimeoutDtoCopyWithImpl;
@useResult
$Res call({
 String callId, String reason
});




}
/// @nodoc
class _$CallTimeoutDtoCopyWithImpl<$Res>
    implements $CallTimeoutDtoCopyWith<$Res> {
  _$CallTimeoutDtoCopyWithImpl(this._self, this._then);

  final CallTimeoutDto _self;
  final $Res Function(CallTimeoutDto) _then;

/// Create a copy of CallTimeoutDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? reason = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CallTimeoutDto].
extension CallTimeoutDtoPatterns on CallTimeoutDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallTimeoutDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallTimeoutDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallTimeoutDto value)  $default,){
final _that = this;
switch (_that) {
case _CallTimeoutDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallTimeoutDto value)?  $default,){
final _that = this;
switch (_that) {
case _CallTimeoutDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallTimeoutDto() when $default != null:
return $default(_that.callId,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  String reason)  $default,) {final _that = this;
switch (_that) {
case _CallTimeoutDto():
return $default(_that.callId,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _CallTimeoutDto() when $default != null:
return $default(_that.callId,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallTimeoutDto implements CallTimeoutDto {
  const _CallTimeoutDto({required this.callId, required this.reason});
  factory _CallTimeoutDto.fromJson(Map<String, dynamic> json) => _$CallTimeoutDtoFromJson(json);

@override final  String callId;
@override final  String reason;

/// Create a copy of CallTimeoutDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallTimeoutDtoCopyWith<_CallTimeoutDto> get copyWith => __$CallTimeoutDtoCopyWithImpl<_CallTimeoutDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallTimeoutDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallTimeoutDto&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,reason);

@override
String toString() {
  return 'CallTimeoutDto(callId: $callId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$CallTimeoutDtoCopyWith<$Res> implements $CallTimeoutDtoCopyWith<$Res> {
  factory _$CallTimeoutDtoCopyWith(_CallTimeoutDto value, $Res Function(_CallTimeoutDto) _then) = __$CallTimeoutDtoCopyWithImpl;
@override @useResult
$Res call({
 String callId, String reason
});




}
/// @nodoc
class __$CallTimeoutDtoCopyWithImpl<$Res>
    implements _$CallTimeoutDtoCopyWith<$Res> {
  __$CallTimeoutDtoCopyWithImpl(this._self, this._then);

  final _CallTimeoutDto _self;
  final $Res Function(_CallTimeoutDto) _then;

/// Create a copy of CallTimeoutDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? reason = null,}) {
  return _then(_CallTimeoutDto(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WebSocketMessage {

 String get type; Map<String, dynamic> get payload;
/// Create a copy of WebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebSocketMessageCopyWith<WebSocketMessage> get copyWith => _$WebSocketMessageCopyWithImpl<WebSocketMessage>(this as WebSocketMessage, _$identity);

  /// Serializes this WebSocketMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebSocketMessage&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'WebSocketMessage(type: $type, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $WebSocketMessageCopyWith<$Res>  {
  factory $WebSocketMessageCopyWith(WebSocketMessage value, $Res Function(WebSocketMessage) _then) = _$WebSocketMessageCopyWithImpl;
@useResult
$Res call({
 String type, Map<String, dynamic> payload
});




}
/// @nodoc
class _$WebSocketMessageCopyWithImpl<$Res>
    implements $WebSocketMessageCopyWith<$Res> {
  _$WebSocketMessageCopyWithImpl(this._self, this._then);

  final WebSocketMessage _self;
  final $Res Function(WebSocketMessage) _then;

/// Create a copy of WebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? payload = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [WebSocketMessage].
extension WebSocketMessagePatterns on WebSocketMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WebSocketMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WebSocketMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WebSocketMessage value)  $default,){
final _that = this;
switch (_that) {
case _WebSocketMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WebSocketMessage value)?  $default,){
final _that = this;
switch (_that) {
case _WebSocketMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  Map<String, dynamic> payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WebSocketMessage() when $default != null:
return $default(_that.type,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  Map<String, dynamic> payload)  $default,) {final _that = this;
switch (_that) {
case _WebSocketMessage():
return $default(_that.type,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  Map<String, dynamic> payload)?  $default,) {final _that = this;
switch (_that) {
case _WebSocketMessage() when $default != null:
return $default(_that.type,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WebSocketMessage implements WebSocketMessage {
  const _WebSocketMessage({required this.type, required final  Map<String, dynamic> payload}): _payload = payload;
  factory _WebSocketMessage.fromJson(Map<String, dynamic> json) => _$WebSocketMessageFromJson(json);

@override final  String type;
 final  Map<String, dynamic> _payload;
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of WebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebSocketMessageCopyWith<_WebSocketMessage> get copyWith => __$WebSocketMessageCopyWithImpl<_WebSocketMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebSocketMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebSocketMessage&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'WebSocketMessage(type: $type, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$WebSocketMessageCopyWith<$Res> implements $WebSocketMessageCopyWith<$Res> {
  factory _$WebSocketMessageCopyWith(_WebSocketMessage value, $Res Function(_WebSocketMessage) _then) = __$WebSocketMessageCopyWithImpl;
@override @useResult
$Res call({
 String type, Map<String, dynamic> payload
});




}
/// @nodoc
class __$WebSocketMessageCopyWithImpl<$Res>
    implements _$WebSocketMessageCopyWith<$Res> {
  __$WebSocketMessageCopyWithImpl(this._self, this._then);

  final _WebSocketMessage _self;
  final $Res Function(_WebSocketMessage) _then;

/// Create a copy of WebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? payload = null,}) {
  return _then(_WebSocketMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
