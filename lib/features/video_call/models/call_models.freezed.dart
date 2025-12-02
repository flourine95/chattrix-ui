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
mixin _$CallUser {

 int get id; String get name; String? get avatarUrl;
/// Create a copy of CallUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallUserCopyWith<CallUser> get copyWith => _$CallUserCopyWithImpl<CallUser>(this as CallUser, _$identity);

  /// Serializes this CallUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallUser&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'CallUser(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $CallUserCopyWith<$Res>  {
  factory $CallUserCopyWith(CallUser value, $Res Function(CallUser) _then) = _$CallUserCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? avatarUrl
});




}
/// @nodoc
class _$CallUserCopyWithImpl<$Res>
    implements $CallUserCopyWith<$Res> {
  _$CallUserCopyWithImpl(this._self, this._then);

  final CallUser _self;
  final $Res Function(CallUser) _then;

/// Create a copy of CallUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallUser].
extension CallUserPatterns on CallUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallUser value)  $default,){
final _that = this;
switch (_that) {
case _CallUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallUser value)?  $default,){
final _that = this;
switch (_that) {
case _CallUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallUser() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _CallUser():
return $default(_that.id,_that.name,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _CallUser() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallUser implements CallUser {
  const _CallUser({required this.id, required this.name, this.avatarUrl});
  factory _CallUser.fromJson(Map<String, dynamic> json) => _$CallUserFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? avatarUrl;

/// Create a copy of CallUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallUserCopyWith<_CallUser> get copyWith => __$CallUserCopyWithImpl<_CallUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallUser&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'CallUser(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$CallUserCopyWith<$Res> implements $CallUserCopyWith<$Res> {
  factory _$CallUserCopyWith(_CallUser value, $Res Function(_CallUser) _then) = __$CallUserCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? avatarUrl
});




}
/// @nodoc
class __$CallUserCopyWithImpl<$Res>
    implements _$CallUserCopyWith<$Res> {
  __$CallUserCopyWithImpl(this._self, this._then);

  final _CallUser _self;
  final $Res Function(_CallUser) _then;

/// Create a copy of CallUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_CallUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CallInfo {

 String get id; String get channelId; CallStatus get status; CallType get callType; CallUser get caller; CallUser get callee; DateTime get createdAt; int? get durationSeconds;
/// Create a copy of CallInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallInfoCopyWith<CallInfo> get copyWith => _$CallInfoCopyWithImpl<CallInfo>(this as CallInfo, _$identity);

  /// Serializes this CallInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.status, status) || other.status == status)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.caller, caller) || other.caller == caller)&&(identical(other.callee, callee) || other.callee == callee)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,channelId,status,callType,caller,callee,createdAt,durationSeconds);

@override
String toString() {
  return 'CallInfo(id: $id, channelId: $channelId, status: $status, callType: $callType, caller: $caller, callee: $callee, createdAt: $createdAt, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class $CallInfoCopyWith<$Res>  {
  factory $CallInfoCopyWith(CallInfo value, $Res Function(CallInfo) _then) = _$CallInfoCopyWithImpl;
@useResult
$Res call({
 String id, String channelId, CallStatus status, CallType callType, CallUser caller, CallUser callee, DateTime createdAt, int? durationSeconds
});


$CallUserCopyWith<$Res> get caller;$CallUserCopyWith<$Res> get callee;

}
/// @nodoc
class _$CallInfoCopyWithImpl<$Res>
    implements $CallInfoCopyWith<$Res> {
  _$CallInfoCopyWithImpl(this._self, this._then);

  final CallInfo _self;
  final $Res Function(CallInfo) _then;

/// Create a copy of CallInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? channelId = null,Object? status = null,Object? callType = null,Object? caller = null,Object? callee = null,Object? createdAt = null,Object? durationSeconds = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallStatus,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,caller: null == caller ? _self.caller : caller // ignore: cast_nullable_to_non_nullable
as CallUser,callee: null == callee ? _self.callee : callee // ignore: cast_nullable_to_non_nullable
as CallUser,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of CallInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallUserCopyWith<$Res> get caller {
  
  return $CallUserCopyWith<$Res>(_self.caller, (value) {
    return _then(_self.copyWith(caller: value));
  });
}/// Create a copy of CallInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallUserCopyWith<$Res> get callee {
  
  return $CallUserCopyWith<$Res>(_self.callee, (value) {
    return _then(_self.copyWith(callee: value));
  });
}
}


/// Adds pattern-matching-related methods to [CallInfo].
extension CallInfoPatterns on CallInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallInfo value)  $default,){
final _that = this;
switch (_that) {
case _CallInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallInfo value)?  $default,){
final _that = this;
switch (_that) {
case _CallInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String channelId,  CallStatus status,  CallType callType,  CallUser caller,  CallUser callee,  DateTime createdAt,  int? durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallInfo() when $default != null:
return $default(_that.id,_that.channelId,_that.status,_that.callType,_that.caller,_that.callee,_that.createdAt,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String channelId,  CallStatus status,  CallType callType,  CallUser caller,  CallUser callee,  DateTime createdAt,  int? durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _CallInfo():
return $default(_that.id,_that.channelId,_that.status,_that.callType,_that.caller,_that.callee,_that.createdAt,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String channelId,  CallStatus status,  CallType callType,  CallUser caller,  CallUser callee,  DateTime createdAt,  int? durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _CallInfo() when $default != null:
return $default(_that.id,_that.channelId,_that.status,_that.callType,_that.caller,_that.callee,_that.createdAt,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallInfo implements CallInfo {
  const _CallInfo({required this.id, required this.channelId, required this.status, required this.callType, required this.caller, required this.callee, required this.createdAt, this.durationSeconds});
  factory _CallInfo.fromJson(Map<String, dynamic> json) => _$CallInfoFromJson(json);

@override final  String id;
@override final  String channelId;
@override final  CallStatus status;
@override final  CallType callType;
@override final  CallUser caller;
@override final  CallUser callee;
@override final  DateTime createdAt;
@override final  int? durationSeconds;

/// Create a copy of CallInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallInfoCopyWith<_CallInfo> get copyWith => __$CallInfoCopyWithImpl<_CallInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.status, status) || other.status == status)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.caller, caller) || other.caller == caller)&&(identical(other.callee, callee) || other.callee == callee)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,channelId,status,callType,caller,callee,createdAt,durationSeconds);

@override
String toString() {
  return 'CallInfo(id: $id, channelId: $channelId, status: $status, callType: $callType, caller: $caller, callee: $callee, createdAt: $createdAt, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$CallInfoCopyWith<$Res> implements $CallInfoCopyWith<$Res> {
  factory _$CallInfoCopyWith(_CallInfo value, $Res Function(_CallInfo) _then) = __$CallInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String channelId, CallStatus status, CallType callType, CallUser caller, CallUser callee, DateTime createdAt, int? durationSeconds
});


@override $CallUserCopyWith<$Res> get caller;@override $CallUserCopyWith<$Res> get callee;

}
/// @nodoc
class __$CallInfoCopyWithImpl<$Res>
    implements _$CallInfoCopyWith<$Res> {
  __$CallInfoCopyWithImpl(this._self, this._then);

  final _CallInfo _self;
  final $Res Function(_CallInfo) _then;

/// Create a copy of CallInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? channelId = null,Object? status = null,Object? callType = null,Object? caller = null,Object? callee = null,Object? createdAt = null,Object? durationSeconds = freezed,}) {
  return _then(_CallInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallStatus,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,caller: null == caller ? _self.caller : caller // ignore: cast_nullable_to_non_nullable
as CallUser,callee: null == callee ? _self.callee : callee // ignore: cast_nullable_to_non_nullable
as CallUser,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of CallInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallUserCopyWith<$Res> get caller {
  
  return $CallUserCopyWith<$Res>(_self.caller, (value) {
    return _then(_self.copyWith(caller: value));
  });
}/// Create a copy of CallInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallUserCopyWith<$Res> get callee {
  
  return $CallUserCopyWith<$Res>(_self.callee, (value) {
    return _then(_self.copyWith(callee: value));
  });
}
}


/// @nodoc
mixin _$CallConnection {

 CallInfo get callInfo; String get token;
/// Create a copy of CallConnection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallConnectionCopyWith<CallConnection> get copyWith => _$CallConnectionCopyWithImpl<CallConnection>(this as CallConnection, _$identity);

  /// Serializes this CallConnection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallConnection&&(identical(other.callInfo, callInfo) || other.callInfo == callInfo)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callInfo,token);

@override
String toString() {
  return 'CallConnection(callInfo: $callInfo, token: $token)';
}


}

/// @nodoc
abstract mixin class $CallConnectionCopyWith<$Res>  {
  factory $CallConnectionCopyWith(CallConnection value, $Res Function(CallConnection) _then) = _$CallConnectionCopyWithImpl;
@useResult
$Res call({
 CallInfo callInfo, String token
});


$CallInfoCopyWith<$Res> get callInfo;

}
/// @nodoc
class _$CallConnectionCopyWithImpl<$Res>
    implements $CallConnectionCopyWith<$Res> {
  _$CallConnectionCopyWithImpl(this._self, this._then);

  final CallConnection _self;
  final $Res Function(CallConnection) _then;

/// Create a copy of CallConnection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callInfo = null,Object? token = null,}) {
  return _then(_self.copyWith(
callInfo: null == callInfo ? _self.callInfo : callInfo // ignore: cast_nullable_to_non_nullable
as CallInfo,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of CallConnection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallInfoCopyWith<$Res> get callInfo {
  
  return $CallInfoCopyWith<$Res>(_self.callInfo, (value) {
    return _then(_self.copyWith(callInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [CallConnection].
extension CallConnectionPatterns on CallConnection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallConnection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallConnection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallConnection value)  $default,){
final _that = this;
switch (_that) {
case _CallConnection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallConnection value)?  $default,){
final _that = this;
switch (_that) {
case _CallConnection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CallInfo callInfo,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallConnection() when $default != null:
return $default(_that.callInfo,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CallInfo callInfo,  String token)  $default,) {final _that = this;
switch (_that) {
case _CallConnection():
return $default(_that.callInfo,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CallInfo callInfo,  String token)?  $default,) {final _that = this;
switch (_that) {
case _CallConnection() when $default != null:
return $default(_that.callInfo,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallConnection implements CallConnection {
  const _CallConnection({required this.callInfo, required this.token});
  factory _CallConnection.fromJson(Map<String, dynamic> json) => _$CallConnectionFromJson(json);

@override final  CallInfo callInfo;
@override final  String token;

/// Create a copy of CallConnection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallConnectionCopyWith<_CallConnection> get copyWith => __$CallConnectionCopyWithImpl<_CallConnection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallConnectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallConnection&&(identical(other.callInfo, callInfo) || other.callInfo == callInfo)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callInfo,token);

@override
String toString() {
  return 'CallConnection(callInfo: $callInfo, token: $token)';
}


}

/// @nodoc
abstract mixin class _$CallConnectionCopyWith<$Res> implements $CallConnectionCopyWith<$Res> {
  factory _$CallConnectionCopyWith(_CallConnection value, $Res Function(_CallConnection) _then) = __$CallConnectionCopyWithImpl;
@override @useResult
$Res call({
 CallInfo callInfo, String token
});


@override $CallInfoCopyWith<$Res> get callInfo;

}
/// @nodoc
class __$CallConnectionCopyWithImpl<$Res>
    implements _$CallConnectionCopyWith<$Res> {
  __$CallConnectionCopyWithImpl(this._self, this._then);

  final _CallConnection _self;
  final $Res Function(_CallConnection) _then;

/// Create a copy of CallConnection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callInfo = null,Object? token = null,}) {
  return _then(_CallConnection(
callInfo: null == callInfo ? _self.callInfo : callInfo // ignore: cast_nullable_to_non_nullable
as CallInfo,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of CallConnection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallInfoCopyWith<$Res> get callInfo {
  
  return $CallInfoCopyWith<$Res>(_self.callInfo, (value) {
    return _then(_self.copyWith(callInfo: value));
  });
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

 String get reason;
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
 String reason
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
as String,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String reason)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String reason)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String reason)?  $default,) {final _that = this;
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
  const _EndCallRequest({this.reason = 'hangup'});
  factory _EndCallRequest.fromJson(Map<String, dynamic> json) => _$EndCallRequestFromJson(json);

@override@JsonKey() final  String reason;

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
 String reason
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
as String,
  ));
}


}


/// @nodoc
mixin _$CallInvitation {

 String get callId; String get channelId; int get callerId; String get callerName; String? get callerAvatar; CallType get callType;
/// Create a copy of CallInvitation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallInvitationCopyWith<CallInvitation> get copyWith => _$CallInvitationCopyWithImpl<CallInvitation>(this as CallInvitation, _$identity);

  /// Serializes this CallInvitation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallInvitation&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.callType, callType) || other.callType == callType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,channelId,callerId,callerName,callerAvatar,callType);

@override
String toString() {
  return 'CallInvitation(callId: $callId, channelId: $channelId, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, callType: $callType)';
}


}

/// @nodoc
abstract mixin class $CallInvitationCopyWith<$Res>  {
  factory $CallInvitationCopyWith(CallInvitation value, $Res Function(CallInvitation) _then) = _$CallInvitationCopyWithImpl;
@useResult
$Res call({
 String callId, String channelId, int callerId, String callerName, String? callerAvatar, CallType callType
});




}
/// @nodoc
class _$CallInvitationCopyWithImpl<$Res>
    implements $CallInvitationCopyWith<$Res> {
  _$CallInvitationCopyWithImpl(this._self, this._then);

  final CallInvitation _self;
  final $Res Function(CallInvitation) _then;

/// Create a copy of CallInvitation
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


/// Adds pattern-matching-related methods to [CallInvitation].
extension CallInvitationPatterns on CallInvitation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallInvitation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallInvitation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallInvitation value)  $default,){
final _that = this;
switch (_that) {
case _CallInvitation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallInvitation value)?  $default,){
final _that = this;
switch (_that) {
case _CallInvitation() when $default != null:
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
case _CallInvitation() when $default != null:
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
case _CallInvitation():
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
case _CallInvitation() when $default != null:
return $default(_that.callId,_that.channelId,_that.callerId,_that.callerName,_that.callerAvatar,_that.callType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallInvitation implements CallInvitation {
  const _CallInvitation({required this.callId, required this.channelId, required this.callerId, required this.callerName, this.callerAvatar, required this.callType});
  factory _CallInvitation.fromJson(Map<String, dynamic> json) => _$CallInvitationFromJson(json);

@override final  String callId;
@override final  String channelId;
@override final  int callerId;
@override final  String callerName;
@override final  String? callerAvatar;
@override final  CallType callType;

/// Create a copy of CallInvitation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallInvitationCopyWith<_CallInvitation> get copyWith => __$CallInvitationCopyWithImpl<_CallInvitation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallInvitationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallInvitation&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.callType, callType) || other.callType == callType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,channelId,callerId,callerName,callerAvatar,callType);

@override
String toString() {
  return 'CallInvitation(callId: $callId, channelId: $channelId, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, callType: $callType)';
}


}

/// @nodoc
abstract mixin class _$CallInvitationCopyWith<$Res> implements $CallInvitationCopyWith<$Res> {
  factory _$CallInvitationCopyWith(_CallInvitation value, $Res Function(_CallInvitation) _then) = __$CallInvitationCopyWithImpl;
@override @useResult
$Res call({
 String callId, String channelId, int callerId, String callerName, String? callerAvatar, CallType callType
});




}
/// @nodoc
class __$CallInvitationCopyWithImpl<$Res>
    implements _$CallInvitationCopyWith<$Res> {
  __$CallInvitationCopyWithImpl(this._self, this._then);

  final _CallInvitation _self;
  final $Res Function(_CallInvitation) _then;

/// Create a copy of CallInvitation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? channelId = null,Object? callerId = null,Object? callerName = null,Object? callerAvatar = freezed,Object? callType = null,}) {
  return _then(_CallInvitation(
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
mixin _$CallAccept {

 String get callId; int get acceptedBy;
/// Create a copy of CallAccept
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallAcceptCopyWith<CallAccept> get copyWith => _$CallAcceptCopyWithImpl<CallAccept>(this as CallAccept, _$identity);

  /// Serializes this CallAccept to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallAccept&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.acceptedBy, acceptedBy) || other.acceptedBy == acceptedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,acceptedBy);

@override
String toString() {
  return 'CallAccept(callId: $callId, acceptedBy: $acceptedBy)';
}


}

/// @nodoc
abstract mixin class $CallAcceptCopyWith<$Res>  {
  factory $CallAcceptCopyWith(CallAccept value, $Res Function(CallAccept) _then) = _$CallAcceptCopyWithImpl;
@useResult
$Res call({
 String callId, int acceptedBy
});




}
/// @nodoc
class _$CallAcceptCopyWithImpl<$Res>
    implements $CallAcceptCopyWith<$Res> {
  _$CallAcceptCopyWithImpl(this._self, this._then);

  final CallAccept _self;
  final $Res Function(CallAccept) _then;

/// Create a copy of CallAccept
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? acceptedBy = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,acceptedBy: null == acceptedBy ? _self.acceptedBy : acceptedBy // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CallAccept].
extension CallAcceptPatterns on CallAccept {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallAccept value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallAccept() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallAccept value)  $default,){
final _that = this;
switch (_that) {
case _CallAccept():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallAccept value)?  $default,){
final _that = this;
switch (_that) {
case _CallAccept() when $default != null:
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
case _CallAccept() when $default != null:
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
case _CallAccept():
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
case _CallAccept() when $default != null:
return $default(_that.callId,_that.acceptedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallAccept implements CallAccept {
  const _CallAccept({required this.callId, required this.acceptedBy});
  factory _CallAccept.fromJson(Map<String, dynamic> json) => _$CallAcceptFromJson(json);

@override final  String callId;
@override final  int acceptedBy;

/// Create a copy of CallAccept
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallAcceptCopyWith<_CallAccept> get copyWith => __$CallAcceptCopyWithImpl<_CallAccept>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallAcceptToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallAccept&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.acceptedBy, acceptedBy) || other.acceptedBy == acceptedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,acceptedBy);

@override
String toString() {
  return 'CallAccept(callId: $callId, acceptedBy: $acceptedBy)';
}


}

/// @nodoc
abstract mixin class _$CallAcceptCopyWith<$Res> implements $CallAcceptCopyWith<$Res> {
  factory _$CallAcceptCopyWith(_CallAccept value, $Res Function(_CallAccept) _then) = __$CallAcceptCopyWithImpl;
@override @useResult
$Res call({
 String callId, int acceptedBy
});




}
/// @nodoc
class __$CallAcceptCopyWithImpl<$Res>
    implements _$CallAcceptCopyWith<$Res> {
  __$CallAcceptCopyWithImpl(this._self, this._then);

  final _CallAccept _self;
  final $Res Function(_CallAccept) _then;

/// Create a copy of CallAccept
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? acceptedBy = null,}) {
  return _then(_CallAccept(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,acceptedBy: null == acceptedBy ? _self.acceptedBy : acceptedBy // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CallReject {

 String get callId; int get rejectedBy; RejectReason get reason;
/// Create a copy of CallReject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallRejectCopyWith<CallReject> get copyWith => _$CallRejectCopyWithImpl<CallReject>(this as CallReject, _$identity);

  /// Serializes this CallReject to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallReject&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,rejectedBy,reason);

@override
String toString() {
  return 'CallReject(callId: $callId, rejectedBy: $rejectedBy, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $CallRejectCopyWith<$Res>  {
  factory $CallRejectCopyWith(CallReject value, $Res Function(CallReject) _then) = _$CallRejectCopyWithImpl;
@useResult
$Res call({
 String callId, int rejectedBy, RejectReason reason
});




}
/// @nodoc
class _$CallRejectCopyWithImpl<$Res>
    implements $CallRejectCopyWith<$Res> {
  _$CallRejectCopyWithImpl(this._self, this._then);

  final CallReject _self;
  final $Res Function(CallReject) _then;

/// Create a copy of CallReject
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


/// Adds pattern-matching-related methods to [CallReject].
extension CallRejectPatterns on CallReject {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallReject value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallReject() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallReject value)  $default,){
final _that = this;
switch (_that) {
case _CallReject():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallReject value)?  $default,){
final _that = this;
switch (_that) {
case _CallReject() when $default != null:
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
case _CallReject() when $default != null:
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
case _CallReject():
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
case _CallReject() when $default != null:
return $default(_that.callId,_that.rejectedBy,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallReject implements CallReject {
  const _CallReject({required this.callId, required this.rejectedBy, required this.reason});
  factory _CallReject.fromJson(Map<String, dynamic> json) => _$CallRejectFromJson(json);

@override final  String callId;
@override final  int rejectedBy;
@override final  RejectReason reason;

/// Create a copy of CallReject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallRejectCopyWith<_CallReject> get copyWith => __$CallRejectCopyWithImpl<_CallReject>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallRejectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallReject&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,rejectedBy,reason);

@override
String toString() {
  return 'CallReject(callId: $callId, rejectedBy: $rejectedBy, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$CallRejectCopyWith<$Res> implements $CallRejectCopyWith<$Res> {
  factory _$CallRejectCopyWith(_CallReject value, $Res Function(_CallReject) _then) = __$CallRejectCopyWithImpl;
@override @useResult
$Res call({
 String callId, int rejectedBy, RejectReason reason
});




}
/// @nodoc
class __$CallRejectCopyWithImpl<$Res>
    implements _$CallRejectCopyWith<$Res> {
  __$CallRejectCopyWithImpl(this._self, this._then);

  final _CallReject _self;
  final $Res Function(_CallReject) _then;

/// Create a copy of CallReject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? rejectedBy = null,Object? reason = null,}) {
  return _then(_CallReject(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,rejectedBy: null == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RejectReason,
  ));
}


}


/// @nodoc
mixin _$CallEnd {

 String get callId; int get endedBy; int get durationSeconds;
/// Create a copy of CallEnd
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallEndCopyWith<CallEnd> get copyWith => _$CallEndCopyWithImpl<CallEnd>(this as CallEnd, _$identity);

  /// Serializes this CallEnd to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallEnd&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.endedBy, endedBy) || other.endedBy == endedBy)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,endedBy,durationSeconds);

@override
String toString() {
  return 'CallEnd(callId: $callId, endedBy: $endedBy, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class $CallEndCopyWith<$Res>  {
  factory $CallEndCopyWith(CallEnd value, $Res Function(CallEnd) _then) = _$CallEndCopyWithImpl;
@useResult
$Res call({
 String callId, int endedBy, int durationSeconds
});




}
/// @nodoc
class _$CallEndCopyWithImpl<$Res>
    implements $CallEndCopyWith<$Res> {
  _$CallEndCopyWithImpl(this._self, this._then);

  final CallEnd _self;
  final $Res Function(CallEnd) _then;

/// Create a copy of CallEnd
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


/// Adds pattern-matching-related methods to [CallEnd].
extension CallEndPatterns on CallEnd {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallEnd value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallEnd() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallEnd value)  $default,){
final _that = this;
switch (_that) {
case _CallEnd():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallEnd value)?  $default,){
final _that = this;
switch (_that) {
case _CallEnd() when $default != null:
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
case _CallEnd() when $default != null:
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
case _CallEnd():
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
case _CallEnd() when $default != null:
return $default(_that.callId,_that.endedBy,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallEnd implements CallEnd {
  const _CallEnd({required this.callId, required this.endedBy, required this.durationSeconds});
  factory _CallEnd.fromJson(Map<String, dynamic> json) => _$CallEndFromJson(json);

@override final  String callId;
@override final  int endedBy;
@override final  int durationSeconds;

/// Create a copy of CallEnd
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallEndCopyWith<_CallEnd> get copyWith => __$CallEndCopyWithImpl<_CallEnd>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallEndToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallEnd&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.endedBy, endedBy) || other.endedBy == endedBy)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,endedBy,durationSeconds);

@override
String toString() {
  return 'CallEnd(callId: $callId, endedBy: $endedBy, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$CallEndCopyWith<$Res> implements $CallEndCopyWith<$Res> {
  factory _$CallEndCopyWith(_CallEnd value, $Res Function(_CallEnd) _then) = __$CallEndCopyWithImpl;
@override @useResult
$Res call({
 String callId, int endedBy, int durationSeconds
});




}
/// @nodoc
class __$CallEndCopyWithImpl<$Res>
    implements _$CallEndCopyWith<$Res> {
  __$CallEndCopyWithImpl(this._self, this._then);

  final _CallEnd _self;
  final $Res Function(_CallEnd) _then;

/// Create a copy of CallEnd
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? endedBy = null,Object? durationSeconds = null,}) {
  return _then(_CallEnd(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,endedBy: null == endedBy ? _self.endedBy : endedBy // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CallTimeout {

 String get callId; String get reason;
/// Create a copy of CallTimeout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallTimeoutCopyWith<CallTimeout> get copyWith => _$CallTimeoutCopyWithImpl<CallTimeout>(this as CallTimeout, _$identity);

  /// Serializes this CallTimeout to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallTimeout&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,reason);

@override
String toString() {
  return 'CallTimeout(callId: $callId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $CallTimeoutCopyWith<$Res>  {
  factory $CallTimeoutCopyWith(CallTimeout value, $Res Function(CallTimeout) _then) = _$CallTimeoutCopyWithImpl;
@useResult
$Res call({
 String callId, String reason
});




}
/// @nodoc
class _$CallTimeoutCopyWithImpl<$Res>
    implements $CallTimeoutCopyWith<$Res> {
  _$CallTimeoutCopyWithImpl(this._self, this._then);

  final CallTimeout _self;
  final $Res Function(CallTimeout) _then;

/// Create a copy of CallTimeout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? reason = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CallTimeout].
extension CallTimeoutPatterns on CallTimeout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallTimeout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallTimeout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallTimeout value)  $default,){
final _that = this;
switch (_that) {
case _CallTimeout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallTimeout value)?  $default,){
final _that = this;
switch (_that) {
case _CallTimeout() when $default != null:
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
case _CallTimeout() when $default != null:
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
case _CallTimeout():
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
case _CallTimeout() when $default != null:
return $default(_that.callId,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallTimeout implements CallTimeout {
  const _CallTimeout({required this.callId, required this.reason});
  factory _CallTimeout.fromJson(Map<String, dynamic> json) => _$CallTimeoutFromJson(json);

@override final  String callId;
@override final  String reason;

/// Create a copy of CallTimeout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallTimeoutCopyWith<_CallTimeout> get copyWith => __$CallTimeoutCopyWithImpl<_CallTimeout>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallTimeoutToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallTimeout&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,reason);

@override
String toString() {
  return 'CallTimeout(callId: $callId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$CallTimeoutCopyWith<$Res> implements $CallTimeoutCopyWith<$Res> {
  factory _$CallTimeoutCopyWith(_CallTimeout value, $Res Function(_CallTimeout) _then) = __$CallTimeoutCopyWithImpl;
@override @useResult
$Res call({
 String callId, String reason
});




}
/// @nodoc
class __$CallTimeoutCopyWithImpl<$Res>
    implements _$CallTimeoutCopyWith<$Res> {
  __$CallTimeoutCopyWithImpl(this._self, this._then);

  final _CallTimeout _self;
  final $Res Function(_CallTimeout) _then;

/// Create a copy of CallTimeout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? reason = null,}) {
  return _then(_CallTimeout(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
