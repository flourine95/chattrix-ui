// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PollDto {

 int get id; String get question; int get conversationId; UserDto get creator; bool get allowMultipleVotes; DateTime? get expiresAt;@JsonKey(name: 'closed') bool get isClosed;@JsonKey(name: 'expired') bool get isExpired;@JsonKey(name: 'active') bool get isActive; DateTime get createdAt; int get totalVoters; List<PollOptionDto> get options; List<int> get currentUserVotedOptionIds;
/// Create a copy of PollDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollDtoCopyWith<PollDto> get copyWith => _$PollDtoCopyWithImpl<PollDto>(this as PollDto, _$identity);

  /// Serializes this PollDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollDto&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.totalVoters, totalVoters) || other.totalVoters == totalVoters)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.currentUserVotedOptionIds, currentUserVotedOptionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,conversationId,creator,allowMultipleVotes,expiresAt,isClosed,isExpired,isActive,createdAt,totalVoters,const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(currentUserVotedOptionIds));

@override
String toString() {
  return 'PollDto(id: $id, question: $question, conversationId: $conversationId, creator: $creator, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt, isClosed: $isClosed, isExpired: $isExpired, isActive: $isActive, createdAt: $createdAt, totalVoters: $totalVoters, options: $options, currentUserVotedOptionIds: $currentUserVotedOptionIds)';
}


}

