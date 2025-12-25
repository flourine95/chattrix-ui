// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pinned_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PinnedMessageModel {

 int get id; int get conversationId; int get senderId; String get senderUsername; String get senderFullName; String get content; String get type; Map<String, dynamic> get reactions; DateTime get sentAt; DateTime get createdAt; DateTime get updatedAt; bool get edited; bool get deleted; bool get forwarded; int get forwardCount; bool get pinned; DateTime? get pinnedAt; int? get pinnedBy; String? get pinnedByUsername; String? get pinnedByFullName; bool get scheduled;
/// Create a copy of PinnedMessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinnedMessageModelCopyWith<PinnedMessageModel> get copyWith => _$PinnedMessageModelCopyWithImpl<PinnedMessageModel>(this as PinnedMessageModel, _$identity);

  /// Serializes this PinnedMessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinnedMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.edited, edited) || other.edited == edited)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.forwarded, forwarded) || other.forwarded == forwarded)&&(identical(other.forwardCount, forwardCount) || other.forwardCount == forwardCount)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&(identical(other.pinnedAt, pinnedAt) || other.pinnedAt == pinnedAt)&&(identical(other.pinnedBy, pinnedBy) || other.pinnedBy == pinnedBy)&&(identical(other.pinnedByUsername, pinnedByUsername) || other.pinnedByUsername == pinnedByUsername)&&(identical(other.pinnedByFullName, pinnedByFullName) || other.pinnedByFullName == pinnedByFullName)&&(identical(other.scheduled, scheduled) || other.scheduled == scheduled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,const DeepCollectionEquality().hash(reactions),sentAt,createdAt,updatedAt,edited,deleted,forwarded,forwardCount,pinned,pinnedAt,pinnedBy,pinnedByUsername,pinnedByFullName,scheduled]);

@override
String toString() {
  return 'PinnedMessageModel(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, reactions: $reactions, sentAt: $sentAt, createdAt: $createdAt, updatedAt: $updatedAt, edited: $edited, deleted: $deleted, forwarded: $forwarded, forwardCount: $forwardCount, pinned: $pinned, pinnedAt: $pinnedAt, pinnedBy: $pinnedBy, pinnedByUsername: $pinnedByUsername, pinnedByFullName: $pinnedByFullName, scheduled: $scheduled)';
}


}

