// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_timeout_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallTimeoutData {

 String get callId;
/// Create a copy of CallTimeoutData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallTimeoutDataCopyWith<CallTimeoutData> get copyWith => _$CallTimeoutDataCopyWithImpl<CallTimeoutData>(this as CallTimeoutData, _$identity);

  /// Serializes this CallTimeoutData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallTimeoutData&&(identical(other.callId, callId) || other.callId == callId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId);

@override
String toString() {
  return 'CallTimeoutData(callId: $callId)';
}


}

/// @nodoc
abstract mixin class $CallTimeoutDataCopyWith<$Res>  {
  factory $CallTimeoutDataCopyWith(CallTimeoutData value, $Res Function(CallTimeoutData) _then) = _$CallTimeoutDataCopyWithImpl;
@useResult
$Res call({
 String callId
});




}
/// @nodoc
class _$CallTimeoutDataCopyWithImpl<$Res>
    implements $CallTimeoutDataCopyWith<$Res> {
  _$CallTimeoutDataCopyWithImpl(this._self, this._then);

  final CallTimeoutData _self;
  final $Res Function(CallTimeoutData) _then;

/// Create a copy of CallTimeoutData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CallTimeoutData].
extension CallTimeoutDataPatterns on CallTimeoutData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallTimeoutData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallTimeoutData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallTimeoutData value)  $default,){
final _that = this;
switch (_that) {
case _CallTimeoutData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallTimeoutData value)?  $default,){
final _that = this;
switch (_that) {
case _CallTimeoutData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallTimeoutData() when $default != null:
return $default(_that.callId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId)  $default,) {final _that = this;
switch (_that) {
case _CallTimeoutData():
return $default(_that.callId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId)?  $default,) {final _that = this;
switch (_that) {
case _CallTimeoutData() when $default != null:
return $default(_that.callId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallTimeoutData implements CallTimeoutData {
  const _CallTimeoutData({required this.callId});
  factory _CallTimeoutData.fromJson(Map<String, dynamic> json) => _$CallTimeoutDataFromJson(json);

@override final  String callId;

/// Create a copy of CallTimeoutData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallTimeoutDataCopyWith<_CallTimeoutData> get copyWith => __$CallTimeoutDataCopyWithImpl<_CallTimeoutData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallTimeoutDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallTimeoutData&&(identical(other.callId, callId) || other.callId == callId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId);

@override
String toString() {
  return 'CallTimeoutData(callId: $callId)';
}


}

/// @nodoc
abstract mixin class _$CallTimeoutDataCopyWith<$Res> implements $CallTimeoutDataCopyWith<$Res> {
  factory _$CallTimeoutDataCopyWith(_CallTimeoutData value, $Res Function(_CallTimeoutData) _then) = __$CallTimeoutDataCopyWithImpl;
@override @useResult
$Res call({
 String callId
});




}
/// @nodoc
class __$CallTimeoutDataCopyWithImpl<$Res>
    implements _$CallTimeoutDataCopyWith<$Res> {
  __$CallTimeoutDataCopyWithImpl(this._self, this._then);

  final _CallTimeoutData _self;
  final $Res Function(_CallTimeoutData) _then;

/// Create a copy of CallTimeoutData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,}) {
  return _then(_CallTimeoutData(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
