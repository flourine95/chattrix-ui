// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_timeout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallTimeout {

 String get callId; String get reason;
/// Create a copy of CallTimeout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallTimeoutCopyWith<CallTimeout> get copyWith => _$CallTimeoutCopyWithImpl<CallTimeout>(this as CallTimeout, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallTimeout&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.reason, reason) || other.reason == reason));
}


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


class _CallTimeout implements CallTimeout {
  const _CallTimeout({required this.callId, required this.reason});
  

@override final  String callId;
@override final  String reason;

/// Create a copy of CallTimeout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallTimeoutCopyWith<_CallTimeout> get copyWith => __$CallTimeoutCopyWithImpl<_CallTimeout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallTimeout&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.reason, reason) || other.reason == reason));
}


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
