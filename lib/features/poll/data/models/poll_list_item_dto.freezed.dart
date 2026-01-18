// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_list_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PollListItemDto {

 int get messageId; String get question; List<PollListOptionDto> get options; bool get allowMultiple; bool get anonymous; bool get isClosed; int get totalVotes; int get createdBy; String get createdByUsername; String? get createdByFullName; String? get createdByAvatarUrl; DateTime get createdAt; DateTime? get expiresAt;
/// Create a copy of PollListItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollListItemDtoCopyWith<PollListItemDto> get copyWith => _$PollListItemDtoCopyWithImpl<PollListItemDto>(this as PollListItemDto, _$identity);

  /// Serializes this PollListItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollListItemDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.allowMultiple, allowMultiple) || other.allowMultiple == allowMultiple)&&(identical(other.anonymous, anonymous) || other.anonymous == anonymous)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.totalVotes, totalVotes) || other.totalVotes == totalVotes)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdByFullName, createdByFullName) || other.createdByFullName == createdByFullName)&&(identical(other.createdByAvatarUrl, createdByAvatarUrl) || other.createdByAvatarUrl == createdByAvatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,question,const DeepCollectionEquality().hash(options),allowMultiple,anonymous,isClosed,totalVotes,createdBy,createdByUsername,createdByFullName,createdByAvatarUrl,createdAt,expiresAt);