/// @nodoc
abstract mixin class $PollDtoCopyWith<$Res>  {
  factory $PollDtoCopyWith(PollDto value, $Res Function(PollDto) _then) = _$PollDtoCopyWithImpl;
@useResult
$Res call({
 int id, String question, int conversationId, UserDto creator, bool allowMultipleVotes, DateTime? expiresAt,@JsonKey(name: 'closed') bool isClosed,@JsonKey(name: 'expired') bool isExpired,@JsonKey(name: 'active') bool isActive, DateTime createdAt, int totalVoters, List<PollOptionDto> options, List<int> currentUserVotedOptionIds
});


$UserDtoCopyWith<$Res> get creator;

}
/// @nodoc
class _$PollDtoCopyWithImpl<$Res>
    implements $PollDtoCopyWith<$Res> {
  _$PollDtoCopyWithImpl(this._self, this._then);

  final PollDto _self;
  final $Res Function(PollDto) _then;

/// Create a copy of PollDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? question = null,Object? conversationId = null,Object? creator = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,Object? isClosed = null,Object? isExpired = null,Object? isActive = null,Object? createdAt = null,Object? totalVoters = null,Object? options = null,Object? currentUserVotedOptionIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as UserDto,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalVoters: null == totalVoters ? _self.totalVoters : totalVoters // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<PollOptionDto>,currentUserVotedOptionIds: null == currentUserVotedOptionIds ? _self.currentUserVotedOptionIds : currentUserVotedOptionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}
/// Create a copy of PollDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get creator {
  
  return $UserDtoCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// Adds pattern-matching-related methods to [PollDto].
extension PollDtoPatterns on PollDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollDto value)  $default,){
final _that = this;
switch (_that) {
case _PollDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollDto value)?  $default,){
final _that = this;
switch (_that) {
case _PollDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String question,  int conversationId,  UserDto creator,  bool allowMultipleVotes,  DateTime? expiresAt, @JsonKey(name: 'closed')  bool isClosed, @JsonKey(name: 'expired')  bool isExpired, @JsonKey(name: 'active')  bool isActive,  DateTime createdAt,  int totalVoters,  List<PollOptionDto> options,  List<int> currentUserVotedOptionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String question,  int conversationId,  UserDto creator,  bool allowMultipleVotes,  DateTime? expiresAt, @JsonKey(name: 'closed')  bool isClosed, @JsonKey(name: 'expired')  bool isExpired, @JsonKey(name: 'active')  bool isActive,  DateTime createdAt,  int totalVoters,  List<PollOptionDto> options,  List<int> currentUserVotedOptionIds)  $default,) {final _that = this;
switch (_that) {
case _PollDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String question,  int conversationId,  UserDto creator,  bool allowMultipleVotes,  DateTime? expiresAt, @JsonKey(name: 'closed')  bool isClosed, @JsonKey(name: 'expired')  bool isExpired, @JsonKey(name: 'active')  bool isActive,  DateTime createdAt,  int totalVoters,  List<PollOptionDto> options,  List<int> currentUserVotedOptionIds)?  $default,) {final _that = this;
switch (_that) {
case _PollDto() when $default != null:
return $default(_that.id,_that.question,_that.conversationId,_that.creator,_that.allowMultipleVotes,_that.expiresAt,_that.isClosed,_that.isExpired,_that.isActive,_that.createdAt,_that.totalVoters,_that.options,_that.currentUserVotedOptionIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollDto implements PollDto {
  const _PollDto({required this.id, required this.question, required this.conversationId, required this.creator, required this.allowMultipleVotes, this.expiresAt, @JsonKey(name: 'closed') this.isClosed = false, @JsonKey(name: 'expired') this.isExpired = false, @JsonKey(name: 'active') this.isActive = true, required this.createdAt, required this.totalVoters, required final  List<PollOptionDto> options, required final  List<int> currentUserVotedOptionIds}): _options = options,_currentUserVotedOptionIds = currentUserVotedOptionIds;
  factory _PollDto.fromJson(Map<String, dynamic> json) => _$PollDtoFromJson(json);

@override final  int id;
@override final  String question;
@override final  int conversationId;
@override final  UserDto creator;
@override final  bool allowMultipleVotes;
@override final  DateTime? expiresAt;
@override@JsonKey(name: 'closed') final  bool isClosed;
@override@JsonKey(name: 'expired') final  bool isExpired;
@override@JsonKey(name: 'active') final  bool isActive;
@override final  DateTime createdAt;
@override final  int totalVoters;
 final  List<PollOptionDto> _options;
@override List<PollOptionDto> get options {
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


/// Create a copy of PollDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollDtoCopyWith<_PollDto> get copyWith => __$PollDtoCopyWithImpl<_PollDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollDto&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.totalVoters, totalVoters) || other.totalVoters == totalVoters)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._currentUserVotedOptionIds, _currentUserVotedOptionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,conversationId,creator,allowMultipleVotes,expiresAt,isClosed,isExpired,isActive,createdAt,totalVoters,const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_currentUserVotedOptionIds));

@override
String toString() {
  return 'PollDto(id: $id, question: $question, conversationId: $conversationId, creator: $creator, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt, isClosed: $isClosed, isExpired: $isExpired, isActive: $isActive, createdAt: $createdAt, totalVoters: $totalVoters, options: $options, currentUserVotedOptionIds: $currentUserVotedOptionIds)';
}


}

/// @nodoc
abstract mixin class _$PollDtoCopyWith<$Res> implements $PollDtoCopyWith<$Res> {
  factory _$PollDtoCopyWith(_PollDto value, $Res Function(_PollDto) _then) = __$PollDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String question, int conversationId, UserDto creator, bool allowMultipleVotes, DateTime? expiresAt,@JsonKey(name: 'closed') bool isClosed,@JsonKey(name: 'expired') bool isExpired,@JsonKey(name: 'active') bool isActive, DateTime createdAt, int totalVoters, List<PollOptionDto> options, List<int> currentUserVotedOptionIds
});


@override $UserDtoCopyWith<$Res> get creator;

}
/// @nodoc
class __$PollDtoCopyWithImpl<$Res>
    implements _$PollDtoCopyWith<$Res> {
  __$PollDtoCopyWithImpl(this._self, this._then);

  final _PollDto _self;
  final $Res Function(_PollDto) _then;

/// Create a copy of PollDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? question = null,Object? conversationId = null,Object? creator = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,Object? isClosed = null,Object? isExpired = null,Object? isActive = null,Object? createdAt = null,Object? totalVoters = null,Object? options = null,Object? currentUserVotedOptionIds = null,}) {
  return _then(_PollDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as UserDto,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalVoters: null == totalVoters ? _self.totalVoters : totalVoters // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<PollOptionDto>,currentUserVotedOptionIds: null == currentUserVotedOptionIds ? _self._currentUserVotedOptionIds : currentUserVotedOptionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

/// Create a copy of PollDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get creator {
  
  return $UserDtoCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}

// dart format on
