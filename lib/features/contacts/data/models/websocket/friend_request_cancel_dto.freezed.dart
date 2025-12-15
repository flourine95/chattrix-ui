// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_request_cancel_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FriendRequestCancelDto {

 int get requestId; int get cancelledBy;
/// Create a copy of FriendRequestCancelDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestCancelDtoCopyWith<FriendRequestCancelDto> get copyWith => _$FriendRequestCancelDtoCopyWithImpl<FriendRequestCancelDto>(this as FriendRequestCancelDto, _$identity);

  /// Serializes this FriendRequestCancelDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestCancelDto&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,cancelledBy);

@override
String toString() {
  return 'FriendRequestCancelDto(requestId: $requestId, cancelledBy: $cancelledBy)';
}


}

/// @nodoc
abstract mixin class $FriendRequestCancelDtoCopyWith<$Res>  {
  factory $FriendRequestCancelDtoCopyWith(FriendRequestCancelDto value, $Res Function(FriendRequestCancelDto) _then) = _$FriendRequestCancelDtoCopyWithImpl;
@useResult
$Res call({
 int requestId, int cancelledBy
});




}
/// @nodoc
class _$FriendRequestCancelDtoCopyWithImpl<$Res>
    implements $FriendRequestCancelDtoCopyWith<$Res> {
  _$FriendRequestCancelDtoCopyWithImpl(this._self, this._then);

  final FriendRequestCancelDto _self;
  final $Res Function(FriendRequestCancelDto) _then;

/// Create a copy of FriendRequestCancelDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requestId = null,Object? cancelledBy = null,}) {
  return _then(_self.copyWith(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as int,cancelledBy: null == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendRequestCancelDto].
extension FriendRequestCancelDtoPatterns on FriendRequestCancelDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendRequestCancelDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendRequestCancelDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendRequestCancelDto value)  $default,){
final _that = this;
switch (_that) {
case _FriendRequestCancelDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendRequestCancelDto value)?  $default,){
final _that = this;
switch (_that) {
case _FriendRequestCancelDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int requestId,  int cancelledBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendRequestCancelDto() when $default != null:
return $default(_that.requestId,_that.cancelledBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int requestId,  int cancelledBy)  $default,) {final _that = this;
switch (_that) {
case _FriendRequestCancelDto():
return $default(_that.requestId,_that.cancelledBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int requestId,  int cancelledBy)?  $default,) {final _that = this;
switch (_that) {
case _FriendRequestCancelDto() when $default != null:
return $default(_that.requestId,_that.cancelledBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendRequestCancelDto implements FriendRequestCancelDto {
  const _FriendRequestCancelDto({required this.requestId, required this.cancelledBy});
  factory _FriendRequestCancelDto.fromJson(Map<String, dynamic> json) => _$FriendRequestCancelDtoFromJson(json);

@override final  int requestId;
@override final  int cancelledBy;

/// Create a copy of FriendRequestCancelDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendRequestCancelDtoCopyWith<_FriendRequestCancelDto> get copyWith => __$FriendRequestCancelDtoCopyWithImpl<_FriendRequestCancelDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendRequestCancelDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendRequestCancelDto&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,cancelledBy);

@override
String toString() {
  return 'FriendRequestCancelDto(requestId: $requestId, cancelledBy: $cancelledBy)';
}


}

/// @nodoc
abstract mixin class _$FriendRequestCancelDtoCopyWith<$Res> implements $FriendRequestCancelDtoCopyWith<$Res> {
  factory _$FriendRequestCancelDtoCopyWith(_FriendRequestCancelDto value, $Res Function(_FriendRequestCancelDto) _then) = __$FriendRequestCancelDtoCopyWithImpl;
@override @useResult
$Res call({
 int requestId, int cancelledBy
});




}
/// @nodoc
class __$FriendRequestCancelDtoCopyWithImpl<$Res>
    implements _$FriendRequestCancelDtoCopyWith<$Res> {
  __$FriendRequestCancelDtoCopyWithImpl(this._self, this._then);

  final _FriendRequestCancelDto _self;
  final $Res Function(_FriendRequestCancelDto) _then;

/// Create a copy of FriendRequestCancelDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? cancelledBy = null,}) {
  return _then(_FriendRequestCancelDto(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as int,cancelledBy: null == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
