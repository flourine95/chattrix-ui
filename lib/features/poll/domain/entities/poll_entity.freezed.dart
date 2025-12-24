// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PollEntity {

 int get id; String get question; int get conversationId; User get creator; bool get allowMultipleVotes; DateTime? get expiresAt; bool get isClosed; bool get isExpired; bool get isActive; DateTime get createdAt; int get totalVoters; List<PollOptionEntity> get options; List<int> get currentUserVotedOptionIds;
/// Create a copy of PollEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollEntityCopyWith<PollEntity> get copyWith => _$PollEntityCopyWithImpl<PollEntity>(this as PollEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.totalVoters, totalVoters) || other.totalVoters == totalVoters)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.currentUserVotedOptionIds, currentUserVotedOptionIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,question,conversationId,creator,allowMultipleVotes,expiresAt,isClosed,isExpired,isActive,createdAt,totalVoters,const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(currentUserVotedOptionIds));

@override
String toString() {
  return 'PollEntity(id: $id, question: $question, conversationId: $conversationId, creator: $creator, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt, isClosed: $isClosed, isExpired: $isExpired, isActive: $isActive, createdAt: $createdAt, totalVoters: $totalVoters, options: $options, currentUserVotedOptionIds: $currentUserVotedOptionIds)';
}


}

/// @nodoc
abstract mixin class $PollEntityCopyWith<$Res>  {
  factory $PollEntityCopyWith(PollEntity value, $Res Function(PollEntity) _then) = _$PollEntityCopyWithImpl;
@useResult
$Res call({
 int id, String question, int conversationId, User creator, bool allowMultipleVotes, DateTime? expiresAt, bool isClosed, bool isExpired, bool isActive, DateTime createdAt, int totalVoters, List<PollOptionEntity> options, List<int> currentUserVotedOptionIds
});


$UserCopyWith<$Res> get creator;

}
/// @nodoc
class _$PollEntityCopyWithImpl<$Res>
    implements $PollEntityCopyWith<$Res> {
  _$PollEntityCopyWithImpl(this._self, this._then);

  final PollEntity _self;
  final $Res Function(PollEntity) _then;

/// Create a copy of PollEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? question = null,Object? conversationId = null,Object? creator = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,Object? isClosed = null,Object? isExpired = null,Object? isActive = null,Object? createdAt = null,Object? totalVoters = null,Object? options = null,Object? currentUserVotedOptionIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as User,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalVoters: null == totalVoters ? _self.totalVoters : totalVoters // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<PollOptionEntity>,currentUserVotedOptionIds: null == currentUserVotedOptionIds ? _self.currentUserVotedOptionIds : currentUserVotedOptionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}
/// Create a copy of PollEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get creator {
  
  return $UserCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// Adds pattern-matching-related methods to [PollEntity].
extension PollEntityPatterns on PollEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollEntity value)  $default,){
final _that = this;
switch (_that) {
case _PollEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PollEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String question,  int conversationId,  User creator,  bool allowMultipleVotes,  DateTime? expiresAt,  bool isClosed,  bool isExpired,  bool isActive,  DateTime createdAt,  int totalVoters,  List<PollOptionEntity> options,  List<int> currentUserVotedOptionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollEntity() when $default != null:
return $default(_that.id,_that.question,_that.conversationId,_that.creator,_that.allowMultipleVotes,_that.expiresAt,_that.isClosed,_that.isExpired,_that.isActive,_that.createdAt,_that.totalVoters,_that.options,_that.currentUserVotedOptionIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String question,  int conversationId,  User creator,  bool allowMultipleVotes,  DateTime? expiresAt,  bool isClosed,  bool isExpired,  bool isActive,  DateTime createdAt,  int totalVoters,  List<PollOptionEntity> options,  List<int> currentUserVotedOptionIds)  $default,) {final _that = this;
switch (_that) {
case _PollEntity():
return $default(_that.id,_that.question,_that.conversationId,_that.creator,_that.allowMultipleVotes,_that.expiresAt,_that.isClosed,_that.isExpired,_that.isActive,_that.createdAt,_that.totalVoters,_that.options,_that.currentUserVotedOptionIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String question,  int conversationId,  User creator,  bool allowMultipleVotes,  DateTime? expiresAt,  bool isClosed,  bool isExpired,  bool isActive,  DateTime createdAt,  int totalVoters,  List<PollOptionEntity> options,  List<int> currentUserVotedOptionIds)?  $default,) {final _that = this;
switch (_that) {
case _PollEntity() when $default != null:
return $default(_that.id,_that.question,_that.conversationId,_that.creator,_that.allowMultipleVotes,_that.expiresAt,_that.isClosed,_that.isExpired,_that.isActive,_that.createdAt,_that.totalVoters,_that.options,_that.currentUserVotedOptionIds);case _:
  return null;

}
}

}

/// @nodoc


class _PollEntity extends PollEntity {
  const _PollEntity({required this.id, required this.question, required this.conversationId, required this.creator, required this.allowMultipleVotes, this.expiresAt, required this.isClosed, required this.isExpired, required this.isActive, required this.createdAt, required this.totalVoters, required final  List<PollOptionEntity> options, required final  List<int> currentUserVotedOptionIds}): _options = options,_currentUserVotedOptionIds = currentUserVotedOptionIds,super._();
  

@override final  int id;
@override final  String question;
@override final  int conversationId;
@override final  User creator;
@override final  bool allowMultipleVotes;
@override final  DateTime? expiresAt;
@override final  bool isClosed;
@override final  bool isExpired;
@override final  bool isActive;
@override final  DateTime createdAt;
@override final  int totalVoters;
 final  List<PollOptionEntity> _options;
@override List<PollOptionEntity> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

