// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outgoing_message_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OutgoingMessageDto {

 int get id; int get conversationId; MessageSenderModel get sender; String get content; String get type; DateTime get createdAt; String? get mediaUrl; String? get thumbnailUrl; String? get fileName; int? get fileSize; int? get duration; double? get latitude; double? get longitude; String? get locationName; int? get replyToMessageId; ReplyToMessageModel? get replyToMessage; Map<String, List<int>>? get reactions; List<int>? get mentions; List<MentionedUserModel>? get mentionedUsers;
/// Create a copy of OutgoingMessageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutgoingMessageDtoCopyWith<OutgoingMessageDto> get copyWith => _$OutgoingMessageDtoCopyWithImpl<OutgoingMessageDto>(this as OutgoingMessageDto, _$identity);

  /// Serializes this OutgoingMessageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutgoingMessageDto&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.replyToMessage, replyToMessage) || other.replyToMessage == replyToMessage)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&const DeepCollectionEquality().equals(other.mentions, mentions)&&const DeepCollectionEquality().equals(other.mentionedUsers, mentionedUsers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,conversationId,sender,content,type,createdAt,mediaUrl,thumbnailUrl,fileName,fileSize,duration,latitude,longitude,locationName,replyToMessageId,replyToMessage,const DeepCollectionEquality().hash(reactions),const DeepCollectionEquality().hash(mentions),const DeepCollectionEquality().hash(mentionedUsers)]);

@override
String toString() {
  return 'OutgoingMessageDto(id: $id, conversationId: $conversationId, sender: $sender, content: $content, type: $type, createdAt: $createdAt, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, duration: $duration, latitude: $latitude, longitude: $longitude, locationName: $locationName, replyToMessageId: $replyToMessageId, replyToMessage: $replyToMessage, reactions: $reactions, mentions: $mentions, mentionedUsers: $mentionedUsers)';
}


}

/// @nodoc
abstract mixin class $OutgoingMessageDtoCopyWith<$Res>  {
  factory $OutgoingMessageDtoCopyWith(OutgoingMessageDto value, $Res Function(OutgoingMessageDto) _then) = _$OutgoingMessageDtoCopyWithImpl;
@useResult
$Res call({
 int id, int conversationId, MessageSenderModel sender, String content, String type, DateTime createdAt, String? mediaUrl, String? thumbnailUrl, String? fileName, int? fileSize, int? duration, double? latitude, double? longitude, String? locationName, int? replyToMessageId, ReplyToMessageModel? replyToMessage, Map<String, List<int>>? reactions, List<int>? mentions, List<MentionedUserModel>? mentionedUsers
});


$MessageSenderModelCopyWith<$Res> get sender;$ReplyToMessageModelCopyWith<$Res>? get replyToMessage;

}
/// @nodoc
class _$OutgoingMessageDtoCopyWithImpl<$Res>
    implements $OutgoingMessageDtoCopyWith<$Res> {
  _$OutgoingMessageDtoCopyWithImpl(this._self, this._then);

  final OutgoingMessageDto _self;
  final $Res Function(OutgoingMessageDto) _then;

/// Create a copy of OutgoingMessageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? sender = null,Object? content = null,Object? type = null,Object? createdAt = null,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? fileName = freezed,Object? fileSize = freezed,Object? duration = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? locationName = freezed,Object? replyToMessageId = freezed,Object? replyToMessage = freezed,Object? reactions = freezed,Object? mentions = freezed,Object? mentionedUsers = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as MessageSenderModel,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
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
as List<int>?,mentionedUsers: freezed == mentionedUsers ? _self.mentionedUsers : mentionedUsers // ignore: cast_nullable_to_non_nullable
as List<MentionedUserModel>?,
  ));
}
/// Create a copy of OutgoingMessageDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageSenderModelCopyWith<$Res> get sender {
  
  return $MessageSenderModelCopyWith<$Res>(_self.sender, (value) {
    return _then(_self.copyWith(sender: value));
  });
}/// Create a copy of OutgoingMessageDto
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
}
}


