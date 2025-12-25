// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Poll {

 int get id; String get question; int get conversationId; User get creator; bool get allowMultipleVotes; DateTime? get expiresAt; bool get closed; bool get expired; bool get active; DateTime get createdAt; int get totalVoters; List<PollOption> get options; List<int> get currentUserVotedOptionIds;
/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollCopyWith<Poll> get copyWith => _$PollCopyWithImpl<Poll>(this as Poll, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Poll&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.closed, closed) || other.closed == closed)&&(identical(other.expired, expired) || other.expired == expired)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.totalVoters, totalVoters) || other.totalVoters == totalVoters)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.currentUserVotedOptionIds, currentUserVotedOptionIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,question,conversationId,creator,allowMultipleVotes,expiresAt,closed,expired,active,createdAt,totalVoters,const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(currentUserVotedOptionIds));

@override
String toString() {
  return 'Poll(id: $id, question: $question, conversationId: $conversationId, creator: $creator, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt, closed: $closed, expired: $expired, active: $active, createdAt: $createdAt, totalVoters: $totalVoters, options: $options, currentUserVotedOptionIds: $currentUserVotedOptionIds)';
}


}

/// @nodoc
abstract mixin class $PollCopyWith<$Res>  {
  factory $PollCopyWith(Poll value, $Res Function(Poll) _then) = _$PollCopyWithImpl;
@useResult
$Res call({
 int id, String question, int conversationId, User creator, bool allowMultipleVotes, DateTime? expiresAt, bool closed, bool expired, bool active, DateTime createdAt, int totalVoters, List<PollOption> options, List<int> currentUserVotedOptionIds
});


$UserCopyWith<$Res> get creator;

}
/// @nodoc
class _$PollCopyWithImpl<$Res>
    implements $PollCopyWith<$Res> {
  _$PollCopyWithImpl(this._self, this._then);

  final Poll _self;
  final $Res Function(Poll) _then;

/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? question = null,Object? conversationId = null,Object? creator = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,Object? closed = null,Object? expired = null,Object? active = null,Object? createdAt = null,Object? totalVoters = null,Object? options = null,Object? currentUserVotedOptionIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as User,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closed: null == closed ? _self.closed : closed // ignore: cast_nullable_to_non_nullable
as bool,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalVoters: null == totalVoters ? _self.totalVoters : totalVoters // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<PollOption>,currentUserVotedOptionIds: null == currentUserVotedOptionIds ? _self.currentUserVotedOptionIds : currentUserVotedOptionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}
/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get creator {
  
  return $UserCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// Adds pattern-matching-related methods to [Poll].
extension PollPatterns on Poll {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Poll value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Poll() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Poll value)  $default,){
final _that = this;
switch (_that) {
case _Poll():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Poll value)?  $default,){
final _that = this;
switch (_that) {
case _Poll() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String question,  int conversationId,  User creator,  bool allowMultipleVotes,  DateTime? expiresAt,  bool closed,  bool expired,  bool active,  DateTime createdAt,  int totalVoters,  List<PollOption> options,  List<int> currentUserVotedOptionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Poll() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String question,  int conversationId,  User creator,  bool allowMultipleVotes,  DateTime? expiresAt,  bool closed,  bool expired,  bool active,  DateTime createdAt,  int totalVoters,  List<PollOption> options,  List<int> currentUserVotedOptionIds)  $default,) {final _that = this;
switch (_that) {
case _Poll():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String question,  int conversationId,  User creator,  bool allowMultipleVotes,  DateTime? expiresAt,  bool closed,  bool expired,  bool active,  DateTime createdAt,  int totalVoters,  List<PollOption> options,  List<int> currentUserVotedOptionIds)?  $default,) {final _that = this;
switch (_that) {
case _Poll() when $default != null:
return $default(_that.id,_that.question,_that.conversationId,_that.creator,_that.allowMultipleVotes,_that.expiresAt,_that.closed,_that.expired,_that.active,_that.createdAt,_that.totalVoters,_that.options,_that.currentUserVotedOptionIds);case _:
  return null;

}
}

}

/// @nodoc


class _Poll implements Poll {
  const _Poll({required this.id, required this.question, required this.conversationId, required this.creator, required this.allowMultipleVotes, this.expiresAt, required this.closed, required this.expired, required this.active, required this.createdAt, required this.totalVoters, required final  List<PollOption> options, required final  List<int> currentUserVotedOptionIds}): _options = options,_currentUserVotedOptionIds = currentUserVotedOptionIds;
  

@override final  int id;
@override final  String question;
@override final  int conversationId;
@override final  User creator;
@override final  bool allowMultipleVotes;
@override final  DateTime? expiresAt;
@override final  bool closed;
@override final  bool expired;
@override final  bool active;
@override final  DateTime createdAt;
@override final  int totalVoters;
 final  List<PollOption> _options;
@override List<PollOption> get options {
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


/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollCopyWith<_Poll> get copyWith => __$PollCopyWithImpl<_Poll>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Poll&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.closed, closed) || other.closed == closed)&&(identical(other.expired, expired) || other.expired == expired)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.totalVoters, totalVoters) || other.totalVoters == totalVoters)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._currentUserVotedOptionIds, _currentUserVotedOptionIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,question,conversationId,creator,allowMultipleVotes,expiresAt,closed,expired,active,createdAt,totalVoters,const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_currentUserVotedOptionIds));

@override
String toString() {
  return 'Poll(id: $id, question: $question, conversationId: $conversationId, creator: $creator, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt, closed: $closed, expired: $expired, active: $active, createdAt: $createdAt, totalVoters: $totalVoters, options: $options, currentUserVotedOptionIds: $currentUserVotedOptionIds)';
}


}

