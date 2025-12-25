// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageModel implements DiagnosticableTreeMixin {

 int get id; int get conversationId; int get senderId; String? get senderUsername; String? get senderFullName; String get content; String get type; String get createdAt;// Rich media fields
 String? get mediaUrl; String? get thumbnailUrl; String? get fileName; int? get fileSize; int? get duration;// Location fields
 double? get latitude; double? get longitude; String? get locationName;// Reply/Thread fields
 int? get replyToMessageId; ReplyToMessageModel? get replyToMessage;// Reactions: Map of emoji to array of user IDs
 Map<String, List<int>>? get reactions;// Mentions: Array of user IDs
 List<int>? get mentions; List<MentionedUserModel> get mentionedUsers;// Timestamps
 String? get sentAt; String? get updatedAt;// Edit/Delete/Forward
 bool get edited; String? get editedAt; bool get deleted; String? get deletedAt; bool get forwarded; int? get originalMessageId; int get forwardCount;// Read receipts
 int get readCount; List<ReadReceiptModel> get readBy;// Scheduled message fields
 bool get scheduled; String? get scheduledTime; String? get scheduledStatus;// PENDING, SENT, CANCELLED, FAILED
// Poll data (for POLL type messages)
 PollDto? get pollData;
/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageModelCopyWith<MessageModel> get copyWith => _$MessageModelCopyWithImpl<MessageModel>(this as MessageModel, _$identity);

  /// Serializes this MessageModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MessageModel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('conversationId', conversationId))..add(DiagnosticsProperty('senderId', senderId))..add(DiagnosticsProperty('senderUsername', senderUsername))..add(DiagnosticsProperty('senderFullName', senderFullName))..add(DiagnosticsProperty('content', content))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('mediaUrl', mediaUrl))..add(DiagnosticsProperty('thumbnailUrl', thumbnailUrl))..add(DiagnosticsProperty('fileName', fileName))..add(DiagnosticsProperty('fileSize', fileSize))..add(DiagnosticsProperty('duration', duration))..add(DiagnosticsProperty('latitude', latitude))..add(DiagnosticsProperty('longitude', longitude))..add(DiagnosticsProperty('locationName', locationName))..add(DiagnosticsProperty('replyToMessageId', replyToMessageId))..add(DiagnosticsProperty('replyToMessage', replyToMessage))..add(DiagnosticsProperty('reactions', reactions))..add(DiagnosticsProperty('mentions', mentions))..add(DiagnosticsProperty('mentionedUsers', mentionedUsers))..add(DiagnosticsProperty('sentAt', sentAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('edited', edited))..add(DiagnosticsProperty('editedAt', editedAt))..add(DiagnosticsProperty('deleted', deleted))..add(DiagnosticsProperty('deletedAt', deletedAt))..add(DiagnosticsProperty('forwarded', forwarded))..add(DiagnosticsProperty('originalMessageId', originalMessageId))..add(DiagnosticsProperty('forwardCount', forwardCount))..add(DiagnosticsProperty('readCount', readCount))..add(DiagnosticsProperty('readBy', readBy))..add(DiagnosticsProperty('scheduled', scheduled))..add(DiagnosticsProperty('scheduledTime', scheduledTime))..add(DiagnosticsProperty('scheduledStatus', scheduledStatus))..add(DiagnosticsProperty('pollData', pollData));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.replyToMessage, replyToMessage) || other.replyToMessage == replyToMessage)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&const DeepCollectionEquality().equals(other.mentions, mentions)&&const DeepCollectionEquality().equals(other.mentionedUsers, mentionedUsers)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.edited, edited) || other.edited == edited)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.forwarded, forwarded) || other.forwarded == forwarded)&&(identical(other.originalMessageId, originalMessageId) || other.originalMessageId == originalMessageId)&&(identical(other.forwardCount, forwardCount) || other.forwardCount == forwardCount)&&(identical(other.readCount, readCount) || other.readCount == readCount)&&const DeepCollectionEquality().equals(other.readBy, readBy)&&(identical(other.scheduled, scheduled) || other.scheduled == scheduled)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.scheduledStatus, scheduledStatus) || other.scheduledStatus == scheduledStatus)&&(identical(other.pollData, pollData) || other.pollData == pollData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,createdAt,mediaUrl,thumbnailUrl,fileName,fileSize,duration,latitude,longitude,locationName,replyToMessageId,replyToMessage,const DeepCollectionEquality().hash(reactions),const DeepCollectionEquality().hash(mentions),const DeepCollectionEquality().hash(mentionedUsers),sentAt,updatedAt,edited,editedAt,deleted,deletedAt,forwarded,originalMessageId,forwardCount,readCount,const DeepCollectionEquality().hash(readBy),scheduled,scheduledTime,scheduledStatus,pollData]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MessageModel(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, createdAt: $createdAt, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, duration: $duration, latitude: $latitude, longitude: $longitude, locationName: $locationName, replyToMessageId: $replyToMessageId, replyToMessage: $replyToMessage, reactions: $reactions, mentions: $mentions, mentionedUsers: $mentionedUsers, sentAt: $sentAt, updatedAt: $updatedAt, edited: $edited, editedAt: $editedAt, deleted: $deleted, deletedAt: $deletedAt, forwarded: $forwarded, originalMessageId: $originalMessageId, forwardCount: $forwardCount, readCount: $readCount, readBy: $readBy, scheduled: $scheduled, scheduledTime: $scheduledTime, scheduledStatus: $scheduledStatus, pollData: $pollData)';
}


}