/// Adds pattern-matching-related methods to [OutgoingMessageDto].
extension OutgoingMessageDtoPatterns on OutgoingMessageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutgoingMessageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutgoingMessageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutgoingMessageDto value)  $default,){
final _that = this;
switch (_that) {
case _OutgoingMessageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutgoingMessageDto value)?  $default,){
final _that = this;
switch (_that) {
case _OutgoingMessageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int conversationId,  MessageSenderModel sender,  String content,  String type,  DateTime createdAt,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  double? latitude,  double? longitude,  String? locationName,  int? replyToMessageId,  ReplyToMessageModel? replyToMessage,  Map<String, List<int>>? reactions,  List<int>? mentions,  List<MentionedUserModel>? mentionedUsers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutgoingMessageDto() when $default != null:
return $default(_that.id,_that.conversationId,_that.sender,_that.content,_that.type,_that.createdAt,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.latitude,_that.longitude,_that.locationName,_that.replyToMessageId,_that.replyToMessage,_that.reactions,_that.mentions,_that.mentionedUsers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int conversationId,  MessageSenderModel sender,  String content,  String type,  DateTime createdAt,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  double? latitude,  double? longitude,  String? locationName,  int? replyToMessageId,  ReplyToMessageModel? replyToMessage,  Map<String, List<int>>? reactions,  List<int>? mentions,  List<MentionedUserModel>? mentionedUsers)  $default,) {final _that = this;
switch (_that) {
case _OutgoingMessageDto():
return $default(_that.id,_that.conversationId,_that.sender,_that.content,_that.type,_that.createdAt,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.latitude,_that.longitude,_that.locationName,_that.replyToMessageId,_that.replyToMessage,_that.reactions,_that.mentions,_that.mentionedUsers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int conversationId,  MessageSenderModel sender,  String content,  String type,  DateTime createdAt,  String? mediaUrl,  String? thumbnailUrl,  String? fileName,  int? fileSize,  int? duration,  double? latitude,  double? longitude,  String? locationName,  int? replyToMessageId,  ReplyToMessageModel? replyToMessage,  Map<String, List<int>>? reactions,  List<int>? mentions,  List<MentionedUserModel>? mentionedUsers)?  $default,) {final _that = this;
switch (_that) {
case _OutgoingMessageDto() when $default != null:
return $default(_that.id,_that.conversationId,_that.sender,_that.content,_that.type,_that.createdAt,_that.mediaUrl,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.duration,_that.latitude,_that.longitude,_that.locationName,_that.replyToMessageId,_that.replyToMessage,_that.reactions,_that.mentions,_that.mentionedUsers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OutgoingMessageDto implements OutgoingMessageDto {
  const _OutgoingMessageDto({required this.id, required this.conversationId, required this.sender, required this.content, required this.type, required this.createdAt, this.mediaUrl, this.thumbnailUrl, this.fileName, this.fileSize, this.duration, this.latitude, this.longitude, this.locationName, this.replyToMessageId, this.replyToMessage, final  Map<String, List<int>>? reactions, final  List<int>? mentions, final  List<MentionedUserModel>? mentionedUsers}): _reactions = reactions,_mentions = mentions,_mentionedUsers = mentionedUsers;
  factory _OutgoingMessageDto.fromJson(Map<String, dynamic> json) => _$OutgoingMessageDtoFromJson(json);

@override final  int id;
@override final  int conversationId;
@override final  MessageSenderModel sender;
@override final  String content;
@override final  String type;
@override final  DateTime createdAt;
@override final  String? mediaUrl;
@override final  String? thumbnailUrl;
@override final  String? fileName;
@override final  int? fileSize;
@override final  int? duration;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? locationName;
@override final  int? replyToMessageId;
@override final  ReplyToMessageModel? replyToMessage;
 final  Map<String, List<int>>? _reactions;
@override Map<String, List<int>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<int>? _mentions;
@override List<int>? get mentions {
  final value = _mentions;
  if (value == null) return null;
  if (_mentions is EqualUnmodifiableListView) return _mentions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MentionedUserModel>? _mentionedUsers;
@override List<MentionedUserModel>? get mentionedUsers {
  final value = _mentionedUsers;
  if (value == null) return null;
  if (_mentionedUsers is EqualUnmodifiableListView) return _mentionedUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of OutgoingMessageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutgoingMessageDtoCopyWith<_OutgoingMessageDto> get copyWith => __$OutgoingMessageDtoCopyWithImpl<_OutgoingMessageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutgoingMessageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutgoingMessageDto&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.replyToMessage, replyToMessage) || other.replyToMessage == replyToMessage)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&const DeepCollectionEquality().equals(other._mentions, _mentions)&&const DeepCollectionEquality().equals(other._mentionedUsers, _mentionedUsers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,conversationId,sender,content,type,createdAt,mediaUrl,thumbnailUrl,fileName,fileSize,duration,latitude,longitude,locationName,replyToMessageId,replyToMessage,const DeepCollectionEquality().hash(_reactions),const DeepCollectionEquality().hash(_mentions),const DeepCollectionEquality().hash(_mentionedUsers)]);

@override
String toString() {
  return 'OutgoingMessageDto(id: $id, conversationId: $conversationId, sender: $sender, content: $content, type: $type, createdAt: $createdAt, mediaUrl: $mediaUrl, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, duration: $duration, latitude: $latitude, longitude: $longitude, locationName: $locationName, replyToMessageId: $replyToMessageId, replyToMessage: $replyToMessage, reactions: $reactions, mentions: $mentions, mentionedUsers: $mentionedUsers)';
}


}

/// @nodoc
abstract mixin class _$OutgoingMessageDtoCopyWith<$Res> implements $OutgoingMessageDtoCopyWith<$Res> {
  factory _$OutgoingMessageDtoCopyWith(_OutgoingMessageDto value, $Res Function(_OutgoingMessageDto) _then) = __$OutgoingMessageDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversationId, MessageSenderModel sender, String content, String type, DateTime createdAt, String? mediaUrl, String? thumbnailUrl, String? fileName, int? fileSize, int? duration, double? latitude, double? longitude, String? locationName, int? replyToMessageId, ReplyToMessageModel? replyToMessage, Map<String, List<int>>? reactions, List<int>? mentions, List<MentionedUserModel>? mentionedUsers
});


@override $MessageSenderModelCopyWith<$Res> get sender;@override $ReplyToMessageModelCopyWith<$Res>? get replyToMessage;

}
/// @nodoc
class __$OutgoingMessageDtoCopyWithImpl<$Res>
    implements _$OutgoingMessageDtoCopyWith<$Res> {
  __$OutgoingMessageDtoCopyWithImpl(this._self, this._then);

  final _OutgoingMessageDto _self;
  final $Res Function(_OutgoingMessageDto) _then;

/// Create a copy of OutgoingMessageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? sender = null,Object? content = null,Object? type = null,Object? createdAt = null,Object? mediaUrl = freezed,Object? thumbnailUrl = freezed,Object? fileName = freezed,Object? fileSize = freezed,Object? duration = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? locationName = freezed,Object? replyToMessageId = freezed,Object? replyToMessage = freezed,Object? reactions = freezed,Object? mentions = freezed,Object? mentionedUsers = freezed,}) {
  return _then(_OutgoingMessageDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as MessageSenderModel,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
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
as List<int>?,mentionedUsers: freezed == mentionedUsers ? _self._mentionedUsers : mentionedUsers // ignore: cast_nullable_to_non_nullable
as List<MentionedUserModel>?,
  ));
}

/// Create a copy of OutgoingMessageDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageSenderModelCopyWith<$Res> get sender {
  
  return $MessageSenderModelCopyWith<$Res>(_self.sender, (value) {
    return _then(_self.copyWith(sender: value));
  });
}/// Create a copy of OutgoingMessageDto
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
}
}

// dart format on
