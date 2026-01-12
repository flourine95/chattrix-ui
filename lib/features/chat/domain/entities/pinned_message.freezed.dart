// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pinned_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PinnedMessage {

 int get id; int get conversationId; int get senderId; String get senderUsername; String get senderFullName; String get content; String get type; Map<String, dynamic> get reactions; DateTime get sentAt; DateTime get createdAt; DateTime get updatedAt; bool get edited; bool get deleted; bool get forwarded; int get forwardCount; bool get pinned; DateTime? get pinnedAt; int? get pinnedBy; String? get pinnedByUsername; String? get pinnedByFullName; bool get scheduled;
/// Create a copy of PinnedMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinnedMessageCopyWith<PinnedMessage> get copyWith => _$PinnedMessageCopyWithImpl<PinnedMessage>(this as PinnedMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinnedMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.edited, edited) || other.edited == edited)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.forwarded, forwarded) || other.forwarded == forwarded)&&(identical(other.forwardCount, forwardCount) || other.forwardCount == forwardCount)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&(identical(other.pinnedAt, pinnedAt) || other.pinnedAt == pinnedAt)&&(identical(other.pinnedBy, pinnedBy) || other.pinnedBy == pinnedBy)&&(identical(other.pinnedByUsername, pinnedByUsername) || other.pinnedByUsername == pinnedByUsername)&&(identical(other.pinnedByFullName, pinnedByFullName) || other.pinnedByFullName == pinnedByFullName)&&(identical(other.scheduled, scheduled) || other.scheduled == scheduled));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,const DeepCollectionEquality().hash(reactions),sentAt,createdAt,updatedAt,edited,deleted,forwarded,forwardCount,pinned,pinnedAt,pinnedBy,pinnedByUsername,pinnedByFullName,scheduled]);

@override
String toString() {
  return 'PinnedMessage(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, reactions: $reactions, sentAt: $sentAt, createdAt: $createdAt, updatedAt: $updatedAt, edited: $edited, deleted: $deleted, forwarded: $forwarded, forwardCount: $forwardCount, pinned: $pinned, pinnedAt: $pinnedAt, pinnedBy: $pinnedBy, pinnedByUsername: $pinnedByUsername, pinnedByFullName: $pinnedByFullName, scheduled: $scheduled)';
}


}

/// @nodoc
abstract mixin class $PinnedMessageCopyWith<$Res>  {
  factory $PinnedMessageCopyWith(PinnedMessage value, $Res Function(PinnedMessage) _then) = _$PinnedMessageCopyWithImpl;
@useResult
$Res call({
 int id, int conversationId, int senderId, String senderUsername, String senderFullName, String content, String type, Map<String, dynamic> reactions, DateTime sentAt, DateTime createdAt, DateTime updatedAt, bool edited, bool deleted, bool forwarded, int forwardCount, bool pinned, DateTime? pinnedAt, int? pinnedBy, String? pinnedByUsername, String? pinnedByFullName, bool scheduled
});




}
/// @nodoc
class _$PinnedMessageCopyWithImpl<$Res>
    implements $PinnedMessageCopyWith<$Res> {
  _$PinnedMessageCopyWithImpl(this._self, this._then);

  final PinnedMessage _self;
  final $Res Function(PinnedMessage) _then;

/// Create a copy of PinnedMessage
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


/// Adds pattern-matching-related methods to [PinnedMessage].
extension PinnedMessagePatterns on PinnedMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinnedMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinnedMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinnedMessage value)  $default,){
final _that = this;
switch (_that) {
case _PinnedMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinnedMessage value)?  $default,){
final _that = this;
switch (_that) {
case _PinnedMessage() when $default != null:
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
case _PinnedMessage() when $default != null:
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
case _PinnedMessage():
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
case _PinnedMessage() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.reactions,_that.sentAt,_that.createdAt,_that.updatedAt,_that.edited,_that.deleted,_that.forwarded,_that.forwardCount,_that.pinned,_that.pinnedAt,_that.pinnedBy,_that.pinnedByUsername,_that.pinnedByFullName,_that.scheduled);case _:
  return null;

}
}

}

/// @nodoc