 final  List<int> _currentUserVotedOptionIds;
@override List<int> get currentUserVotedOptionIds {
  if (_currentUserVotedOptionIds is EqualUnmodifiableListView) return _currentUserVotedOptionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentUserVotedOptionIds);
}


/// Create a copy of PollEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollEntityCopyWith<_PollEntity> get copyWith => __$PollEntityCopyWithImpl<_PollEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.totalVoters, totalVoters) || other.totalVoters == totalVoters)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._currentUserVotedOptionIds, _currentUserVotedOptionIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,question,conversationId,creator,allowMultipleVotes,expiresAt,isClosed,isExpired,isActive,createdAt,totalVoters,const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_currentUserVotedOptionIds));

@override
String toString() {
  return 'PollEntity(id: $id, question: $question, conversationId: $conversationId, creator: $creator, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt, isClosed: $isClosed, isExpired: $isExpired, isActive: $isActive, createdAt: $createdAt, totalVoters: $totalVoters, options: $options, currentUserVotedOptionIds: $currentUserVotedOptionIds)';
}


}

/// @nodoc
abstract mixin class _$PollEntityCopyWith<$Res> implements $PollEntityCopyWith<$Res> {
  factory _$PollEntityCopyWith(_PollEntity value, $Res Function(_PollEntity) _then) = __$PollEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String question, int conversationId, User creator, bool allowMultipleVotes, DateTime? expiresAt, bool isClosed, bool isExpired, bool isActive, DateTime createdAt, int totalVoters, List<PollOptionEntity> options, List<int> currentUserVotedOptionIds
});


@override $UserCopyWith<$Res> get creator;

}
/// @nodoc
class __$PollEntityCopyWithImpl<$Res>
    implements _$PollEntityCopyWith<$Res> {
  __$PollEntityCopyWithImpl(this._self, this._then);

  final _PollEntity _self;
  final $Res Function(_PollEntity) _then;

/// Create a copy of PollEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? question = null,Object? conversationId = null,Object? creator = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,Object? isClosed = null,Object? isExpired = null,Object? isActive = null,Object? createdAt = null,Object? totalVoters = null,Object? options = null,Object? currentUserVotedOptionIds = null,}) {
  return _then(_PollEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as User,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalVoters: null == totalVoters ? _self.totalVoters : totalVoters // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<PollOptionEntity>,currentUserVotedOptionIds: null == currentUserVotedOptionIds ? _self._currentUserVotedOptionIds : currentUserVotedOptionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

/// Create a copy of PollEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get creator {
  
  return $UserCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}

// dart format on
