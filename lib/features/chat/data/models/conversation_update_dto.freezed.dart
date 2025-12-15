// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_update_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConversationUpdateDto {

 int get conversationId; String get updatedAt; LastMessageInfoDto? get lastMessage;
/// Create a copy of ConversationUpdateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationUpdateDtoCopyWith<ConversationUpdateDto> get copyWith => _$ConversationUpdateDtoCopyWithImpl<ConversationUpdateDto>(this as ConversationUpdateDto, _$identity);

  /// Serializes this ConversationUpdateDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationUpdateDto&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversationId,updatedAt,lastMessage);

@override
String toString() {
  return 'ConversationUpdateDto(conversationId: $conversationId, updatedAt: $updatedAt, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class $ConversationUpdateDtoCopyWith<$Res>  {
  factory $ConversationUpdateDtoCopyWith(ConversationUpdateDto value, $Res Function(ConversationUpdateDto) _then) = _$ConversationUpdateDtoCopyWithImpl;
@useResult
$Res call({
 int conversationId, String updatedAt, LastMessageInfoDto? lastMessage
});


$LastMessageInfoDtoCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class _$ConversationUpdateDtoCopyWithImpl<$Res>
    implements $ConversationUpdateDtoCopyWith<$Res> {
  _$ConversationUpdateDtoCopyWithImpl(this._self, this._then);

  final ConversationUpdateDto _self;
  final $Res Function(ConversationUpdateDto) _then;

/// Create a copy of ConversationUpdateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationId = null,Object? updatedAt = null,Object? lastMessage = freezed,}) {
  return _then(_self.copyWith(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as LastMessageInfoDto?,
  ));
}
/// Create a copy of ConversationUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastMessageInfoDtoCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $LastMessageInfoDtoCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConversationUpdateDto].
extension ConversationUpdateDtoPatterns on ConversationUpdateDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationUpdateDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationUpdateDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationUpdateDto value)  $default,){
final _that = this;
switch (_that) {
case _ConversationUpdateDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationUpdateDto value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationUpdateDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int conversationId,  String updatedAt,  LastMessageInfoDto? lastMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationUpdateDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int conversationId,  String updatedAt,  LastMessageInfoDto? lastMessage)  $default,) {final _that = this;
switch (_that) {
case _ConversationUpdateDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int conversationId,  String updatedAt,  LastMessageInfoDto? lastMessage)?  $default,) {final _that = this;
switch (_that) {
case _ConversationUpdateDto() when $default != null:
return $default(_that.conversationId,_that.updatedAt,_that.lastMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConversationUpdateDto implements ConversationUpdateDto {
  const _ConversationUpdateDto({required this.conversationId, required this.updatedAt, this.lastMessage});
  factory _ConversationUpdateDto.fromJson(Map<String, dynamic> json) => _$ConversationUpdateDtoFromJson(json);

@override final  int conversationId;
@override final  String updatedAt;
@override final  LastMessageInfoDto? lastMessage;

/// Create a copy of ConversationUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationUpdateDtoCopyWith<_ConversationUpdateDto> get copyWith => __$ConversationUpdateDtoCopyWithImpl<_ConversationUpdateDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationUpdateDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationUpdateDto&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversationId,updatedAt,lastMessage);

@override
String toString() {
  return 'ConversationUpdateDto(conversationId: $conversationId, updatedAt: $updatedAt, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class _$ConversationUpdateDtoCopyWith<$Res> implements $ConversationUpdateDtoCopyWith<$Res> {
  factory _$ConversationUpdateDtoCopyWith(_ConversationUpdateDto value, $Res Function(_ConversationUpdateDto) _then) = __$ConversationUpdateDtoCopyWithImpl;
@override @useResult
$Res call({
 int conversationId, String updatedAt, LastMessageInfoDto? lastMessage
});


@override $LastMessageInfoDtoCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class __$ConversationUpdateDtoCopyWithImpl<$Res>
    implements _$ConversationUpdateDtoCopyWith<$Res> {
  __$ConversationUpdateDtoCopyWithImpl(this._self, this._then);

  final _ConversationUpdateDto _self;
  final $Res Function(_ConversationUpdateDto) _then;

/// Create a copy of ConversationUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? updatedAt = null,Object? lastMessage = freezed,}) {
  return _then(_ConversationUpdateDto(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as LastMessageInfoDto?,
  ));
}

/// Create a copy of ConversationUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastMessageInfoDtoCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $LastMessageInfoDtoCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// @nodoc
mixin _$LastMessageInfoDto {

 int get id; String get content; int get senderId; String get senderUsername; String get sentAt; String get type;
/// Create a copy of LastMessageInfoDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LastMessageInfoDtoCopyWith<LastMessageInfoDto> get copyWith => _$LastMessageInfoDtoCopyWithImpl<LastMessageInfoDto>(this as LastMessageInfoDto, _$identity);

  /// Serializes this LastMessageInfoDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LastMessageInfoDto&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,senderId,senderUsername,sentAt,type);

@override
String toString() {
  return 'LastMessageInfoDto(id: $id, content: $content, senderId: $senderId, senderUsername: $senderUsername, sentAt: $sentAt, type: $type)';
}


}

/// @nodoc
abstract mixin class $LastMessageInfoDtoCopyWith<$Res>  {
  factory $LastMessageInfoDtoCopyWith(LastMessageInfoDto value, $Res Function(LastMessageInfoDto) _then) = _$LastMessageInfoDtoCopyWithImpl;
@useResult
$Res call({
 int id, String content, int senderId, String senderUsername, String sentAt, String type
});




}
/// @nodoc
class _$LastMessageInfoDtoCopyWithImpl<$Res>
    implements $LastMessageInfoDtoCopyWith<$Res> {
  _$LastMessageInfoDtoCopyWithImpl(this._self, this._then);

  final LastMessageInfoDto _self;
  final $Res Function(LastMessageInfoDto) _then;

/// Create a copy of LastMessageInfoDto
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


/// Adds pattern-matching-related methods to [LastMessageInfoDto].
extension LastMessageInfoDtoPatterns on LastMessageInfoDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LastMessageInfoDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LastMessageInfoDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LastMessageInfoDto value)  $default,){
final _that = this;
switch (_that) {
case _LastMessageInfoDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LastMessageInfoDto value)?  $default,){
final _that = this;
switch (_that) {
case _LastMessageInfoDto() when $default != null:
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
case _LastMessageInfoDto() when $default != null:
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
case _LastMessageInfoDto():
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
case _LastMessageInfoDto() when $default != null:
return $default(_that.id,_that.content,_that.senderId,_that.senderUsername,_that.sentAt,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LastMessageInfoDto implements LastMessageInfoDto {
  const _LastMessageInfoDto({required this.id, required this.content, required this.senderId, required this.senderUsername, required this.sentAt, required this.type});
  factory _LastMessageInfoDto.fromJson(Map<String, dynamic> json) => _$LastMessageInfoDtoFromJson(json);

@override final  int id;
@override final  String content;
@override final  int senderId;
@override final  String senderUsername;
@override final  String sentAt;
@override final  String type;

/// Create a copy of LastMessageInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LastMessageInfoDtoCopyWith<_LastMessageInfoDto> get copyWith => __$LastMessageInfoDtoCopyWithImpl<_LastMessageInfoDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LastMessageInfoDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LastMessageInfoDto&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,senderId,senderUsername,sentAt,type);

@override
String toString() {
  return 'LastMessageInfoDto(id: $id, content: $content, senderId: $senderId, senderUsername: $senderUsername, sentAt: $sentAt, type: $type)';
}


}

/// @nodoc
abstract mixin class _$LastMessageInfoDtoCopyWith<$Res> implements $LastMessageInfoDtoCopyWith<$Res> {
  factory _$LastMessageInfoDtoCopyWith(_LastMessageInfoDto value, $Res Function(_LastMessageInfoDto) _then) = __$LastMessageInfoDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String content, int senderId, String senderUsername, String sentAt, String type
});




}
/// @nodoc
class __$LastMessageInfoDtoCopyWithImpl<$Res>
    implements _$LastMessageInfoDtoCopyWith<$Res> {
  __$LastMessageInfoDtoCopyWithImpl(this._self, this._then);

  final _LastMessageInfoDto _self;
  final $Res Function(_LastMessageInfoDto) _then;

/// Create a copy of LastMessageInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? senderId = null,Object? senderUsername = null,Object? sentAt = null,Object? type = null,}) {
  return _then(_LastMessageInfoDto(
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
