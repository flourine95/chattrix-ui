// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Message {

 int get id; int get conversationId; int get senderId; String? get senderUsername; String? get senderFullName; String get content; String get type;// 'TEXT', 'IMAGE', 'VIDEO', 'AUDIO', 'FILE', 'LOCATION'
 DateTime get createdAt;@Deprecated('Use senderId, senderUsername, senderFullName instead') MessageSender? get sender;// Rich media fields
 String? get mediaUrl;// URL for image, video, audio, or document
 String? get thumbnailUrl;// Thumbnail for video or document preview
 String? get fileName;// Original file name for documents
 int? get fileSize;// File size in bytes
 int? get duration;// Duration in seconds for audio/video
// Location fields
 double? get latitude; double? get longitude; String? get locationName;// Human-readable location name
// Reply/Thread fields
 int? get replyToMessageId;// ID of message being replied to
 ReplyToMessage? get replyToMessage;// Full reply message details
// Reactions (stored as JSON string: {"👍": [userId1, userId2], "❤️": [userId3]})
 String? get reactions;// Mentions (stored as JSON string: [userId1, userId2])
 String? get mentions; List<MentionedUser> get mentionedUsers;// Timestamps
 DateTime? get sentAt; DateTime? get updatedAt;// Edit/Delete/Forward
 bool get edited; DateTime? get editedAt; bool get deleted; DateTime? get deletedAt; bool get forwarded; int? get originalMessageId; int get forwardCount;// Read receipts
 int get readCount; List<ReadReceipt> get readBy;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<Message> get copyWith => _$MessageCopyWithImpl<Message>(this as Message, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.replyToMessage, replyToMessage) || other.replyToMessage == replyToMessage)&&(identical(other.reactions, reactions) || other.reactions == reactions)&&(identical(other.mentions, mentions) || other.mentions == mentions)&&const DeepCollectionEquality().equals(other.mentionedUsers, mentionedUsers)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.edited, edited) || other.edited == edited)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.forwarded, forwarded) || other.forwarded == forwarded)&&(identical(other.originalMessageId, originalMessageId) || other.originalMessageId == originalMessageId)&&(identical(other.forwardCount, forwardCount) || other.forwardCount == forwardCount)&&(identical(other.readCount, readCount) || other.readCount == readCount)&&const DeepCollectionEquality().equals(other.readBy, readBy));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,createdAt,sender,mediaUrl,thumbnailUrl,fileName,fileSize,duration,latitude,longitude,locationName,replyToMessageId,replyToMessage,reactions,mentions,const DeepCollectionEquality().hash(mentionedUsers),sentAt,updatedAt,edited,editedAt,deleted,deletedAt,forwarded,originalMessageId,forwardCount,readCount,const DeepCollectionEquality().hash(readBy)]);

@override
String toString() {
  return 'Message(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, createdAt: $createdAt, sender: $sender, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, duration: $duration, latitude: $latitude, longitude: $longitude, locationName: $locationName, replyToMessageId: $replyToMessageId, replyToMessage: $replyToMessage, reactions: $reactions, mentions: $mentions, mentionedUsers: $mentionedUsers, sentAt: $sentAt, updatedAt: $updatedAt, edited: $edited, editedAt: $editedAt, deleted: $deleted, deletedAt: $deletedAt, forwarded: $forwarded, originalMessageId: $originalMessageId, forwardCount: $forwardCount, readCount: $readCount, readBy: $readBy)';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res>  {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
 int id, int conversationId, int senderId, String? senderUsername, String? senderFullName, String content, String type, DateTime createdAt,@Deprecated('Use senderId, senderUsername, senderFullName instead') MessageSender? sender, String? mediaUrl, String? thumbnailUrl, String? fileName, int? fileSize, int? duration, double? latitude, double? longitude, String? locationName, int? replyToMessageId, ReplyToMessage? replyToMessage, String? reactions, String? mentions, List<MentionedUser> mentionedUsers, DateTime? sentAt, DateTime? updatedAt, bool edited, DateTime? editedAt, bool deleted, DateTime? deletedAt, bool forwarded, int? originalMessageId, int forwardCount, int readCount, List<ReadReceipt> readBy
});


