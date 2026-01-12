// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConversationUpdate {

 int get conversationId; String get updatedAt; LastMessageInfo? get lastMessage;
/// Create a copy of ConversationUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationUpdateCopyWith<ConversationUpdate> get copyWith => _$ConversationUpdateCopyWithImpl<ConversationUpdate>(this as ConversationUpdate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationUpdate&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,updatedAt,lastMessage);

@override
String toString() {
  return 'ConversationUpdate(conversationId: $conversationId, updatedAt: $updatedAt, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class $ConversationUpdateCopyWith<$Res>  {
  factory $ConversationUpdateCopyWith(ConversationUpdate value, $Res Function(ConversationUpdate) _then) = _$ConversationUpdateCopyWithImpl;
@useResult
$Res call({
 int conversationId, String updatedAt, LastMessageInfo? lastMessage
});


$LastMessageInfoCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class _$ConversationUpdateCopyWithImpl<$Res>
    implements $ConversationUpdateCopyWith<$Res> {
  _$ConversationUpdateCopyWithImpl(this._self, this._then);

  final ConversationUpdate _self;
  final $Res Function(ConversationUpdate) _then;

/// Create a copy of ConversationUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationId = null,Object? updatedAt = null,Object? lastMessage = freezed,}) {
  return _then(_self.copyWith(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as LastMessageInfo?,
  ));
}
/// Create a copy of ConversationUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastMessageInfoCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $LastMessageInfoCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConversationUpdate].
extension ConversationUpdatePatterns on ConversationUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationUpdate value)  $default,){
final _that = this;
switch (_that) {
case _ConversationUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int conversationId,  String updatedAt,  LastMessageInfo? lastMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationUpdate() when $default != null:
return $default(_that.conversationId,_that.updatedAt,_that.lastMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int conversationId,  String updatedAt,  LastMessageInfo? lastMessage)  $default,) {final _that = this;
switch (_that) {
case _ConversationUpdate():
return $default(_that.conversationId,_that.updatedAt,_that.lastMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int conversationId,  String updatedAt,  LastMessageInfo? lastMessage)?  $default,) {final _that = this;
switch (_that) {
case _ConversationUpdate() when $default != null:
return $default(_that.conversationId,_that.updatedAt,_that.lastMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ConversationUpdate extends ConversationUpdate {
  const _ConversationUpdate({required this.conversationId, required this.updatedAt, this.lastMessage}): super._();
  

@override final  int conversationId;
@override final  String updatedAt;
@override final  LastMessageInfo? lastMessage;

/// Create a copy of ConversationUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationUpdateCopyWith<_ConversationUpdate> get copyWith => __$ConversationUpdateCopyWithImpl<_ConversationUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationUpdate&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,updatedAt,lastMessage);

@override
String toString() {
  return 'ConversationUpdate(conversationId: $conversationId, updatedAt: $updatedAt, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class _$ConversationUpdateCopyWith<$Res> implements $ConversationUpdateCopyWith<$Res> {
  factory _$ConversationUpdateCopyWith(_ConversationUpdate value, $Res Function(_ConversationUpdate) _then) = __$ConversationUpdateCopyWithImpl;
@override @useResult
$Res call({
 int conversationId, String updatedAt, LastMessageInfo? lastMessage
});


@override $LastMessageInfoCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class __$ConversationUpdateCopyWithImpl<$Res>
    implements _$ConversationUpdateCopyWith<$Res> {
  __$ConversationUpdateCopyWithImpl(this._self, this._then);

  final _ConversationUpdate _self;
  final $Res Function(_ConversationUpdate) _then;

/// Create a copy of ConversationUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? updatedAt = null,Object? lastMessage = freezed,}) {
  return _then(_ConversationUpdate(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as LastMessageInfo?,
  ));
}

/// Create a copy of ConversationUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastMessageInfoCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $LastMessageInfoCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}

/// @nodoc
mixin _$LastMessageInfo {

 int get id; String get content; int get senderId; String get senderUsername; String get sentAt; String get type;
/// Create a copy of LastMessageInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LastMessageInfoCopyWith<LastMessageInfo> get copyWith => _$LastMessageInfoCopyWithImpl<LastMessageInfo>(this as LastMessageInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LastMessageInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,senderId,senderUsername,sentAt,type);

@override
String toString() {
  return 'LastMessageInfo(id: $id, content: $content, senderId: $senderId, senderUsername: $senderUsername, sentAt: $sentAt, type: $type)';
}


}

/// @nodoc
abstract mixin class $LastMessageInfoCopyWith<$Res>  {
  factory $LastMessageInfoCopyWith(LastMessageInfo value, $Res Function(LastMessageInfo) _then) = _$LastMessageInfoCopyWithImpl;
@useResult
$Res call({
 int id, String content, int senderId, String senderUsername, String sentAt, String type
});




}
/// @nodoc
class _$LastMessageInfoCopyWithImpl<$Res>
    implements $LastMessageInfoCopyWith<$Res> {
  _$LastMessageInfoCopyWithImpl(this._self, this._then);

  final LastMessageInfo _self;
  final $Res Function(LastMessageInfo) _then;

/// Create a copy of LastMessageInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? senderId = null,Object? senderUsername = null,Object? sentAt = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: null == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LastMessageInfo].
extension LastMessageInfoPatterns on LastMessageInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LastMessageInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LastMessageInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LastMessageInfo value)  $default,){
final _that = this;
switch (_that) {
case _LastMessageInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LastMessageInfo value)?  $default,){
final _that = this;
switch (_that) {
case _LastMessageInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String content,  int senderId,  String senderUsername,  String sentAt,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LastMessageInfo() when $default != null:
return $default(_that.id,_that.content,_that.senderId,_that.senderUsername,_that.sentAt,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String content,  int senderId,  String senderUsername,  String sentAt,  String type)  $default,) {final _that = this;
switch (_that) {
case _LastMessageInfo():
return $default(_that.id,_that.content,_that.senderId,_that.senderUsername,_that.sentAt,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String content,  int senderId,  String senderUsername,  String sentAt,  String type)?  $default,) {final _that = this;
switch (_that) {
case _LastMessageInfo() when $default != null:
return $default(_that.id,_that.content,_that.senderId,_that.senderUsername,_that.sentAt,_that.type);case _:
  return null;

}
}

}

/// @nodoc


class _LastMessageInfo extends LastMessageInfo {
  const _LastMessageInfo({required this.id, required this.content, required this.senderId, required this.senderUsername, required this.sentAt, required this.type}): super._();
  

@override final  int id;
@override final  String content;
@override final  int senderId;
@override final  String senderUsername;
@override final  String sentAt;
@override final  String type;

/// Create a copy of LastMessageInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LastMessageInfoCopyWith<_LastMessageInfo> get copyWith => __$LastMessageInfoCopyWithImpl<_LastMessageInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LastMessageInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,senderId,senderUsername,sentAt,type);

@override
String toString() {
  return 'LastMessageInfo(id: $id, content: $content, senderId: $senderId, senderUsername: $senderUsername, sentAt: $sentAt, type: $type)';
}


}

/// @nodoc
abstract mixin class _$LastMessageInfoCopyWith<$Res> implements $LastMessageInfoCopyWith<$Res> {
  factory _$LastMessageInfoCopyWith(_LastMessageInfo value, $Res Function(_LastMessageInfo) _then) = __$LastMessageInfoCopyWithImpl;
@override @useResult
$Res call({
 int id, String content, int senderId, String senderUsername, String sentAt, String type
});




}
/// @nodoc
class __$LastMessageInfoCopyWithImpl<$Res>
    implements _$LastMessageInfoCopyWith<$Res> {
  __$LastMessageInfoCopyWithImpl(this._self, this._then);

  final _LastMessageInfo _self;
  final $Res Function(_LastMessageInfo) _then;

/// Create a copy of LastMessageInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? senderId = null,Object? senderUsername = null,Object? sentAt = null,Object? type = null,}) {
  return _then(_LastMessageInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: null == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
