// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_list_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventListItemDto {

 int get messageId; String get title; String? get description; String get startTime; String get endTime; String? get location; List<int> get going; List<int> get maybe; List<int> get notGoing; int get createdBy; String get createdByUsername; String get createdAt;
/// Create a copy of EventListItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventListItemDtoCopyWith<EventListItemDto> get copyWith => _$EventListItemDtoCopyWithImpl<EventListItemDto>(this as EventListItemDto, _$identity);

  /// Serializes this EventListItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventListItemDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.going, going)&&const DeepCollectionEquality().equals(other.maybe, maybe)&&const DeepCollectionEquality().equals(other.notGoing, notGoing)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,title,description,startTime,endTime,location,const DeepCollectionEquality().hash(going),const DeepCollectionEquality().hash(maybe),const DeepCollectionEquality().hash(notGoing),createdBy,createdByUsername,createdAt);

@override
String toString() {
  return 'EventListItemDto(messageId: $messageId, title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location, going: $going, maybe: $maybe, notGoing: $notGoing, createdBy: $createdBy, createdByUsername: $createdByUsername, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $EventListItemDtoCopyWith<$Res>  {
  factory $EventListItemDtoCopyWith(EventListItemDto value, $Res Function(EventListItemDto) _then) = _$EventListItemDtoCopyWithImpl;
@useResult
$Res call({
 int messageId, String title, String? description, String startTime, String endTime, String? location, List<int> going, List<int> maybe, List<int> notGoing, int createdBy, String createdByUsername, String createdAt
});




}
/// @nodoc
class _$EventListItemDtoCopyWithImpl<$Res>
    implements $EventListItemDtoCopyWith<$Res> {
  _$EventListItemDtoCopyWithImpl(this._self, this._then);

  final EventListItemDto _self;
  final $Res Function(EventListItemDto) _then;

/// Create a copy of EventListItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? location = freezed,Object? going = null,Object? maybe = null,Object? notGoing = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,going: null == going ? _self.going : going // ignore: cast_nullable_to_non_nullable
as List<int>,maybe: null == maybe ? _self.maybe : maybe // ignore: cast_nullable_to_non_nullable
as List<int>,notGoing: null == notGoing ? _self.notGoing : notGoing // ignore: cast_nullable_to_non_nullable
as List<int>,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EventListItemDto].
extension EventListItemDtoPatterns on EventListItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventListItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventListItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventListItemDto value)  $default,){
final _that = this;
switch (_that) {
case _EventListItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventListItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventListItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int messageId,  String title,  String? description,  String startTime,  String endTime,  String? location,  List<int> going,  List<int> maybe,  List<int> notGoing,  int createdBy,  String createdByUsername,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventListItemDto() when $default != null:
return $default(_that.messageId,_that.title,_that.description,_that.startTime,_that.endTime,_that.location,_that.going,_that.maybe,_that.notGoing,_that.createdBy,_that.createdByUsername,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int messageId,  String title,  String? description,  String startTime,  String endTime,  String? location,  List<int> going,  List<int> maybe,  List<int> notGoing,  int createdBy,  String createdByUsername,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _EventListItemDto():
return $default(_that.messageId,_that.title,_that.description,_that.startTime,_that.endTime,_that.location,_that.going,_that.maybe,_that.notGoing,_that.createdBy,_that.createdByUsername,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int messageId,  String title,  String? description,  String startTime,  String endTime,  String? location,  List<int> going,  List<int> maybe,  List<int> notGoing,  int createdBy,  String createdByUsername,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _EventListItemDto() when $default != null:
return $default(_that.messageId,_that.title,_that.description,_that.startTime,_that.endTime,_that.location,_that.going,_that.maybe,_that.notGoing,_that.createdBy,_that.createdByUsername,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventListItemDto implements EventListItemDto {
  const _EventListItemDto({required this.messageId, required this.title, this.description, required this.startTime, required this.endTime, this.location, required final  List<int> going, required final  List<int> maybe, required final  List<int> notGoing, required this.createdBy, required this.createdByUsername, required this.createdAt}): _going = going,_maybe = maybe,_notGoing = notGoing;
  factory _EventListItemDto.fromJson(Map<String, dynamic> json) => _$EventListItemDtoFromJson(json);

@override final  int messageId;
@override final  String title;
@override final  String? description;
@override final  String startTime;
@override final  String endTime;
@override final  String? location;
 final  List<int> _going;
@override List<int> get going {
  if (_going is EqualUnmodifiableListView) return _going;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_going);
}

 final  List<int> _maybe;
@override List<int> get maybe {
  if (_maybe is EqualUnmodifiableListView) return _maybe;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_maybe);
}

 final  List<int> _notGoing;
@override List<int> get notGoing {
  if (_notGoing is EqualUnmodifiableListView) return _notGoing;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notGoing);
}

@override final  int createdBy;
@override final  String createdByUsername;
@override final  String createdAt;

/// Create a copy of EventListItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventListItemDtoCopyWith<_EventListItemDto> get copyWith => __$EventListItemDtoCopyWithImpl<_EventListItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventListItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventListItemDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._going, _going)&&const DeepCollectionEquality().equals(other._maybe, _maybe)&&const DeepCollectionEquality().equals(other._notGoing, _notGoing)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,title,description,startTime,endTime,location,const DeepCollectionEquality().hash(_going),const DeepCollectionEquality().hash(_maybe),const DeepCollectionEquality().hash(_notGoing),createdBy,createdByUsername,createdAt);

@override
String toString() {
  return 'EventListItemDto(messageId: $messageId, title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location, going: $going, maybe: $maybe, notGoing: $notGoing, createdBy: $createdBy, createdByUsername: $createdByUsername, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EventListItemDtoCopyWith<$Res> implements $EventListItemDtoCopyWith<$Res> {
  factory _$EventListItemDtoCopyWith(_EventListItemDto value, $Res Function(_EventListItemDto) _then) = __$EventListItemDtoCopyWithImpl;
@override @useResult
$Res call({
 int messageId, String title, String? description, String startTime, String endTime, String? location, List<int> going, List<int> maybe, List<int> notGoing, int createdBy, String createdByUsername, String createdAt
});




}
/// @nodoc
class __$EventListItemDtoCopyWithImpl<$Res>
    implements _$EventListItemDtoCopyWith<$Res> {
  __$EventListItemDtoCopyWithImpl(this._self, this._then);

  final _EventListItemDto _self;
  final $Res Function(_EventListItemDto) _then;

/// Create a copy of EventListItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? location = freezed,Object? going = null,Object? maybe = null,Object? notGoing = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdAt = null,}) {
  return _then(_EventListItemDto(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,going: null == going ? _self._going : going // ignore: cast_nullable_to_non_nullable
as List<int>,maybe: null == maybe ? _self._maybe : maybe // ignore: cast_nullable_to_non_nullable
as List<int>,notGoing: null == notGoing ? _self._notGoing : notGoing // ignore: cast_nullable_to_non_nullable
as List<int>,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
