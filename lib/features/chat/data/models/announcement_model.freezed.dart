// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnnouncementModel {

 int get id; int get conversationId; int get senderId; String? get senderUsername; String? get senderFullName; String get content; String get type; Map<String, List<int>>? get reactions; String get sentAt; String get createdAt; String? get updatedAt; bool get edited; bool get deleted; bool get forwarded; int get forwardCount; bool get scheduled;
/// Create a copy of AnnouncementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementModelCopyWith<AnnouncementModel> get copyWith => _$AnnouncementModelCopyWithImpl<AnnouncementModel>(this as AnnouncementModel, _$identity);

  /// Serializes this AnnouncementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnouncementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.edited, edited) || other.edited == edited)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.forwarded, forwarded) || other.forwarded == forwarded)&&(identical(other.forwardCount, forwardCount) || other.forwardCount == forwardCount)&&(identical(other.scheduled, scheduled) || other.scheduled == scheduled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,const DeepCollectionEquality().hash(reactions),sentAt,createdAt,updatedAt,edited,deleted,forwarded,forwardCount,scheduled);

@override
String toString() {
  return 'AnnouncementModel(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, reactions: $reactions, sentAt: $sentAt, createdAt: $createdAt, updatedAt: $updatedAt, edited: $edited, deleted: $deleted, forwarded: $forwarded, forwardCount: $forwardCount, scheduled: $scheduled)';
}


}