/// @nodoc
abstract mixin class $MessageModelCopyWith<$Res>  {
  factory $MessageModelCopyWith(MessageModel value, $Res Function(MessageModel) _then) = _$MessageModelCopyWithImpl;
@useResult
$Res call({
 int id, int conversationId, int senderId, String? senderUsername, String? senderFullName, String content, String type, String createdAt, String? mediaUrl, String? thumbnailUrl, String? fileName, int? fileSize, int? duration, double? latitude, double? longitude, String? locationName, int? replyToMessageId, ReplyToMessageModel? replyToMessage, Map<String, List<int>>? reactions, List<int>? mentions, List<MentionedUserModel> mentionedUsers, String? sentAt, String? updatedAt, bool edited, String? editedAt, bool deleted, String? deletedAt, bool forwarded, int? originalMessageId, int forwardCount, int readCount, List<ReadReceiptModel> readBy, bool scheduled, String? scheduledTime, String? scheduledStatus, PollDto? pollData
});


$ReplyToMessageModelCopyWith<$Res>? get replyToMessage;$PollDtoCopyWith<$Res>? get pollData;

}
/// @nodoc
class _$MessageModelCopyWithImpl<$Res>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._self, this._then);

  final MessageModel _self;
  final $Res Function(MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = freezed,Object? senderFullName = freezed,Object? content = null,Object? type = null,Object? createdAt = null,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? fileName = freezed,Object? fileSize = freezed,Object? duration = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? locationName = freezed,Object? replyToMessageId = freezed,Object? replyToMessage = freezed,Object? reactions = freezed,Object? mentions = freezed,Object? mentionedUsers = null,Object? sentAt = freezed,Object? updatedAt = freezed,Object? edited = null,Object? editedAt = freezed,Object? deleted = null,Object? deletedAt = freezed,Object? forwarded = null,Object? originalMessageId = freezed,Object? forwardCount = null,Object? readCount = null,Object? readBy = null,Object? scheduled = null,Object? scheduledTime = freezed,Object? scheduledStatus = freezed,Object? pollData = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: freezed == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String?,senderFullName: freezed == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as int?,replyToMessage: freezed == replyToMessage ? _self.replyToMessage : replyToMessage // ignore: cast_nullable_to_non_nullable
as ReplyToMessageModel?,reactions: freezed == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<int>>?,mentions: freezed == mentions ? _self.mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<int>?,mentionedUsers: null == mentionedUsers ? _self.mentionedUsers : mentionedUsers // ignore: cast_nullable_to_non_nullable
as List<MentionedUserModel>,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as String?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as String?,forwarded: null == forwarded ? _self.forwarded : forwarded // ignore: cast_nullable_to_non_nullable
as bool,originalMessageId: freezed == originalMessageId ? _self.originalMessageId : originalMessageId // ignore: cast_nullable_to_non_nullable
as int?,forwardCount: null == forwardCount ? _self.forwardCount : forwardCount // ignore: cast_nullable_to_non_nullable
as int,readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,readBy: null == readBy ? _self.readBy : readBy // ignore: cast_nullable_to_non_nullable
as List<ReadReceiptModel>,scheduled: null == scheduled ? _self.scheduled : scheduled // ignore: cast_nullable_to_non_nullable
as bool,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as String?,scheduledStatus: freezed == scheduledStatus ? _self.scheduledStatus : scheduledStatus // ignore: cast_nullable_to_non_nullable
as String?,pollData: freezed == pollData ? _self.pollData : pollData // ignore: cast_nullable_to_non_nullable
as PollDto?,
  ));
}
/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplyToMessageModelCopyWith<$Res>? get replyToMessage {
    if (_self.replyToMessage == null) {
    return null;
  }

  return $ReplyToMessageModelCopyWith<$Res>(_self.replyToMessage!, (value) {
    return _then(_self.copyWith(replyToMessage: value));
  });
}/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PollDtoCopyWith<$Res>? get pollData {
    if (_self.pollData == null) {
    return null;
  }

  return $PollDtoCopyWith<$Res>(_self.pollData!, (value) {
    return _then(_self.copyWith(pollData: value));
  });
}
}


