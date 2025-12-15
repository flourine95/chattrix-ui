// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_request_reject_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FriendRequestRejectDto {

 int get requestId; int get rejectedBy;
/// Create a copy of FriendRequestRejectDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestRejectDtoCopyWith<FriendRequestRejectDto> get copyWith => _$FriendRequestRejectDtoCopyWithImpl<FriendRequestRejectDto>(this as FriendRequestRejectDto, _$identity);

  /// Serializes this FriendRequestRejectDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestRejectDto&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,rejectedBy);

@override
String toString() {
  return 'FriendRequestRejectDto(requestId: $requestId, rejectedBy: $rejectedBy)';
}


}

/// @nodoc
abstract mixin class $FriendRequestRejectDtoCopyWith<$Res>  {
  factory $FriendRequestRejectDtoCopyWith(FriendRequestRejectDto value, $Res Function(FriendRequestRejectDto) _then) = _$FriendRequestRejectDtoCopyWithImpl;
@useResult
$Res call({
 int requestId, int rejectedBy
});




}
/// @nodoc
class _$FriendRequestRejectDtoCopyWithImpl<$Res>
    implements $FriendRequestRejectDtoCopyWith<$Res> {
  _$FriendRequestRejectDtoCopyWithImpl(this._self, this._then);

  final FriendRequestRejectDto _self;
  final $Res Function(FriendRequestRejectDto) _then;

/// Create a copy of FriendRequestRejectDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requestId = null,Object? rejectedBy = null,}) {
  return _then(_self.copyWith(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as int,rejectedBy: null == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendRequestRejectDto].
extension FriendRequestRejectDtoPatterns on FriendRequestRejectDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendRequestRejectDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendRequestRejectDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendRequestRejectDto value)  $default,){
final _that = this;
switch (_that) {
case _FriendRequestRejectDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendRequestRejectDto value)?  $default,){
final _that = this;
switch (_that) {
case _FriendRequestRejectDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int requestId,  int rejectedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendRequestRejectDto() when $default != null:
return $default(_that.requestId,_that.rejectedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int requestId,  int rejectedBy)  $default,) {final _that = this;
switch (_that) {
case _FriendRequestRejectDto():
return $default(_that.requestId,_that.rejectedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int requestId,  int rejectedBy)?  $default,) {final _that = this;
switch (_that) {
case _FriendRequestRejectDto() when $default != null:
return $default(_that.requestId,_that.rejectedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendRequestRejectDto implements FriendRequestRejectDto {
  const _FriendRequestRejectDto({required this.requestId, required this.rejectedBy});
  factory _FriendRequestRejectDto.fromJson(Map<String, dynamic> json) => _$FriendRequestRejectDtoFromJson(json);

@override final  int requestId;
@override final  int rejectedBy;

/// Create a copy of FriendRequestRejectDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendRequestRejectDtoCopyWith<_FriendRequestRejectDto> get copyWith => __$FriendRequestRejectDtoCopyWithImpl<_FriendRequestRejectDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendRequestRejectDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendRequestRejectDto&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.rejectedBy, rejectedBy) || other.rejectedBy == rejectedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,rejectedBy);

@override
String toString() {
  return 'FriendRequestRejectDto(requestId: $requestId, rejectedBy: $rejectedBy)';
}


}

/// @nodoc
abstract mixin class _$FriendRequestRejectDtoCopyWith<$Res> implements $FriendRequestRejectDtoCopyWith<$Res> {
  factory _$FriendRequestRejectDtoCopyWith(_FriendRequestRejectDto value, $Res Function(_FriendRequestRejectDto) _then) = __$FriendRequestRejectDtoCopyWithImpl;
@override @useResult
$Res call({
 int requestId, int rejectedBy
});




}
/// @nodoc
class __$FriendRequestRejectDtoCopyWithImpl<$Res>
    implements _$FriendRequestRejectDtoCopyWith<$Res> {
  __$FriendRequestRejectDtoCopyWithImpl(this._self, this._then);

  final _FriendRequestRejectDto _self;
  final $Res Function(_FriendRequestRejectDto) _then;

/// Create a copy of FriendRequestRejectDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? rejectedBy = null,}) {
  return _then(_FriendRequestRejectDto(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as int,rejectedBy: null == rejectedBy ? _self.rejectedBy : rejectedBy // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
