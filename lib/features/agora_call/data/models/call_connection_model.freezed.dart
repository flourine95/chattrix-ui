// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_connection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallConnectionModel {

 CallModel get callData; String get token;
/// Create a copy of CallConnectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallConnectionModelCopyWith<CallConnectionModel> get copyWith => _$CallConnectionModelCopyWithImpl<CallConnectionModel>(this as CallConnectionModel, _$identity);

  /// Serializes this CallConnectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallConnectionModel&&(identical(other.callData, callData) || other.callData == callData)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callData,token);

@override
String toString() {
  return 'CallConnectionModel(callData: $callData, token: $token)';
}


}

/// @nodoc
abstract mixin class $CallConnectionModelCopyWith<$Res>  {
  factory $CallConnectionModelCopyWith(CallConnectionModel value, $Res Function(CallConnectionModel) _then) = _$CallConnectionModelCopyWithImpl;
@useResult
$Res call({
 CallModel callData, String token
});


$CallModelCopyWith<$Res> get callData;

}
/// @nodoc
class _$CallConnectionModelCopyWithImpl<$Res>
    implements $CallConnectionModelCopyWith<$Res> {
  _$CallConnectionModelCopyWithImpl(this._self, this._then);

  final CallConnectionModel _self;
  final $Res Function(CallConnectionModel) _then;

/// Create a copy of CallConnectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callData = null,Object? token = null,}) {
  return _then(_self.copyWith(
callData: null == callData ? _self.callData : callData // ignore: cast_nullable_to_non_nullable
as CallModel,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of CallConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallModelCopyWith<$Res> get callData {
  
  return $CallModelCopyWith<$Res>(_self.callData, (value) {
    return _then(_self.copyWith(callData: value));
  });
}
}


/// Adds pattern-matching-related methods to [CallConnectionModel].
extension CallConnectionModelPatterns on CallConnectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallConnectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallConnectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallConnectionModel value)  $default,){
final _that = this;
switch (_that) {
case _CallConnectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallConnectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _CallConnectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CallModel callData,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallConnectionModel() when $default != null:
return $default(_that.callData,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CallModel callData,  String token)  $default,) {final _that = this;
switch (_that) {
case _CallConnectionModel():
return $default(_that.callData,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CallModel callData,  String token)?  $default,) {final _that = this;
switch (_that) {
case _CallConnectionModel() when $default != null:
return $default(_that.callData,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallConnectionModel extends CallConnectionModel {
  const _CallConnectionModel({required this.callData, required this.token}): super._();
  factory _CallConnectionModel.fromJson(Map<String, dynamic> json) => _$CallConnectionModelFromJson(json);

@override final  CallModel callData;
@override final  String token;

/// Create a copy of CallConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallConnectionModelCopyWith<_CallConnectionModel> get copyWith => __$CallConnectionModelCopyWithImpl<_CallConnectionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallConnectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallConnectionModel&&(identical(other.callData, callData) || other.callData == callData)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callData,token);

@override
String toString() {
  return 'CallConnectionModel(callData: $callData, token: $token)';
}


}

/// @nodoc
abstract mixin class _$CallConnectionModelCopyWith<$Res> implements $CallConnectionModelCopyWith<$Res> {
  factory _$CallConnectionModelCopyWith(_CallConnectionModel value, $Res Function(_CallConnectionModel) _then) = __$CallConnectionModelCopyWithImpl;
@override @useResult
$Res call({
 CallModel callData, String token
});


@override $CallModelCopyWith<$Res> get callData;

}
/// @nodoc
class __$CallConnectionModelCopyWithImpl<$Res>
    implements _$CallConnectionModelCopyWith<$Res> {
  __$CallConnectionModelCopyWithImpl(this._self, this._then);

  final _CallConnectionModel _self;
  final $Res Function(_CallConnectionModel) _then;

/// Create a copy of CallConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callData = null,Object? token = null,}) {
  return _then(_CallConnectionModel(
callData: null == callData ? _self.callData : callData // ignore: cast_nullable_to_non_nullable
as CallModel,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of CallConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallModelCopyWith<$Res> get callData {
  
  return $CallModelCopyWith<$Res>(_self.callData, (value) {
    return _then(_self.copyWith(callData: value));
  });
}
}

// dart format on
