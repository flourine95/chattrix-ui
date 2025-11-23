// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_rejected_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallRejectedData {

 String get callId; String get rejectedBy; String? get reason;
/// Create a copy of CallRejectedData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallRejectedDataCopyWith<CallRejectedData> get copyWith => _$CallRejectedDataCopyWithImpl<CallRejectedData>(this as CallRejectedData, _$identity);

  /// Serializes this CallRejectedData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallRejectedData&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,rejectedBy,reason);

@override
String toString() {
  return 'CallRejectedData(callId: $callId, rejectedBy: $rejectedBy, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $CallRejectedDataCopyWith<$Res>  {
  factory $CallRejectedDataCopyWith(CallRejectedData value, $Res Function(CallRejectedData) _then) = _$CallRejectedDataCopyWithImpl;
@useResult
$Res call({
 String callId, String rejectedBy, String? reason
});




}
/// @nodoc
class _$CallRejectedDataCopyWithImpl<$Res>
    implements $CallRejectedDataCopyWith<$Res> {
  _$CallRejectedDataCopyWithImpl(this._self, this._then);

  final CallRejectedData _self;
  final $Res Function(CallRejectedData) _then;

/// Create a copy of CallRejectedData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? rejectedBy = null,Object? reason = freezed,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,rejectedBy: null == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallRejectedData].
extension CallRejectedDataPatterns on CallRejectedData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallRejectedData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallRejectedData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallRejectedData value)  $default,){
final _that = this;
switch (_that) {
case _CallRejectedData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallRejectedData value)?  $default,){
final _that = this;
switch (_that) {
case _CallRejectedData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  String rejectedBy,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallRejectedData() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  String rejectedBy,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _CallRejectedData():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  String rejectedBy,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _CallRejectedData() when $default != null:
return $default(_that.callId,_that.rejectedBy,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallRejectedData implements CallRejectedData {
  const _CallRejectedData({required this.callId, required this.rejectedBy, this.reason});
  factory _CallRejectedData.fromJson(Map<String, dynamic> json) => _$CallRejectedDataFromJson(json);

@override final  String callId;
@override final  String rejectedBy;
@override final  String? reason;

/// Create a copy of CallRejectedData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallRejectedDataCopyWith<_CallRejectedData> get copyWith => __$CallRejectedDataCopyWithImpl<_CallRejectedData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallRejectedDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallRejectedData&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,rejectedBy,reason);

@override
String toString() {
  return 'CallRejectedData(callId: $callId, rejectedBy: $rejectedBy, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$CallRejectedDataCopyWith<$Res> implements $CallRejectedDataCopyWith<$Res> {
  factory _$CallRejectedDataCopyWith(_CallRejectedData value, $Res Function(_CallRejectedData) _then) = __$CallRejectedDataCopyWithImpl;
@override @useResult
$Res call({
 String callId, String rejectedBy, String? reason
});




}
/// @nodoc
class __$CallRejectedDataCopyWithImpl<$Res>
    implements _$CallRejectedDataCopyWith<$Res> {
  __$CallRejectedDataCopyWithImpl(this._self, this._then);

  final _CallRejectedData _self;
  final $Res Function(_CallRejectedData) _then;

/// Create a copy of CallRejectedData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? rejectedBy = null,Object? reason = freezed,}) {
  return _then(_CallRejectedData(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,rejectedBy: null == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