/// @nodoc
abstract mixin class _$PollCopyWith<$Res> implements $PollCopyWith<$Res> {
  factory _$PollCopyWith(_Poll value, $Res Function(_Poll) _then) = __$PollCopyWithImpl;
@override @useResult
$Res call({
 int id, String question, int conversationId, User creator, bool allowMultipleVotes, DateTime? expiresAt, bool closed, bool expired, bool active, DateTime createdAt, int totalVoters, List<PollOption> options, List<int> currentUserVotedOptionIds
});


@override $UserCopyWith<$Res> get creator;

}
/// @nodoc
class __$PollCopyWithImpl<$Res>
    implements _$PollCopyWith<$Res> {
  __$PollCopyWithImpl(this._self, this._then);

  final _Poll _self;
  final $Res Function(_Poll) _then;

/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? question = null,Object? conversationId = null,Object? creator = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,Object? closed = null,Object? expired = null,Object? active = null,Object? createdAt = null,Object? totalVoters = null,Object? options = null,Object? currentUserVotedOptionIds = null,}) {
  return _then(_Poll(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as User,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closed: null == closed ? _self.closed : closed // ignore: cast_nullable_to_non_nullable
as bool,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalVoters: null == totalVoters ? _self.totalVoters : totalVoters // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<PollOption>,currentUserVotedOptionIds: null == currentUserVotedOptionIds ? _self._currentUserVotedOptionIds : currentUserVotedOptionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

/// Create a copy of Poll
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get creator {
  
  return $UserCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}

/// @nodoc
mixin _$PollOption {

 int get id; String get optionText; int get optionOrder; int get voteCount; double get percentage; List<User> get voters;
/// Create a copy of PollOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollOptionCopyWith<PollOption> get copyWith => _$PollOptionCopyWithImpl<PollOption>(this as PollOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollOption&&(identical(other.id, id) || other.id == id)&&(identical(other.optionText, optionText) || other.optionText == optionText)&&(identical(other.optionOrder, optionOrder) || other.optionOrder == optionOrder)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other.voters, voters));
}


@override
int get hashCode => Object.hash(runtimeType,id,optionText,optionOrder,voteCount,percentage,const DeepCollectionEquality().hash(voters));

@override
String toString() {
  return 'PollOption(id: $id, optionText: $optionText, optionOrder: $optionOrder, voteCount: $voteCount, percentage: $percentage, voters: $voters)';
}


}

/// @nodoc
abstract mixin class $PollOptionCopyWith<$Res>  {
  factory $PollOptionCopyWith(PollOption value, $Res Function(PollOption) _then) = _$PollOptionCopyWithImpl;
@useResult
$Res call({
 int id, String optionText, int optionOrder, int voteCount, double percentage, List<User> voters
});




}
/// @nodoc
class _$PollOptionCopyWithImpl<$Res>
    implements $PollOptionCopyWith<$Res> {
  _$PollOptionCopyWithImpl(this._self, this._then);

  final PollOption _self;
  final $Res Function(PollOption) _then;

/// Create a copy of PollOption
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


/// Adds pattern-matching-related methods to [PollOption].
extension PollOptionPatterns on PollOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollOption value)  $default,){
final _that = this;
switch (_that) {
case _PollOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollOption value)?  $default,){
final _that = this;
switch (_that) {
case _PollOption() when $default != null:
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
case _PollOption() when $default != null:
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
case _PollOption():
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
case _PollOption() when $default != null:
return $default(_that.id,_that.optionText,_that.optionOrder,_that.voteCount,_that.percentage,_that.voters);case _:
  return null;

}
}

}

/// @nodoc


class _PollOption implements PollOption {
  const _PollOption({required this.id, required this.optionText, required this.optionOrder, required this.voteCount, required this.percentage, required final  List<User> voters}): _voters = voters;
  

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


/// Create a copy of PollOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollOptionCopyWith<_PollOption> get copyWith => __$PollOptionCopyWithImpl<_PollOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollOption&&(identical(other.id, id) || other.id == id)&&(identical(other.optionText, optionText) || other.optionText == optionText)&&(identical(other.optionOrder, optionOrder) || other.optionOrder == optionOrder)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other._voters, _voters));
}


@override
int get hashCode => Object.hash(runtimeType,id,optionText,optionOrder,voteCount,percentage,const DeepCollectionEquality().hash(_voters));

@override
String toString() {
  return 'PollOption(id: $id, optionText: $optionText, optionOrder: $optionOrder, voteCount: $voteCount, percentage: $percentage, voters: $voters)';
}


}

/// @nodoc
abstract mixin class _$PollOptionCopyWith<$Res> implements $PollOptionCopyWith<$Res> {
  factory _$PollOptionCopyWith(_PollOption value, $Res Function(_PollOption) _then) = __$PollOptionCopyWithImpl;
@override @useResult
$Res call({
 int id, String optionText, int optionOrder, int voteCount, double percentage, List<User> voters
});




}
/// @nodoc
class __$PollOptionCopyWithImpl<$Res>
    implements _$PollOptionCopyWith<$Res> {
  __$PollOptionCopyWithImpl(this._self, this._then);

  final _PollOption _self;
  final $Res Function(_PollOption) _then;

/// Create a copy of PollOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? optionText = null,Object? optionOrder = null,Object? voteCount = null,Object? percentage = null,Object? voters = null,}) {
  return _then(_PollOption(
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
