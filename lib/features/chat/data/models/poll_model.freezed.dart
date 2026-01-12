// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PollModel {

 int get id; String get question; int get conversationId; UserDto get creator; bool get allowMultipleVotes; DateTime? get expiresAt; bool get closed; bool get expired; bool get active; DateTime get createdAt; int get totalVoters; List<PollOptionModel> get options; List<int> get currentUserVotedOptionIds;
/// Create a copy of PollModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollModelCopyWith<PollModel> get copyWith => _$PollModelCopyWithImpl<PollModel>(this as PollModel, _$identity);

  /// Serializes this PollModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollModel&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.closed, closed) || other.closed == closed)&&(identical(other.expired, expired) || other.expired == expired)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.totalVoters, totalVoters) || other.totalVoters == totalVoters)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.currentUserVotedOptionIds, currentUserVotedOptionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,conversationId,creator,allowMultipleVotes,expiresAt,closed,expired,active,createdAt,totalVoters,const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(currentUserVotedOptionIds));

@override
String toString() {
  return 'PollModel(id: $id, question: $question, conversationId: $conversationId, creator: $creator, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt, closed: $closed, expired: $expired, active: $active, createdAt: $createdAt, totalVoters: $totalVoters, options: $options, currentUserVotedOptionIds: $currentUserVotedOptionIds)';
}


}