/// Adds pattern-matching-related methods to [MessageModel].
extension MessageModelPatterns on MessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  String createdAt,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  double? latitude,  double? longitude,  String? locationName,  int? replyToMessageId,  ReplyToMessageModel? replyToMessage,  Map<String, List<int>>? reactions,  List<int>? mentions,  List<MentionedUserModel> mentionedUsers,  String? sentAt,  String? updatedAt,  bool edited,  String? editedAt,  bool deleted,  String? deletedAt,  bool forwarded,  int? originalMessageId,  int forwardCount,  int readCount,  List<ReadReceiptModel> readBy,  bool scheduled,  String? scheduledTime,  String? scheduledStatus,  PollDto? pollData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.createdAt,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.latitude,_that.longitude,_that.locationName,_that.replyToMessageId,_that.replyToMessage,_that.reactions,_that.mentions,_that.mentionedUsers,_that.sentAt,_that.updatedAt,_that.edited,_that.editedAt,_that.deleted,_that.deletedAt,_that.forwarded,_that.originalMessageId,_that.forwardCount,_that.readCount,_that.readBy,_that.scheduled,_that.scheduledTime,_that.scheduledStatus,_that.pollData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  String createdAt,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  double? latitude,  double? longitude,  String? locationName,  int? replyToMessageId,  ReplyToMessageModel? replyToMessage,  Map<String, List<int>>? reactions,  List<int>? mentions,  List<MentionedUserModel> mentionedUsers,  String? sentAt,  String? updatedAt,  bool edited,  String? editedAt,  bool deleted,  String? deletedAt,  bool forwarded,  int? originalMessageId,  int forwardCount,  int readCount,  List<ReadReceiptModel> readBy,  bool scheduled,  String? scheduledTime,  String? scheduledStatus,  PollDto? pollData)  $default,) {final _that = this;
switch (_that) {
case _MessageModel():
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.createdAt,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.latitude,_that.longitude,_that.locationName,_that.replyToMessageId,_that.replyToMessage,_that.reactions,_that.mentions,_that.mentionedUsers,_that.sentAt,_that.updatedAt,_that.edited,_that.editedAt,_that.deleted,_that.deletedAt,_that.forwarded,_that.originalMessageId,_that.forwardCount,_that.readCount,_that.readBy,_that.scheduled,_that.scheduledTime,_that.scheduledStatus,_that.pollData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  String createdAt,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  double? latitude,  double? longitude,  String? locationName,  int? replyToMessageId,  ReplyToMessageModel? replyToMessage,  Map<String, List<int>>? reactions,  List<int>? mentions,  List<MentionedUserModel> mentionedUsers,  String? sentAt,  String? updatedAt,  bool edited,  String? editedAt,  bool deleted,  String? deletedAt,  bool forwarded,  int? originalMessageId,  int forwardCount,  int readCount,  List<ReadReceiptModel> readBy,  bool scheduled,  String? scheduledTime,  String? scheduledStatus,  PollDto? pollData)?  $default,) {final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.createdAt,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.latitude,_that.longitude,_that.locationName,_that.replyToMessageId,_that.replyToMessage,_that.reactions,_that.mentions,_that.mentionedUsers,_that.sentAt,_that.updatedAt,_that.edited,_that.editedAt,_that.deleted,_that.deletedAt,_that.forwarded,_that.originalMessageId,_that.forwardCount,_that.readCount,_that.readBy,_that.scheduled,_that.scheduledTime,_that.scheduledStatus,_that.pollData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageModel extends MessageModel with DiagnosticableTreeMixin {
  const _MessageModel({required this.id, required this.conversationId, required this.senderId, this.senderUsername, this.senderFullName, required this.content, required this.type, required this.createdAt, this.mediaUrl, this.thumbnailUrl, this.fileName, this.fileSize, this.duration, this.latitude, this.longitude, this.locationName, this.replyToMessageId, this.replyToMessage, final  Map<String, List<int>>? reactions, final  List<int>? mentions, final  List<MentionedUserModel> mentionedUsers = const [], this.sentAt, this.updatedAt, this.edited = false, this.editedAt, this.deleted = false, this.deletedAt, this.forwarded = false, this.originalMessageId, this.forwardCount = 0, this.readCount = 0, final  List<ReadReceiptModel> readBy = const [], this.scheduled = false, this.scheduledTime, this.scheduledStatus, this.pollData}): _reactions = reactions,_mentions = mentions,_mentionedUsers = mentionedUsers,_readBy = readBy,super._();
  factory _MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

@override final  int id;
@override final  int conversationId;
@override final  int senderId;
@override final  String? senderUsername;
@override final  String? senderFullName;
@override final  String content;
@override final  String type;
@override final  String createdAt;
// Rich media fields
@override final  String? mediaUrl;
@override final  String? thumbnailUrl;
@override final  String? fileName;
@override final  int? fileSize;
@override final  int? duration;
// Location fields
@override final  double? latitude;
@override final  double? longitude;
@override final  String? locationName;
// Reply/Thread fields
@override final  int? replyToMessageId;
@override final  ReplyToMessageModel? replyToMessage;
// Reactions: Map of emoji to array of user IDs
 final  Map<String, List<int>>? _reactions;
// Reactions: Map of emoji to array of user IDs
@override Map<String, List<int>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Mentions: Array of user IDs
 final  List<int>? _mentions;
// Mentions: Array of user IDs
@override List<int>? get mentions {
  final value = _mentions;
  if (value == null) return null;
  if (_mentions is EqualUnmodifiableListView) return _mentions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MentionedUserModel> _mentionedUsers;
@override@JsonKey() List<MentionedUserModel> get mentionedUsers {
  if (_mentionedUsers is EqualUnmodifiableListView) return _mentionedUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mentionedUsers);
}

// Timestamps
@override final  String? sentAt;
@override final  String? updatedAt;
// Edit/Delete/Forward
@override@JsonKey() final  bool edited;
@override final  String? editedAt;
@override@JsonKey() final  bool deleted;
@override final  String? deletedAt;
@override@JsonKey() final  bool forwarded;
@override final  int? originalMessageId;
@override@JsonKey() final  int forwardCount;
// Read receipts
@override@JsonKey() final  int readCount;
 final  List<ReadReceiptModel> _readBy;
@override@JsonKey() List<ReadReceiptModel> get readBy {
  if (_readBy is EqualUnmodifiableListView) return _readBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readBy);
}

// Scheduled message fields
@override@JsonKey() final  bool scheduled;
@override final  String? scheduledTime;
@override final  String? scheduledStatus;
// PENDING, SENT, CANCELLED, FAILED
// Poll data (for POLL type messages)
@override final  PollDto? pollData;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageModelCopyWith<_MessageModel> get copyWith => __$MessageModelCopyWithImpl<_MessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MessageModel'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('conversationId', conversationId))..add(DiagnosticsProperty('senderId', senderId))..add(DiagnosticsProperty('senderUsername', senderUsername))..add(DiagnosticsProperty('senderFullName', senderFullName))..add(DiagnosticsProperty('content', content))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('mediaUrl', mediaUrl))..add(DiagnosticsProperty('thumbnailUrl', thumbnailUrl))..add(DiagnosticsProperty('fileName', fileName))..add(DiagnosticsProperty('fileSize', fileSize))..add(DiagnosticsProperty('duration', duration))..add(DiagnosticsProperty('latitude', latitude))..add(DiagnosticsProperty('longitude', longitude))..add(DiagnosticsProperty('locationName', locationName))..add(DiagnosticsProperty('replyToMessageId', replyToMessageId))..add(DiagnosticsProperty('replyToMessage', replyToMessage))..add(DiagnosticsProperty('reactions', reactions))..add(DiagnosticsProperty('mentions', mentions))..add(DiagnosticsProperty('mentionedUsers', mentionedUsers))..add(DiagnosticsProperty('sentAt', sentAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('edited', edited))..add(DiagnosticsProperty('editedAt', editedAt))..add(DiagnosticsProperty('deleted', deleted))..add(DiagnosticsProperty('deletedAt', deletedAt))..add(DiagnosticsProperty('forwarded', forwarded))..add(DiagnosticsProperty('originalMessageId', originalMessageId))..add(DiagnosticsProperty('forwardCount', forwardCount))..add(DiagnosticsProperty('readCount', readCount))..add(DiagnosticsProperty('readBy', readBy))..add(DiagnosticsProperty('scheduled', scheduled))..add(DiagnosticsProperty('scheduledTime', scheduledTime))..add(DiagnosticsProperty('scheduledStatus', scheduledStatus))..add(DiagnosticsProperty('pollData', pollData));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.replyToMessage, replyToMessage) || other.replyToMessage == replyToMessage)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&const DeepCollectionEquality().equals(other._mentions, _mentions)&&const DeepCollectionEquality().equals(other._mentionedUsers, _mentionedUsers)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.edited, edited) || other.edited == edited)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.forwarded, forwarded) || other.forwarded == forwarded)&&(identical(other.originalMessageId, originalMessageId) || other.originalMessageId == originalMessageId)&&(identical(other.forwardCount, forwardCount) || other.forwardCount == forwardCount)&&(identical(other.readCount, readCount) || other.readCount == readCount)&&const DeepCollectionEquality().equals(other._readBy, _readBy)&&(identical(other.scheduled, scheduled) || other.scheduled == scheduled)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.scheduledStatus, scheduledStatus) || other.scheduledStatus == scheduledStatus)&&(identical(other.pollData, pollData) || other.pollData == pollData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,createdAt,mediaUrl,thumbnailUrl,fileName,fileSize,duration,latitude,longitude,locationName,replyToMessageId,replyToMessage,const DeepCollectionEquality().hash(_reactions),const DeepCollectionEquality().hash(_mentions),const DeepCollectionEquality().hash(_mentionedUsers),sentAt,updatedAt,edited,editedAt,deleted,deletedAt,forwarded,originalMessageId,forwardCount,readCount,const DeepCollectionEquality().hash(_readBy),scheduled,scheduledTime,scheduledStatus,pollData]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MessageModel(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, createdAt: $createdAt, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, duration: $duration, latitude: $latitude, longitude: $longitude, locationName: $locationName, replyToMessageId: $replyToMessageId, replyToMessage: $replyToMessage, reactions: $reactions, mentions: $mentions, mentionedUsers: $mentionedUsers, sentAt: $sentAt, updatedAt: $updatedAt, edited: $edited, editedAt: $editedAt, deleted: $deleted, deletedAt: $deletedAt, forwarded: $forwarded, originalMessageId: $originalMessageId, forwardCount: $forwardCount, readCount: $readCount, readBy: $readBy, scheduled: $scheduled, scheduledTime: $scheduledTime, scheduledStatus: $scheduledStatus, pollData: $pollData)';
}


}

