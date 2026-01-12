// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_option_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PollOptionEntity {

 int get id; String get optionText; int get optionOrder; int get voteCount; double get percentage; List<User> get voters;
/// Create a copy of PollOptionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollOptionEntityCopyWith<PollOptionEntity> get copyWith => _$PollOptionEntityCopyWithImpl<PollOptionEntity>(this as PollOptionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollOptionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.optionText, optionText) || other.optionText == optionText)&&(identical(other.optionOrder, optionOrder) || other.optionOrder == optionOrder)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other.voters, voters));
}


@override
int get hashCode => Object.hash(runtimeType,id,optionText,optionOrder,voteCount,percentage,const DeepCollectionEquality().hash(voters));

@override
String toString() {
  return 'PollOptionEntity(id: $id, optionText: $optionText, optionOrder: $optionOrder, voteCount: $voteCount, percentage: $percentage, voters: $voters)';
}


}

/// @nodoc
abstract mixin class $PollOptionEntityCopyWith<$Res>  {
  factory $PollOptionEntityCopyWith(PollOptionEntity value, $Res Function(PollOptionEntity) _then) = _$PollOptionEntityCopyWithImpl;
@useResult
$Res call({
 int id, String optionText, int optionOrder, int voteCount, double percentage, List<User> voters
});




}
/// @nodoc
class _$PollOptionEntityCopyWithImpl<$Res>
    implements $PollOptionEntityCopyWith<$Res> {
  _$PollOptionEntityCopyWithImpl(this._self, this._then);

  final PollOptionEntity _self;
  final $Res Function(PollOptionEntity) _then;

/// Create a copy of PollOptionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? optionText = null,Object? optionOrder = null,Object? voteCount = null,Object? percentage = null,Object? voters = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,optionText: null == optionText ? _self.optionText : optionText // ignore: cast_nullable_to_non_nullable
as String,optionOrder: null == optionOrder ? _self.optionOrder : optionOrder // ignore: cast_nullable_to_non_nullable
as int,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,voters: null == voters ? _self.voters : voters // ignore: cast_nullable_to_non_nullable
as List<User>,
  ));
}

}


/// Adds pattern-matching-related methods to [PollOptionEntity].
extension PollOptionEntityPatterns on PollOptionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollOptionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollOptionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollOptionEntity value)  $default,){
final _that = this;
switch (_that) {
case _PollOptionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollOptionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PollOptionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String optionText,  int optionOrder,  int voteCount,  double percentage,  List<User> voters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollOptionEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String optionText,  int optionOrder,  int voteCount,  double percentage,  List<User> voters)  $default,) {final _that = this;
switch (_that) {
case _PollOptionEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String optionText,  int optionOrder,  int voteCount,  double percentage,  List<User> voters)?  $default,) {final _that = this;
switch (_that) {
case _PollOptionEntity() when $default != null:
return $default(_that.id,_that.optionText,_that.optionOrder,_that.voteCount,_that.percentage,_that.voters);case _:
  return null;

}
}

}

/// @nodoc


class _PollOptionEntity extends PollOptionEntity {
  const _PollOptionEntity({required this.id, required this.optionText, required this.optionOrder, required this.voteCount, required this.percentage, required final  List<User> voters}): _voters = voters,super._();
  

@override final  int id;
@override final  String optionText;
@override final  int optionOrder;
@override final  int voteCount;
@override final  double percentage;
 final  List<User> _voters;
@override List<User> get voters {
  if (_voters is EqualUnmodifiableListView) return _voters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_voters);
}


/// Create a copy of PollOptionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollOptionEntityCopyWith<_PollOptionEntity> get copyWith => __$PollOptionEntityCopyWithImpl<_PollOptionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollOptionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.optionText, optionText) || other.optionText == optionText)&&(identical(other.optionOrder, optionOrder) || other.optionOrder == optionOrder)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other._voters, _voters));
}


@override
int get hashCode => Object.hash(runtimeType,id,optionText,optionOrder,voteCount,percentage,const DeepCollectionEquality().hash(_voters));

@override
String toString() {
  return 'PollOptionEntity(id: $id, optionText: $optionText, optionOrder: $optionOrder, voteCount: $voteCount, percentage: $percentage, voters: $voters)';
}


}

/// @nodoc
abstract mixin class _$PollOptionEntityCopyWith<$Res> implements $PollOptionEntityCopyWith<$Res> {
  factory _$PollOptionEntityCopyWith(_PollOptionEntity value, $Res Function(_PollOptionEntity) _then) = __$PollOptionEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String optionText, int optionOrder, int voteCount, double percentage, List<User> voters
});




}
/// @nodoc
class __$PollOptionEntityCopyWithImpl<$Res>
    implements _$PollOptionEntityCopyWith<$Res> {
  __$PollOptionEntityCopyWithImpl(this._self, this._then);

  final _PollOptionEntity _self;
  final $Res Function(_PollOptionEntity) _then;

/// Create a copy of PollOptionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? optionText = null,Object? optionOrder = null,Object? voteCount = null,Object? percentage = null,Object? voters = null,}) {
  return _then(_PollOptionEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,optionText: null == optionText ? _self.optionText : optionText // ignore: cast_nullable_to_non_nullable
as String,optionOrder: null == optionOrder ? _self.optionOrder : optionOrder // ignore: cast_nullable_to_non_nullable
as int,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,voters: null == voters ? _self._voters : voters // ignore: cast_nullable_to_non_nullable
as List<User>,
  ));
}


}

// dart format on
