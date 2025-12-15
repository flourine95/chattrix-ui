// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_reject_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallRejectDto {

 String get callId; int get rejectedBy; String get reason;
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
 String callId, int rejectedBy, String reason
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
as String,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  int rejectedBy,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  int rejectedBy,  String reason)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  int rejectedBy,  String reason)?  $default,) {final _that = this;
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
@override final  String reason;

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
 String callId, int rejectedBy, String reason
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
as String,
  ));
}


}

// dart format on
