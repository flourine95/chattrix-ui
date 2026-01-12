// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_timeout_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

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

// dart format on
