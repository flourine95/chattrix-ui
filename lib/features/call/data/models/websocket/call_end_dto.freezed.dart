// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_end_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

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

// dart format on