@override
String toString() {
  return 'PollListItemDto(messageId: $messageId, question: $question, options: $options, allowMultiple: $allowMultiple, anonymous: $anonymous, isClosed: $isClosed, totalVotes: $totalVotes, createdBy: $createdBy, createdByUsername: $createdByUsername, createdByFullName: $createdByFullName, createdByAvatarUrl: $createdByAvatarUrl, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $PollListItemDtoCopyWith<$Res>  {
  factory $PollListItemDtoCopyWith(PollListItemDto value, $Res Function(PollListItemDto) _then) = _$PollListItemDtoCopyWithImpl;
@useResult
$Res call({
 int messageId, String question, List<PollListOptionDto> options, bool allowMultiple, bool anonymous, bool isClosed, int totalVotes, int createdBy, String createdByUsername, String? createdByFullName, String? createdByAvatarUrl, DateTime createdAt, DateTime? expiresAt
});




}
/// @nodoc
class _$PollListItemDtoCopyWithImpl<$Res>
    implements $PollListItemDtoCopyWith<$Res> {
  _$PollListItemDtoCopyWithImpl(this._self, this._then);

  final PollListItemDto _self;
  final $Res Function(PollListItemDto) _then;

/// Create a copy of PollListItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? question = null,Object? options = null,Object? allowMultiple = null,Object? anonymous = null,Object? isClosed = null,Object? totalVotes = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdByFullName = freezed,Object? createdByAvatarUrl = freezed,Object? createdAt = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<PollListOptionDto>,allowMultiple: null == allowMultiple ? _self.allowMultiple : allowMultiple // ignore: cast_nullable_to_non_nullable
as bool,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,totalVotes: null == totalVotes ? _self.totalVotes : totalVotes // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdByFullName: freezed == createdByFullName ? _self.createdByFullName : createdByFullName // ignore: cast_nullable_to_non_nullable
as String?,createdByAvatarUrl: freezed == createdByAvatarUrl ? _self.createdByAvatarUrl : createdByAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PollListItemDto].
extension PollListItemDtoPatterns on PollListItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollListItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollListItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollListItemDto value)  $default,){
final _that = this;
switch (_that) {
case _PollListItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollListItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _PollListItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int messageId,  String question,  List<PollListOptionDto> options,  bool allowMultiple,  bool anonymous,  bool isClosed,  int totalVotes,  int createdBy,  String createdByUsername,  String? createdByFullName,  String? createdByAvatarUrl,  DateTime createdAt,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollListItemDto() when $default != null:
return $default(_that.messageId,_that.question,_that.options,_that.allowMultiple,_that.anonymous,_that.isClosed,_that.totalVotes,_that.createdBy,_that.createdByUsername,_that.createdByFullName,_that.createdByAvatarUrl,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int messageId,  String question,  List<PollListOptionDto> options,  bool allowMultiple,  bool anonymous,  bool isClosed,  int totalVotes,  int createdBy,  String createdByUsername,  String? createdByFullName,  String? createdByAvatarUrl,  DateTime createdAt,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _PollListItemDto():
return $default(_that.messageId,_that.question,_that.options,_that.allowMultiple,_that.anonymous,_that.isClosed,_that.totalVotes,_that.createdBy,_that.createdByUsername,_that.createdByFullName,_that.createdByAvatarUrl,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int messageId,  String question,  List<PollListOptionDto> options,  bool allowMultiple,  bool anonymous,  bool isClosed,  int totalVotes,  int createdBy,  String createdByUsername,  String? createdByFullName,  String? createdByAvatarUrl,  DateTime createdAt,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _PollListItemDto() when $default != null:
return $default(_that.messageId,_that.question,_that.options,_that.allowMultiple,_that.anonymous,_that.isClosed,_that.totalVotes,_that.createdBy,_that.createdByUsername,_that.createdByFullName,_that.createdByAvatarUrl,_that.createdAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollListItemDto extends PollListItemDto {
  const _PollListItemDto({required this.messageId, required this.question, required final  List<PollListOptionDto> options, required this.allowMultiple, required this.anonymous, required this.isClosed, required this.totalVotes, required this.createdBy, required this.createdByUsername, this.createdByFullName, this.createdByAvatarUrl, required this.createdAt, this.expiresAt}): _options = options,super._();
  factory _PollListItemDto.fromJson(Map<String, dynamic> json) => _$PollListItemDtoFromJson(json);

@override final  int messageId;
@override final  String question;
 final  List<PollListOptionDto> _options;
@override List<PollListOptionDto> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  bool allowMultiple;
@override final  bool anonymous;
@override final  bool isClosed;
@override final  int totalVotes;
@override final  int createdBy;
@override final  String createdByUsername;
@override final  String? createdByFullName;
@override final  String? createdByAvatarUrl;
@override final  DateTime createdAt;
@override final  DateTime? expiresAt;

/// Create a copy of PollListItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollListItemDtoCopyWith<_PollListItemDto> get copyWith => __$PollListItemDtoCopyWithImpl<_PollListItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollListItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollListItemDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.allowMultiple, allowMultiple) || other.allowMultiple == allowMultiple)&&(identical(other.anonymous, anonymous) || other.anonymous == anonymous)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.totalVotes, totalVotes) || other.totalVotes == totalVotes)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdByFullName, createdByFullName) || other.createdByFullName == createdByFullName)&&(identical(other.createdByAvatarUrl, createdByAvatarUrl) || other.createdByAvatarUrl == createdByAvatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,question,const DeepCollectionEquality().hash(_options),allowMultiple,anonymous,isClosed,totalVotes,createdBy,createdByUsername,createdByFullName,createdByAvatarUrl,createdAt,expiresAt);

@override
String toString() {
  return 'PollListItemDto(messageId: $messageId, question: $question, options: $options, allowMultiple: $allowMultiple, anonymous: $anonymous, isClosed: $isClosed, totalVotes: $totalVotes, createdBy: $createdBy, createdByUsername: $createdByUsername, createdByFullName: $createdByFullName, createdByAvatarUrl: $createdByAvatarUrl, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$PollListItemDtoCopyWith<$Res> implements $PollListItemDtoCopyWith<$Res> {
  factory _$PollListItemDtoCopyWith(_PollListItemDto value, $Res Function(_PollListItemDto) _then) = __$PollListItemDtoCopyWithImpl;
@override @useResult
$Res call({
 int messageId, String question, List<PollListOptionDto> options, bool allowMultiple, bool anonymous, bool isClosed, int totalVotes, int createdBy, String createdByUsername, String? createdByFullName, String? createdByAvatarUrl, DateTime createdAt, DateTime? expiresAt
});




}
/// @nodoc
class __$PollListItemDtoCopyWithImpl<$Res>
    implements _$PollListItemDtoCopyWith<$Res> {
  __$PollListItemDtoCopyWithImpl(this._self, this._then);

  final _PollListItemDto _self;
  final $Res Function(_PollListItemDto) _then;

/// Create a copy of PollListItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? question = null,Object? options = null,Object? allowMultiple = null,Object? anonymous = null,Object? isClosed = null,Object? totalVotes = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdByFullName = freezed,Object? createdByAvatarUrl = freezed,Object? createdAt = null,Object? expiresAt = freezed,}) {
  return _then(_PollListItemDto(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<PollListOptionDto>,allowMultiple: null == allowMultiple ? _self.allowMultiple : allowMultiple // ignore: cast_nullable_to_non_nullable
as bool,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,totalVotes: null == totalVotes ? _self.totalVotes : totalVotes // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdByFullName: freezed == createdByFullName ? _self.createdByFullName : createdByFullName // ignore: cast_nullable_to_non_nullable
as String?,createdByAvatarUrl: freezed == createdByAvatarUrl ? _self.createdByAvatarUrl : createdByAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PollListOptionDto {

 int get id; String get text; int get voteCount; List<int> get voterIds; bool get hasVoted;
/// Create a copy of PollListOptionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollListOptionDtoCopyWith<PollListOptionDto> get copyWith => _$PollListOptionDtoCopyWithImpl<PollListOptionDto>(this as PollListOptionDto, _$identity);

  /// Serializes this PollListOptionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollListOptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&const DeepCollectionEquality().equals(other.voterIds, voterIds)&&(identical(other.hasVoted, hasVoted) || other.hasVoted == hasVoted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,voteCount,const DeepCollectionEquality().hash(voterIds),hasVoted);

@override
String toString() {
  return 'PollListOptionDto(id: $id, text: $text, voteCount: $voteCount, voterIds: $voterIds, hasVoted: $hasVoted)';
}


}

/// @nodoc
abstract mixin class $PollListOptionDtoCopyWith<$Res>  {
  factory $PollListOptionDtoCopyWith(PollListOptionDto value, $Res Function(PollListOptionDto) _then) = _$PollListOptionDtoCopyWithImpl;
@useResult
$Res call({
 int id, String text, int voteCount, List<int> voterIds, bool hasVoted
});




}
/// @nodoc
class _$PollListOptionDtoCopyWithImpl<$Res>
    implements $PollListOptionDtoCopyWith<$Res> {
  _$PollListOptionDtoCopyWithImpl(this._self, this._then);

  final PollListOptionDto _self;
  final $Res Function(PollListOptionDto) _then;

/// Create a copy of PollListOptionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? voteCount = null,Object? voterIds = null,Object? hasVoted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,voterIds: null == voterIds ? _self.voterIds : voterIds // ignore: cast_nullable_to_non_nullable
as List<int>,hasVoted: null == hasVoted ? _self.hasVoted : hasVoted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PollListOptionDto].
extension PollListOptionDtoPatterns on PollListOptionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollListOptionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollListOptionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollListOptionDto value)  $default,){
final _that = this;
switch (_that) {
case _PollListOptionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollListOptionDto value)?  $default,){
final _that = this;
switch (_that) {
case _PollListOptionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String text,  int voteCount,  List<int> voterIds,  bool hasVoted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollListOptionDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String text,  int voteCount,  List<int> voterIds,  bool hasVoted)  $default,) {final _that = this;
switch (_that) {
case _PollListOptionDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String text,  int voteCount,  List<int> voterIds,  bool hasVoted)?  $default,) {final _that = this;
switch (_that) {
case _PollListOptionDto() when $default != null:
return $default(_that.id,_that.text,_that.voteCount,_that.voterIds,_that.hasVoted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollListOptionDto extends PollListOptionDto {
  const _PollListOptionDto({required this.id, required this.text, required this.voteCount, required final  List<int> voterIds, required this.hasVoted}): _voterIds = voterIds,super._();
  factory _PollListOptionDto.fromJson(Map<String, dynamic> json) => _$PollListOptionDtoFromJson(json);

@override final  int id;
@override final  String text;
@override final  int voteCount;
 final  List<int> _voterIds;
@override List<int> get voterIds {
  if (_voterIds is EqualUnmodifiableListView) return _voterIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_voterIds);
}

@override final  bool hasVoted;

/// Create a copy of PollListOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollListOptionDtoCopyWith<_PollListOptionDto> get copyWith => __$PollListOptionDtoCopyWithImpl<_PollListOptionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollListOptionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollListOptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&const DeepCollectionEquality().equals(other._voterIds, _voterIds)&&(identical(other.hasVoted, hasVoted) || other.hasVoted == hasVoted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,voteCount,const DeepCollectionEquality().hash(_voterIds),hasVoted);

@override
String toString() {
  return 'PollListOptionDto(id: $id, text: $text, voteCount: $voteCount, voterIds: $voterIds, hasVoted: $hasVoted)';
}


}

/// @nodoc
abstract mixin class _$PollListOptionDtoCopyWith<$Res> implements $PollListOptionDtoCopyWith<$Res> {
  factory _$PollListOptionDtoCopyWith(_PollListOptionDto value, $Res Function(_PollListOptionDto) _then) = __$PollListOptionDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String text, int voteCount, List<int> voterIds, bool hasVoted
});




}
/// @nodoc
class __$PollListOptionDtoCopyWithImpl<$Res>
    implements _$PollListOptionDtoCopyWith<$Res> {
  __$PollListOptionDtoCopyWithImpl(this._self, this._then);

  final _PollListOptionDto _self;
  final $Res Function(_PollListOptionDto) _then;

/// Create a copy of PollListOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? voteCount = null,Object? voterIds = null,Object? hasVoted = null,}) {
  return _then(_PollListOptionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,voterIds: null == voterIds ? _self._voterIds : voterIds // ignore: cast_nullable_to_non_nullable
as List<int>,hasVoted: null == hasVoted ? _self.hasVoted : hasVoted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