/// @nodoc
abstract mixin class $AnnouncementModelCopyWith<$Res>  {
  factory $AnnouncementModelCopyWith(AnnouncementModel value, $Res Function(AnnouncementModel) _then) = _$AnnouncementModelCopyWithImpl;
@useResult
$Res call({
 int id, int conversationId, int senderId, String? senderUsername, String? senderFullName, String content, String type, Map<String, List<int>>? reactions, String sentAt, String createdAt, String? updatedAt, bool edited, bool deleted, bool forwarded, int forwardCount, bool scheduled
});




}
/// @nodoc
class _$AnnouncementModelCopyWithImpl<$Res>
    implements $AnnouncementModelCopyWith<$Res> {
  _$AnnouncementModelCopyWithImpl(this._self, this._then);

  final AnnouncementModel _self;
  final $Res Function(AnnouncementModel) _then;

/// Create a copy of AnnouncementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = freezed,Object? senderFullName = freezed,Object? content = null,Object? type = null,Object? reactions = freezed,Object? sentAt = null,Object? createdAt = null,Object? updatedAt = freezed,Object? edited = null,Object? deleted = null,Object? forwarded = null,Object? forwardCount = null,Object? scheduled = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: freezed == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String?,senderFullName: freezed == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,reactions: freezed == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<int>>?,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,forwarded: null == forwarded ? _self.forwarded : forwarded // ignore: cast_nullable_to_non_nullable
as bool,forwardCount: null == forwardCount ? _self.forwardCount : forwardCount // ignore: cast_nullable_to_non_nullable
as int,scheduled: null == scheduled ? _self.scheduled : scheduled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AnnouncementModel].
extension AnnouncementModelPatterns on AnnouncementModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnouncementModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnouncementModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnouncementModel value)  $default,){
final _that = this;
switch (_that) {
case _AnnouncementModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnouncementModel value)?  $default,){
final _that = this;
switch (_that) {
case _AnnouncementModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  Map<String, List<int>>? reactions,  String sentAt,  String createdAt,  String? updatedAt,  bool edited,  bool deleted,  bool forwarded,  int forwardCount,  bool scheduled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnouncementModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.reactions,_that.sentAt,_that.createdAt,_that.updatedAt,_that.edited,_that.deleted,_that.forwarded,_that.forwardCount,_that.scheduled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  Map<String, List<int>>? reactions,  String sentAt,  String createdAt,  String? updatedAt,  bool edited,  bool deleted,  bool forwarded,  int forwardCount,  bool scheduled)  $default,) {final _that = this;
switch (_that) {
case _AnnouncementModel():
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.reactions,_that.sentAt,_that.createdAt,_that.updatedAt,_that.edited,_that.deleted,_that.forwarded,_that.forwardCount,_that.scheduled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int conversationId,  int senderId,  String? senderUsername,  String? senderFullName,  String content,  String type,  Map<String, List<int>>? reactions,  String sentAt,  String createdAt,  String? updatedAt,  bool edited,  bool deleted,  bool forwarded,  int forwardCount,  bool scheduled)?  $default,) {final _that = this;
switch (_that) {
case _AnnouncementModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderUsername,_that.senderFullName,_that.content,_that.type,_that.reactions,_that.sentAt,_that.createdAt,_that.updatedAt,_that.edited,_that.deleted,_that.forwarded,_that.forwardCount,_that.scheduled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnnouncementModel implements AnnouncementModel {
  const _AnnouncementModel({required this.id, required this.conversationId, required this.senderId, this.senderUsername, this.senderFullName, required this.content, required this.type, final  Map<String, List<int>>? reactions, required this.sentAt, required this.createdAt, this.updatedAt, this.edited = false, this.deleted = false, this.forwarded = false, this.forwardCount = 0, this.scheduled = false}): _reactions = reactions;
  factory _AnnouncementModel.fromJson(Map<String, dynamic> json) => _$AnnouncementModelFromJson(json);

@override final  int id;
@override final  int conversationId;
@override final  int senderId;
@override final  String? senderUsername;
@override final  String? senderFullName;
@override final  String content;
@override final  String type;
 final  Map<String, List<int>>? _reactions;
@override Map<String, List<int>>? get reactions {
  final value = _reactions;
  if (value == null) return null;
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String sentAt;
@override final  String createdAt;
@override final  String? updatedAt;
@override@JsonKey() final  bool edited;
@override@JsonKey() final  bool deleted;
@override@JsonKey() final  bool forwarded;
@override@JsonKey() final  int forwardCount;
@override@JsonKey() final  bool scheduled;

/// Create a copy of AnnouncementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementModelCopyWith<_AnnouncementModel> get copyWith => __$AnnouncementModelCopyWithImpl<_AnnouncementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnouncementModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnouncementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.edited, edited) || other.edited == edited)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.forwarded, forwarded) || other.forwarded == forwarded)&&(identical(other.forwardCount, forwardCount) || other.forwardCount == forwardCount)&&(identical(other.scheduled, scheduled) || other.scheduled == scheduled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,senderId,senderUsername,senderFullName,content,type,const DeepCollectionEquality().hash(_reactions),sentAt,createdAt,updatedAt,edited,deleted,forwarded,forwardCount,scheduled);

@override
String toString() {
  return 'AnnouncementModel(id: $id, conversationId: $conversationId, senderId: $senderId, senderUsername: $senderUsername, senderFullName: $senderFullName, content: $content, type: $type, reactions: $reactions, sentAt: $sentAt, createdAt: $createdAt, updatedAt: $updatedAt, edited: $edited, deleted: $deleted, forwarded: $forwarded, forwardCount: $forwardCount, scheduled: $scheduled)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementModelCopyWith<$Res> implements $AnnouncementModelCopyWith<$Res> {
  factory _$AnnouncementModelCopyWith(_AnnouncementModel value, $Res Function(_AnnouncementModel) _then) = __$AnnouncementModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversationId, int senderId, String? senderUsername, String? senderFullName, String content, String type, Map<String, List<int>>? reactions, String sentAt, String createdAt, String? updatedAt, bool edited, bool deleted, bool forwarded, int forwardCount, bool scheduled
});




}
/// @nodoc
class __$AnnouncementModelCopyWithImpl<$Res>
    implements _$AnnouncementModelCopyWith<$Res> {
  __$AnnouncementModelCopyWithImpl(this._self, this._then);

  final _AnnouncementModel _self;
  final $Res Function(_AnnouncementModel) _then;

/// Create a copy of AnnouncementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderUsername = freezed,Object? senderFullName = freezed,Object? content = null,Object? type = null,Object? reactions = freezed,Object? sentAt = null,Object? createdAt = null,Object? updatedAt = freezed,Object? edited = null,Object? deleted = null,Object? forwarded = null,Object? forwardCount = null,Object? scheduled = null,}) {
  return _then(_AnnouncementModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: freezed == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String?,senderFullName: freezed == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,reactions: freezed == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<int>>?,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,forwarded: null == forwarded ? _self.forwarded : forwarded // ignore: cast_nullable_to_non_nullable
as bool,forwardCount: null == forwardCount ? _self.forwardCount : forwardCount // ignore: cast_nullable_to_non_nullable
as int,scheduled: null == scheduled ? _self.scheduled : scheduled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
