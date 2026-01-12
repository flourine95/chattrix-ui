// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_timeout_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallTimeoutModel {

 String get callId; String get reason;
/// Create a copy of CallTimeoutModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallTimeoutModelCopyWith<CallTimeoutModel> get copyWith => _$CallTimeoutModelCopyWithImpl<CallTimeoutModel>(this as CallTimeoutModel, _$identity);

  /// Serializes this CallTimeoutModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallTimeoutModel&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,reason);

@override
String toString() {
  return 'CallTimeoutModel(callId: $callId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $CallTimeoutModelCopyWith<$Res>  {
  factory $CallTimeoutModelCopyWith(CallTimeoutModel value, $Res Function(CallTimeoutModel) _then) = _$CallTimeoutModelCopyWithImpl;
@useResult
$Res call({
 String callId, String reason
});




}
/// @nodoc
class _$CallTimeoutModelCopyWithImpl<$Res>
    implements $CallTimeoutModelCopyWith<$Res> {
  _$CallTimeoutModelCopyWithImpl(this._self, this._then);

  final CallTimeoutModel _self;
  final $Res Function(CallTimeoutModel) _then;

/// Create a copy of CallTimeoutModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? reason = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CallTimeoutModel].
extension CallTimeoutModelPatterns on CallTimeoutModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallTimeoutModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallTimeoutModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallTimeoutModel value)  $default,){
final _that = this;
switch (_that) {
case _CallTimeoutModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallTimeoutModel value)?  $default,){
final _that = this;
switch (_that) {
case _CallTimeoutModel() when $default != null:
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
case _CallTimeoutModel() when $default != null:
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
case _CallTimeoutModel():
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
case _CallTimeoutModel() when $default != null:
return $default(_that.callId,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallTimeoutModel extends CallTimeoutModel {
  const _CallTimeoutModel({required this.callId, required this.reason}): super._();
  factory _CallTimeoutModel.fromJson(Map<String, dynamic> json) => _$CallTimeoutModelFromJson(json);

@override final  String callId;
@override final  String reason;

/// Create a copy of CallTimeoutModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallTimeoutModelCopyWith<_CallTimeoutModel> get copyWith => __$CallTimeoutModelCopyWithImpl<_CallTimeoutModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallTimeoutModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallTimeoutModel&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,reason);

@override
String toString() {
  return 'CallTimeoutModel(callId: $callId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$CallTimeoutModelCopyWith<$Res> implements $CallTimeoutModelCopyWith<$Res> {
  factory _$CallTimeoutModelCopyWith(_CallTimeoutModel value, $Res Function(_CallTimeoutModel) _then) = __$CallTimeoutModelCopyWithImpl;
@override @useResult
$Res call({
 String callId, String reason
});




}
/// @nodoc
class __$CallTimeoutModelCopyWithImpl<$Res>
    implements _$CallTimeoutModelCopyWith<$Res> {
  __$CallTimeoutModelCopyWithImpl(this._self, this._then);

  final _CallTimeoutModel _self;
  final $Res Function(_CallTimeoutModel) _then;

/// Create a copy of CallTimeoutModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? reason = null,}) {
  return _then(_CallTimeoutModel(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
