// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_accept_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallAcceptModel {

 String get callId; int get acceptedBy;
/// Create a copy of CallAcceptModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallAcceptModelCopyWith<CallAcceptModel> get copyWith => _$CallAcceptModelCopyWithImpl<CallAcceptModel>(this as CallAcceptModel, _$identity);

  /// Serializes this CallAcceptModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallAcceptModel&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.acceptedBy, acceptedBy) || other.acceptedBy == acceptedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,acceptedBy);

@override
String toString() {
  return 'CallAcceptModel(callId: $callId, acceptedBy: $acceptedBy)';
}


}

/// @nodoc
abstract mixin class $CallAcceptModelCopyWith<$Res>  {
  factory $CallAcceptModelCopyWith(CallAcceptModel value, $Res Function(CallAcceptModel) _then) = _$CallAcceptModelCopyWithImpl;
@useResult
$Res call({
 String callId, int acceptedBy
});




}
/// @nodoc
class _$CallAcceptModelCopyWithImpl<$Res>
    implements $CallAcceptModelCopyWith<$Res> {
  _$CallAcceptModelCopyWithImpl(this._self, this._then);

  final CallAcceptModel _self;
  final $Res Function(CallAcceptModel) _then;

/// Create a copy of CallAcceptModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? acceptedBy = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,acceptedBy: null == acceptedBy ? _self.acceptedBy : acceptedBy // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CallAcceptModel].
extension CallAcceptModelPatterns on CallAcceptModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallAcceptModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallAcceptModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallAcceptModel value)  $default,){
final _that = this;
switch (_that) {
case _CallAcceptModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallAcceptModel value)?  $default,){
final _that = this;
switch (_that) {
case _CallAcceptModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  int acceptedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallAcceptModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  int acceptedBy)  $default,) {final _that = this;
switch (_that) {
case _CallAcceptModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  int acceptedBy)?  $default,) {final _that = this;
switch (_that) {
case _CallAcceptModel() when $default != null:
return $default(_that.callId,_that.acceptedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallAcceptModel extends CallAcceptModel {
  const _CallAcceptModel({required this.callId, required this.acceptedBy}): super._();
  factory _CallAcceptModel.fromJson(Map<String, dynamic> json) => _$CallAcceptModelFromJson(json);

@override final  String callId;
@override final  int acceptedBy;

/// Create a copy of CallAcceptModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallAcceptModelCopyWith<_CallAcceptModel> get copyWith => __$CallAcceptModelCopyWithImpl<_CallAcceptModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallAcceptModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallAcceptModel&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.acceptedBy, acceptedBy) || other.acceptedBy == acceptedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,acceptedBy);

@override
String toString() {
  return 'CallAcceptModel(callId: $callId, acceptedBy: $acceptedBy)';
}


}

/// @nodoc
abstract mixin class _$CallAcceptModelCopyWith<$Res> implements $CallAcceptModelCopyWith<$Res> {
  factory _$CallAcceptModelCopyWith(_CallAcceptModel value, $Res Function(_CallAcceptModel) _then) = __$CallAcceptModelCopyWithImpl;
@override @useResult
$Res call({
 String callId, int acceptedBy
});




}
/// @nodoc
class __$CallAcceptModelCopyWithImpl<$Res>
    implements _$CallAcceptModelCopyWith<$Res> {
  __$CallAcceptModelCopyWithImpl(this._self, this._then);

  final _CallAcceptModel _self;
  final $Res Function(_CallAcceptModel) _then;

/// Create a copy of CallAcceptModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? acceptedBy = null,}) {
  return _then(_CallAcceptModel(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,acceptedBy: null == acceptedBy ? _self.acceptedBy : acceptedBy // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
