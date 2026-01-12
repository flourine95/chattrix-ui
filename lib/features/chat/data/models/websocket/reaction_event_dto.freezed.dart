// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reaction_event_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReactionEventDto {

 int get messageId; int get userId; String get userName; String get emoji; String get action; Map<String, List<int>> get reactions; DateTime get timestamp;
/// Create a copy of ReactionEventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReactionEventDtoCopyWith<ReactionEventDto> get copyWith => _$ReactionEventDtoCopyWithImpl<ReactionEventDto>(this as ReactionEventDto, _$identity);

  /// Serializes this ReactionEventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReactionEventDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.action, action) || other.action == action)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,userId,userName,emoji,action,const DeepCollectionEquality().hash(reactions),timestamp);

@override
String toString() {
  return 'ReactionEventDto(messageId: $messageId, userId: $userId, userName: $userName, emoji: $emoji, action: $action, reactions: $reactions, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ReactionEventDtoCopyWith<$Res>  {
  factory $ReactionEventDtoCopyWith(ReactionEventDto value, $Res Function(ReactionEventDto) _then) = _$ReactionEventDtoCopyWithImpl;
@useResult
$Res call({
 int messageId, int userId, String userName, String emoji, String action, Map<String, List<int>> reactions, DateTime timestamp
});




}
/// @nodoc
class _$ReactionEventDtoCopyWithImpl<$Res>
    implements $ReactionEventDtoCopyWith<$Res> {
  _$ReactionEventDtoCopyWithImpl(this._self, this._then);

  final ReactionEventDto _self;
  final $Res Function(ReactionEventDto) _then;

/// Create a copy of ReactionEventDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? userId = null,Object? userName = null,Object? emoji = null,Object? action = null,Object? reactions = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,reactions: null == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<int>>,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ReactionEventDto].
extension ReactionEventDtoPatterns on ReactionEventDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReactionEventDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReactionEventDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReactionEventDto value)  $default,){
final _that = this;
switch (_that) {
case _ReactionEventDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReactionEventDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReactionEventDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int messageId,  int userId,  String userName,  String emoji,  String action,  Map<String, List<int>> reactions,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReactionEventDto() when $default != null:
return $default(_that.messageId,_that.userId,_that.userName,_that.emoji,_that.action,_that.reactions,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int messageId,  int userId,  String userName,  String emoji,  String action,  Map<String, List<int>> reactions,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _ReactionEventDto():
return $default(_that.messageId,_that.userId,_that.userName,_that.emoji,_that.action,_that.reactions,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int messageId,  int userId,  String userName,  String emoji,  String action,  Map<String, List<int>> reactions,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _ReactionEventDto() when $default != null:
return $default(_that.messageId,_that.userId,_that.userName,_that.emoji,_that.action,_that.reactions,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReactionEventDto implements ReactionEventDto {
  const _ReactionEventDto({required this.messageId, required this.userId, required this.userName, required this.emoji, required this.action, required final  Map<String, List<int>> reactions, required this.timestamp}): _reactions = reactions;
  factory _ReactionEventDto.fromJson(Map<String, dynamic> json) => _$ReactionEventDtoFromJson(json);

@override final  int messageId;
@override final  int userId;
@override final  String userName;
@override final  String emoji;
@override final  String action;
 final  Map<String, List<int>> _reactions;
@override Map<String, List<int>> get reactions {
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_reactions);
}

@override final  DateTime timestamp;

/// Create a copy of ReactionEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReactionEventDtoCopyWith<_ReactionEventDto> get copyWith => __$ReactionEventDtoCopyWithImpl<_ReactionEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReactionEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReactionEventDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.action, action) || other.action == action)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,userId,userName,emoji,action,const DeepCollectionEquality().hash(_reactions),timestamp);

@override
String toString() {
  return 'ReactionEventDto(messageId: $messageId, userId: $userId, userName: $userName, emoji: $emoji, action: $action, reactions: $reactions, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ReactionEventDtoCopyWith<$Res> implements $ReactionEventDtoCopyWith<$Res> {
  factory _$ReactionEventDtoCopyWith(_ReactionEventDto value, $Res Function(_ReactionEventDto) _then) = __$ReactionEventDtoCopyWithImpl;
@override @useResult
$Res call({
 int messageId, int userId, String userName, String emoji, String action, Map<String, List<int>> reactions, DateTime timestamp
});




}
/// @nodoc
class __$ReactionEventDtoCopyWithImpl<$Res>
    implements _$ReactionEventDtoCopyWith<$Res> {
  __$ReactionEventDtoCopyWithImpl(this._self, this._then);

  final _ReactionEventDto _self;
  final $Res Function(_ReactionEventDto) _then;

/// Create a copy of ReactionEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? userId = null,Object? userName = null,Object? emoji = null,Object? action = null,Object? reactions = null,Object? timestamp = null,}) {
  return _then(_ReactionEventDto(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,reactions: null == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<int>>,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