$MessageSenderCopyWith<$Res>? get sender;$ReplyToMessageCopyWith<$Res>? get replyToMessage;

}
/// @nodoc
class _$MessageCopyWithImpl<$Res>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = freezed,Object? senderFullName = freezed,Object? content = null,Object? type = null,Object? createdAt = null,Object? sender = freezed,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? fileName = freezed,Object? fileSize = freezed,Object? duration = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? locationName = freezed,Object? replyToMessageId = freezed,Object? replyToMessage = freezed,Object? reactions = freezed,Object? mentions = freezed,Object? mentionedUsers = null,Object? sentAt = freezed,Object? updatedAt = freezed,Object? edited = null,Object? editedAt = freezed,Object? deleted = null,Object? deletedAt = freezed,Object? forwarded = null,Object? originalMessageId = freezed,Object? forwardCount = null,Object? readCount = null,Object? readBy = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: freezed == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String?,senderFullName: freezed == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as MessageSender?,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as int?,replyToMessage: freezed == replyToMessage ? _self.replyToMessage : replyToMessage // ignore: cast_nullable_to_non_nullable
as ReplyToMessage?,reactions: freezed == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as String?,mentions: freezed == mentions ? _self.mentions : mentions // ignore: cast_nullable_to_non_nullable
as String?,mentionedUsers: null == mentionedUsers ? _self.mentionedUsers : mentionedUsers // ignore: cast_nullable_to_non_nullable
as List<MentionedUser>,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,forwarded: null == forwarded ? _self.forwarded : forwarded // ignore: cast_nullable_to_non_nullable
as bool,originalMessageId: freezed == originalMessageId ? _self.originalMessageId : originalMessageId // ignore: cast_nullable_to_non_nullable
as int?,forwardCount: null == forwardCount ? _self.forwardCount : forwardCount // ignore: cast_nullable_to_non_nullable
as int,readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,readBy: null == readBy ? _self.readBy : readBy // ignore: cast_nullable_to_non_nullable
as List<ReadReceipt>,
  ));
}
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageSenderCopyWith<$Res>? get sender {
    if (_self.sender == null) {
    return null;
  }

  return $MessageSenderCopyWith<$Res>(_self.sender!, (value) {
    return _then(_self.copyWith(sender: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplyToMessageCopyWith<$Res>? get replyToMessage {
    if (_self.replyToMessage == null) {
    return null;
  }

  return $ReplyToMessageCopyWith<$Res>(_self.replyToMessage!, (value) {
    return _then(_self.copyWith(replyToMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns on Message {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Message value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Message() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Message value)  $default,){
final _that = this;
switch (_that) {
case _Message():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Message value)?  $default,){
final _that = this;
switch (_that) {
case _Message() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  DateTime createdAt, @Deprecated('Use senderId, senderUsername, senderFullName instead')  MessageSender? sender,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  double? latitude,  double? longitude,  String? locationName,  int? replyToMessageId,  ReplyToMessage? replyToMessage,  String? reactions,  String? mentions,  List<MentionedUser> mentionedUsers,  DateTime? sentAt,  DateTime? updatedAt,  bool edited,  DateTime? editedAt,  bool deleted,  DateTime? deletedAt,  bool forwarded,  int? originalMessageId,  int forwardCount,  int readCount,  List<ReadReceipt> readBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.createdAt,_that.sender,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.latitude,_that.longitude,_that.locationName,_that.replyToMessageId,_that.replyToMessage,_that.reactions,_that.mentions,_that.mentionedUsers,_that.sentAt,_that.updatedAt,_that.edited,_that.editedAt,_that.deleted,_that.deletedAt,_that.forwarded,_that.originalMessageId,_that.forwardCount,_that.readCount,_that.readBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  DateTime createdAt, @Deprecated('Use senderId, senderUsername, senderFullName instead')  MessageSender? sender,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  double? latitude,  double? longitude,  String? locationName,  int? replyToMessageId,  ReplyToMessage? replyToMessage,  String? reactions,  String? mentions,  List<MentionedUser> mentionedUsers,  DateTime? sentAt,  DateTime? updatedAt,  bool edited,  DateTime? editedAt,  bool deleted,  DateTime? deletedAt,  bool forwarded,  int? originalMessageId,  int forwardCount,  int readCount,  List<ReadReceipt> readBy)  $default,) {final _that = this;
switch (_that) {
case _Message():
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.createdAt,_that.sender,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.latitude,_that.longitude,_that.locationName,_that.replyToMessageId,_that.replyToMessage,_that.reactions,_that.mentions,_that.mentionedUsers,_that.sentAt,_that.updatedAt,_that.edited,_that.editedAt,_that.deleted,_that.deletedAt,_that.forwarded,_that.originalMessageId,_that.forwardCount,_that.readCount,_that.readBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  DateTime createdAt, @Deprecated('Use senderId, senderUsername, senderFullName instead')  MessageSender? sender,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  double? latitude,  double? longitude,  String? locationName,  int? replyToMessageId,  ReplyToMessage? replyToMessage,  String? reactions,  String? mentions,  List<MentionedUser> mentionedUsers,  DateTime? sentAt,  DateTime? updatedAt,  bool edited,  DateTime? editedAt,  bool deleted,  DateTime? deletedAt,  bool forwarded,  int? originalMessageId,  int forwardCount,  int readCount,  List<ReadReceipt> readBy)?  $default,) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.createdAt,_that.sender,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.latitude,_that.longitude,_that.locationName,_that.replyToMessageId,_that.replyToMessage,_that.reactions,_that.mentions,_that.mentionedUsers,_that.sentAt,_that.updatedAt,_that.edited,_that.editedAt,_that.deleted,_that.deletedAt,_that.forwarded,_that.originalMessageId,_that.forwardCount,_that.readCount,_that.readBy);case _:
  return null;

}
}

}

/// @nodoc


class _Message implements Message {
  const _Message({required this.id, required this.conversationId, required this.senderId, this.senderUsername, this.senderFullName, required this.content, required this.type, required this.createdAt, @Deprecated('Use senderId, senderUsername, senderFullName instead') this.sender, this.mediaUrl, this.thumbnailUrl, this.fileName, this.fileSize, this.duration, this.latitude, this.longitude, this.locationName, this.replyToMessageId, this.replyToMessage, this.reactions, this.mentions, final  List<MentionedUser> mentionedUsers = const [], this.sentAt, this.updatedAt, this.edited = false, this.editedAt, this.deleted = false, this.deletedAt, this.forwarded = false, this.originalMessageId, this.forwardCount = 0, this.readCount = 0, final  List<ReadReceipt> readBy = const []}): _mentionedUsers = mentionedUsers,_readBy = readBy;
  

@override final  int id;
@override final  int conversationId;
@override final  int senderId;
@override final  String? senderUsername;
@override final  String? senderFullName;
@override final  String content;
@override final  String type;
// 'TEXT', 'IMAGE', 'VIDEO', 'AUDIO', 'FILE', 'LOCATION'
@override final  DateTime createdAt;
@override@Deprecated('Use senderId, senderUsername, senderFullName instead') final  MessageSender? sender;
// Rich media fields
@override final  String? mediaUrl;
// URL for image, video, audio, or document
@override final  String? thumbnailUrl;
// Thumbnail for video or document preview
@override final  String? fileName;
// Original file name for documents
@override final  int? fileSize;
// File size in bytes
@override final  int? duration;
// Duration in seconds for audio/video
// Location fields
@override final  double? latitude;
@override final  double? longitude;
@override final  String? locationName;
// Human-readable location name
// Reply/Thread fields
@override final  int? replyToMessageId;
// ID of message being replied to
@override final  ReplyToMessage? replyToMessage;
// Full reply message details
// Reactions (stored as JSON string: {"👍": [userId1, userId2], "❤️": [userId3]})
@override final  String? reactions;
// Mentions (stored as JSON string: [userId1, userId2])
@override final  String? mentions;
 final  List<MentionedUser> _mentionedUsers;
@override@JsonKey() List<MentionedUser> get mentionedUsers {
  if (_mentionedUsers is EqualUnmodifiableListView) return _mentionedUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mentionedUsers);
}

// Timestamps
@override final  DateTime? sentAt;
@override final  DateTime? updatedAt;
// Edit/Delete/Forward
@override@JsonKey() final  bool edited;
@override final  DateTime? editedAt;
@override@JsonKey() final  bool deleted;
@override final  DateTime? deletedAt;
@override@JsonKey() final  bool forwarded;
@override final  int? originalMessageId;
@override@JsonKey() final  int forwardCount;
// Read receipts
@override@JsonKey() final  int readCount;
 final  List<ReadReceipt> _readBy;
@override@JsonKey() List<ReadReceipt> get readBy {
  if (_readBy is EqualUnmodifiableListView) return _readBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readBy);
}


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageCopyWith<_Message> get copyWith => __$MessageCopyWithImpl<_Message>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Message&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.replyToMessage, replyToMessage) || other.replyToMessage == replyToMessage)&&(identical(other.reactions, reactions) || other.reactions == reactions)&&(identical(other.mentions, mentions) || other.mentions == mentions)&&const DeepCollectionEquality().equals(other._mentionedUsers, _mentionedUsers)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.edited, edited) || other.edited == edited)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.forwarded, forwarded) || other.forwarded == forwarded)&&(identical(other.originalMessageId, originalMessageId) || other.originalMessageId == originalMessageId)&&(identical(other.forwardCount, forwardCount) || other.forwardCount == forwardCount)&&(identical(other.readCount, readCount) || other.readCount == readCount)&&const DeepCollectionEquality().equals(other._readBy, _readBy));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,createdAt,sender,mediaUrl,thumbnailUrl,fileName,fileSize,duration,latitude,longitude,locationName,replyToMessageId,replyToMessage,reactions,mentions,const DeepCollectionEquality().hash(_mentionedUsers),sentAt,updatedAt,edited,editedAt,deleted,deletedAt,forwarded,originalMessageId,forwardCount,readCount,const DeepCollectionEquality().hash(_readBy)]);

