// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallConnection {

 CallInfo get callInfo; String get token;
/// Create a copy of CallConnection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallConnectionCopyWith<CallConnection> get copyWith => _$CallConnectionCopyWithImpl<CallConnection>(this as CallConnection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallConnection&&(identical(other.callInfo, callInfo) || other.callInfo == callInfo)&&(identical(other.token, token) || other.token == token));
}


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


class _CallConnection implements CallConnection {
  const _CallConnection({required this.callInfo, required this.token});
  

@override final  CallInfo callInfo;
@override final  String token;

/// Create a copy of CallConnection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallConnectionCopyWith<_CallConnection> get copyWith => __$CallConnectionCopyWithImpl<_CallConnection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallConnection&&(identical(other.callInfo, callInfo) || other.callInfo == callInfo)&&(identical(other.token, token) || other.token == token));
}


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

// dart format on