/// @nodoc
abstract mixin class $PinnedMessageModelCopyWith<$Res>  {
  factory $PinnedMessageModelCopyWith(PinnedMessageModel value, $Res Function(PinnedMessageModel) _then) = _$PinnedMessageModelCopyWithImpl;
@useResult
$Res call({
 int id, int conversationId, int senderId, String senderUsername, String senderFullName, String content, String type, Map<String, dynamic> reactions, DateTime sentAt, DateTime createdAt, DateTime updatedAt, bool edited, bool deleted, bool forwarded, int forwardCount, bool pinned, DateTime? pinnedAt, int? pinnedBy, String? pinnedByUsername, String? pinnedByFullName, bool scheduled
});




}
/// @nodoc
class _$PinnedMessageModelCopyWithImpl<$Res>
    implements $PinnedMessageModelCopyWith<$Res> {
  _$PinnedMessageModelCopyWithImpl(this._self, this._then);

  final PinnedMessageModel _self;
  final $Res Function(PinnedMessageModel) _then;

/// Create a copy of PinnedMessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = null,Object? senderFullName = null,Object? content = null,Object? type = null,Object? reactions = null,Object? sentAt = null,Object? createdAt = null,Object? updatedAt = null,Object? edited = null,Object? deleted = null,Object? forwarded = null,Object? forwardCount = null,Object? pinned = null,Object? pinnedAt = freezed,Object? pinnedBy = freezed,Object? pinnedByUsername = freezed,Object? pinnedByFullName = freezed,Object? scheduled = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: null == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String,senderFullName: null == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,reactions: null == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,forwarded: null == forwarded ? _self.forwarded : forwarded // ignore: cast_nullable_to_non_nullable
as bool,forwardCount: null == forwardCount ? _self.forwardCount : forwardCount // ignore: cast_nullable_to_non_nullable
as int,pinned: null == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool,pinnedAt: freezed == pinnedAt ? _self.pinnedAt : pinnedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pinnedBy: freezed == pinnedBy ? _self.pinnedBy : pinnedBy // ignore: cast_nullable_to_non_nullable
as int?,pinnedByUsername: freezed == pinnedByUsername ? _self.pinnedByUsername : pinnedByUsername // ignore: cast_nullable_to_non_nullable
as String?,pinnedByFullName: freezed == pinnedByFullName ? _self.pinnedByFullName : pinnedByFullName // ignore: cast_nullable_to_non_nullable
as String?,scheduled: null == scheduled ? _self.scheduled : scheduled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PinnedMessageModel].
extension PinnedMessageModelPatterns on PinnedMessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinnedMessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinnedMessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinnedMessageModel value)  $default,){
final _that = this;
switch (_that) {
case _PinnedMessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinnedMessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _PinnedMessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String senderUsername,  String senderFullName,  String content,  String type,  Map<String, dynamic> reactions,  DateTime sentAt,  DateTime createdAt,  DateTime updatedAt,  bool edited,  bool deleted,  bool forwarded,  int forwardCount,  bool pinned,  DateTime? pinnedAt,  int? pinnedBy,  String? pinnedByUsername,  String? pinnedByFullName,  bool scheduled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinnedMessageModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.reactions,_that.sentAt,_that.createdAt,_that.updatedAt,_that.edited,_that.deleted,_that.forwarded,_that.forwardCount,_that.pinned,_that.pinnedAt,_that.pinnedBy,_that.pinnedByUsername,_that.pinnedByFullName,_that.scheduled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String senderUsername,  String senderFullName,  String content,  String type,  Map<String, dynamic> reactions,  DateTime sentAt,  DateTime createdAt,  DateTime updatedAt,  bool edited,  bool deleted,  bool forwarded,  int forwardCount,  bool pinned,  DateTime? pinnedAt,  int? pinnedBy,  String? pinnedByUsername,  String? pinnedByFullName,  bool scheduled)  $default,) {final _that = this;
switch (_that) {
case _PinnedMessageModel():
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.reactions,_that.sentAt,_that.createdAt,_that.updatedAt,_that.edited,_that.deleted,_that.forwarded,_that.forwardCount,_that.pinned,_that.pinnedAt,_that.pinnedBy,_that.pinnedByUsername,_that.pinnedByFullName,_that.scheduled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int conversationId,  int senderId,  String senderUsername,  String senderFullName,  String content,  String type,  Map<String, dynamic> reactions,  DateTime sentAt,  DateTime createdAt,  DateTime updatedAt,  bool edited,  bool deleted,  bool forwarded,  int forwardCount,  bool pinned,  DateTime? pinnedAt,  int? pinnedBy,  String? pinnedByUsername,  String? pinnedByFullName,  bool scheduled)?  $default,) {final _that = this;
switch (_that) {
case _PinnedMessageModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.reactions,_that.sentAt,_that.createdAt,_that.updatedAt,_that.edited,_that.deleted,_that.forwarded,_that.forwardCount,_that.pinned,_that.pinnedAt,_that.pinnedBy,_that.pinnedByUsername,_that.pinnedByFullName,_that.scheduled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PinnedMessageModel implements PinnedMessageModel {
  const _PinnedMessageModel({required this.id, required this.conversationId, required this.senderId, required this.senderUsername, required this.senderFullName, required this.content, required this.type, final  Map<String, dynamic> reactions = const {}, required this.sentAt, required this.createdAt, required this.updatedAt, this.edited = false, this.deleted = false, this.forwarded = false, this.forwardCount = 0, this.pinned = true, this.pinnedAt, this.pinnedBy, this.pinnedByUsername, this.pinnedByFullName, this.scheduled = false}): _reactions = reactions;
  factory _PinnedMessageModel.fromJson(Map<String, dynamic> json) => _$PinnedMessageModelFromJson(json);

@override final  int id;
@override final  int conversationId;
@override final  int senderId;
@override final  String senderUsername;
@override final  String senderFullName;
@override final  String content;
@override final  String type;
 final  Map<String, dynamic> _reactions;
@override@JsonKey() Map<String, dynamic> get reactions {
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_reactions);
}

@override final  DateTime sentAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  bool edited;
@override@JsonKey() final  bool deleted;
@override@JsonKey() final  bool forwarded;
@override@JsonKey() final  int forwardCount;
@override@JsonKey() final  bool pinned;
@override final  DateTime? pinnedAt;
@override final  int? pinnedBy;
@override final  String? pinnedByUsername;
@override final  String? pinnedByFullName;
@override@JsonKey() final  bool scheduled;

/// Create a copy of PinnedMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinnedMessageModelCopyWith<_PinnedMessageModel> get copyWith => __$PinnedMessageModelCopyWithImpl<_PinnedMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PinnedMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinnedMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.edited, edited) || other.edited == edited)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.forwarded, forwarded) || other.forwarded == forwarded)&&(identical(other.forwardCount, forwardCount) || other.forwardCount == forwardCount)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&(identical(other.pinnedAt, pinnedAt) || other.pinnedAt == pinnedAt)&&(identical(other.pinnedBy, pinnedBy) || other.pinnedBy == pinnedBy)&&(identical(other.pinnedByUsername, pinnedByUsername) || other.pinnedByUsername == pinnedByUsername)&&(identical(other.pinnedByFullName, pinnedByFullName) || other.pinnedByFullName == pinnedByFullName)&&(identical(other.scheduled, scheduled) || other.scheduled == scheduled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,const DeepCollectionEquality().hash(_reactions),sentAt,createdAt,updatedAt,edited,deleted,forwarded,forwardCount,pinned,pinnedAt,pinnedBy,pinnedByUsername,pinnedByFullName,scheduled]);

@override
String toString() {
  return 'PinnedMessageModel(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, reactions: $reactions, sentAt: $sentAt, createdAt: $createdAt, updatedAt: $updatedAt, edited: $edited, deleted: $deleted, forwarded: $forwarded, forwardCount: $forwardCount, pinned: $pinned, pinnedAt: $pinnedAt, pinnedBy: $pinnedBy, pinnedByUsername: $pinnedByUsername, pinnedByFullName: $pinnedByFullName, scheduled: $scheduled)';
}


}

/// @nodoc
abstract mixin class _$PinnedMessageModelCopyWith<$Res> implements $PinnedMessageModelCopyWith<$Res> {
  factory _$PinnedMessageModelCopyWith(_PinnedMessageModel value, $Res Function(_PinnedMessageModel) _then) = __$PinnedMessageModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversationId, int senderId, String senderUsername, String senderFullName, String content, String type, Map<String, dynamic> reactions, DateTime sentAt, DateTime createdAt, DateTime updatedAt, bool edited, bool deleted, bool forwarded, int forwardCount, bool pinned, DateTime? pinnedAt, int? pinnedBy, String? pinnedByUsername, String? pinnedByFullName, bool scheduled
});




}
/// @nodoc
class __$PinnedMessageModelCopyWithImpl<$Res>
    implements _$PinnedMessageModelCopyWith<$Res> {
  __$PinnedMessageModelCopyWithImpl(this._self, this._then);

  final _PinnedMessageModel _self;
  final $Res Function(_PinnedMessageModel) _then;

/// Create a copy of PinnedMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = null,Object? senderFullName = null,Object? content = null,Object? type = null,Object? reactions = null,Object? sentAt = null,Object? createdAt = null,Object? updatedAt = null,Object? edited = null,Object? deleted = null,Object? forwarded = null,Object? forwardCount = null,Object? pinned = null,Object? pinnedAt = freezed,Object? pinnedBy = freezed,Object? pinnedByUsername = freezed,Object? pinnedByFullName = freezed,Object? scheduled = null,}) {
  return _then(_PinnedMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: null == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String,senderFullName: null == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,reactions: null == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,forwarded: null == forwarded ? _self.forwarded : forwarded // ignore: cast_nullable_to_non_nullable
as bool,forwardCount: null == forwardCount ? _self.forwardCount : forwardCount // ignore: cast_nullable_to_non_nullable
as int,pinned: null == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool,pinnedAt: freezed == pinnedAt ? _self.pinnedAt : pinnedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pinnedBy: freezed == pinnedBy ? _self.pinnedBy : pinnedBy // ignore: cast_nullable_to_non_nullable
as int?,pinnedByUsername: freezed == pinnedByUsername ? _self.pinnedByUsername : pinnedByUsername // ignore: cast_nullable_to_non_nullable
as String?,pinnedByFullName: freezed == pinnedByFullName ? _self.pinnedByFullName : pinnedByFullName // ignore: cast_nullable_to_non_nullable
as String?,scheduled: null == scheduled ? _self.scheduled : scheduled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SearchMessagesRequest {

 String get query; int? get limit; String? get cursor;
/// Create a copy of SearchMessagesRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchMessagesRequestCopyWith<SearchMessagesRequest> get copyWith => _$SearchMessagesRequestCopyWithImpl<SearchMessagesRequest>(this as SearchMessagesRequest, _$identity);

  /// Serializes this SearchMessagesRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchMessagesRequest&&(identical(other.query, query) || other.query == query)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.cursor, cursor) || other.cursor == cursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,limit,cursor);

@override
String toString() {
  return 'SearchMessagesRequest(query: $query, limit: $limit, cursor: $cursor)';
}


}

/// @nodoc
abstract mixin class $SearchMessagesRequestCopyWith<$Res>  {
  factory $SearchMessagesRequestCopyWith(SearchMessagesRequest value, $Res Function(SearchMessagesRequest) _then) = _$SearchMessagesRequestCopyWithImpl;
@useResult
$Res call({
 String query, int? limit, String? cursor
});




}
/// @nodoc
class _$SearchMessagesRequestCopyWithImpl<$Res>
    implements $SearchMessagesRequestCopyWith<$Res> {
  _$SearchMessagesRequestCopyWithImpl(this._self, this._then);

  final SearchMessagesRequest _self;
  final $Res Function(SearchMessagesRequest) _then;

/// Create a copy of SearchMessagesRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? limit = freezed,Object? cursor = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchMessagesRequest].
extension SearchMessagesRequestPatterns on SearchMessagesRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchMessagesRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchMessagesRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchMessagesRequest value)  $default,){
final _that = this;
switch (_that) {
case _SearchMessagesRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchMessagesRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SearchMessagesRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  int? limit,  String? cursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchMessagesRequest() when $default != null:
return $default(_that.query,_that.limit,_that.cursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  int? limit,  String? cursor)  $default,) {final _that = this;
switch (_that) {
case _SearchMessagesRequest():
return $default(_that.query,_that.limit,_that.cursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  int? limit,  String? cursor)?  $default,) {final _that = this;
switch (_that) {
case _SearchMessagesRequest() when $default != null:
return $default(_that.query,_that.limit,_that.cursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchMessagesRequest implements SearchMessagesRequest {
  const _SearchMessagesRequest({required this.query, this.limit, this.cursor});
  factory _SearchMessagesRequest.fromJson(Map<String, dynamic> json) => _$SearchMessagesRequestFromJson(json);

@override final  String query;
@override final  int? limit;
@override final  String? cursor;

/// Create a copy of SearchMessagesRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchMessagesRequestCopyWith<_SearchMessagesRequest> get copyWith => __$SearchMessagesRequestCopyWithImpl<_SearchMessagesRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchMessagesRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchMessagesRequest&&(identical(other.query, query) || other.query == query)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.cursor, cursor) || other.cursor == cursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,limit,cursor);

@override
String toString() {
  return 'SearchMessagesRequest(query: $query, limit: $limit, cursor: $cursor)';
}


}

/// @nodoc
abstract mixin class _$SearchMessagesRequestCopyWith<$Res> implements $SearchMessagesRequestCopyWith<$Res> {
  factory _$SearchMessagesRequestCopyWith(_SearchMessagesRequest value, $Res Function(_SearchMessagesRequest) _then) = __$SearchMessagesRequestCopyWithImpl;
@override @useResult
$Res call({
 String query, int? limit, String? cursor
});




}
/// @nodoc
class __$SearchMessagesRequestCopyWithImpl<$Res>
    implements _$SearchMessagesRequestCopyWith<$Res> {
  __$SearchMessagesRequestCopyWithImpl(this._self, this._then);

  final _SearchMessagesRequest _self;
  final $Res Function(_SearchMessagesRequest) _then;

/// Create a copy of SearchMessagesRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? limit = freezed,Object? cursor = freezed,}) {
  return _then(_SearchMessagesRequest(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SearchMediaRequest {

 String? get type; int? get limit; String? get cursor;
/// Create a copy of SearchMediaRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchMediaRequestCopyWith<SearchMediaRequest> get copyWith => _$SearchMediaRequestCopyWithImpl<SearchMediaRequest>(this as SearchMediaRequest, _$identity);

  /// Serializes this SearchMediaRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchMediaRequest&&(identical(other.type, type) || other.type == type)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.cursor, cursor) || other.cursor == cursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,limit,cursor);

@override
String toString() {
  return 'SearchMediaRequest(type: $type, limit: $limit, cursor: $cursor)';
}


}

/// @nodoc
abstract mixin class $SearchMediaRequestCopyWith<$Res>  {
  factory $SearchMediaRequestCopyWith(SearchMediaRequest value, $Res Function(SearchMediaRequest) _then) = _$SearchMediaRequestCopyWithImpl;
@useResult
$Res call({
 String? type, int? limit, String? cursor
});




}
/// @nodoc
class _$SearchMediaRequestCopyWithImpl<$Res>
    implements $SearchMediaRequestCopyWith<$Res> {
  _$SearchMediaRequestCopyWithImpl(this._self, this._then);

  final SearchMediaRequest _self;
  final $Res Function(SearchMediaRequest) _then;

/// Create a copy of SearchMediaRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? limit = freezed,Object? cursor = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchMediaRequest].
extension SearchMediaRequestPatterns on SearchMediaRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchMediaRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchMediaRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchMediaRequest value)  $default,){
final _that = this;
switch (_that) {
case _SearchMediaRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchMediaRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SearchMediaRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? type,  int? limit,  String? cursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchMediaRequest() when $default != null:
return $default(_that.type,_that.limit,_that.cursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? type,  int? limit,  String? cursor)  $default,) {final _that = this;
switch (_that) {
case _SearchMediaRequest():
return $default(_that.type,_that.limit,_that.cursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? type,  int? limit,  String? cursor)?  $default,) {final _that = this;
switch (_that) {
case _SearchMediaRequest() when $default != null:
return $default(_that.type,_that.limit,_that.cursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchMediaRequest implements SearchMediaRequest {
  const _SearchMediaRequest({this.type, this.limit, this.cursor});
  factory _SearchMediaRequest.fromJson(Map<String, dynamic> json) => _$SearchMediaRequestFromJson(json);

@override final  String? type;
@override final  int? limit;
@override final  String? cursor;

/// Create a copy of SearchMediaRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchMediaRequestCopyWith<_SearchMediaRequest> get copyWith => __$SearchMediaRequestCopyWithImpl<_SearchMediaRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchMediaRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchMediaRequest&&(identical(other.type, type) || other.type == type)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.cursor, cursor) || other.cursor == cursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,limit,cursor);

@override
String toString() {
  return 'SearchMediaRequest(type: $type, limit: $limit, cursor: $cursor)';
}


}

/// @nodoc
abstract mixin class _$SearchMediaRequestCopyWith<$Res> implements $SearchMediaRequestCopyWith<$Res> {
  factory _$SearchMediaRequestCopyWith(_SearchMediaRequest value, $Res Function(_SearchMediaRequest) _then) = __$SearchMediaRequestCopyWithImpl;
@override @useResult
$Res call({
 String? type, int? limit, String? cursor
});




}
/// @nodoc
class __$SearchMediaRequestCopyWithImpl<$Res>
    implements _$SearchMediaRequestCopyWith<$Res> {
  __$SearchMediaRequestCopyWithImpl(this._self, this._then);

  final _SearchMediaRequest _self;
  final $Res Function(_SearchMediaRequest) _then;

/// Create a copy of SearchMediaRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? limit = freezed,Object? cursor = freezed,}) {
  return _then(_SearchMediaRequest(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
