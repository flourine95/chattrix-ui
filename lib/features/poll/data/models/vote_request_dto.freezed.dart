// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VoteRequestDto {

 List<int> get optionIds;
/// Create a copy of VoteRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteRequestDtoCopyWith<VoteRequestDto> get copyWith => _$VoteRequestDtoCopyWithImpl<VoteRequestDto>(this as VoteRequestDto, _$identity);

  /// Serializes this VoteRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteRequestDto&&const DeepCollectionEquality().equals(other.optionIds, optionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(optionIds));

@override
String toString() {
  return 'VoteRequestDto(optionIds: $optionIds)';
}


}

/// @nodoc
abstract mixin class $VoteRequestDtoCopyWith<$Res>  {
  factory $VoteRequestDtoCopyWith(VoteRequestDto value, $Res Function(VoteRequestDto) _then) = _$VoteRequestDtoCopyWithImpl;
@useResult
$Res call({
 List<int> optionIds
});




}
/// @nodoc
class _$VoteRequestDtoCopyWithImpl<$Res>
    implements $VoteRequestDtoCopyWith<$Res> {
  _$VoteRequestDtoCopyWithImpl(this._self, this._then);

  final VoteRequestDto _self;
  final $Res Function(VoteRequestDto) _then;

/// Create a copy of VoteRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? optionIds = null,}) {
  return _then(_self.copyWith(
optionIds: null == optionIds ? _self.optionIds : optionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [VoteRequestDto].
extension VoteRequestDtoPatterns on VoteRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoteRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoteRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoteRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _VoteRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoteRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _VoteRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<int> optionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoteRequestDto() when $default != null:
return $default(_that.optionIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<int> optionIds)  $default,) {final _that = this;
switch (_that) {
case _VoteRequestDto():
return $default(_that.optionIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<int> optionIds)?  $default,) {final _that = this;
switch (_that) {
case _VoteRequestDto() when $default != null:
return $default(_that.optionIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VoteRequestDto implements VoteRequestDto {
  const _VoteRequestDto({required final  List<int> optionIds}): _optionIds = optionIds;
  factory _VoteRequestDto.fromJson(Map<String, dynamic> json) => _$VoteRequestDtoFromJson(json);

 final  List<int> _optionIds;
@override List<int> get optionIds {
  if (_optionIds is EqualUnmodifiableListView) return _optionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_optionIds);
}


/// Create a copy of VoteRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteRequestDtoCopyWith<_VoteRequestDto> get copyWith => __$VoteRequestDtoCopyWithImpl<_VoteRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoteRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteRequestDto&&const DeepCollectionEquality().equals(other._optionIds, _optionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_optionIds));

@override
String toString() {
  return 'VoteRequestDto(optionIds: $optionIds)';
}


}

/// @nodoc
abstract mixin class _$VoteRequestDtoCopyWith<$Res> implements $VoteRequestDtoCopyWith<$Res> {
  factory _$VoteRequestDtoCopyWith(_VoteRequestDto value, $Res Function(_VoteRequestDto) _then) = __$VoteRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 List<int> optionIds
});




}
/// @nodoc
class __$VoteRequestDtoCopyWithImpl<$Res>
    implements _$VoteRequestDtoCopyWith<$Res> {
  __$VoteRequestDtoCopyWithImpl(this._self, this._then);

  final _VoteRequestDto _self;
  final $Res Function(_VoteRequestDto) _then;

/// Create a copy of VoteRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? optionIds = null,}) {
  return _then(_VoteRequestDto(
optionIds: null == optionIds ? _self._optionIds : optionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
