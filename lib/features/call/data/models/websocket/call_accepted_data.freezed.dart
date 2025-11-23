// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_accepted_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallAcceptedData {

 String get callId; String get acceptedBy;
/// Create a copy of CallAcceptedData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallAcceptedDataCopyWith<CallAcceptedData> get copyWith => _$CallAcceptedDataCopyWithImpl<CallAcceptedData>(this as CallAcceptedData, _$identity);

  /// Serializes this CallAcceptedData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallAcceptedData&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.acceptedBy, acceptedBy) || other.acceptedBy == acceptedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,acceptedBy);

@override
String toString() {
  return 'CallAcceptedData(callId: $callId, acceptedBy: $acceptedBy)';
}


}

/// @nodoc
abstract mixin class $CallAcceptedDataCopyWith<$Res>  {
  factory $CallAcceptedDataCopyWith(CallAcceptedData value, $Res Function(CallAcceptedData) _then) = _$CallAcceptedDataCopyWithImpl;
@useResult
$Res call({
 String callId, String acceptedBy
});




}
/// @nodoc
class _$CallAcceptedDataCopyWithImpl<$Res>
    implements $CallAcceptedDataCopyWith<$Res> {
  _$CallAcceptedDataCopyWithImpl(this._self, this._then);

  final CallAcceptedData _self;
  final $Res Function(CallAcceptedData) _then;

/// Create a copy of CallAcceptedData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? acceptedBy = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,acceptedBy: null == acceptedBy ? _self.acceptedBy : acceptedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CallAcceptedData].
extension CallAcceptedDataPatterns on CallAcceptedData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallAcceptedData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallAcceptedData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallAcceptedData value)  $default,){
final _that = this;
switch (_that) {
case _CallAcceptedData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallAcceptedData value)?  $default,){
final _that = this;
switch (_that) {
case _CallAcceptedData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  String acceptedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallAcceptedData() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  String acceptedBy)  $default,) {final _that = this;
switch (_that) {
case _CallAcceptedData():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  String acceptedBy)?  $default,) {final _that = this;
switch (_that) {
case _CallAcceptedData() when $default != null:
return $default(_that.callId,_that.acceptedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallAcceptedData implements CallAcceptedData {
  const _CallAcceptedData({required this.callId, required this.acceptedBy});
  factory _CallAcceptedData.fromJson(Map<String, dynamic> json) => _$CallAcceptedDataFromJson(json);

@override final  String callId;
@override final  String acceptedBy;

/// Create a copy of CallAcceptedData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallAcceptedDataCopyWith<_CallAcceptedData> get copyWith => __$CallAcceptedDataCopyWithImpl<_CallAcceptedData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallAcceptedDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallAcceptedData&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.acceptedBy, acceptedBy) || other.acceptedBy == acceptedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,acceptedBy);

@override
String toString() {
  return 'CallAcceptedData(callId: $callId, acceptedBy: $acceptedBy)';
}


}

/// @nodoc
abstract mixin class _$CallAcceptedDataCopyWith<$Res> implements $CallAcceptedDataCopyWith<$Res> {
  factory _$CallAcceptedDataCopyWith(_CallAcceptedData value, $Res Function(_CallAcceptedData) _then) = __$CallAcceptedDataCopyWithImpl;
@override @useResult
$Res call({
 String callId, String acceptedBy
});




}
/// @nodoc
class __$CallAcceptedDataCopyWithImpl<$Res>
    implements _$CallAcceptedDataCopyWith<$Res> {
  __$CallAcceptedDataCopyWithImpl(this._self, this._then);

  final _CallAcceptedData _self;
  final $Res Function(_CallAcceptedData) _then;

/// Create a copy of CallAcceptedData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? acceptedBy = null,}) {
  return _then(_CallAcceptedData(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,acceptedBy: null == acceptedBy ? _self.acceptedBy : acceptedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
