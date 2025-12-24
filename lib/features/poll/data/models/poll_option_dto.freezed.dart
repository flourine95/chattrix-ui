// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_option_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PollOptionDto {

 int get id; String get optionText; int get optionOrder; int get voteCount; double get percentage; List<UserDto> get voters;
/// Create a copy of PollOptionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollOptionDtoCopyWith<PollOptionDto> get copyWith => _$PollOptionDtoCopyWithImpl<PollOptionDto>(this as PollOptionDto, _$identity);

  /// Serializes this PollOptionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollOptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.optionText, optionText) || other.optionText == optionText)&&(identical(other.optionOrder, optionOrder) || other.optionOrder == optionOrder)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other.voters, voters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,optionText,optionOrder,voteCount,percentage,const DeepCollectionEquality().hash(voters));

@override
String toString() {
  return 'PollOptionDto(id: $id, optionText: $optionText, optionOrder: $optionOrder, voteCount: $voteCount, percentage: $percentage, voters: $voters)';
}


}

/// @nodoc
abstract mixin class $PollOptionDtoCopyWith<$Res>  {
  factory $PollOptionDtoCopyWith(PollOptionDto value, $Res Function(PollOptionDto) _then) = _$PollOptionDtoCopyWithImpl;
@useResult
$Res call({
 int id, String optionText, int optionOrder, int voteCount, double percentage, List<UserDto> voters
});




}
/// @nodoc
class _$PollOptionDtoCopyWithImpl<$Res>
    implements $PollOptionDtoCopyWith<$Res> {
  _$PollOptionDtoCopyWithImpl(this._self, this._then);

  final PollOptionDto _self;
  final $Res Function(PollOptionDto) _then;

/// Create a copy of PollOptionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? optionText = null,Object? optionOrder = null,Object? voteCount = null,Object? percentage = null,Object? voters = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,optionText: null == optionText ? _self.optionText : optionText // ignore: cast_nullable_to_non_nullable
as String,optionOrder: null == optionOrder ? _self.optionOrder : optionOrder // ignore: cast_nullable_to_non_nullable
as int,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,voters: null == voters ? _self.voters : voters // ignore: cast_nullable_to_non_nullable
as List<UserDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [PollOptionDto].
extension PollOptionDtoPatterns on PollOptionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollOptionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollOptionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollOptionDto value)  $default,){
final _that = this;
switch (_that) {
case _PollOptionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollOptionDto value)?  $default,){
final _that = this;
switch (_that) {
case _PollOptionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String optionText,  int optionOrder,  int voteCount,  double percentage,  List<UserDto> voters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollOptionDto() when $default != null:
return $default(_that.id,_that.optionText,_that.optionOrder,_that.voteCount,_that.percentage,_that.voters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String optionText,  int optionOrder,  int voteCount,  double percentage,  List<UserDto> voters)  $default,) {final _that = this;
switch (_that) {
case _PollOptionDto():
return $default(_that.id,_that.optionText,_that.optionOrder,_that.voteCount,_that.percentage,_that.voters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String optionText,  int optionOrder,  int voteCount,  double percentage,  List<UserDto> voters)?  $default,) {final _that = this;
switch (_that) {
case _PollOptionDto() when $default != null:
return $default(_that.id,_that.optionText,_that.optionOrder,_that.voteCount,_that.percentage,_that.voters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollOptionDto implements PollOptionDto {
  const _PollOptionDto({required this.id, required this.optionText, required this.optionOrder, required this.voteCount, required this.percentage, required final  List<UserDto> voters}): _voters = voters;
  factory _PollOptionDto.fromJson(Map<String, dynamic> json) => _$PollOptionDtoFromJson(json);

@override final  int id;
@override final  String optionText;
@override final  int optionOrder;
@override final  int voteCount;
@override final  double percentage;
 final  List<UserDto> _voters;
@override List<UserDto> get voters {
  if (_voters is EqualUnmodifiableListView) return _voters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_voters);
}


/// Create a copy of PollOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollOptionDtoCopyWith<_PollOptionDto> get copyWith => __$PollOptionDtoCopyWithImpl<_PollOptionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollOptionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollOptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.optionText, optionText) || other.optionText == optionText)&&(identical(other.optionOrder, optionOrder) || other.optionOrder == optionOrder)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other._voters, _voters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,optionText,optionOrder,voteCount,percentage,const DeepCollectionEquality().hash(_voters));

@override
String toString() {
  return 'PollOptionDto(id: $id, optionText: $optionText, optionOrder: $optionOrder, voteCount: $voteCount, percentage: $percentage, voters: $voters)';
}


}

/// @nodoc
abstract mixin class _$PollOptionDtoCopyWith<$Res> implements $PollOptionDtoCopyWith<$Res> {
  factory _$PollOptionDtoCopyWith(_PollOptionDto value, $Res Function(_PollOptionDto) _then) = __$PollOptionDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String optionText, int optionOrder, int voteCount, double percentage, List<UserDto> voters
});




}
/// @nodoc
class __$PollOptionDtoCopyWithImpl<$Res>
    implements _$PollOptionDtoCopyWith<$Res> {
  __$PollOptionDtoCopyWithImpl(this._self, this._then);

  final _PollOptionDto _self;
  final $Res Function(_PollOptionDto) _then;

/// Create a copy of PollOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? optionText = null,Object? optionOrder = null,Object? voteCount = null,Object? percentage = null,Object? voters = null,}) {
  return _then(_PollOptionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,optionText: null == optionText ? _self.optionText : optionText // ignore: cast_nullable_to_non_nullable
as String,optionOrder: null == optionOrder ? _self.optionOrder : optionOrder // ignore: cast_nullable_to_non_nullable
as int,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,voters: null == voters ? _self._voters : voters // ignore: cast_nullable_to_non_nullable
as List<UserDto>,
  ));
}


}

// dart format on