class _PinnedMessage implements PinnedMessage {
  const _PinnedMessage({required this.id, required this.conversationId, required this.senderId, required this.senderUsername, required this.senderFullName, required this.content, required this.type, required final  Map<String, dynamic> reactions, required this.sentAt, required this.createdAt, required this.updatedAt, required this.edited, required this.deleted, required this.forwarded, required this.forwardCount, required this.pinned, this.pinnedAt, this.pinnedBy, this.pinnedByUsername, this.pinnedByFullName, required this.scheduled}): _reactions = reactions;
  

@override final  int id;
@override final  int conversationId;
@override final  int senderId;
@override final  String senderUsername;
@override final  String senderFullName;
@override final  String content;
@override final  String type;
 final  Map<String, dynamic> _reactions;
@override Map<String, dynamic> get reactions {
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_reactions);
}

@override final  DateTime sentAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  bool edited;
@override final  bool deleted;
@override final  bool forwarded;
@override final  int forwardCount;
@override final  bool pinned;
@override final  DateTime? pinnedAt;
@override final  int? pinnedBy;
@override final  String? pinnedByUsername;
@override final  String? pinnedByFullName;
@override final  bool scheduled;

/// Create a copy of PinnedMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinnedMessageCopyWith<_PinnedMessage> get copyWith => __$PinnedMessageCopyWithImpl<_PinnedMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinnedMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.edited, edited) || other.edited == edited)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.forwarded, forwarded) || other.forwarded == forwarded)&&(identical(other.forwardCount, forwardCount) || other.forwardCount == forwardCount)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&(identical(other.pinnedAt, pinnedAt) || other.pinnedAt == pinnedAt)&&(identical(other.pinnedBy, pinnedBy) || other.pinnedBy == pinnedBy)&&(identical(other.pinnedByUsername, pinnedByUsername) || other.pinnedByUsername == pinnedByUsername)&&(identical(other.pinnedByFullName, pinnedByFullName) || other.pinnedByFullName == pinnedByFullName)&&(identical(other.scheduled, scheduled) || other.scheduled == scheduled));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,const DeepCollectionEquality().hash(_reactions),sentAt,createdAt,updatedAt,edited,deleted,forwarded,forwardCount,pinned,pinnedAt,pinnedBy,pinnedByUsername,pinnedByFullName,scheduled]);

@override
String toString() {
  return 'PinnedMessage(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, reactions: $reactions, sentAt: $sentAt, createdAt: $createdAt, updatedAt: $updatedAt, edited: $edited, deleted: $deleted, forwarded: $forwarded, forwardCount: $forwardCount, pinned: $pinned, pinnedAt: $pinnedAt, pinnedBy: $pinnedBy, pinnedByUsername: $pinnedByUsername, pinnedByFullName: $pinnedByFullName, scheduled: $scheduled)';
}


}

/// @nodoc
abstract mixin class _$PinnedMessageCopyWith<$Res> implements $PinnedMessageCopyWith<$Res> {
  factory _$PinnedMessageCopyWith(_PinnedMessage value, $Res Function(_PinnedMessage) _then) = __$PinnedMessageCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversationId, int senderId, String senderUsername, String senderFullName, String content, String type, Map<String, dynamic> reactions, DateTime sentAt, DateTime createdAt, DateTime updatedAt, bool edited, bool deleted, bool forwarded, int forwardCount, bool pinned, DateTime? pinnedAt, int? pinnedBy, String? pinnedByUsername, String? pinnedByFullName, bool scheduled
});




}
/// @nodoc
class __$PinnedMessageCopyWithImpl<$Res>
    implements _$PinnedMessageCopyWith<$Res> {
  __$PinnedMessageCopyWithImpl(this._self, this._then);

  final _PinnedMessage _self;
  final $Res Function(_PinnedMessage) _then;

/// Create a copy of PinnedMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = null,Object? senderFullName = null,Object? content = null,Object? type = null,Object? reactions = null,Object? sentAt = null,Object? createdAt = null,Object? updatedAt = null,Object? edited = null,Object? deleted = null,Object? forwarded = null,Object? forwardCount = null,Object? pinned = null,Object? pinnedAt = freezed,Object? pinnedBy = freezed,Object? pinnedByUsername = freezed,Object? pinnedByFullName = freezed,Object? scheduled = null,}) {
  return _then(_PinnedMessage(
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

// dart format on
