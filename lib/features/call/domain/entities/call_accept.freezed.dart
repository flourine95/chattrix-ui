// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_accept.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallAccept {

 String get callId; int get acceptedBy;
/// Create a copy of CallAccept
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallAcceptCopyWith<CallAccept> get copyWith => _$CallAcceptCopyWithImpl<CallAccept>(this as CallAccept, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallAccept&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.acceptedBy, acceptedBy) || other.acceptedBy == acceptedBy));
}


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


class _CallAccept implements CallAccept {
  const _CallAccept({required this.callId, required this.acceptedBy});
  

@override final  String callId;
@override final  int acceptedBy;

/// Create a copy of CallAccept
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallAcceptCopyWith<_CallAccept> get copyWith => __$CallAcceptCopyWithImpl<_CallAccept>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallAccept&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.acceptedBy, acceptedBy) || other.acceptedBy == acceptedBy));
}


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

// dart format on
