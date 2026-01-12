// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_end.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallEnd {

 String get callId; int get endedBy; int? get durationSeconds;
/// Create a copy of CallEnd
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallEndCopyWith<CallEnd> get copyWith => _$CallEndCopyWithImpl<CallEnd>(this as CallEnd, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallEnd&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.endedBy, endedBy) || other.endedBy == endedBy)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}


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
 String callId, int endedBy, int? durationSeconds
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
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? endedBy = null,Object? durationSeconds = freezed,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,endedBy: null == endedBy ? _self.endedBy : endedBy // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  int endedBy,  int? durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  int endedBy,  int? durationSeconds)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  int endedBy,  int? durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _CallEnd() when $default != null:
return $default(_that.callId,_that.endedBy,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc


class _CallEnd implements CallEnd {
  const _CallEnd({required this.callId, required this.endedBy, this.durationSeconds});
  

@override final  String callId;
@override final  int endedBy;
@override final  int? durationSeconds;

/// Create a copy of CallEnd
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallEndCopyWith<_CallEnd> get copyWith => __$CallEndCopyWithImpl<_CallEnd>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallEnd&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.endedBy, endedBy) || other.endedBy == endedBy)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}


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
 String callId, int endedBy, int? durationSeconds
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
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? endedBy = null,Object? durationSeconds = freezed,}) {
  return _then(_CallEnd(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,endedBy: null == endedBy ? _self.endedBy : endedBy // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
