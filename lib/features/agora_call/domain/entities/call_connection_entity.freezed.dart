// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_connection_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallConnectionEntity {

 CallEntity get callEntity; String get token;
/// Create a copy of CallConnectionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallConnectionEntityCopyWith<CallConnectionEntity> get copyWith => _$CallConnectionEntityCopyWithImpl<CallConnectionEntity>(this as CallConnectionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallConnectionEntity&&(identical(other.callEntity, callEntity) || other.callEntity == callEntity)&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,callEntity,token);

@override
String toString() {
  return 'CallConnectionEntity(callEntity: $callEntity, token: $token)';
}


}

/// @nodoc
abstract mixin class $CallConnectionEntityCopyWith<$Res>  {
  factory $CallConnectionEntityCopyWith(CallConnectionEntity value, $Res Function(CallConnectionEntity) _then) = _$CallConnectionEntityCopyWithImpl;
@useResult
$Res call({
 CallEntity callEntity, String token
});


$CallEntityCopyWith<$Res> get callEntity;

}
/// @nodoc
class _$CallConnectionEntityCopyWithImpl<$Res>
    implements $CallConnectionEntityCopyWith<$Res> {
  _$CallConnectionEntityCopyWithImpl(this._self, this._then);

  final CallConnectionEntity _self;
  final $Res Function(CallConnectionEntity) _then;

/// Create a copy of CallConnectionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callEntity = null,Object? token = null,}) {
  return _then(_self.copyWith(
callEntity: null == callEntity ? _self.callEntity : callEntity // ignore: cast_nullable_to_non_nullable
as CallEntity,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of CallConnectionEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallEntityCopyWith<$Res> get callEntity {
  
  return $CallEntityCopyWith<$Res>(_self.callEntity, (value) {
    return _then(_self.copyWith(callEntity: value));
  });
}
}


/// Adds pattern-matching-related methods to [CallConnectionEntity].
extension CallConnectionEntityPatterns on CallConnectionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallConnectionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallConnectionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallConnectionEntity value)  $default,){
final _that = this;
switch (_that) {
case _CallConnectionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallConnectionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CallConnectionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CallEntity callEntity,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallConnectionEntity() when $default != null:
return $default(_that.callEntity,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CallEntity callEntity,  String token)  $default,) {final _that = this;
switch (_that) {
case _CallConnectionEntity():
return $default(_that.callEntity,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CallEntity callEntity,  String token)?  $default,) {final _that = this;
switch (_that) {
case _CallConnectionEntity() when $default != null:
return $default(_that.callEntity,_that.token);case _:
  return null;

}
}

}

/// @nodoc


class _CallConnectionEntity implements CallConnectionEntity {
  const _CallConnectionEntity({required this.callEntity, required this.token});
  

@override final  CallEntity callEntity;
@override final  String token;

/// Create a copy of CallConnectionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallConnectionEntityCopyWith<_CallConnectionEntity> get copyWith => __$CallConnectionEntityCopyWithImpl<_CallConnectionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallConnectionEntity&&(identical(other.callEntity, callEntity) || other.callEntity == callEntity)&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,callEntity,token);

@override
String toString() {
  return 'CallConnectionEntity(callEntity: $callEntity, token: $token)';
}


}

/// @nodoc
abstract mixin class _$CallConnectionEntityCopyWith<$Res> implements $CallConnectionEntityCopyWith<$Res> {
  factory _$CallConnectionEntityCopyWith(_CallConnectionEntity value, $Res Function(_CallConnectionEntity) _then) = __$CallConnectionEntityCopyWithImpl;
@override @useResult
$Res call({
 CallEntity callEntity, String token
});


@override $CallEntityCopyWith<$Res> get callEntity;

}
/// @nodoc
class __$CallConnectionEntityCopyWithImpl<$Res>
    implements _$CallConnectionEntityCopyWith<$Res> {
  __$CallConnectionEntityCopyWithImpl(this._self, this._then);

  final _CallConnectionEntity _self;
  final $Res Function(_CallConnectionEntity) _then;

/// Create a copy of CallConnectionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callEntity = null,Object? token = null,}) {
  return _then(_CallConnectionEntity(
callEntity: null == callEntity ? _self.callEntity : callEntity // ignore: cast_nullable_to_non_nullable
as CallEntity,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of CallConnectionEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallEntityCopyWith<$Res> get callEntity {
  
  return $CallEntityCopyWith<$Res>(_self.callEntity, (value) {
    return _then(_self.copyWith(callEntity: value));
  });
}
}

// dart format on