@override
String toString() {
  return 'Message(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, createdAt: $createdAt, sender: $sender, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, duration: $duration, latitude: $latitude, longitude: $longitude, locationName: $locationName, replyToMessageId: $replyToMessageId, replyToMessage: $replyToMessage, reactions: $reactions, mentions: $mentions, mentionedUsers: $mentionedUsers, sentAt: $sentAt, updatedAt: $updatedAt, edited: $edited, editedAt: $editedAt, deleted: $deleted, deletedAt: $deletedAt, forwarded: $forwarded, originalMessageId: $originalMessageId, forwardCount: $forwardCount, readCount: $readCount, readBy: $readBy)';
}


}

/// @nodoc
abstract mixin class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) _then) = __$MessageCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversationId, int senderId, String? senderUsername, String? senderFullName, String content, String type, DateTime createdAt,@Deprecated('Use senderId, senderUsername, senderFullName instead') MessageSender? sender, String? mediaUrl, String? thumbnailUrl, String? fileName, int? fileSize, int? duration, double? latitude, double? longitude, String? locationName, int? replyToMessageId, ReplyToMessage? replyToMessage, String? reactions, String? mentions, List<MentionedUser> mentionedUsers, DateTime? sentAt, DateTime? updatedAt, bool edited, DateTime? editedAt, bool deleted, DateTime? deletedAt, bool forwarded, int? originalMessageId, int forwardCount, int readCount, List<ReadReceipt> readBy
});