/// @nodoc
abstract mixin class _$MessageModelCopyWith<$Res> implements $MessageModelCopyWith<$Res> {
  factory _$MessageModelCopyWith(_MessageModel value, $Res Function(_MessageModel) _then) = __$MessageModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversationId, int senderId, String? senderUsername, String? senderFullName, String content, String type, String createdAt, String? mediaUrl, String? thumbnailUrl, String? fileName, int? fileSize, int? duration, double? latitude, double? longitude, String? locationName, int? replyToMessageId, ReplyToMessageModel? replyToMessage, Map<String, List<int>>? reactions, List<int>? mentions, List<MentionedUserModel> mentionedUsers, String? sentAt, String? updatedAt, bool edited, String? editedAt, bool deleted, String? deletedAt, bool forwarded, int? originalMessageId, int forwardCount, int readCount, List<ReadReceiptModel> readBy, bool scheduled, String? scheduledTime, String? scheduledStatus, PollDto? pollData
});


@override $ReplyToMessageModelCopyWith<$Res>? get replyToMessage;@override $PollDtoCopyWith<$Res>? get pollData;

}
/// @nodoc
class __$MessageModelCopyWithImpl<$Res>
    implements _$MessageModelCopyWith<$Res> {
  __$MessageModelCopyWithImpl(this._self, this._then);

  final _MessageModel _self;
  final $Res Function(_MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = freezed,Object? senderFullName = freezed,Object? content = null,Object? type = null,Object? createdAt = null,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? fileName = freezed,Object? fileSize = freezed,Object? duration = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? locationName = freezed,Object? replyToMessageId = freezed,Object? replyToMessage = freezed,Object? reactions = freezed,Object? mentions = freezed,Object? mentionedUsers = null,Object? sentAt = freezed,Object? updatedAt = freezed,Object? edited = null,Object? editedAt = freezed,Object? deleted = null,Object? deletedAt = freezed,Object? forwarded = null,Object? originalMessageId = freezed,Object? forwardCount = null,Object? readCount = null,Object? readBy = null,Object? scheduled = null,Object? scheduledTime = freezed,Object? scheduledStatus = freezed,Object? pollData = freezed,}) {
  return _then(_MessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: freezed == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String?,senderFullName: freezed == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as int?,replyToMessage: freezed == replyToMessage ? _self.replyToMessage : replyToMessage // ignore: cast_nullable_to_non_nullable
as ReplyToMessageModel?,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<int>>?,mentions: freezed == mentions ? _self._mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<int>?,mentionedUsers: null == mentionedUsers ? _self._mentionedUsers : mentionedUsers // ignore: cast_nullable_to_non_nullable
as List<MentionedUserModel>,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as String?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as String?,forwarded: null == forwarded ? _self.forwarded : forwarded // ignore: cast_nullable_to_non_nullable
as bool,originalMessageId: freezed == originalMessageId ? _self.originalMessageId : originalMessageId // ignore: cast_nullable_to_non_nullable
as int?,forwardCount: null == forwardCount ? _self.forwardCount : forwardCount // ignore: cast_nullable_to_non_nullable
as int,readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,readBy: null == readBy ? _self._readBy : readBy // ignore: cast_nullable_to_non_nullable
as List<ReadReceiptModel>,scheduled: null == scheduled ? _self.scheduled : scheduled // ignore: cast_nullable_to_non_nullable
as bool,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as String?,scheduledStatus: freezed == scheduledStatus ? _self.scheduledStatus : scheduledStatus // ignore: cast_nullable_to_non_nullable
as String?,pollData: freezed == pollData ? _self.pollData : pollData // ignore: cast_nullable_to_non_nullable
as PollDto?,
  ));
}

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReplyToMessageModelCopyWith<$Res>? get replyToMessage {
    if (_self.replyToMessage == null) {
    return null;
  }

  return $ReplyToMessageModelCopyWith<$Res>(_self.replyToMessage!, (value) {
    return _then(_self.copyWith(replyToMessage: value));
  });
}/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PollDtoCopyWith<$Res>? get pollData {
    if (_self.pollData == null) {
    return null;
  }

  return $PollDtoCopyWith<$Res>(_self.pollData!, (value) {
    return _then(_self.copyWith(pollData: value));
  });
}
}

// dart format on
