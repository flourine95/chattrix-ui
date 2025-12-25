// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mutual_group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MutualGroupModel {

 int get id; String get type; DateTime get createdAt; DateTime get updatedAt; List<ParticipantModel> get participants;
/// Create a copy of MutualGroupModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MutualGroupModelCopyWith<MutualGroupModel> get copyWith => _$MutualGroupModelCopyWithImpl<MutualGroupModel>(this as MutualGroupModel, _$identity);

  /// Serializes this MutualGroupModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MutualGroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.participants, participants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,createdAt,updatedAt,const DeepCollectionEquality().hash(participants));

@override
String toString() {
  return 'MutualGroupModel(id: $id, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, participants: $participants)';
}


}

/// @nodoc
abstract mixin class $MutualGroupModelCopyWith<$Res>  {
  factory $MutualGroupModelCopyWith(MutualGroupModel value, $Res Function(MutualGroupModel) _then) = _$MutualGroupModelCopyWithImpl;
@useResult
$Res call({
 int id, String type, DateTime createdAt, DateTime updatedAt, List<ParticipantModel> participants
});




}
/// @nodoc
class _$MutualGroupModelCopyWithImpl<$Res>
    implements $MutualGroupModelCopyWith<$Res> {
  _$MutualGroupModelCopyWithImpl(this._self, this._then);

  final MutualGroupModel _self;
  final $Res Function(MutualGroupModel) _then;

/// Create a copy of MutualGroupModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? createdAt = null,Object? updatedAt = null,Object? participants = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<ParticipantModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [MutualGroupModel].
extension MutualGroupModelPatterns on MutualGroupModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MutualGroupModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MutualGroupModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MutualGroupModel value)  $default,){
final _that = this;
switch (_that) {
case _MutualGroupModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MutualGroupModel value)?  $default,){
final _that = this;
switch (_that) {
case _MutualGroupModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type,  DateTime createdAt,  DateTime updatedAt,  List<ParticipantModel> participants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MutualGroupModel() when $default != null:
return $default(_that.id,_that.type,_that.createdAt,_that.updatedAt,_that.participants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type,  DateTime createdAt,  DateTime updatedAt,  List<ParticipantModel> participants)  $default,) {final _that = this;
switch (_that) {
case _MutualGroupModel():
return $default(_that.id,_that.type,_that.createdAt,_that.updatedAt,_that.participants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type,  DateTime createdAt,  DateTime updatedAt,  List<ParticipantModel> participants)?  $default,) {final _that = this;
switch (_that) {
case _MutualGroupModel() when $default != null:
return $default(_that.id,_that.type,_that.createdAt,_that.updatedAt,_that.participants);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MutualGroupModel implements MutualGroupModel {
  const _MutualGroupModel({required this.id, required this.type, required this.createdAt, required this.updatedAt, final  List<ParticipantModel> participants = const []}): _participants = participants;
  factory _MutualGroupModel.fromJson(Map<String, dynamic> json) => _$MutualGroupModelFromJson(json);

@override final  int id;
@override final  String type;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
 final  List<ParticipantModel> _participants;
@override@JsonKey() List<ParticipantModel> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}


/// Create a copy of MutualGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MutualGroupModelCopyWith<_MutualGroupModel> get copyWith => __$MutualGroupModelCopyWithImpl<_MutualGroupModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MutualGroupModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MutualGroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._participants, _participants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,createdAt,updatedAt,const DeepCollectionEquality().hash(_participants));

@override
String toString() {
  return 'MutualGroupModel(id: $id, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, participants: $participants)';
}


}

/// @nodoc
abstract mixin class _$MutualGroupModelCopyWith<$Res> implements $MutualGroupModelCopyWith<$Res> {
  factory _$MutualGroupModelCopyWith(_MutualGroupModel value, $Res Function(_MutualGroupModel) _then) = __$MutualGroupModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String type, DateTime createdAt, DateTime updatedAt, List<ParticipantModel> participants
});




}
/// @nodoc
class __$MutualGroupModelCopyWithImpl<$Res>
    implements _$MutualGroupModelCopyWith<$Res> {
  __$MutualGroupModelCopyWithImpl(this._self, this._then);

  final _MutualGroupModel _self;
  final $Res Function(_MutualGroupModel) _then;

/// Create a copy of MutualGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? createdAt = null,Object? updatedAt = null,Object? participants = null,}) {
  return _then(_MutualGroupModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<ParticipantModel>,
  ));
}


}

// dart format on