/// @nodoc
abstract mixin class $PollModelCopyWith<$Res>  {
  factory $PollModelCopyWith(PollModel value, $Res Function(PollModel) _then) = _$PollModelCopyWithImpl;
@useResult
$Res call({
 int id, String question, int conversationId, UserDto creator, bool allowMultipleVotes, DateTime? expiresAt, bool closed, bool expired, bool active, DateTime createdAt, int totalVoters, List<PollOptionModel> options, List<int> currentUserVotedOptionIds
});


$UserDtoCopyWith<$Res> get creator;

}
/// @nodoc
class _$PollModelCopyWithImpl<$Res>
    implements $PollModelCopyWith<$Res> {
  _$PollModelCopyWithImpl(this._self, this._then);

  final PollModel _self;
  final $Res Function(PollModel) _then;

/// Create a copy of PollModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? question = null,Object? conversationId = null,Object? creator = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,Object? closed = null,Object? expired = null,Object? active = null,Object? createdAt = null,Object? totalVoters = null,Object? options = null,Object? currentUserVotedOptionIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as UserDto,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closed: null == closed ? _self.closed : closed // ignore: cast_nullable_to_non_nullable
as bool,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalVoters: null == totalVoters ? _self.totalVoters : totalVoters // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<PollOptionModel>,currentUserVotedOptionIds: null == currentUserVotedOptionIds ? _self.currentUserVotedOptionIds : currentUserVotedOptionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}
/// Create a copy of PollModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get creator {
  
  return $UserDtoCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// Adds pattern-matching-related methods to [PollModel].
extension PollModelPatterns on PollModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollModel value)  $default,){
final _that = this;
switch (_that) {
case _PollModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollModel value)?  $default,){
final _that = this;
switch (_that) {
case _PollModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String question,  int conversationId,  UserDto creator,  bool allowMultipleVotes,  DateTime? expiresAt,  bool closed,  bool expired,  bool active,  DateTime createdAt,  int totalVoters,  List<PollOptionModel> options,  List<int> currentUserVotedOptionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollModel() when $default != null:
return $default(_that.id,_that.question,_that.conversationId,_that.creator,_that.allowMultipleVotes,_that.expiresAt,_that.closed,_that.expired,_that.active,_that.createdAt,_that.totalVoters,_that.options,_that.currentUserVotedOptionIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String question,  int conversationId,  UserDto creator,  bool allowMultipleVotes,  DateTime? expiresAt,  bool closed,  bool expired,  bool active,  DateTime createdAt,  int totalVoters,  List<PollOptionModel> options,  List<int> currentUserVotedOptionIds)  $default,) {final _that = this;
switch (_that) {
case _PollModel():
return $default(_that.id,_that.question,_that.conversationId,_that.creator,_that.allowMultipleVotes,_that.expiresAt,_that.closed,_that.expired,_that.active,_that.createdAt,_that.totalVoters,_that.options,_that.currentUserVotedOptionIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String question,  int conversationId,  UserDto creator,  bool allowMultipleVotes,  DateTime? expiresAt,  bool closed,  bool expired,  bool active,  DateTime createdAt,  int totalVoters,  List<PollOptionModel> options,  List<int> currentUserVotedOptionIds)?  $default,) {final _that = this;
switch (_that) {
case _PollModel() when $default != null:
return $default(_that.id,_that.question,_that.conversationId,_that.creator,_that.allowMultipleVotes,_that.expiresAt,_that.closed,_that.expired,_that.active,_that.createdAt,_that.totalVoters,_that.options,_that.currentUserVotedOptionIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollModel implements PollModel {
  const _PollModel({required this.id, required this.question, required this.conversationId, required this.creator, required this.allowMultipleVotes, this.expiresAt, this.closed = false, this.expired = false, this.active = true, required this.createdAt, this.totalVoters = 0, final  List<PollOptionModel> options = const [], final  List<int> currentUserVotedOptionIds = const []}): _options = options,_currentUserVotedOptionIds = currentUserVotedOptionIds;
  factory _PollModel.fromJson(Map<String, dynamic> json) => _$PollModelFromJson(json);

@override final  int id;
@override final  String question;
@override final  int conversationId;
@override final  UserDto creator;
@override final  bool allowMultipleVotes;
@override final  DateTime? expiresAt;
@override@JsonKey() final  bool closed;
@override@JsonKey() final  bool expired;
@override@JsonKey() final  bool active;
@override final  DateTime createdAt;
@override@JsonKey() final  int totalVoters;
 final  List<PollOptionModel> _options;
@override@JsonKey() List<PollOptionModel> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

 final  List<int> _currentUserVotedOptionIds;
@override@JsonKey() List<int> get currentUserVotedOptionIds {
  if (_currentUserVotedOptionIds is EqualUnmodifiableListView) return _currentUserVotedOptionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentUserVotedOptionIds);
}


/// Create a copy of PollModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollModelCopyWith<_PollModel> get copyWith => __$PollModelCopyWithImpl<_PollModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollModel&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.closed, closed) || other.closed == closed)&&(identical(other.expired, expired) || other.expired == expired)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.totalVoters, totalVoters) || other.totalVoters == totalVoters)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._currentUserVotedOptionIds, _currentUserVotedOptionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,conversationId,creator,allowMultipleVotes,expiresAt,closed,expired,active,createdAt,totalVoters,const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_currentUserVotedOptionIds));

@override
String toString() {
  return 'PollModel(id: $id, question: $question, conversationId: $conversationId, creator: $creator, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt, closed: $closed, expired: $expired, active: $active, createdAt: $createdAt, totalVoters: $totalVoters, options: $options, currentUserVotedOptionIds: $currentUserVotedOptionIds)';
}


}

/// @nodoc
abstract mixin class _$PollModelCopyWith<$Res> implements $PollModelCopyWith<$Res> {
  factory _$PollModelCopyWith(_PollModel value, $Res Function(_PollModel) _then) = __$PollModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String question, int conversationId, UserDto creator, bool allowMultipleVotes, DateTime? expiresAt, bool closed, bool expired, bool active, DateTime createdAt, int totalVoters, List<PollOptionModel> options, List<int> currentUserVotedOptionIds
});


@override $UserDtoCopyWith<$Res> get creator;

}
/// @nodoc
class __$PollModelCopyWithImpl<$Res>
    implements _$PollModelCopyWith<$Res> {
  __$PollModelCopyWithImpl(this._self, this._then);

  final _PollModel _self;
  final $Res Function(_PollModel) _then;

/// Create a copy of PollModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? question = null,Object? conversationId = null,Object? creator = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,Object? closed = null,Object? expired = null,Object? active = null,Object? createdAt = null,Object? totalVoters = null,Object? options = null,Object? currentUserVotedOptionIds = null,}) {
  return _then(_PollModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as UserDto,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closed: null == closed ? _self.closed : closed // ignore: cast_nullable_to_non_nullable
as bool,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalVoters: null == totalVoters ? _self.totalVoters : totalVoters // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<PollOptionModel>,currentUserVotedOptionIds: null == currentUserVotedOptionIds ? _self._currentUserVotedOptionIds : currentUserVotedOptionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

/// Create a copy of PollModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get creator {
  
  return $UserDtoCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// @nodoc
mixin _$PollOptionModel {

 int get id; String get optionText; int get optionOrder; int get voteCount; double get percentage; List<UserDto> get voters;
/// Create a copy of PollOptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollOptionModelCopyWith<PollOptionModel> get copyWith => _$PollOptionModelCopyWithImpl<PollOptionModel>(this as PollOptionModel, _$identity);

  /// Serializes this PollOptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollOptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.optionText, optionText) || other.optionText == optionText)&&(identical(other.optionOrder, optionOrder) || other.optionOrder == optionOrder)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other.voters, voters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,optionText,optionOrder,voteCount,percentage,const DeepCollectionEquality().hash(voters));

@override
String toString() {
  return 'PollOptionModel(id: $id, optionText: $optionText, optionOrder: $optionOrder, voteCount: $voteCount, percentage: $percentage, voters: $voters)';
}


}

/// @nodoc
abstract mixin class $PollOptionModelCopyWith<$Res>  {
  factory $PollOptionModelCopyWith(PollOptionModel value, $Res Function(PollOptionModel) _then) = _$PollOptionModelCopyWithImpl;
@useResult
$Res call({
 int id, String optionText, int optionOrder, int voteCount, double percentage, List<UserDto> voters
});




}
/// @nodoc
class _$PollOptionModelCopyWithImpl<$Res>
    implements $PollOptionModelCopyWith<$Res> {
  _$PollOptionModelCopyWithImpl(this._self, this._then);

  final PollOptionModel _self;
  final $Res Function(PollOptionModel) _then;

/// Create a copy of PollOptionModel
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


/// Adds pattern-matching-related methods to [PollOptionModel].
extension PollOptionModelPatterns on PollOptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollOptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollOptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollOptionModel value)  $default,){
final _that = this;
switch (_that) {
case _PollOptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollOptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _PollOptionModel() when $default != null:
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
case _PollOptionModel() when $default != null:
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
case _PollOptionModel():
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
case _PollOptionModel() when $default != null:
return $default(_that.id,_that.optionText,_that.optionOrder,_that.voteCount,_that.percentage,_that.voters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollOptionModel implements PollOptionModel {
  const _PollOptionModel({required this.id, required this.optionText, required this.optionOrder, this.voteCount = 0, this.percentage = 0.0, final  List<UserDto> voters = const []}): _voters = voters;
  factory _PollOptionModel.fromJson(Map<String, dynamic> json) => _$PollOptionModelFromJson(json);

@override final  int id;
@override final  String optionText;
@override final  int optionOrder;
@override@JsonKey() final  int voteCount;
@override@JsonKey() final  double percentage;
 final  List<UserDto> _voters;
@override@JsonKey() List<UserDto> get voters {
  if (_voters is EqualUnmodifiableListView) return _voters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_voters);
}


/// Create a copy of PollOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollOptionModelCopyWith<_PollOptionModel> get copyWith => __$PollOptionModelCopyWithImpl<_PollOptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollOptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollOptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.optionText, optionText) || other.optionText == optionText)&&(identical(other.optionOrder, optionOrder) || other.optionOrder == optionOrder)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other._voters, _voters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,optionText,optionOrder,voteCount,percentage,const DeepCollectionEquality().hash(_voters));

@override
String toString() {
  return 'PollOptionModel(id: $id, optionText: $optionText, optionOrder: $optionOrder, voteCount: $voteCount, percentage: $percentage, voters: $voters)';
}


}

/// @nodoc
abstract mixin class _$PollOptionModelCopyWith<$Res> implements $PollOptionModelCopyWith<$Res> {
  factory _$PollOptionModelCopyWith(_PollOptionModel value, $Res Function(_PollOptionModel) _then) = __$PollOptionModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String optionText, int optionOrder, int voteCount, double percentage, List<UserDto> voters
});




}
/// @nodoc
class __$PollOptionModelCopyWithImpl<$Res>
    implements _$PollOptionModelCopyWith<$Res> {
  __$PollOptionModelCopyWithImpl(this._self, this._then);

  final _PollOptionModel _self;
  final $Res Function(_PollOptionModel) _then;

/// Create a copy of PollOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? optionText = null,Object? optionOrder = null,Object? voteCount = null,Object? percentage = null,Object? voters = null,}) {
  return _then(_PollOptionModel(
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


/// @nodoc
mixin _$CreatePollRequest {

 String get question; List<String> get options; bool get allowMultipleVotes;@JsonKey(toJson: _dateTimeToUtcString) DateTime? get expiresAt;
/// Create a copy of CreatePollRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePollRequestCopyWith<CreatePollRequest> get copyWith => _$CreatePollRequestCopyWithImpl<CreatePollRequest>(this as CreatePollRequest, _$identity);

  /// Serializes this CreatePollRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePollRequest&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,const DeepCollectionEquality().hash(options),allowMultipleVotes,expiresAt);

@override
String toString() {
  return 'CreatePollRequest(question: $question, options: $options, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $CreatePollRequestCopyWith<$Res>  {
  factory $CreatePollRequestCopyWith(CreatePollRequest value, $Res Function(CreatePollRequest) _then) = _$CreatePollRequestCopyWithImpl;
@useResult
$Res call({
 String question, List<String> options, bool allowMultipleVotes,@JsonKey(toJson: _dateTimeToUtcString) DateTime? expiresAt
});




}
/// @nodoc
class _$CreatePollRequestCopyWithImpl<$Res>
    implements $CreatePollRequestCopyWith<$Res> {
  _$CreatePollRequestCopyWithImpl(this._self, this._then);

  final CreatePollRequest _self;
  final $Res Function(CreatePollRequest) _then;

/// Create a copy of CreatePollRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? options = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePollRequest].
extension CreatePollRequestPatterns on CreatePollRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePollRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePollRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePollRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreatePollRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePollRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePollRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  List<String> options,  bool allowMultipleVotes, @JsonKey(toJson: _dateTimeToUtcString)  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePollRequest() when $default != null:
return $default(_that.question,_that.options,_that.allowMultipleVotes,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  List<String> options,  bool allowMultipleVotes, @JsonKey(toJson: _dateTimeToUtcString)  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _CreatePollRequest():
return $default(_that.question,_that.options,_that.allowMultipleVotes,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  List<String> options,  bool allowMultipleVotes, @JsonKey(toJson: _dateTimeToUtcString)  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _CreatePollRequest() when $default != null:
return $default(_that.question,_that.options,_that.allowMultipleVotes,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePollRequest implements CreatePollRequest {
  const _CreatePollRequest({required this.question, required final  List<String> options, this.allowMultipleVotes = false, @JsonKey(toJson: _dateTimeToUtcString) this.expiresAt}): _options = options;
  factory _CreatePollRequest.fromJson(Map<String, dynamic> json) => _$CreatePollRequestFromJson(json);

@override final  String question;
 final  List<String> _options;
@override List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override@JsonKey() final  bool allowMultipleVotes;
@override@JsonKey(toJson: _dateTimeToUtcString) final  DateTime? expiresAt;

/// Create a copy of CreatePollRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePollRequestCopyWith<_CreatePollRequest> get copyWith => __$CreatePollRequestCopyWithImpl<_CreatePollRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePollRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePollRequest&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,const DeepCollectionEquality().hash(_options),allowMultipleVotes,expiresAt);

@override
String toString() {
  return 'CreatePollRequest(question: $question, options: $options, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$CreatePollRequestCopyWith<$Res> implements $CreatePollRequestCopyWith<$Res> {
  factory _$CreatePollRequestCopyWith(_CreatePollRequest value, $Res Function(_CreatePollRequest) _then) = __$CreatePollRequestCopyWithImpl;
@override @useResult
$Res call({
 String question, List<String> options, bool allowMultipleVotes,@JsonKey(toJson: _dateTimeToUtcString) DateTime? expiresAt
});




}
/// @nodoc
class __$CreatePollRequestCopyWithImpl<$Res>
    implements _$CreatePollRequestCopyWith<$Res> {
  __$CreatePollRequestCopyWithImpl(this._self, this._then);

  final _CreatePollRequest _self;
  final $Res Function(_CreatePollRequest) _then;

/// Create a copy of CreatePollRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? options = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,}) {
  return _then(_CreatePollRequest(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$VotePollRequest {

 List<int> get optionIds;
/// Create a copy of VotePollRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VotePollRequestCopyWith<VotePollRequest> get copyWith => _$VotePollRequestCopyWithImpl<VotePollRequest>(this as VotePollRequest, _$identity);

  /// Serializes this VotePollRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VotePollRequest&&const DeepCollectionEquality().equals(other.optionIds, optionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(optionIds));

@override
String toString() {
  return 'VotePollRequest(optionIds: $optionIds)';
}


}

/// @nodoc
abstract mixin class $VotePollRequestCopyWith<$Res>  {
  factory $VotePollRequestCopyWith(VotePollRequest value, $Res Function(VotePollRequest) _then) = _$VotePollRequestCopyWithImpl;
@useResult
$Res call({
 List<int> optionIds
});




}
/// @nodoc
class _$VotePollRequestCopyWithImpl<$Res>
    implements $VotePollRequestCopyWith<$Res> {
  _$VotePollRequestCopyWithImpl(this._self, this._then);

  final VotePollRequest _self;
  final $Res Function(VotePollRequest) _then;

/// Create a copy of VotePollRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? optionIds = null,}) {
  return _then(_self.copyWith(
optionIds: null == optionIds ? _self.optionIds : optionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [VotePollRequest].
extension VotePollRequestPatterns on VotePollRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VotePollRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VotePollRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VotePollRequest value)  $default,){
final _that = this;
switch (_that) {
case _VotePollRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VotePollRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VotePollRequest() when $default != null:
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
case _VotePollRequest() when $default != null:
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
case _VotePollRequest():
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
case _VotePollRequest() when $default != null:
return $default(_that.optionIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VotePollRequest implements VotePollRequest {
  const _VotePollRequest({required final  List<int> optionIds}): _optionIds = optionIds;
  factory _VotePollRequest.fromJson(Map<String, dynamic> json) => _$VotePollRequestFromJson(json);

 final  List<int> _optionIds;
@override List<int> get optionIds {
  if (_optionIds is EqualUnmodifiableListView) return _optionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_optionIds);
}


/// Create a copy of VotePollRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VotePollRequestCopyWith<_VotePollRequest> get copyWith => __$VotePollRequestCopyWithImpl<_VotePollRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VotePollRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VotePollRequest&&const DeepCollectionEquality().equals(other._optionIds, _optionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_optionIds));

@override
String toString() {
  return 'VotePollRequest(optionIds: $optionIds)';
}


}

/// @nodoc
abstract mixin class _$VotePollRequestCopyWith<$Res> implements $VotePollRequestCopyWith<$Res> {
  factory _$VotePollRequestCopyWith(_VotePollRequest value, $Res Function(_VotePollRequest) _then) = __$VotePollRequestCopyWithImpl;
@override @useResult
$Res call({
 List<int> optionIds
});




}
/// @nodoc
class __$VotePollRequestCopyWithImpl<$Res>
    implements _$VotePollRequestCopyWith<$Res> {
  __$VotePollRequestCopyWithImpl(this._self, this._then);

  final _VotePollRequest _self;
  final $Res Function(_VotePollRequest) _then;

/// Create a copy of VotePollRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? optionIds = null,}) {
  return _then(_VotePollRequest(
optionIds: null == optionIds ? _self._optionIds : optionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$RemoveVoteRequest {

 List<int> get optionIds;
/// Create a copy of RemoveVoteRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveVoteRequestCopyWith<RemoveVoteRequest> get copyWith => _$RemoveVoteRequestCopyWithImpl<RemoveVoteRequest>(this as RemoveVoteRequest, _$identity);

  /// Serializes this RemoveVoteRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveVoteRequest&&const DeepCollectionEquality().equals(other.optionIds, optionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(optionIds));

@override
String toString() {
  return 'RemoveVoteRequest(optionIds: $optionIds)';
}


}

/// @nodoc
abstract mixin class $RemoveVoteRequestCopyWith<$Res>  {
  factory $RemoveVoteRequestCopyWith(RemoveVoteRequest value, $Res Function(RemoveVoteRequest) _then) = _$RemoveVoteRequestCopyWithImpl;
@useResult
$Res call({
 List<int> optionIds
});




}
/// @nodoc
class _$RemoveVoteRequestCopyWithImpl<$Res>
    implements $RemoveVoteRequestCopyWith<$Res> {
  _$RemoveVoteRequestCopyWithImpl(this._self, this._then);

  final RemoveVoteRequest _self;
  final $Res Function(RemoveVoteRequest) _then;

/// Create a copy of RemoveVoteRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? optionIds = null,}) {
  return _then(_self.copyWith(
optionIds: null == optionIds ? _self.optionIds : optionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [RemoveVoteRequest].
extension RemoveVoteRequestPatterns on RemoveVoteRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemoveVoteRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemoveVoteRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemoveVoteRequest value)  $default,){
final _that = this;
switch (_that) {
case _RemoveVoteRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemoveVoteRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RemoveVoteRequest() when $default != null:
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
case _RemoveVoteRequest() when $default != null:
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
case _RemoveVoteRequest():
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
case _RemoveVoteRequest() when $default != null:
return $default(_that.optionIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemoveVoteRequest implements RemoveVoteRequest {
  const _RemoveVoteRequest({required final  List<int> optionIds}): _optionIds = optionIds;
  factory _RemoveVoteRequest.fromJson(Map<String, dynamic> json) => _$RemoveVoteRequestFromJson(json);

 final  List<int> _optionIds;
@override List<int> get optionIds {
  if (_optionIds is EqualUnmodifiableListView) return _optionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_optionIds);
}


/// Create a copy of RemoveVoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveVoteRequestCopyWith<_RemoveVoteRequest> get copyWith => __$RemoveVoteRequestCopyWithImpl<_RemoveVoteRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemoveVoteRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveVoteRequest&&const DeepCollectionEquality().equals(other._optionIds, _optionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_optionIds));

@override
String toString() {
  return 'RemoveVoteRequest(optionIds: $optionIds)';
}


}

/// @nodoc
abstract mixin class _$RemoveVoteRequestCopyWith<$Res> implements $RemoveVoteRequestCopyWith<$Res> {
  factory _$RemoveVoteRequestCopyWith(_RemoveVoteRequest value, $Res Function(_RemoveVoteRequest) _then) = __$RemoveVoteRequestCopyWithImpl;
@override @useResult
$Res call({
 List<int> optionIds
});




}
/// @nodoc
class __$RemoveVoteRequestCopyWithImpl<$Res>
    implements _$RemoveVoteRequestCopyWith<$Res> {
  __$RemoveVoteRequestCopyWithImpl(this._self, this._then);

  final _RemoveVoteRequest _self;
  final $Res Function(_RemoveVoteRequest) _then;

/// Create a copy of RemoveVoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? optionIds = null,}) {
  return _then(_RemoveVoteRequest(
optionIds: null == optionIds ? _self._optionIds : optionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
