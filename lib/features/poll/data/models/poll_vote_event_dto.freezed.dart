// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_vote_event_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PollVoteEventDto {

 int get messageId; String get question; List<PollVoteOptionDto> get options; bool get allowMultiple; bool get anonymous; String? get closesAt; bool get isClosed; int get totalVotes; int get createdBy; String get createdByUsername; String get createdAt;
/// Create a copy of PollVoteEventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollVoteEventDtoCopyWith<PollVoteEventDto> get copyWith => _$PollVoteEventDtoCopyWithImpl<PollVoteEventDto>(this as PollVoteEventDto, _$identity);

  /// Serializes this PollVoteEventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollVoteEventDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.allowMultiple, allowMultiple) || other.allowMultiple == allowMultiple)&&(identical(other.anonymous, anonymous) || other.anonymous == anonymous)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.totalVotes, totalVotes) || other.totalVotes == totalVotes)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,question,const DeepCollectionEquality().hash(options),allowMultiple,anonymous,closesAt,isClosed,totalVotes,createdBy,createdByUsername,createdAt);

@override
String toString() {
  return 'PollVoteEventDto(messageId: $messageId, question: $question, options: $options, allowMultiple: $allowMultiple, anonymous: $anonymous, closesAt: $closesAt, isClosed: $isClosed, totalVotes: $totalVotes, createdBy: $createdBy, createdByUsername: $createdByUsername, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PollVoteEventDtoCopyWith<$Res>  {
  factory $PollVoteEventDtoCopyWith(PollVoteEventDto value, $Res Function(PollVoteEventDto) _then) = _$PollVoteEventDtoCopyWithImpl;
@useResult
$Res call({
 int messageId, String question, List<PollVoteOptionDto> options, bool allowMultiple, bool anonymous, String? closesAt, bool isClosed, int totalVotes, int createdBy, String createdByUsername, String createdAt
});




}
/// @nodoc
class _$PollVoteEventDtoCopyWithImpl<$Res>
    implements $PollVoteEventDtoCopyWith<$Res> {
  _$PollVoteEventDtoCopyWithImpl(this._self, this._then);

  final PollVoteEventDto _self;
  final $Res Function(PollVoteEventDto) _then;

/// Create a copy of PollVoteEventDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? question = null,Object? options = null,Object? allowMultiple = null,Object? anonymous = null,Object? closesAt = freezed,Object? isClosed = null,Object? totalVotes = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<PollVoteOptionDto>,allowMultiple: null == allowMultiple ? _self.allowMultiple : allowMultiple // ignore: cast_nullable_to_non_nullable
as bool,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as String?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,totalVotes: null == totalVotes ? _self.totalVotes : totalVotes // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PollVoteEventDto].
extension PollVoteEventDtoPatterns on PollVoteEventDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollVoteEventDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollVoteEventDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollVoteEventDto value)  $default,){
final _that = this;
switch (_that) {
case _PollVoteEventDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollVoteEventDto value)?  $default,){
final _that = this;
switch (_that) {
case _PollVoteEventDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int messageId,  String question,  List<PollVoteOptionDto> options,  bool allowMultiple,  bool anonymous,  String? closesAt,  bool isClosed,  int totalVotes,  int createdBy,  String createdByUsername,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollVoteEventDto() when $default != null:
return $default(_that.messageId,_that.question,_that.options,_that.allowMultiple,_that.anonymous,_that.closesAt,_that.isClosed,_that.totalVotes,_that.createdBy,_that.createdByUsername,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int messageId,  String question,  List<PollVoteOptionDto> options,  bool allowMultiple,  bool anonymous,  String? closesAt,  bool isClosed,  int totalVotes,  int createdBy,  String createdByUsername,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _PollVoteEventDto():
return $default(_that.messageId,_that.question,_that.options,_that.allowMultiple,_that.anonymous,_that.closesAt,_that.isClosed,_that.totalVotes,_that.createdBy,_that.createdByUsername,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int messageId,  String question,  List<PollVoteOptionDto> options,  bool allowMultiple,  bool anonymous,  String? closesAt,  bool isClosed,  int totalVotes,  int createdBy,  String createdByUsername,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PollVoteEventDto() when $default != null:
return $default(_that.messageId,_that.question,_that.options,_that.allowMultiple,_that.anonymous,_that.closesAt,_that.isClosed,_that.totalVotes,_that.createdBy,_that.createdByUsername,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollVoteEventDto implements PollVoteEventDto {
  const _PollVoteEventDto({required this.messageId, required this.question, required final  List<PollVoteOptionDto> options, required this.allowMultiple, required this.anonymous, this.closesAt, this.isClosed = false, required this.totalVotes, required this.createdBy, required this.createdByUsername, required this.createdAt}): _options = options;
  factory _PollVoteEventDto.fromJson(Map<String, dynamic> json) => _$PollVoteEventDtoFromJson(json);

@override final  int messageId;
@override final  String question;
 final  List<PollVoteOptionDto> _options;
@override List<PollVoteOptionDto> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  bool allowMultiple;
@override final  bool anonymous;
@override final  String? closesAt;
@override@JsonKey() final  bool isClosed;
@override final  int totalVotes;
@override final  int createdBy;
@override final  String createdByUsername;
@override final  String createdAt;

/// Create a copy of PollVoteEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollVoteEventDtoCopyWith<_PollVoteEventDto> get copyWith => __$PollVoteEventDtoCopyWithImpl<_PollVoteEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollVoteEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollVoteEventDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.allowMultiple, allowMultiple) || other.allowMultiple == allowMultiple)&&(identical(other.anonymous, anonymous) || other.anonymous == anonymous)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.totalVotes, totalVotes) || other.totalVotes == totalVotes)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,question,const DeepCollectionEquality().hash(_options),allowMultiple,anonymous,closesAt,isClosed,totalVotes,createdBy,createdByUsername,createdAt);

@override
String toString() {
  return 'PollVoteEventDto(messageId: $messageId, question: $question, options: $options, allowMultiple: $allowMultiple, anonymous: $anonymous, closesAt: $closesAt, isClosed: $isClosed, totalVotes: $totalVotes, createdBy: $createdBy, createdByUsername: $createdByUsername, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PollVoteEventDtoCopyWith<$Res> implements $PollVoteEventDtoCopyWith<$Res> {
  factory _$PollVoteEventDtoCopyWith(_PollVoteEventDto value, $Res Function(_PollVoteEventDto) _then) = __$PollVoteEventDtoCopyWithImpl;
@override @useResult
$Res call({
 int messageId, String question, List<PollVoteOptionDto> options, bool allowMultiple, bool anonymous, String? closesAt, bool isClosed, int totalVotes, int createdBy, String createdByUsername, String createdAt
});




}
/// @nodoc
class __$PollVoteEventDtoCopyWithImpl<$Res>
    implements _$PollVoteEventDtoCopyWith<$Res> {
  __$PollVoteEventDtoCopyWithImpl(this._self, this._then);

  final _PollVoteEventDto _self;
  final $Res Function(_PollVoteEventDto) _then;

/// Create a copy of PollVoteEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? question = null,Object? options = null,Object? allowMultiple = null,Object? anonymous = null,Object? closesAt = freezed,Object? isClosed = null,Object? totalVotes = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdAt = null,}) {
  return _then(_PollVoteEventDto(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<PollVoteOptionDto>,allowMultiple: null == allowMultiple ? _self.allowMultiple : allowMultiple // ignore: cast_nullable_to_non_nullable
as bool,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as String?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,totalVotes: null == totalVotes ? _self.totalVotes : totalVotes // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PollVoteOptionDto {

 int get id; String get text; int get voteCount; List<int>? get voterIds; bool? get hasVoted;
/// Create a copy of PollVoteOptionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollVoteOptionDtoCopyWith<PollVoteOptionDto> get copyWith => _$PollVoteOptionDtoCopyWithImpl<PollVoteOptionDto>(this as PollVoteOptionDto, _$identity);

  /// Serializes this PollVoteOptionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollVoteOptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&const DeepCollectionEquality().equals(other.voterIds, voterIds)&&(identical(other.hasVoted, hasVoted) || other.hasVoted == hasVoted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,voteCount,const DeepCollectionEquality().hash(voterIds),hasVoted);

@override
String toString() {
  return 'PollVoteOptionDto(id: $id, text: $text, voteCount: $voteCount, voterIds: $voterIds, hasVoted: $hasVoted)';
}


}

/// @nodoc
abstract mixin class $PollVoteOptionDtoCopyWith<$Res>  {
  factory $PollVoteOptionDtoCopyWith(PollVoteOptionDto value, $Res Function(PollVoteOptionDto) _then) = _$PollVoteOptionDtoCopyWithImpl;
@useResult
$Res call({
 int id, String text, int voteCount, List<int>? voterIds, bool? hasVoted
});




}
/// @nodoc
class _$PollVoteOptionDtoCopyWithImpl<$Res>
    implements $PollVoteOptionDtoCopyWith<$Res> {
  _$PollVoteOptionDtoCopyWithImpl(this._self, this._then);

  final PollVoteOptionDto _self;
  final $Res Function(PollVoteOptionDto) _then;

/// Create a copy of PollVoteOptionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? voteCount = null,Object? voterIds = freezed,Object? hasVoted = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,voterIds: freezed == voterIds ? _self.voterIds : voterIds // ignore: cast_nullable_to_non_nullable
as List<int>?,hasVoted: freezed == hasVoted ? _self.hasVoted : hasVoted // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [PollVoteOptionDto].
extension PollVoteOptionDtoPatterns on PollVoteOptionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollVoteOptionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollVoteOptionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollVoteOptionDto value)  $default,){
final _that = this;
switch (_that) {
case _PollVoteOptionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollVoteOptionDto value)?  $default,){
final _that = this;
switch (_that) {
case _PollVoteOptionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String text,  int voteCount,  List<int>? voterIds,  bool? hasVoted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollVoteOptionDto() when $default != null:
return $default(_that.id,_that.text,_that.voteCount,_that.voterIds,_that.hasVoted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String text,  int voteCount,  List<int>? voterIds,  bool? hasVoted)  $default,) {final _that = this;
switch (_that) {
case _PollVoteOptionDto():
return $default(_that.id,_that.text,_that.voteCount,_that.voterIds,_that.hasVoted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String text,  int voteCount,  List<int>? voterIds,  bool? hasVoted)?  $default,) {final _that = this;
switch (_that) {
case _PollVoteOptionDto() when $default != null:
return $default(_that.id,_that.text,_that.voteCount,_that.voterIds,_that.hasVoted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollVoteOptionDto implements PollVoteOptionDto {
  const _PollVoteOptionDto({required this.id, required this.text, required this.voteCount, final  List<int>? voterIds, this.hasVoted}): _voterIds = voterIds;
  factory _PollVoteOptionDto.fromJson(Map<String, dynamic> json) => _$PollVoteOptionDtoFromJson(json);

@override final  int id;
@override final  String text;
@override final  int voteCount;
 final  List<int>? _voterIds;
@override List<int>? get voterIds {
  final value = _voterIds;
  if (value == null) return null;
  if (_voterIds is EqualUnmodifiableListView) return _voterIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool? hasVoted;

/// Create a copy of PollVoteOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollVoteOptionDtoCopyWith<_PollVoteOptionDto> get copyWith => __$PollVoteOptionDtoCopyWithImpl<_PollVoteOptionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollVoteOptionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollVoteOptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&const DeepCollectionEquality().equals(other._voterIds, _voterIds)&&(identical(other.hasVoted, hasVoted) || other.hasVoted == hasVoted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,voteCount,const DeepCollectionEquality().hash(_voterIds),hasVoted);

@override
String toString() {
  return 'PollVoteOptionDto(id: $id, text: $text, voteCount: $voteCount, voterIds: $voterIds, hasVoted: $hasVoted)';
}


}

/// @nodoc
abstract mixin class _$PollVoteOptionDtoCopyWith<$Res> implements $PollVoteOptionDtoCopyWith<$Res> {
  factory _$PollVoteOptionDtoCopyWith(_PollVoteOptionDto value, $Res Function(_PollVoteOptionDto) _then) = __$PollVoteOptionDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String text, int voteCount, List<int>? voterIds, bool? hasVoted
});




}
/// @nodoc
class __$PollVoteOptionDtoCopyWithImpl<$Res>
    implements _$PollVoteOptionDtoCopyWith<$Res> {
  __$PollVoteOptionDtoCopyWithImpl(this._self, this._then);

  final _PollVoteOptionDto _self;
  final $Res Function(_PollVoteOptionDto) _then;

/// Create a copy of PollVoteOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? voteCount = null,Object? voterIds = freezed,Object? hasVoted = freezed,}) {
  return _then(_PollVoteOptionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,voterIds: freezed == voterIds ? _self._voterIds : voterIds // ignore: cast_nullable_to_non_nullable
as List<int>?,hasVoted: freezed == hasVoted ? _self.hasVoted : hasVoted // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