@override $MessageSenderCopyWith<$Res>? get sender;@override $ReplyToMessageCopyWith<$Res>? get replyToMessage;

}
/// @nodoc
class __$MessageCopyWithImpl<$Res>
    implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(this._self, this._then);

  final _Message _self;
  final $Res Function(_Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = freezed,Object? senderFullName = freezed,Object? content = null,Object? type = null,Object? createdAt = null,Object? sender = freezed,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? fileName = freezed,Object? fileSize = freezed,Object? duration = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? locationName = freezed,Object? replyToMessageId = freezed,Object? replyToMessage = freezed,Object? reactions = freezed,Object? mentions = freezed,Object? mentionedUsers = null,Object? sentAt = freezed,Object? updatedAt = freezed,Object? edited = null,Object? editedAt = freezed,Object? deleted = null,Object? deletedAt = freezed,Object? forwarded = null,Object? originalMessageId = freezed,Object? forwardCount = null,Object? readCount = null,Object? readBy = null,}) {
  return _then(_Message(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: freezed == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String?,senderFullName: freezed == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as MessageSender?,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as int?,replyToMessage: freezed == replyToMessage ? _self.replyToMessage : replyToMessage // ignore: cast_nullable_to_non_nullable
as ReplyToMessage?,reactions: freezed == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as String?,mentions: freezed == mentions ? _self.mentions : mentions // ignore: cast_nullable_to_non_nullable
as String?,mentionedUsers: null == mentionedUsers ? _self._mentionedUsers : mentionedUsers // ignore: cast_nullable_to_non_nullable
as List<MentionedUser>,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,forwarded: null == forwarded ? _self.forwarded : forwarded // ignore: cast_nullable_to_non_nullable
as bool,originalMessageId: freezed == originalMessageId ? _self.originalMessageId : originalMessageId // ignore: cast_nullable_to_non_nullable
as int?,forwardCount: null == forwardCount ? _self.forwardCount : forwardCount // ignore: cast_nullable_to_non_nullable
as int,readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,readBy: null == readBy ? _self._readBy : readBy // ignore: cast_nullable_to_non_nullable
as List<ReadReceipt>,
  ));
}

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageSenderCopyWith<$Res>? get sender {
    if (_self.sender == null) {
    return null;
  }

  return $MessageSenderCopyWith<$Res>(_self.sender!, (value) {
    return _then(_self.copyWith(sender: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplyToMessageCopyWith<$Res>? get replyToMessage {
    if (_self.replyToMessage == null) {
    return null;
  }

  return $ReplyToMessageCopyWith<$Res>(_self.replyToMessage!, (value) {
    return _then(_self.copyWith(replyToMessage: value));
  });
}
}

// dart format on
