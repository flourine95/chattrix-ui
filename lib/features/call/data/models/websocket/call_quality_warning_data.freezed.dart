// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_quality_warning_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallQualityWarningData {

 String get callId; String get quality;
/// Create a copy of CallQualityWarningData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallQualityWarningDataCopyWith<CallQualityWarningData> get copyWith => _$CallQualityWarningDataCopyWithImpl<CallQualityWarningData>(this as CallQualityWarningData, _$identity);

  /// Serializes this CallQualityWarningData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallQualityWarningData&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.quality, quality) || other.quality == quality));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,quality);

@override
String toString() {
  return 'CallQualityWarningData(callId: $callId, quality: $quality)';
}


}

/// @nodoc
abstract mixin class $CallQualityWarningDataCopyWith<$Res>  {
  factory $CallQualityWarningDataCopyWith(CallQualityWarningData value, $Res Function(CallQualityWarningData) _then) = _$CallQualityWarningDataCopyWithImpl;
@useResult
$Res call({
 String callId, String quality
});




}
/// @nodoc
class _$CallQualityWarningDataCopyWithImpl<$Res>
    implements $CallQualityWarningDataCopyWith<$Res> {
  _$CallQualityWarningDataCopyWithImpl(this._self, this._then);

  final CallQualityWarningData _self;
  final $Res Function(CallQualityWarningData) _then;

/// Create a copy of CallQualityWarningData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? quality = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CallQualityWarningData].
extension CallQualityWarningDataPatterns on CallQualityWarningData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallQualityWarningData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallQualityWarningData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallQualityWarningData value)  $default,){
final _that = this;
switch (_that) {
case _CallQualityWarningData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallQualityWarningData value)?  $default,){
final _that = this;
switch (_that) {
case _CallQualityWarningData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  String quality)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallQualityWarningData() when $default != null:
return $default(_that.callId,_that.quality);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  String quality)  $default,) {final _that = this;
switch (_that) {
case _CallQualityWarningData():
return $default(_that.callId,_that.quality);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  String quality)?  $default,) {final _that = this;
switch (_that) {
case _CallQualityWarningData() when $default != null:
return $default(_that.callId,_that.quality);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallQualityWarningData implements CallQualityWarningData {
  const _CallQualityWarningData({required this.callId, required this.quality});
  factory _CallQualityWarningData.fromJson(Map<String, dynamic> json) => _$CallQualityWarningDataFromJson(json);

@override final  String callId;
@override final  String quality;

/// Create a copy of CallQualityWarningData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallQualityWarningDataCopyWith<_CallQualityWarningData> get copyWith => __$CallQualityWarningDataCopyWithImpl<_CallQualityWarningData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallQualityWarningDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallQualityWarningData&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.quality, quality) || other.quality == quality));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,quality);

@override
String toString() {
  return 'CallQualityWarningData(callId: $callId, quality: $quality)';
}


}

/// @nodoc
abstract mixin class _$CallQualityWarningDataCopyWith<$Res> implements $CallQualityWarningDataCopyWith<$Res> {
  factory _$CallQualityWarningDataCopyWith(_CallQualityWarningData value, $Res Function(_CallQualityWarningData) _then) = __$CallQualityWarningDataCopyWithImpl;
@override @useResult
$Res call({
 String callId, String quality
});




}
/// @nodoc
class __$CallQualityWarningDataCopyWithImpl<$Res>
    implements _$CallQualityWarningDataCopyWith<$Res> {
  __$CallQualityWarningDataCopyWithImpl(this._self, this._then);

  final _CallQualityWarningData _self;
  final $Res Function(_CallQualityWarningData) _then;

/// Create a copy of CallQualityWarningData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? quality = null,}) {
  return _then(_CallQualityWarningData(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
