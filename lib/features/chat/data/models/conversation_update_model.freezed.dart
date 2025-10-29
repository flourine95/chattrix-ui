// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_update_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConversationUpdateModel {

 int get conversationId; String get updatedAt; LastMessageInfoModel? get lastMessage;
/// Create a copy of ConversationUpdateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationUpdateModelCopyWith<ConversationUpdateModel> get copyWith => _$ConversationUpdateModelCopyWithImpl<ConversationUpdateModel>(this as ConversationUpdateModel, _$identity);

  /// Serializes this ConversationUpdateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationUpdateModel&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversationId,updatedAt,lastMessage);

@override
String toString() {
  return 'ConversationUpdateModel(conversationId: $conversationId, updatedAt: $updatedAt, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class $ConversationUpdateModelCopyWith<$Res>  {
  factory $ConversationUpdateModelCopyWith(ConversationUpdateModel value, $Res Function(ConversationUpdateModel) _then) = _$ConversationUpdateModelCopyWithImpl;
@useResult
$Res call({
 int conversationId, String updatedAt, LastMessageInfoModel? lastMessage
});


$LastMessageInfoModelCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class _$ConversationUpdateModelCopyWithImpl<$Res>
    implements $ConversationUpdateModelCopyWith<$Res> {
  _$ConversationUpdateModelCopyWithImpl(this._self, this._then);

  final ConversationUpdateModel _self;
  final $Res Function(ConversationUpdateModel) _then;

/// Create a copy of ConversationUpdateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationId = null,Object? updatedAt = null,Object? lastMessage = freezed,}) {
  return _then(_self.copyWith(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as LastMessageInfoModel?,
  ));
}
/// Create a copy of ConversationUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastMessageInfoModelCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $LastMessageInfoModelCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConversationUpdateModel].
extension ConversationUpdateModelPatterns on ConversationUpdateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationUpdateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationUpdateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationUpdateModel value)  $default,){
final _that = this;
switch (_that) {
case _ConversationUpdateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationUpdateModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationUpdateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int conversationId,  String updatedAt,  LastMessageInfoModel? lastMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationUpdateModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int conversationId,  String updatedAt,  LastMessageInfoModel? lastMessage)  $default,) {final _that = this;
switch (_that) {
case _ConversationUpdateModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int conversationId,  String updatedAt,  LastMessageInfoModel? lastMessage)?  $default,) {final _that = this;
switch (_that) {
case _ConversationUpdateModel() when $default != null:
return $default(_that.conversationId,_that.updatedAt,_that.lastMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConversationUpdateModel extends ConversationUpdateModel {
  const _ConversationUpdateModel({required this.conversationId, required this.updatedAt, this.lastMessage}): super._();
  factory _ConversationUpdateModel.fromJson(Map<String, dynamic> json) => _$ConversationUpdateModelFromJson(json);

@override final  int conversationId;
@override final  String updatedAt;
@override final  LastMessageInfoModel? lastMessage;

/// Create a copy of ConversationUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationUpdateModelCopyWith<_ConversationUpdateModel> get copyWith => __$ConversationUpdateModelCopyWithImpl<_ConversationUpdateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationUpdateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationUpdateModel&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversationId,updatedAt,lastMessage);

@override
String toString() {
  return 'ConversationUpdateModel(conversationId: $conversationId, updatedAt: $updatedAt, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class _$ConversationUpdateModelCopyWith<$Res> implements $ConversationUpdateModelCopyWith<$Res> {
  factory _$ConversationUpdateModelCopyWith(_ConversationUpdateModel value, $Res Function(_ConversationUpdateModel) _then) = __$ConversationUpdateModelCopyWithImpl;
@override @useResult
$Res call({
 int conversationId, String updatedAt, LastMessageInfoModel? lastMessage
});


@override $LastMessageInfoModelCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class __$ConversationUpdateModelCopyWithImpl<$Res>
    implements _$ConversationUpdateModelCopyWith<$Res> {
  __$ConversationUpdateModelCopyWithImpl(this._self, this._then);

  final _ConversationUpdateModel _self;
  final $Res Function(_ConversationUpdateModel) _then;

/// Create a copy of ConversationUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? updatedAt = null,Object? lastMessage = freezed,}) {
  return _then(_ConversationUpdateModel(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as LastMessageInfoModel?,
  ));
}

/// Create a copy of ConversationUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastMessageInfoModelCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $LastMessageInfoModelCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// @nodoc
mixin _$LastMessageInfoModel {

 int get id; String get content; int get senderId; String get senderUsername; String get sentAt; String get type;
/// Create a copy of LastMessageInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LastMessageInfoModelCopyWith<LastMessageInfoModel> get copyWith => _$LastMessageInfoModelCopyWithImpl<LastMessageInfoModel>(this as LastMessageInfoModel, _$identity);

  /// Serializes this LastMessageInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LastMessageInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,senderId,senderUsername,sentAt,type);

@override
String toString() {
  return 'LastMessageInfoModel(id: $id, content: $content, senderId: $senderId, senderUsername: $senderUsername, sentAt: $sentAt, type: $type)';
}


}

/// @nodoc
abstract mixin class $LastMessageInfoModelCopyWith<$Res>  {
  factory $LastMessageInfoModelCopyWith(LastMessageInfoModel value, $Res Function(LastMessageInfoModel) _then) = _$LastMessageInfoModelCopyWithImpl;
@useResult
$Res call({
 int id, String content, int senderId, String senderUsername, String sentAt, String type
});




}
/// @nodoc
class _$LastMessageInfoModelCopyWithImpl<$Res>
    implements $LastMessageInfoModelCopyWith<$Res> {
  _$LastMessageInfoModelCopyWithImpl(this._self, this._then);

  final LastMessageInfoModel _self;
  final $Res Function(LastMessageInfoModel) _then;

/// Create a copy of LastMessageInfoModel
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


/// Adds pattern-matching-related methods to [LastMessageInfoModel].
extension LastMessageInfoModelPatterns on LastMessageInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LastMessageInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LastMessageInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LastMessageInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _LastMessageInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LastMessageInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _LastMessageInfoModel() when $default != null:
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
case _LastMessageInfoModel() when $default != null:
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
case _LastMessageInfoModel():
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
case _LastMessageInfoModel() when $default != null:
return $default(_that.id,_that.content,_that.senderId,_that.senderUsername,_that.sentAt,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LastMessageInfoModel extends LastMessageInfoModel {
  const _LastMessageInfoModel({required this.id, required this.content, required this.senderId, required this.senderUsername, required this.sentAt, required this.type}): super._();
  factory _LastMessageInfoModel.fromJson(Map<String, dynamic> json) => _$LastMessageInfoModelFromJson(json);

@override final  int id;
@override final  String content;
@override final  int senderId;
@override final  String senderUsername;
@override final  String sentAt;
@override final  String type;

/// Create a copy of LastMessageInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LastMessageInfoModelCopyWith<_LastMessageInfoModel> get copyWith => __$LastMessageInfoModelCopyWithImpl<_LastMessageInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LastMessageInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LastMessageInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,senderId,senderUsername,sentAt,type);

@override
String toString() {
  return 'LastMessageInfoModel(id: $id, content: $content, senderId: $senderId, senderUsername: $senderUsername, sentAt: $sentAt, type: $type)';
}


}

/// @nodoc
abstract mixin class _$LastMessageInfoModelCopyWith<$Res> implements $LastMessageInfoModelCopyWith<$Res> {
  factory _$LastMessageInfoModelCopyWith(_LastMessageInfoModel value, $Res Function(_LastMessageInfoModel) _then) = __$LastMessageInfoModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String content, int senderId, String senderUsername, String sentAt, String type
});




}
/// @nodoc
class __$LastMessageInfoModelCopyWithImpl<$Res>
    implements _$LastMessageInfoModelCopyWith<$Res> {
  __$LastMessageInfoModelCopyWithImpl(this._self, this._then);

  final _LastMessageInfoModel _self;
  final $Res Function(_LastMessageInfoModel) _then;

/// Create a copy of LastMessageInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? senderId = null,Object? senderUsername = null,Object? sentAt = null,Object? type = null,}) {
  return _then(_LastMessageInfoModel(
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
